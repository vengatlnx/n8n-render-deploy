FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    ca-certificates \
    git \
    nodejs \
    npm \
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

# Install Playwright and Chromium
RUN pip install --no-cache-dir playwright && \
    playwright install --with-deps chromium

# Install n8n globally
RUN npm install -g n8n@latest

# Set environment variables for n8n
ENV NODE_ENV=production
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=admin
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678 # n8n will listen on this port internally
ENV WEBHOOK_URL=https://n8n-render-deploy-lzqt.onrender.com
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Clone your Python app
RUN git clone https://github.com/vengatlnx/n8n-zepto.git /app
WORKDIR /app

# Install Python dependencies
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Expose ports for n8n (5678) and the Python app (8000)
EXPOSE 5678
EXPOSE 8000

# Start both services (n8n and Python) using a script or process manager
# Ensure your 'main.py' is configured to listen on port 8000.
# For example, if using Flask, it might look like: app.run(host='0.0.0.0', port=8000)
CMD ["bash", "-c", "n8n start & python main.py"]
