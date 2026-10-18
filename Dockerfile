# --- Build Stage ---
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .

# Create a virtual environment and install packages into it
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt

# --- Final Runner Stage ---
FROM python:3.11-slim AS runner
WORKDIR /app
# Copy the entire virtual environment over
COPY --from=builder /opt/venv /opt/venv
# Copy your application files
COPY app.py .
# Make sure the runner uses the virtual environment's dependencies
ENV PATH="/opt/venv/bin:$PATH"
EXPOSE 5000
CMD ["python", "app.py"]