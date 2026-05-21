from flask import Flask, jsonify, request

app = Flask(__name__)

orders = []

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy", "service": "order-service"})

@app.route('/orders', methods=['GET'])
def get_orders():
    return jsonify({"orders": orders})

@app.route('/orders', methods=['POST'])
def create_order():
    data = request.get_json()
    order = {
        "id": len(orders) + 1,
        "item": data["item"],
        "quantity": data["quantity"],
        "status": "created"
    }
    orders.append(order)
    return jsonify({"order": order}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
