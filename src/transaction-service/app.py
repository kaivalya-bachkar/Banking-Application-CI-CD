from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import os, requests

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL', 'postgresql://postgres:postgres@localhost:5432/banking_db')
db = SQLAlchemy(app)

NOTIFICATION_SERVICE_URL = os.environ.get("NOTIFICATION_SERVICE_URL", "http://127.0.0.1:5004")
ACCOUNT_SERVICE_URL = os.environ.get("ACCOUNT_SERVICE_URL", "http://127.0.0.1:5002")

class Transaction(db.Model):
    __tablename__ = 'transactions'
    txn_id = db.Column(db.Integer, primary_key=True)
    account_id = db.Column(db.Integer, nullable=False)
    amount = db.Column(db.Numeric(12, 2), nullable=False)
    txn_type = db.Column(db.String(20), nullable=False) 
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

with app.app_context():
    db.create_all()

@app.route('/transactions', methods=['POST'])
def process_transaction():
    data = request.get_json()
    # 1. Update Balance first (Validation)
    try:
        resp = requests.put(f"{ACCOUNT_SERVICE_URL}/accounts/{data['account_id']}", json=data)
        if resp.status_code != 200: return jsonify({"error": "Invalid Account"}), 400
    except: return jsonify({"error": "Account Service Offline"}), 503

    # 2. Record Transaction
    new_txn = Transaction(account_id=data['account_id'], amount=data['amount'], txn_type=data['txn_type'])
    db.session.add(new_txn)
    db.session.commit()

    # 3. Notify
    try:
        msg = f"Txn: {data['txn_type']} of ${data['amount']} on Acc #{data['account_id']}"
        requests.post(f"{NOTIFICATION_SERVICE_URL}/notifications/send", json={"message": msg})
    except: pass

    return jsonify({"message": "Success"}), 201

@app.route('/transactions', methods=['GET'])
def get_all_transactions():
    txns = Transaction.query.all()
    return jsonify([{"txn_id": t.txn_id, "account_id": t.account_id, "amount": str(t.amount), "txn_type": t.txn_type} for t in txns])

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5003)