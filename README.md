# Student Performance Analysis

A beginner-friendly **Business Analytics** project designed for college students and fresher analytics portfolios.

This project analyzes student academic performance across 5 engineering departments using a synthetic dataset of 100 student records, examining how **classroom attendance**, **departmental differences**, and **subject difficulty** influence student success.

---

## Project Deliverables & File Structure

```text
Student_Performance_Analysis/
│
├── student_performance.csv          # 1. Clean synthetic CSV dataset (100 student records)
├── student_performance_analysis.xlsx # 2. Excel workbook with formulas, KPIs, and native charts
├── analysis_queries.sql             # 3. PostgreSQL table schema, import commands, & 10 queries
├── dashboard_guide.md               # 4a. Step-by-step Power BI & Tableau dashboard creation guide
├── dashboard_mockup.html            # 4b. Interactive, standalone web dashboard preview
├── Project_Report.md                # 5. Short academic project report (findings & recommendations)
└── README.md                        # 6. Setup, execution, and interview guide
```

---

## 1. Dataset Overview

- **Source:** Synthetic dataset created for academic purposes.
- **Records:** 100 students (20 per department).
- **Columns:**
  1. `Student_ID` - Unique identifier (`STU1001` - `STU1100`)
  2. `Student_Name` - Full student name
  3. `Department` - Academic stream (`Computer Science`, `Information Technology`, `Mechanical Engineering`, `Electrical Engineering`, `Civil Engineering`)
  4. `Attendance_Percentage` - Semester class attendance (52% - 96%)
  5. `Maths_Marks` - Score out of 100
  6. `Science_Marks` - Score out of 100
  7. `English_Marks` - Score out of 100
  8. `Total_Marks` - Calculated as `Maths + Science + English`
  9. `Average_Marks` - Arithmetic mean of the 3 subjects
  10. `Result` - `Pass` if marks $\ge 40$ in all three subjects, else `Fail`

---

## 2. Step-by-Step Execution Guide

### A. Microsoft Excel Analysis
1. Open `student_performance_analysis.xlsx` in Microsoft Excel.
2. The workbook is organized into two sheets:
   - **`Student_Data`**: Contains the full raw data with Excel formulas:
     - Total Marks: `=SUM(E2:G2)`
     - Average Marks: `=ROUND(AVERAGE(E2:G2), 2)`
     - Result: `=IF(AND(E2>=40, F2>=40, G2>=40), "Pass", "Fail")`
   - **`Summary_Analysis`**: Executive summary dashboard with:
     - 5 KPI summary cards (`Total Students`, `Avg Attendance`, `Overall Avg Marks`, `Pass Rate`, `Pass / Fail Count`)
     - Subject performance table using `=AVERAGE()`, `=MAX()`, `=MIN()`
     - Department comparison table using `=COUNTIF()`, `=AVERAGEIF()`, `=COUNTIFS()`
     - Attendance bracket segmentation table
     - Three native Excel charts: Department comparison bar chart, Subject average column chart, and Pass vs Fail pie chart.

### B. PostgreSQL Analysis
1. Open **pgAdmin** or the **psql** command line.
2. Create or connect to a database:
   ```sql
   CREATE DATABASE student_db;
   \c student_db;
   ```
3. Run the script `analysis_queries.sql` or open it in pgAdmin Query Tool.
4. The script executes:
   - Table creation (`CREATE TABLE student_performance ...`)
   - Data import via `\copy` (or pgAdmin GUI Import wizard)
   - 10 targeted analytics queries using `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `COUNT`, `AVG`, `MIN`, `MAX`, and `CASE WHEN`.

### C. Power BI & Tableau Dashboard
- Follow [dashboard_guide.md](dashboard_guide.md) for step-by-step instructions on setting up DAX measures in Power BI or calculated fields in Tableau.
- To immediately inspect or present the interactive dashboard in any browser, double-click or open [dashboard_mockup.html](dashboard_mockup.html).

---

## 3. Key Analytical Findings

| Metric | Batch Value | Top Performer | Lowest Performer |
|---|---|---|---|
| **Overall Pass Rate** | **87.0%** (87 Pass / 13 Fail) | IT: **95.0%** (19/20) | Civil: **75.0%** (15/20) |
| **Overall Average Marks** | **68.57** / 100 | IT: **71.19** | Civil: **66.98** |
| **Average Attendance** | **78.45%** | IT: **82.00%** | Electrical: **76.50%** |
| **Subject Difficulty** | English: **70.13** (Highest) | Science: **68.04** | Maths: **67.55** (Lowest) |
| **Top Student** | **Gaurav Joshi** (CS, STU1066) | **281 Total** (93.67% Avg) | Attendance: **85%** |

### Critical Finding: Attendance vs Failure Risk
- **100% of failed students (13 of 13)** had attendance below the 75% threshold.
- Students with $\ge 75\%$ attendance achieved a **100% pass rate** (74 out of 74).
- Students with $< 75\%$ attendance had a **50% failure rate** (13 of 26).

---

## 4. How to Explain This Project in an Interview / Viva

When asked: *"Walk me through a data analytics project you worked on."*

> "I worked on a Student Performance Analysis project where I analyzed academic records for 100 students across 5 engineering departments to identify factors impacting academic pass rates.
> 
> Using Excel, I built dynamic KPI summary cards and department-wise comparison tables using formulas like `COUNTIFS` and `AVERAGEIF`. Next, I loaded the dataset into PostgreSQL and wrote 10 targeted queries using `GROUP BY`, aggregation functions, and `CASE WHEN` logic to segment students by attendance brackets and analyze subject-specific failure patterns.
> 
> Finally, I designed an interactive dashboard in Power BI/Tableau. The key insight was that 100% of the failed students had attendance below 75%, while students with 75%+ attendance had a 100% pass rate. Based on this, I recommended establishing a mid-semester attendance early warning system and targeted tutorials for Civil Engineering and Mathematics."
