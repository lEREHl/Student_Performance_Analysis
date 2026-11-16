# Academic Project Report: Student Performance Analysis

**Project Title:** Student Academic Performance & Attendance Analytics  
**Domain:** Higher Education / Academic Analytics  
**Target Level:** Beginner / Fresher Business Analyst  
**Author:** Academic Project Portfolio  
**Date:** Academic Year 2025–2026  

---

## 1. Executive Summary

This project conducts an exploratory business analytics evaluation of student academic performance across five engineering departments. Using a synthetic dataset of **100 student records**, we analyzed marks across three core subjects (**Mathematics, Science, and English**) alongside **attendance percentages** to uncover key determinants of student success and failure.

The analysis was executed using foundational analytics tools: **Microsoft Excel** for exploratory data analysis and formula modeling, **PostgreSQL** for relational data querying and aggregation, and **Power BI / Tableau** for visual reporting. 

The primary finding of this study is a dramatic correlation between classroom attendance and academic outcomes: **100% of students who failed (13 out of 13) had attendance rates under 75%**, whereas every student with attendance above 75% passed their exams successfully.

---

## 2. Problem Statement

Academic institutions often face high dropout rates, unexpected exam failures, and unbalanced departmental performance. Educational administrators need simple, evidence-based methods to:
1. Identify academic subjects that present the greatest difficulty for students.
2. Determine which academic departments require additional instructional resources.
3. Establish whether non-academic metrics (such as classroom attendance) can serve as early warning indicators to prevent end-of-term failures.

---

## 3. Project Objectives

The primary objectives of this beginner-level analytics project are:
- **Data Ingestion & Integrity:** Model and clean a structured academic dataset of 100 students across 5 departments.
- **Subject Analysis:** Calculate batch-level subject benchmarks (averages, minimums, maximums) to evaluate curriculum difficulty.
- **Departmental Benchmarking:** Compare academic performance and attendance across Computer Science, Information Technology, Mechanical Engineering, Electrical Engineering, and Civil Engineering.
- **Attendance Risk Correlation:** Quantify the relationship between attendance percentage brackets and student pass/fail status.
- **Actionable Decision Support:** Deliver intuitive visual dashboards and clear, low-complexity recommendations suitable for college leadership.

---

## 4. Dataset Description

The dataset was synthetically generated for academic demonstration purposes, simulating typical undergraduate student performance.

- **Total Records:** 100 rows
- **Total Columns:** 10 attributes
- **Data Integrity:** No missing values, uniform distribution of 20 students per department.

### Data Dictionary

| Column Name | Data Type | Description | Value Range / Constraints |
|---|---|---|---|
| `Student_ID` | String | Unique identifier for each student | `STU1001` to `STU1100` |
| `Student_Name` | String | Full name of the student | Realistic sample names |
| `Department` | String | Academic department | CS, IT, ME, EE, Civil |
| `Attendance_Percentage` | Integer | Overall semester class attendance | `52%` to `96%` |
| `Maths_Marks` | Integer | Score obtained in Mathematics | `30` to `99` (Passing: >= 40) |
| `Science_Marks` | Integer | Score obtained in Science | `30` to `98` (Passing: >= 40) |
| `English_Marks` | Integer | Score obtained in English | `35` to `93` (Passing: >= 40) |
| `Total_Marks` | Integer | Sum of all three subject marks | `120` to `281` (Formula: `=SUM(E:G)`) |
| `Average_Marks` | Decimal | Arithmetic mean of subject marks | `40.00` to `93.67` (Formula: `=AVERAGE(E:G)`) |
| `Result` | String | Academic status (`Pass` or `Fail`) | `Pass` if all subjects >= 40, else `Fail` |

---

## 5. Tools & Technologies Used

To simulate a real-world entry-level Business Analyst workflow, three core tools were used without unnecessary complexity:

1. **Microsoft Excel:**
   - Raw data hygiene, sorting, and multi-condition filtering.
   - Core formulas: `SUM()`, `AVERAGE()`, `COUNTIF()`, `COUNTIFS()`, `AVERAGEIF()`, `IF()`, `AND()`, `ROUND()`.
   - Native charts: Bar charts, Column charts, and Doughnut charts.
2. **PostgreSQL 18:**
   - Schema creation (`CREATE TABLE`) with primary keys and constrained data types.
   - Data import using `\copy`.
   - 10 targeted analytics queries using `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `COUNT`, `AVG`, `MIN`, `MAX`, and `CASE WHEN`.
3. **Power BI / Tableau / HTML Mockup:**
   - Interactive dashboard design with 4 KPI cards and 4 charts.
   - Slicers for departmental filtering and cross-filtering analysis.

---

## 6. Analysis Performed

The study followed an iterative 4-stage analytics methodology:

```
[ Data Ingestion & Cleaning ]
             ↓
[ Excel Formula Modeling & Summary KPIs ]
             ↓
[ PostgreSQL Relational Aggregation (10 Queries) ]
             ↓
[ Visual Dashboard Reporting & Business Insights ]
```

1. **Batch KPI Benchmarking:** Calculated batch totals, overall pass percentage (87.0%), average attendance (78.45%), and average academic score (68.57).
2. **Subject Variance Analysis:** Evaluated average, minimum, and maximum scores for Mathematics, Science, and English.
3. **Department Comparative Analysis:** Grouped records by department to compare academic score averages and pass rates.
4. **Attendance Segmentation Analysis:** Segmented the student cohort into three attendance tiers:
   - High Attendance: $\ge 85\%$
   - Moderate Attendance: $75\% - 84\%$
   - Low Attendance (At-Risk): $< 75\%$
5. **Root-Cause Failure Profiling:** Inspected each of the 13 failed students using SQL conditional logic (`CASE WHEN`) to isolate individual subject failure points.

---

## 7. Key Findings (Based on Actual Dataset Results)

### Finding 1: Classroom Attendance is the Decisive Determinant of Failure
- Out of 100 students, **26 students (26%) had attendance below 75%**.
- **All 13 students who failed the semester (100%) had attendance below 75%**.
- Conversely, for students maintaining $75\%$ or higher attendance (74 students), the **pass rate was exactly 100%**.
- The average score for low attendance students was **49.56**, compared to **75.25** for students with attendance $\ge 75\%$.

### Finding 2: Information Technology Outperformed All Other Departments
- **IT ranked #1** in overall average marks (**71.19**), average attendance (**82.00%**), and pass rate (**95.0%**; 19 passed out of 20).
- Only 1 student failed in Information Technology, and that student had an attendance of 59%.

### Finding 3: Civil Engineering Recorded the Lowest Academic Performance
- **Civil Engineering ranked lowest** in average marks (**66.98**) and pass rate (**75.0%**; 5 failed out of 20).
- Civil Engineering accounted for **38.5% of all batch failures** (5 out of 13).

### Finding 4: Mathematics Showed the Highest Difficulty and Score Variance
- **Mathematics** had the lowest batch average (**67.55**) and the widest spread (minimum score of 30, maximum score of 99).
- By comparison, **English** recorded the highest batch average (**70.13**) with a minimum score of 35.

### Finding 5: High-Performing Outliers
- The top-performing student across the entire college is **Gaurav Joshi** (Computer Science, `STU1066`), achieving **281 total marks** (**93.67% average**) with **85% attendance**.
- All top 5 students had attendance records between **85% and 94%**, validating that consistent attendance accompanies top academic honors.

---

## 8. Summary Table of Department Performance

| Department | Enrolled | Avg Attendance | Avg Maths | Avg Science | Avg English | Overall Avg | Passed | Failed | Pass Rate |
|---|---|---|---|---|---|---|---|---|---|
| **Information Technology** | 20 | 82.00% | 69.00 | 71.00 | 73.55 | **71.19** | 19 | 1 | **95.0%** |
| **Electrical Engineering** | 20 | 76.50% | 68.60 | 68.05 | 69.15 | **68.60** | 18 | 2 | **90.0%** |
| **Mechanical Engineering** | 20 | 78.15% | 67.45 | 65.95 | 71.00 | **68.13** | 18 | 2 | **90.0%** |
| **Computer Science** | 20 | 77.85% | 67.30 | 67.85 | 68.75 | **67.97** | 17 | 3 | **85.0%** |
| **Civil Engineering** | 20 | 77.75% | 65.40 | 67.35 | 68.20 | **66.98** | 15 | 5 | **75.0%** |
| **Overall Batch** | **100** | **78.45%** | **67.55** | **68.04** | **70.13** | **68.57** | **87** | **13** | **87.0%** |

---

## 9. Actionable Recommendations

Based on the empirical findings, educational management should implement three straightforward, low-cost interventions:

### Recommendation 1: Implement an Automated Mid-Semester Attendance Warning System
- **Action:** Set up an early warning trigger at the mid-semester checkpoint (Week 6) for any student whose attendance drops below 80%.
- **Rationale:** Because 100% of failing students fell into the $<75\%$ attendance bracket, proactive academic counseling before final exams can prevent semester-end failures.

### Recommendation 2: Introduce Department-Specific Remedial Support for Civil Engineering
- **Action:** Provide supplemental problem-solving tutorials and faculty office hours specifically for Civil Engineering students in foundational Mathematics and Science.
- **Rationale:** Civil Engineering suffered a 25% failure rate (5 of 20 students), which is three times higher than the failure rate in IT (5%).

### Recommendation 3: Peer-Assisted Tutoring for Quantitative Subjects (Maths & Science)
- **Action:** Pair top scorers (e.g., students scoring $\ge 85$) with struggling students scoring between 40 and 50 in Mathematics.
- **Rationale:** Mathematics exhibited the lowest average score (67.55) and the lowest minimum score (30). Peer study groups provide accessible, informal academic reinforcement.

---

## 10. Conclusion

This project demonstrates how basic data analytics tools—Excel, SQL, and Power BI/Tableau—can yield high-value business insights for academic administration. By tracking simple descriptive metrics and segmenting cohorts, institutions can move from reactive grading to proactive student retention and academic support.
