from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_health():
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json()["status"] == "healthy"


def test_request_id_is_returned():
    response = client.get("/health")

    assert "X-Request-ID" in response.headers


def test_custom_request_id_is_preserved():
    request_id = "test-request-123"

    response = client.get(
        "/health",
        headers={"X-Request-ID": request_id},
    )

    assert response.headers["X-Request-ID"] == request_id