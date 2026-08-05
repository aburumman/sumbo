# 05. Cloud Infrastructure & DevOps Architecture

> **Cloud Provider**: Google Cloud Platform (GCP)  
> **Deployment Model**: Serverless Containers (Cloud Run) + Managed Relational DB (Cloud SQL)  
> **Target SLA**: 99.95% Uptime Availability

---

## 1. Cloud Infrastructure Topology Diagram

```mermaid
graph TD
    UserTraffic[Internet User Traffic] --> CDN[Cloud CDN & Cloud Armor WAF]
    CDN --> LoadBalancer[HTTPS Global Load Balancer]
    
    LoadBalancer --> StaticAssets[Cloud Storage Static Assets - Single-File & Dist]
    LoadBalancer --> CloudRun[GCP Cloud Run - API Container Fleet]

    subgraph Internal VPC Network
        CloudRun --> Redis[(Memorystore Redis - Cache & Sessions)]
        CloudRun --> DB[(Cloud SQL PostgreSQL - Primary Node)]
        DB --> ReadReplica[(Cloud SQL Read Replica)]
    end

    subgraph DevOps & Observability
        GitHubActions[GitHub Actions CI/CD] --> CloudRun
        CloudRun --> CloudLogging[Google Cloud Logging & Monitoring]
        CloudRun --> Grafana[Grafana / Prometheus Metrics]
    end
```

---

## 2. Infrastructure Component Justification

| GCP Service | Component Role | Justification |
| :--- | :--- | :--- |
| **Cloud Run** | Serverless Microservices Host | Auto-scales stateless API containers from 0 to 100+ instances within seconds based on HTTP concurrency. |
| **Cloud SQL (PostgreSQL)** | Managed Database | Regional HA deployment with automated failover, point-in-time recovery (PITR), and encrypted storage. |
| **Memorystore (Redis)** | In-Memory Caching Layer | Eliminates repetitive database queries for product catalogs and active store feature flag lookup (<2ms latency). |
| **Cloud Armor WAF** | DDoS & Web Security | Protects API endpoints against OWASP Top 10 vulnerabilities, SQL injection, and rate limits brute-force attacks. |
| **Cloud CDN** | Global Asset Distribution | Caches static JavaScript bundles and product catalog images across global edge nodes for sub-20ms asset delivery. |

---

## 3. Disaster Recovery & Backup SLA

- **Recovery Point Objective (RPO)**: **< 5 minutes** (Continuous WAL archive streaming to Cloud Storage).
- **Recovery Time Objective (RTO)**: **< 30 minutes** (Automated Cloud SQL regional failover + Cloud Run container multi-zone deployment).
- **Backup Policy**: Daily automated full backups retained for 30 days, stored with Geo-Redundant storage.
