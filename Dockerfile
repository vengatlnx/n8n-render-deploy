FROM docker.n8n.io/n8nio/n8n

# Install system dependencies
RUN apt-get update && apt-get install -y \
	python \
    wget \
    curl \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    libxshmfence1 \
    libgbm1 \
    libu2f-udev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright and its dependencies
RUN pip install --no-cache-dir playwright && \
    playwright install --with-deps chromium

# Set environment variables for headless operation
ENV PYTHONUNBUFFERED=1
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

# Clone n8n-zepto repo
RUN git clone https://github.com/vengatlnx/n8n-zepto.git /app

# Create app directory
WORKDIR /app

# Install Python dependencies if requirements.txt exists
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi


ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=admin
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV WEBHOOK_URL=https://n8n-render-deploy-lzqt.onrender.com
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true


EXPOSE 5678

CMD ["n8n"]
CMD ["python", "main.py"]

