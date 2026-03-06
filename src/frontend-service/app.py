from flask import Flask, render_template
import requests
import os

app = Flask(__name__)

# URLs for all 4 backend microservices
USER_SERVICE_URL = os.environ.get("USER_SERVICE_URL", "http://127.0.0.1:5001")
ACCOUNT_SERVICE_URL = os.environ.get("ACCOUNT_SERVICE_URL", "http://127.0.0.1:5002")
TRANSACTION_SERVICE_URL = os.environ.get("TRANSACTION_SERVICE_URL", "http://127.0.0.1:5003")
NOTIFICATION_SERVICE_URL = os.environ.get("NOTIFICATION_SERVICE_URL", "http://127.0.0.1:5004")

@app.route('/')
def dashboard():
    # 1. Fetch Users
    try:
        users = requests.get(f"{USER_SERVICE_URL}/users").json().get("data", {})
    except:
        users = {}
    
    # 2. Fetch Accounts
    try:
        accounts = requests.get(f"{ACCOUNT_SERVICE_URL}/accounts").json().get("data", {})
    except:
        accounts = {}

    # 3. Fetch Transactions
    try:
        # Transactions is a list in our mock data, not a dictionary
        transactions = requests.get(f"{TRANSACTION_SERVICE_URL}/transactions").json().get("data", [])
    except:
        transactions = []

    # 4. Fetch Notification Health Status
    try:
        notif_status = requests.get(f"{NOTIFICATION_SERVICE_URL}/notifications/health").json().get("status", "offline")
    except:
        notif_status = "offline"

    # Render the HTML page with all the data
    return render_template('index.html', 
                           users=users, 
                           accounts=accounts, 
                           transactions=transactions, 
                           notif_status=notif_status)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)