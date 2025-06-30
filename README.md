
# 🐳 DevOps Load Balancer Project with Auto-Scaling

This project simulates a **real-time load balancing and auto-scaling setup** using **Docker Compose**, **NGINX**, and a **custom CPU-based auto-scaler**. When the CPU usage of `app1` crosses 70%, a new container (`app3`) is launched dynamically to handle the load.

---

## 📁 Project Structure

```
devops-loadbalancer-project/
├── app1/                # Express.js App 1
│   └── server.js
├── app2/                # Express.js App 2
│   └── server.js
├── app3/                # Created dynamically (same as app1)
│   └── server.js
├── nginx/
│   └── nginx.conf       # Load balancer config (round-robin)
├── docker-compose.yml   # Multi-container setup
├── auto_scaler.ps1      # CPU-based auto-scaling script (PowerShell)
└── README.md            # Project documentation
```

---

## 🚀 Features

✅ Load balancing with NGINX  
✅ Multiple backend containers (`app1`, `app2`)  
✅ Auto-scaling: Adds `app3` when `app1` CPU ≥ 70%  
✅ Real-world DevOps scenario simulation  
✅ Suitable for learning replicas, health, failover, and scaling

---

## 🧪 How It Works

- `app1` and `app2` run Express.js apps on port 3000
- NGINX forwards traffic to both using round-robin
- A script monitors `app1` CPU usage every 10 seconds
- When CPU exceeds 70%, `app3` container is started dynamically

---

## 🧑‍💻 Prerequisites

- Docker & Docker Compose installed
- PowerShell (for `auto_scaler.ps1`) on Windows

---

## 🛠️ Usage

### Step 1: Start all services
```bash
docker compose up --build -d
```

### Step 2: Run the CPU monitoring script
> In PowerShell (run as admin):
```powershell
./auto_scaler.ps1
```

### Step 3: Simulate CPU Load (app1)
```bash
docker exec -it app1 sh -c "yes > /dev/null"
```

> This will spike the CPU usage of `app1`. Once it reaches ≥70%, `app3` will automatically start.

## 🌐 Access the App

Open in your browser:
```
http://localhost:8080
```

Refresh the page to see round-robin load balancing across running apps.

---

## 📘 NGINX Load Balancing (nginx.conf)

```nginx
events {}

http {
    upstream backend_servers {
        server app1:3000;
        server app2:3000;
        server app3:3000;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://backend_servers;
        }
    }
}
```

---

## 📈 Monitoring

Use this to see live container stats:
```bash
docker stats
```

---

## 🧠 Real-Time Concepts Covered

- Multi-container Docker apps
- Load balancing with NGINX
- Custom auto-scaling logic (CPU-based)
- Docker Compose `depends_on` & health checks
- Simulating real-world backend scaling strategies



