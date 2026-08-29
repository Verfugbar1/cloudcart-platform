from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_get_products():
    response = client.get("/api/v1/products")

    assert response.status_code == 200
    assert isinstance(response.json(), list)


def test_get_missing_product():
    response = client.get("/api/v1/products/999999")

    assert response.status_code == 404


def test_create_invalid_product():
    response = client.post(
        "/api/v1/products",
        json={
            "name": "Invalid",
            "price": -10,
            "category": "Electronics",
            "stock": 10,
        },
    )

    assert response.status_code == 422