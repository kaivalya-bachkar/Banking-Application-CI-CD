from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL', 'postgresql://postgres:postgres@localhost:5432/banking_db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

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
    new_acc = Account(user_id=data['user_id'], account_type=data['account_type'], balance=data.get('initial_deposit', 0))
    db.session.add(new_acc)
    db.session.commit()
    return jsonify({"message": "Account created", "account_number": new_acc.account_number}), 201

@app.route('/accounts/<int:user_id>', methods=['GET'])
def get_accounts(user_id):
    accounts = Account.query.filter_by(user_id=user_id).all()
    return jsonify([{"acc_num": a.account_number, "type": a.account_type, "balance": str(a.balance)} for a in accounts])

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)