from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from decimal import Decimal
import os, requests

app = Flask(__name__)

db_user = os.environ.get('DB_USER', 'postgres')
db_password = os.environ.get('DB_PASSWORD', 'postgres')
db_host = os.environ.get('DB_HOST', 'localhost')
db_port = os.environ.get('DB_PORT', '5432')
db_name = os.environ.get('DB_NAME', 'banking_db')

app.config['SQLALCHEMY_DATABASE_URI'] = f"postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"
db = SQLAlchemy(app)

USER_SERVICE_URL = os.environ.get("USER_SERVICE_URL", "http://user-service")

class Account(db.Model):
    __tablename__ = 'accounts'
    account_number = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)
    account_type = db.Column(db.String(50), nullable=False)
    balance = db.Column(db.Numeric(12, 2), default=0.00)

with app.app_context():
    db.create_all()

@app.route('/accounts', methods=['POST'])
def create_account():
    data = request.get_json()
    try:
        user_resp = requests.get(f"{USER_SERVICE_URL}/users/{data['user_id']}")
        if user_resp.status_code != 200:
            return jsonify({"error": "User does not exist"}), 400
        if user_resp.json().get('kyc') != 'done':
            return jsonify({"error": "KYC not completed"}), 400
    except:
        return jsonify({"error": "User service unreachable"}), 503

    new_acc = Account(
        user_id=data['user_id'], 
        account_type=data['account_type'], 
        balance=Decimal(str(data.get('initial_deposit', 0.00)))
    )
    db.session.add(new_acc)
    db.session.commit()
    return jsonify({"message": "Account created", "account_number": new_acc.account_number}), 201

@app.route('/accounts', methods=['GET'])
def get_all_accounts():
    accounts = Account.query.all()
    return jsonify([{"acc_num": a.account_number, "user_id": a.user_id, "type": a.account_type, "balance": str(a.balance)} for a in accounts])

@app.route('/accounts/<int:account_number>', methods=['PUT'])
def update_balance(account_number):
    data = request.get_json()
    account = Account.query.get(account_number)
    if not account: return jsonify({"error": "Account not found"}), 404
    
    amount = Decimal(str(data['amount']))
    txn_type = data.get('txn_type', '').lower()
    
    # Robust checking to handle frontend quirks safely
    if txn_type in ['credit', 'deposit']:
        account.balance = account.balance + amount
    elif txn_type in ['debit', 'withdraw', 'withdrawal']:
        account.balance = account.balance - amount
    
    db.session.commit()
    return jsonify({"message": "Updated"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)