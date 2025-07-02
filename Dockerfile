FROM node:20-alpine

WORKDIR /usr/src/app

# Install n8n globally
RUN npm install -g n8n@latest

# Set environment variables (important for n8n)
ENV NODE_ENV=production

ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=admin
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV WEBHOOK_URL=https://n8n-render-deploy-lzqt.onrender.com
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false


EXPOSE 5678

CMD ["n8n", "start"]
