# SumboPos - Point of Sale, Sales & Inventory Management MVP

A modern, fast, and feature-complete Point of Sale (POS), Sales Analytics, and Inventory Management MVP web application built for retail, grocery, hospitality, and e-commerce operations.

![Sumbo POS Platform Overview](https://images.unsplash.com/photo-1556742049-0a679149026a?w=800&auto=format&fit=crop&q=80)

---

## 🚀 Quick Start & How to Run

### Option 1: Standalone Instant Browser Launch (Zero Installation Required)
Simply open the standalone single-file distribution directly in any web browser:

Double-clicking or opening `standalone.html` in Chrome/Firefox/Edge/Safari gives you immediate access to POS Checkout, Inventory Tracking, and Transaction Logs.

### Option 2: Local Vite Development Server
1. Open your terminal in this directory:
   ```bash
   cd pos-inventory-platform
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Launch the development server:
   ```bash
   npm run dev
   ```
4. Open `http://localhost:3000` in your browser.

---

## 🌟 Feature Modules

### 1. 🛒 POS Checkout Terminal
- **Catalog Search & Barcode Mode**: Real-time filtering by item name, SKU, or simulated barcode scanning (e.g. `8901001`).
- **Interactive Cart**: Quick quantity adjustment (`+` / `-`), individual item removal, custom discount application ($), tax calculation.
- **Multi-Payment Modes**: Credit Card, Cash, Digital Wallet.
- **Thermal Receipt Generator**: Thermal receipt modal formatted with store branding, order items breakdown, tax, barcode, and 1-click `Print` action.

### 2. 📦 Inventory Management
- **Stock Tracking & Alerts**: Real-time stock counts with color-coded status pills (`In Stock`, `Low Stock Alert`, `Out of Stock`).
- **Product Creation & Editing Modal**: Add/edit product details including Name, SKU, Barcode, Category, Selling Price, Unit Cost, Initial Stock, and Reorder Point.
- **Stock Replenish Shortcut**: Quick `+5` replenish or `-1` decrement buttons right inside the table.

### 3. 📊 Sales Analytics & Financial KPI Reports
- **Executive KPI Cards**: Gross Revenue, Total Completed Orders, Average Order Value (AOV), Profit Margin.
- **Interactive SVG Trend Chart**: Smooth gradient area chart charting revenue over time.
- **Top Products Ranking**: Best-performing SKUs ranked by revenue and unit sales.
- **Payment Method Distribution**: Percentage breakdown of sales across Credit Card, Cash, and Digital Wallets.

### 4. 📜 Transaction Ledger & History
- **Sales Audit Log**: Filterable ledger of past transactions.
- **Receipt Lookup**: Re-open and re-print receipts for any past sale.

### 5. ⚙️ Store Settings & Data Persistence
- **Store Configuration**: Edit Store Name, Phone, Address, Currency Symbol (`$`, `€`, `£`, `¥`, `₹`), Tax Rate (`8.5%`), and Receipt Footers.
- **Demo Data Seed / Reset**: 1-click button to reset products and sales to initial demo dataset for testing.
