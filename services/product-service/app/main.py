from contextlib import asynccontextmanager

from fastapi import FastAPI
import logging
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