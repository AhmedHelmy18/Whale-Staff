# 🐋 Whale Staff HRMS

A premium, high-performance Human Resource Management System (HRMS) built with Flutter. Whale Staff is designed to provide a seamless and professional experience for managing employees, salaries, and leave requests, all within a beautiful, modern interface.

---

## ✨ Key Features in Detail

### 📊 Dynamic Dashboard & Analytics

- **Live Statistics**: Real-time count of total employees and active leaves.
- **Financial Overviews**: Visual breakdown of monthly salary distributions.
- **Interactive Charts**: Powered by `fl_chart`, providing responsive data visualization for staff trends and leave history.

### 👥 Comprehensive Employee Management

Each employee profile is managed with granular data fields:

- **Personal Info**: Full name, Email, Phone, and Birthday.
- **Professional Details**: Unique ID, Position, and Hire Date.
- **Payroll Configuration**: Base Salary and a customizable Bonus Percentage.
- **Actions**: Full CRUD (Create, Read, Update, Delete) capabilities with local persistence.

### 💰 Robust Salary Engine

Whale Staff features a precise calculation engine for payroll:

- **Base Logic**: `Final Salary = Base Salary + (Base Salary * Bonus%) + Manual Bonuses - Deductions`.
- **Manual Adjustments**: Ability to add one-time bonuses or deductions (e.g., penalties or performance rewards).
- **History**: Every calculation is timestamped and saved to the local Hive database for audit trails.

### 📅 Advanced Leave Tracking

- **Workflow**: Automated leave request management.
- **Status Tracking**: Real-time updates on leave balances and approval history.
- **Integration**: Leave data directly impacts the dashboard analytics for workforce planning.

### 📈 Professional Reporting

Generate production-ready documents with a single click:

- **Employee Records (Excel)**: Full export of the employee database in `.xlsx` format for external processing.
- **Salary Reports (Word)**: Detailed, templated `.docx` documents for monthly payroll summaries, including individual breakdowns.

---

## 🛠️ Technical Deep Dive

### Architecture: Clean Architecture Pattern

Separation of concerns is maintained through four distinct layers:

1. **Domain Layer**: Contains Business Entities and Use Cases (e.g., `CalculateSalary`, `GetEmployees`).
2. **Presentation Layer**: Built with **Bloc/Cubit** for reactive state management and a premium UI.
3. **Data Layer**: Implements Repository interfaces and handles Data Models (Mappers).
4. **External Layer**: Integration with **Hive** (NoSQL) and file system services.

### Tech Stack Details

- **State Management**: `flutter_bloc` for predictable app states.
- **Persistence**: `hive` with custom `TypeAdapters` for lightning-fast local storage.
- **Theming**: Custom HSL-based design system with `google_fonts` (Inter/Outfit).
- **Animations**: `flutter_animate` for fluid micro-interactions and staggered list loadings.
- **Exporting**: `excel` and `docx_template` for high-fidelity document generation.

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Latest Stable)
- Dart SDK
- Windows development environment (PathProvider specialized for Windows)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/AhmedHelmy18/Whale-Staff.git
   cd Whale-Staff
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the application**:
   ```bash
   flutter run -d windows
   ```

---

## 🎨 Design Philosophy

Whale Staff prioritizes a **Premium Visual Identity**. We use curated HSL color palettes, subtle glassmorphism, and modern typography to ensure the interface feels professional and responsive. The UI is designed to scale beautifully for desktop users.

---

## 📄 License

This project is proprietary. All rights reserved.
