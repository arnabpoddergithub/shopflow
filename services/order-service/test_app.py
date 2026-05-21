import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    return app.test_client()

def test_health(client):
    response = client.get('/health')
    assert response.status_code == 500  # wrong status code on purpose
