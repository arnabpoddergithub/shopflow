from flask import Flask, jsonify, request
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
import time

app = Flask(__name__)

orders = []

# Prometheus metrics
REQUEST_COUNT = Counter(
    'order_service_requests_total',
    'Total request count',
    ['method', 'endpoint', 'status']
)

REQUEST_LATENCY = Histogram(
    'order_service_request_latency_seconds',
    'Request latency in seconds',
    ['endpoint']
)

@app.before_request
def start_timer():
    request.start_time = time.time()

@app.after_request
def record_metrics(response):
    latency = time.time() - request.start_time
    REQUEST_COUNT.labels(
        method=request.method,
        endpoint=request.path,
        status=response.status_code
    ).inc()
    REQUEST_LATENCY.labels(endpoint=request.path).observe(latency)
    return response

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

@app.route('/metrics', methods=['GET'])
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


@app.route('/version', methods=['GET'])
def version():
    return jsonify({"version": "2.0", "service": "order-service"})
