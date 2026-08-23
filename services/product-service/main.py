from fastapi import FastAPI
from app.errors import unhandled_exception_handler
app = FastAPI()



app.add_exception_handler(
    Exception,
    unhandled_exception_handler,
)
@app.get("/health")
def health_check():
    return {"status": "Elbow is broken"}