# n8n Render Deployment

This project contains the necessary files to deploy n8n on Render using Docker.

## Steps

1. Create a new GitHub repository and upload these files.
2. Go to Render and create a new Web Service.
3. Connect your GitHub repo and select this project.
4. Set the environment to Docker and port to 5678.
5. Add the following environment variables in Render:

| Key                     | Value                                |
|------------------------|--------------------------------------|
| N8N_BASIC_AUTH_ACTIVE  | true                                 |
| N8N_BASIC_AUTH_USER    | admin                                |
| N8N_BASIC_AUTH_PASSWORD| yourpassword                         |
| WEBHOOK_URL            | https://your-subdomain.onrender.com/ |

6. Deploy and access your n8n instance at the Render-provided URL.

