from sqlalchemy import select
from sqlalchemy.orm import Session

from app.models.product import Product
from app.models.schemas import ProductCreate


def get_all_products(
    db: Session,
    skip: int = 0,
    limit: int = 20,
    category: str | None = None,
) -> list[Product]:

    statement = select(Product)

    if category:
        statement = statement.where(
            Product.category == category
        )

    statement = (
        statement
        .offset(skip)
        .limit(limit)
    )

    return list(db.scalars(statement).all())


def get_product(
    db: Session,
    product_id: int,
) -> Product | None:

    return db.get(Product, product_id)


def create_product(
    db: Session,
    product_data: ProductCreate,
) -> Product:

    product = Product(
        **product_data.model_dump()
    )

    db.add(product)
    db.commit()
    db.refresh(product)

    return product


def update_product(
    db: Session,
    product_id: int,
    product_data: ProductCreate,
) -> Product | None:

    product = db.get(Product, product_id)

    if product is None:
        return None

    for field, value in product_data.model_dump().items():
        setattr(product, field, value)

    db.commit()
    db.refresh(product)

    return product


def delete_product(
    db: Session,
    product_id: int,
) -> bool:

    product = db.get(Product, product_id)

    if product is None:
        return False

    db.delete(product)
    db.commit()

    return True