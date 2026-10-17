import os
from flask import Flask
from redis import Redis # type: ignore
app = Flask(__name__)
redis_client = Redis(host='redis', port=6379, decode_responses=True)
@app.route('/')
def hell0():
    Visits = redis_client.incr('counter')
    return f"Container network communication successful! Total visits:{Visits}"
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)