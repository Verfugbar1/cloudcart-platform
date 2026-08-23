from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database import get_db
from app.models.schemas import (
    ProductCreate,
    ProductResponse,
)
from app.services import product_service


router = APIRouter(
    prefix="/products",
    tags=["products"],
)


@router.get(
    "",
    response_model=list[ProductResponse],
)
def get_products(
    skip: int = 0,
    limit: int = 20,
    category: str | None = None,
    db: Session = Depends(get_db),
):
    limit = min(limit, 100)

    return product_service.get_all_products(
        db,
        skip=skip,
        limit=limit,
        category=category,
    )


@router.get(
    "/{product_id}",
    response_model=ProductResponse,
)
def get_product(
    product_id: int,
    db: Session = Depends(get_db),
):
    product = product_service.get_product(
        db,
        product_id,
    )

    if product is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Product not found",
        )

    return product


@router.post(
    "",
    response_model=ProductResponse,
    status_code=status.HTTP_201_CREATED,
)
def create_product(
    product_data: ProductCreate,
    db: Session = Depends(get_db),
):
    return product_service.create_product(
        db,
        product_data,
    )


@router.put(
    "/{product_id}",
    response_model=ProductResponse,
)
def update_product(
    product_id: int,
    product_data: ProductCreate,
    db: Session = Depends(get_db),
):
    product = product_service.update_product(
        db,
        product_id,
        product_data,
    )

    if product is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Product not found",
        )

    return product


@router.delete("/{product_id}")
def delete_product(
    product_id: int,
    db: Session = Depends(get_db),
):
    deleted = product_service.delete_product(
        db,
        product_id,
    )

    if not deleted:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Product not found",
        )

    return {
        "message": "Product deleted successfully"
    }