from flask import Flask, render_template, request, redirect, url_for
import requests, os

app = Flask(__name__)

U_URL = os.environ.get("USER_SERVICE_URL", "http://user-service")
A_URL = os.environ.get("ACCOUNT_SERVICE_URL", "http://account-service")
T_URL = os.environ.get("TRANSACTION_SERVICE_URL", "http://transaction-service")
N_URL = os.environ.get("NOTIFICATION_SERVICE_URL", "http://notification-service")

def fetch(url):
    try: return requests.get(url).json()
    except: return []

@app.route('/')
def dashboard():
    users = fetch(f"{U_URL}/users")
    accounts = fetch(f"{A_URL}/accounts")
    txns = fetch(f"{T_URL}/transactions")
    try:
        notifs = requests.get(f"{N_URL}/notifications").json().get("data", [])
        status = "healthy"
    except:
        notifs, status = [], "offline"
    return render_template('index.html', users=users, accounts=accounts, transactions=txns, alerts_list=notifs, notif_status=status)

@app.route('/add_user', methods=['POST'])
def add_user():
    requests.post(f"{U_URL}/users", json={"name": request.form['name'], "email": request.form['email']})
    return redirect('/')

@app.route('/approve_user/<int:user_id>', methods=['POST'])
def approve_user(user_id):
    requests.post(f"{U_URL}/users/{user_id}/approve")
    return redirect('/')

@app.route('/add_account', methods=['POST'])
def add_account():
    requests.post(f"{A_URL}/accounts", json={"user_id": int(request.form['user_id']), "account_type": request.form['account_type'], "initial_deposit": float(request.form['initial_deposit'])})
    return redirect('/')

@app.route('/add_transaction', methods=['POST'])
def add_transaction():
    requests.post(f"{T_URL}/transactions", json={"account_id": int(request.form['account_id']), "amount": float(request.form['amount']), "txn_type": request.form['txn_type']})
    return redirect('/')

@app.route("/health/live", methods=["GET"])
def liveness_probe():
    return jsonify({"status": "alive"}), 200

@app.route("/health/ready", methods=["GET"])
def readiness_probe():
    return jsonify({"status": "ready"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)