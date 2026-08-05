# 01. Executive Summary & Tech Stack Justification

> **Platform Name**: Sumbō POS, Sales & Inventory Platform  
> **Document Version**: 1.0.0  
> **Architecture Model**: Multi-Tenant Cloud-Native SaaS with Local Offline Resiliency

---

## 1. System Vision & Architecture Objectives

Sumbō is designed as an enterprise-grade, multi-tenant Point of Sale (POS), Inventory Control, and Sales Analytics platform tailored for retail, grocery, and multi-location businesses. 

The architecture is designed to satisfy five non-negotiable architectural requirements:
1. **High Availability & Sub-50ms Response Time**: Ultra-fast POS checkout performance during peak trading hours.
2. **ACID Financial Integrity**: Financial transactions and stock decrements must satisfy strict ACID properties (Atomicity, Consistency, Isolation, Durability) to eliminate stock drift.
3. **Offline Resiliency**: POS terminals must continue processing transactions seamlessly during network outages using client-side queuing and automatic background sync.
4. **Multi-Tenancy & Feature Isolation**: Secure isolation between store tenants with dynamic feature flag toggles managed by a Back Office Admin.
5. **Zero Hardware Lock-In**: Fully responsive browser execution across mobile tablets, laptops, and desktop terminals.

---

## 2. Technology Stack Justification Matrix

| Architectural Layer | Selected Technology | Alternative Evaluated | Trade-off Justification |
| :--- | :--- | :--- | :--- |
| **Frontend Framework** | **React 18 + Vite** | Next.js SSR / Vue.js | React 18's concurrent rendering, minimal bundle size with Vite, and SPA speed provide instant UI responsiveness essential for POS checkout without server-side rendering latency. |
| **Frontend Styling** | **Vanilla CSS Design System (Custom HSL)** | TailwindCSS / Bootstrap | Zero runtime performance overhead, complete design control over glassmorphism & light themes, and zero external CSS dependency bloat. |
| **Backend Runtime** | **Node.js (TypeScript) + Express / Fastify** | Python Django / Java Spring | Non-blocking I/O event loop handles high-concurrency WebSocket connections and POS checkout requests with minimal CPU overhead. TypeScript enforces end-to-end type safety. |
| **Database Engine** | **PostgreSQL 16 (GCP Cloud SQL)** | MongoDB / DynamoDB | Financial ledger and inventory transactions require strict relational ACID compliance, foreign key constraints, and transactional row locking to prevent race conditions during simultaneous sales. |
| **ORM / Query Engine** | **Prisma ORM** | TypeORM / Raw SQL | Provides auto-generated, type-safe database queries, declarative schema migrations, and high developer velocity while preventing SQL injection vulnerabilities. |
| **In-Memory Cache** | **Redis (GCP Memorystore)** | Memcached | Used for real-time stock availability caching, user session management, rate limiting, and Pub/Sub event broadcasting across POS terminals. |
| **Cloud Hosting** | **GCP Cloud Run + Cloud CDN** | AWS EC2 / Kubernetes (GKE) | Serverless container deployment scales to zero during off-peak hours and automatically handles traffic spikes during peak retail sales without managing infrastructure nodes. |
| **CI/CD Pipeline** | **GitHub Actions** | Jenkins / CircleCI | Fully integrated into the source repository with matrix testing, security audit automation, and automated deployment pipelines to Staging and Production. |
