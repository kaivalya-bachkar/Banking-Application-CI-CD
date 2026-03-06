from flask import Flask, jsonify, request
from datetime import datetime

app = Flask(__name__)
notifications_db = []

@app.route('/notifications/send', methods=['POST'])
def send_notification():
    data = request.get_json() or {}
    msg = data.get("message", "System Alert")
    notifications_db.insert(0, {"message": msg, "time": datetime.now().strftime("%I:%M %p")})
    return jsonify({"status": "sent"}), 201

@app.route('/notifications', methods=['GET'])
def get_notifications():
    return jsonify({"data": notifications_db[:10]})

@app.route('/notifications/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5004)