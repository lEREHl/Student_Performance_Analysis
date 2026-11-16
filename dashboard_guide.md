# Dashboard Guide: Student Performance Analysis

This guide provides step-by-step instructions for building the **Student Performance Analysis Dashboard** in **Microsoft Power BI** or **Tableau Desktop / Tableau Public**.

The dashboard includes **4 KPI summary cards** and **4 primary visual charts** designed to be clean, modern, and beginner-friendly.

---

## 1. Key Metrics & Dataset Summary

| Metric | Target Value | Calculation / Formula |
|---|---|---|
| **Total Students** | `100` | Count of `Student_ID` |
| **Overall Average Marks** | `68.57` | Average of `Average_Marks` |
| **Pass Percentage** | `87.0%` | (Students with Result = 'Pass') / Total Students |
| **Average Attendance** | `78.45%` | Average of `Attendance_Percentage` |
| **Passed Students** | `87` | Count of students where `Result = 'Pass'` |
| **Failed Students** | `13` | Count of students where `Result = 'Fail'` |

---

## 2. Option A: Step-by-Step Implementation in Microsoft Power BI

### Step 1: Import Data
1. Open **Power BI Desktop**.
2. Click **Get Data** -> **Text/CSV**.
3. Select `student_performance.csv` and click **Load**.

### Step 2: Create Explicit DAX Measures
In the `student_performance` table, click **New Measure** on the ribbon and create the following 4 basic DAX measures:

```dax
-- 1. Total Students
Total Students = COUNT(student_performance[Student_ID])

-- 2. Average Marks
Average Marks = ROUND(AVERAGE(student_performance[Average_Marks]), 2)

-- 3. Average Attendance
Average Attendance = ROUND(AVERAGE(student_performance[Attendance_Percentage]), 2)

-- 4. Pass Percentage
Pass Rate % = 
DIVIDE(
    CALCULATE(COUNTROWS(student_performance), student_performance[Result] = "Pass"),
    COUNTROWS(student_performance),
    0
) * 100
```

### Step 3: Build the Visuals (Canvas Layout)

#### 1. KPI Cards (Top Banner)
- Add 4 **Card** visuals across the top row:
  - Card 1: Field = `[Total Students]` | Label: **Total Students**
  - Card 2: Field = `[Average Marks]` | Label: **Average Marks**
  - Card 3: Field = `[Pass Rate %]` | Display units: None, Suffix `%` | Label: **Pass Percentage**
  - Card 4: Field = `[Average Attendance]` | Suffix `%` | Label: **Average Attendance**

#### 2. Chart 1: Department-Wise Average Marks (Clustered Bar Chart)
- **Visual Type**: Clustered Bar Chart (or Clustered Column Chart).
- **Y-Axis**: `Department`
- **X-Axis**: `Average of Average_Marks` (or `[Average Marks]` measure)
- **Sorting**: Sort descending by average marks.
- **Insight**: Highlights Information Technology (71.19) as top performer and Civil Engineering (66.98) as lowest.

#### 3. Chart 2: Subject-Wise Performance Comparison (Clustered Column Chart)
- **Visual Type**: Clustered Column Chart.
- Create a simple unpivoted view or drag `Maths_Marks`, `Science_Marks`, and `English_Marks` into the Values field well (summarized as Average).
- **Y-Axis**: Average Score
- **X-Axis**: Subjects (Maths: 67.55, Science: 68.04, English: 70.13)
- **Insight**: English has the highest average; Mathematics has the widest variance.

#### 4. Chart 3: Pass vs Fail Distribution (Donut Chart)
- **Visual Type**: Donut Chart.
- **Legend**: `Result`
- **Values**: `Count of Student_ID`
- **Colors**: Set `Pass` to Green/Teal (`#2E7D32`) and `Fail` to Soft Red (`#C62828`).
- **Data Labels**: Category + Percentage (`Pass: 87.0%`, `Fail: 13.0%`).

#### 5. Chart 4: Attendance vs Academic Performance (Column Chart / Matrix)
- Add a calculated column for Attendance Bracket:
```dax
Attendance Bracket = 
SWITCH(
    TRUE(),
    student_performance[Attendance_Percentage] >= 85, "High (>=85%)",
    student_performance[Attendance_Percentage] >= 75, "Moderate (75-84%)",
    "Low (<75%)"
)
```
- **Visual Type**: Clustered Column Chart.
- **X-Axis**: `Attendance Bracket`
- **Y-Axis**: `Average Marks` and `Count of Failures`
- **Insight**: Confirms that 100% of failed students fall into the `<75%` attendance bracket.

#### 6. Interactive Slicer
- **Visual Type**: Slicer.
- **Field**: `Department`
- Allows viewers to click any department (e.g. Mechanical Engineering) and watch all KPI cards and charts filter instantly.

---

## 3. Option B: Step-by-Step Implementation in Tableau (Public / Desktop)

### Step 1: Connect to Data
1. Launch Tableau and click **Text file**.
2. Select `student_performance.csv`.
3. Check the Data Source tab to ensure all 10 columns are recognized properly.

### Step 2: Create Calculated Fields
- In the Data pane, click the drop-down next to search -> **Create Calculated Field**:
  - **Pass Count**: `IF [Result] = 'Pass' THEN 1 ELSE 0 END`
  - **Pass Rate**: `SUM([Pass Count]) / COUNT([Student ID])` (Format as Percentage, 1 decimal)
  - **Attendance Tier**:
    ```tableau
    IF [Attendance Percentage] >= 85 THEN "High (>=85%)"
    ELSEIF [Attendance Percentage] >= 75 THEN "Moderate (75-84%)"
    ELSE "Low (<75%)"
    END
    ```

### Step 3: Create Individual Worksheets

1. **Sheet 1 - Department Comparison**:
   - Drag `Department` to **Rows**.
   - Drag `Average Marks` to **Columns** (Set aggregation to `AVG`).
   - Sort descending. Turn on Mark Labels.

2. **Sheet 2 - Subject Averages**:
   - Drag `Measure Names` to **Columns**, filter to `AVG(Maths Marks)`, `AVG(Science Marks)`, `AVG(English Marks)`.
   - Drag `Measure Values` to **Rows**.

3. **Sheet 3 - Pass vs Fail Donut / Pie**:
   - Change Marks card to **Pie**.
   - Drag `Result` to **Color**.
   - Drag `Student ID` (Count) to **Angle** and **Label**.
   - Add Quick Table Calculation -> **Percent of Total**.

4. **Sheet 4 - Attendance vs Pass Rate**:
   - Drag `Attendance Tier` to **Columns**.
   - Drag `Pass Rate` and `AVG(Average Marks)` to **Rows**.

### Step 4: Assemble the Interactive Dashboard
1. Click **New Dashboard** (Size: `1200 x 800` Fixed or Automatic).
2. Add a Header Text box: `Student Academic Performance Analysis`.
3. Drag 4 KPI text / measure boxes across the top.
4. Place Sheet 1 and Sheet 2 side-by-side in the middle container.
5. Place Sheet 3 and Sheet 4 side-by-side in the bottom container.
6. Click on Sheet 1 (Department) -> click **Use as Filter** (funnel icon) so clicking a department cross-filters the entire dashboard.

---

## 4. Standalone Interactive Preview (`dashboard_mockup.html`)

For immediate preview and college presentation without requiring installed software, open [dashboard_mockup.html](file:///c:/Users/hp/Desktop/BA_role_proj/Student_Performance_Analysis/dashboard_mockup.html) in any web browser. It renders the exact KPI metrics, dynamic departmental filters, and charts matching this specification.
