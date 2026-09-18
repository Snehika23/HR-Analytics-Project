# 🧑‍💼 HR Analytics Dashboard | MySQL + Power BI

![HR Analytics](https://img.shields.io/badge/Project-HR%20Analytics-blue?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-26.7-orange?style=for-the-badge&logo=mysql)
![PowerBI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?style=for-the-badge&logo=powerbi)
![Status](https://img.shields.io/badge/Status-Completed-green?style=for-the-badge)

---

## 📌 Project Overview

This end-to-end **HR Analytics Portfolio Project** involves cleaning, analyzing, and visualizing a large Human Resources dataset using **MySQL** for data processing and **Power BI** for interactive dashboard creation.

The project answers **15 key business questions** about employee demographics, hiring trends, termination rates, and workforce distribution — providing actionable insights for HR decision-making.

---

## 📊 Dashboard Preview

> 📁 *Open `HR_Analytics_Dashboard.pbix` in Power BI Desktop to view the full interactive dashboard.*

The dashboard includes:
- 👥 Gender Distribution
- 🌍 HQ vs Remote Distribution
- 🎂 Age Wise Distribution
- 🏢 Department vs Gender Distribution
- 🌿 Race Distribution
- 📈 Employee Count Over Time
- 📋 Tenure by Department
- 🗺️ State Wise Distribution

[![View Dashboard](https://img.shields.io/badge/Power%20BI-HR%20Analytics%20Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)]([YOUR_LINK_HERE](https://github.com/Snehika23/HR-Analytics-Project/blob/main/HR_Analytics_Dashboard.pdf))
---

## 🗂️ Project Structure

```
HR-Analytics-Project/
│
├── 📄 HR_Analytics_SQL.sql       # MySQL queries for data cleaning & analysis
├── 📊 HR_Analytics_Dashboard.pbix # Power BI Dashboard file
└── 📖 README.md                  # Project documentation
```

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **MySQL 26.7** | Database creation, data cleaning, data analysis |
| **MySQL Workbench** | SQL query editor and database management |
| **Power BI Desktop** | Interactive dashboard and data visualization |
| **CSV (Human Resources)** | Source dataset with 22,000+ employee records |

---

## 📁 Dataset

- **File:** `Human Resources.csv`
- **Records:** ~22,000 employees
- **Columns:** 13 fields including:

| Column | Description |
|--------|-------------|
| `id` | Unique Employee ID |
| `first_name` | Employee First Name |
| `last_name` | Employee Last Name |
| `birthdate` | Date of Birth |
| `gender` | Employee Gender |
| `race` | Employee Race/Ethnicity |
| `department` | Department Name |
| `jobtitle` | Job Title |
| `location` | HQ or Remote |
| `hire_date` | Date of Hiring |
| `termdate` | Termination Date (if applicable) |
| `location_city` | City of Work |
| `location_state` | State of Work |

---

## 🧹 Data Cleaning Steps (MySQL)

The following cleaning operations were performed on the raw dataset:

1. ✅ **Renamed** `id` column to `emp_id`
2. ✅ **Standardized date formats** for `birthdate`, `hire_date`, and `termdate` columns (handled mixed formats: `MM/DD/YYYY` and `MM-DD-YYYY`)
3. ✅ **Converted date columns** to proper `DATE` datatype
4. ✅ **Cleaned termdate** by removing UTC timezone text and handling NULL/empty values
5. ✅ **Added `age` column** calculated from birthdate using `TIMESTAMPDIFF`
6. ✅ **Disabled safe update mode** for bulk updates

---

## 🔍 Business Questions Answered

### 👥 Workforce Demographics
1. What is the **gender breakdown** of employees?
2. What is the **race/ethnicity breakdown** of employees?
3. What is the **age distribution** of employees?
4. How many employees work at **HQ vs Remote**?

### 📈 Employment Trends
5. What is the **average length of employment** for terminated employees?
6. How has the **employee count changed over time** based on hire and termination dates?
7. What is the **tenure distribution** for each department?

### 🏢 Department & Role Analysis
8. How does **gender distribution vary** across departments and job titles?
9. What is the **distribution of job titles** across the company?
10. Which department has the **highest turnover/termination rate**?

### 🗺️ Location Analysis
11. What is the **distribution of employees across states**?

### 📊 Termination Breakdown
12. Termination and hire breakdown **gender wise**
13. Termination and hire breakdown **age wise**
14. Termination and hire breakdown **department wise**
15. Termination and hire breakdown **race wise** and **year wise**

---

## 💻 How to Run This Project

### Prerequisites
- [MySQL Community Server 26.7+](https://dev.mysql.com/downloads/mysql/)
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)
- [Power BI Desktop](https://powerbi.microsoft.com/downloads/)

### Steps

**Step 1 — Set up MySQL Database:**
```sql
CREATE DATABASE projects_hr;
USE projects_hr;
```

**Step 2 — Import the Dataset:**
- Place `Human Resources.csv` in your MySQL Uploads folder:
```
C:/ProgramData/MySQL/MySQL Server 26.7/Uploads/
```

**Step 3 — Run the SQL Script:**
- Open `HR_Analytics_SQL.sql` in MySQL Workbench
- Run the full script to create, clean and analyze the data

**Step 4 — Open Power BI Dashboard:**
- Open `HR_Analytics_Dashboard.pbix` in Power BI Desktop
- Reconnect to your MySQL database if prompted:
  - Server: `localhost`
  - Database: `projects_hr`

---

## 📈 Key Insights

- 👨 **Male employees** form the largest gender group in the company
- 🏢 **74.98%** of employees work at **Headquarters**, while **25.02%** work **Remotely**
- 🎂 The **25-44 age group** has the highest number of employees
- ⚪ **White** is the most common race/ethnicity among employees
- 📉 The **Auditing** department has the highest termination rate
- 📅 Average employee tenure is approximately **8 years**
- 🗺️ **Ohio** has the highest concentration of employees

---

## 👩‍💻 Author

**Snehika Amudalapalli**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat&logo=github)](https://www.github.com)

---

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

---

> ⭐ If you found this project helpful, please give it a star on GitHub!
