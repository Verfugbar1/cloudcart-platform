from contextlib import asynccontextmanager
import logging
import os

from azure.monitor.opentelemetry import configure_azure_monitor

if os.getenv("APPLICATIONINSIGHTS_CONNECTION_STRING"):
    configure_azure_monitor()

from fastapi import FastAPI

from app.logging_config import configure_logging
from app.middleware.request_id import request_id_middleware
from app.routes.health import router as health_router
from app.routes.products import router as product_router


@asynccontextmanager
async def lifespan(app: FastAPI):
    configure_logging()

    logger = logging.getLogger(__name__)
    logger.info("Product service starting")

    yield

    logger.info("Product service shutting down")


app = FastAPI(
    title="CloudCart Product Service",
    version="1.0.0",
    lifespan=lifespan,
)

app.middleware("http")(request_id_middleware)

app.include_router(health_router)

app.include_router(
    product_router,
    prefix="/api/v1",
)