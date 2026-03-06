from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import os

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL', 'postgresql://postgres:postgres@localhost:5432/banking_db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Transaction(db.Model):
    __tablename__ = 'transactions'
    txn_id = db.Column(db.Integer, primary_key=True)
    account_id = db.Column(db.Integer, nullable=False)
    amount = db.Column(db.Numeric(12, 2), nullable=False)
    txn_type = db.Column(db.String(20), nullable=False) # 'credit' or 'debit'
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

with app.app_context():
    db.create_all()

@app.route('/transactions', methods=['POST'])
def process_transaction():
    data = request.get_json()
    new_txn = Transaction(account_id=data['account_id'], amount=data['amount'], txn_type=data['txn_type'])
    db.session.add(new_txn)
    db.session.commit()
    return jsonify({"message": "Transaction recorded", "txn_id": new_txn.txn_id}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5003)