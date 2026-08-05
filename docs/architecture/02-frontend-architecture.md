# 02. Frontend Architecture & State Management

> **Layer**: Client Application Architecture  
> **Framework**: React 18 + Vite + Lucide UI  
> **Target Execution**: Desktop Web, Tablet PWA, Mobile POS

---

## 1. Frontend Architecture Overview

The Sumbō client application is structured as a single-page application (SPA) optimized for low latency, local state persistence, and instant catalog rendering.

```mermaid
graph TD
    AppShell[App Shell - App.jsx] --> AppProvider[AppContext Provider]
    AppProvider --> Sidebar[Sidebar Navigation]
    AppProvider --> Header[Header & Clock Status]
    AppProvider --> MainView[Active Screen Container]
    
    MainView --> POSTerminal[🛒 POS Terminal View]
    MainView --> InventoryManager[📦 Inventory Manager View]
    MainView --> SalesAnalytics[📊 Sales Analytics View]
    MainView --> TransactionHistory[📜 Order Ledger View]
    MainView --> BackOfficeAdmin[🛡️ Back Office Admin View]
    MainView --> StoreSettings[⚙️ Store Settings View]

    AppProvider --> ReceiptModal[📄 Thermal Receipt Modal]
    AppProvider --> AuthModal[🔑 User Auth & Store Registration Modal]
    AppProvider --> ProductModal[➕ Product Add/Edit Modal]

    POSTerminal --> LocalStorage[(Client LocalStorage / IndexedDB Cache)]
    InventoryManager --> LocalStorage
    BackOfficeAdmin --> LocalStorage
```

---

## 2. Component Directory Breakdown

```
src/
├── App.jsx                       # Main layout shell & toast notification manager
├── main.jsx                      # Vite entrypoint with React.StrictMode
├── index.css                     # Global Lumina Executive Design System
├── context/
│   └── AppContext.jsx            # Central reactive state, auth & localStorage sync
├── data/
│   └── seedData.js               # Initial seed dataset & store demo profiles
└── components/
    ├── Sidebar.jsx               # Navigation bar & user store pill
    ├── Header.jsx                # Header bar, search & system status
    ├── Auth/
    │   └── AuthModal.jsx         # Sign Up, Sign In & store registration modal
    ├── POS/
    │   ├── POSTerminal.jsx       # Catalog grid, cart drawer & checkout
    │   └── ReceiptModal.jsx      # Thermal printable receipt generator
    ├── Inventory/
    │   ├── InventoryManager.jsx  # SKU ledger table & quick stock adjust
    │   └── ProductModal.jsx      # Add / edit product creation modal
    ├── Analytics/
    │   └── SalesAnalytics.jsx    # Real-time KPI cards & SVG trend charts
    ├── Transactions/
    │   └── TransactionHistory.jsx# Order ledger & receipt lookup
    ├── Admin/
    │   └── BackOfficeAdmin.jsx   # Super admin store directory & feature flag toggles
    └── Settings/
        └── StoreSettings.jsx     # Store details & tax configuration
```

---

## 3. Offline Synchronization Strategy

To ensure zero downtime during network outages, Sumbō implements an offline sync strategy:

```mermaid
sequenceDiagram
    autonumber
    actor Cashier
    participant POS as POS Terminal (Client)
    participant Storage as LocalStorage / IndexedDB
    participant Server as Sumbō Backend API
    participant DB as PostgreSQL Database

    Cashier->>POS: Scan Barcode & Click Checkout
    POS->>POS: Check Network Connection Status
    alt Online Mode
        POS->>Server: POST /api/v1/checkout (Order Payload)
        Server->>DB: Execute ACID Transaction (Stock Decr + Order Insert)
        DB-->>Server: Transaction Committed
        Server-->>POS: HTTP 200 OK + Order ID
        POS->>POS: Render Thermal Receipt Modal
    else Offline Mode
        POS->>Storage: Queue Order to PendingTxn Queue
        POS->>Storage: Decrement Stock in Local Cache
        POS-->>POS: Render Receipt (Marked "Pending Sync")
        Note over POS,Storage: Internet connection restored...
        POS->>Storage: Read PendingTxn Queue
        POS->>Server: POST /api/v1/checkout/batch-sync
        Server->>DB: Commit Queued Orders
        Server-->>POS: Sync Confirmed
        POS->>Storage: Clear PendingTxn Queue
    end
```
