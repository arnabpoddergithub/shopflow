import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    return app.test_client()

def test_health(client):
    response = client.get('/health')
    assert response.status_code == 200

def test_create_order(client):
    response = client.post('/orders', 
        json={"item": "laptop", "quantity": 1})
    assert response.status_code == 201

def test_get_orders(client):
    response = client.get('/orders')
    assert response.status_code == 200
