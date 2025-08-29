## CRM Application Version 2

A simple **Customer Relationship Management (CRM)** application built using **ColdFusion** and **MySQL**.  
This project was developed as a practice project to understand **CRUD operations, AJAX integration, and session handling** in a real-world style application.

---

## Features
- User authentication (Login / Logout)
- Add new customer details
- Edit and update customer records
- Delete customer records
- Real-time search functionality using AJAX
- Organized project structure with CFC components

---

## Technologies Used
- **Backend:** ColdFusion 2023 (CFML)
- **Frontend:** HTML, CSS, JavaScript, jQuery (AJAX)
- **Database:** MySQL

Features in This Version
Code reorganized into modular folders.
Separation of CSS, JS, and CFM files for clarity.
Common layouts (header.cfm, footer.cfm) added for reusability.

## Folder Structure
CRMv2/
├── application.cfc                # Application-level configuration
│
├── components/                    # Reusable components
│   └── customerservice.cfc
│
├── includes/                      # Shared layouts
│   ├── header.cfm
│   └── footer.cfm
│
├── pages/                         # Application modules
│   ├── activitylogs/
│   │   ├── logs.cfm
│   │   └── logs.css
│   │
│   ├── customer management/
│   │   ├── customer_report/
│   │   │   └── customer_report.cfm
│   │   │
│   │   ├── customers/
│   │   │   ├── customers.cfm
│   │   │   ├── customers.css
│   │   │   └── customers.js
│   │   │
│   │   └── scheduletask_mails/
│   │       ├── daily_customer_report.cfm
│   │       ├── sendmail.cfm
│   │       └── sendmail.js
│   │
│   ├── forgot password/
│   │   ├── forgot.cfm
│   │   └── forgot.css
│   │
│   ├── home page/
│   │   ├── home.cfm
│   │   ├── home.css
│   │   └── home.js
│   │
│   ├── login/
│   │   ├── login.cfm
│   │   ├── login.css
│   │   └── login.js
│   │
│   ├── logout/
│   │   └── logout.cfm
│   │
│   ├── profile/
│   │   ├── profile.cfm
│   │   └── profile.css
│   │
│   ├── registration/
│   │   ├── register.cfm
│   │   └── register.css
│   │
│   ├── requests/
│   │   ├── delete_request/
│   │   │   └── delete.cfm
│   │   │
│   │   ├── edit_request/
│   │   │   ├── edit.cfm
│   │   │   └── edit.css
│   │   │
│   │   ├── request_report/
│   │   │   ├── request_report.cfm
│   │   │   └── request_report.css
│   │   │
│   │   ├── submit_request/
│   │   │   ├── submit_request.cfm
│   │   │   ├── submit_request.css
│   │   │   └── submit_request.js
│   │   │
│   │   ├── update_request/
│   │   │   └── update.cfm
│   │   │
│   │   └── view_requests/
│   │       ├── view_requests.cfm
│   │       └── view_requests.css
│   │
│   └── user registrations/
│       ├── user.cfm
│       └── user.css
│
├── styles/                        # Common shared styles
│   └── common.css
│
├── uploads/                       # File uploads
