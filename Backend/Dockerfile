# Use Python 3.11 slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install uv for dependency management
RUN pip install uv

# Copy dependency files
COPY pyproject.toml uv.lock README.md ./

# Install dependencies
ENV UV_PROJECT_ENVIRONMENT="usr/local"
RUN uv sync --frozen

# Copy application code
COPY app/ ./app/

# Expose port 8000
EXPOSE 8000

# Command to run uvicorn with hot reload
CMD ["uv", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"] 