# MLops-App

A minimal MLOps pipeline that combines infrastructure-as-code (Terraform), containerized model serving (Docker), and automated deployment via GitHub Actions.

When you push to the repository, the application is automatically built, tested, and deployed to a cloud server — a true **CI/CD workflow**.

---

## Prerequisites

- **Terraform** (for admins only)  
  Used to provision cloud infrastructure (VM, networking, SSH keys).
- **Python 3.10+** (for developers)  
  Required to run the application locally and generate test data.
- **Docker & Docker Compose**  
  Installed automatically on the target server via `cloud-init`.
- **GitHub account with Actions enabled**  
  Used for CI/CD pipeline.

> 🔑 Admins use Terraform to create the server.  
> Developers just push code — everything else happens automatically.

---

## Installing

### 1. Provision the server (admin only)
```bash
cd Firsttry/
terraform apply
```

This creates a VM with:
Docker & Docker Compose
Nginx (as reverse proxy)
Netdata (for real-time monitoring on port 19999)
Pre-configured docker-compose.yml and app directory

2. Deploy the app (automatic)

Push your code to the main branch.
GitHub Actions will:
- Run tests
- Build a Docker image
- Save it as a .tar.gz archive
- Transfer it to the server
- Load the image and restart containers via docker-compose

Usage

Once deployed, the service is available at:

```bash
http://<SERVER_IP>/
```
Available endpoints:

GET /health → returns {"status": "healthy"}

POST /predict → accepts JSON input and returns model prediction

The request is automatically load-balanced across three identical containers.


Monitoring

View real-time system & container metrics at:

```bash
http://<SERVER_IP>:19999
```