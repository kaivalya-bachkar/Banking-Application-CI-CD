from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/notifications/send', methods=['POST'])
def send_notification():
    # Mocking an SMS/Email send
    return jsonify({"service": "notification-service", "message": "Alert sent to user successfully."}), 200

@app.route('/notifications/health', methods=['GET'])
def health_check():
    return jsonify({"service": "notification-service", "status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5004)