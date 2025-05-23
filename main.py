from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from DevOps!",
            "new": "Added content",
            "latest": "add new code",
            "jenkins": "addded with jenkins pipeline"
            }
