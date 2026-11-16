-- =============================================================================
-- PROJECT: Student Performance Analysis
-- FILE: analysis_queries.sql
-- DESCRIPTION: PostgreSQL Table Definition, Data Import, and 10 Beginner Queries
-- AUTHOR: Student / Fresher Business Analyst
-- DATABASE: PostgreSQL 12+ / 14+ / 16+ / 18+
-- =============================================================================

-- -----------------------------------------------------------------------------
-- STEP 1: CREATE TABLE
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS student_performance;

CREATE TABLE student_performance (
    student_id             VARCHAR(10) PRIMARY KEY,
    student_name           VARCHAR(100) NOT NULL,
    department             VARCHAR(50)  NOT NULL,
    attendance_percentage  INT          NOT NULL,
    maths_marks            INT          NOT NULL,
    science_marks          INT          NOT NULL,
    english_marks          INT          NOT NULL,
    total_marks            INT          NOT NULL,
    average_marks          NUMERIC(5,2) NOT NULL,
    result                 VARCHAR(10)  NOT NULL
);

-- -----------------------------------------------------------------------------
-- STEP 2: IMPORT DATA FROM CSV
-- Method A (Using psql CLI):
-- Run this command in psql or terminal (replace with full path if needed):
-- \copy student_performance FROM 'student_performance.csv' WITH (FORMAT csv, HEADER true);
--
-- Method B (Using pgAdmin GUI):
-- 1. Right click on table 'student_performance' -> Import/Export Data.
-- 2. Select 'Import' slider.
-- 3. Browse to 'student_performance.csv'.
-- 4. Enable Header toggle, select delimiter as comma (,), and click OK.
-- -----------------------------------------------------------------------------


-- =============================================================================
-- 10 BEGINNER-FRIENDLY BUSINESS ANALYTICS SQL QUERIES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- QUERY 1: Basic Data Preview
-- Objective: View the first 10 student records to verify successful data load.
-- Concepts: SELECT, LIMIT
-- -----------------------------------------------------------------------------
SELECT 
    student_id,
    student_name,
    department,
    attendance_percentage,
    total_marks,
    average_marks,
    result
FROM student_performance
LIMIT 10;


-- -----------------------------------------------------------------------------
-- QUERY 2: Top 5 Highest Performing Students
-- Objective: Find the top 5 students based on total marks obtained.
-- Concepts: SELECT, ORDER BY, LIMIT
-- Expected Output: STU1066 (281), STU1012 (259), STU1017 (259), STU1025 (257), STU1035 (257)
-- -----------------------------------------------------------------------------
SELECT 
    student_id,
    student_name,
    department,
    attendance_percentage,
    maths_marks,
    science_marks,
    english_marks,
    total_marks,
    average_marks
FROM student_performance
ORDER BY total_marks DESC
LIMIT 5;


-- -----------------------------------------------------------------------------
-- QUERY 3: Subject-Wise Performance Summary (Average, Minimum, Maximum)
-- Objective: Evaluate batch-level difficulty across Maths, Science, and English.
-- Concepts: SELECT, AVG, MIN, MAX, ROUND
-- Expected Output:
--   Maths:   Avg 67.55 | Min 30 | Max 99
--   Science: Avg 68.04 | Min 30 | Max 98
--   English: Avg 70.13 | Min 35 | Max 93
-- -----------------------------------------------------------------------------
SELECT 
    ROUND(AVG(maths_marks), 2)   AS avg_maths,
    MIN(maths_marks)             AS min_maths,
    MAX(maths_marks)             AS max_maths,
    ROUND(AVG(science_marks), 2) AS avg_science,
    MIN(science_marks)           AS min_science,
    MAX(science_marks)           AS max_science,
    ROUND(AVG(english_marks), 2) AS avg_english,
    MIN(english_marks)           AS min_english,
    MAX(english_marks)           AS max_english
FROM student_performance;


-- -----------------------------------------------------------------------------
-- QUERY 4: Overall Academic KPI Metrics
-- Objective: Calculate total students, average attendance, and average score.
-- Concepts: COUNT, AVG, ROUND
-- Expected Output: 100 students | 78.45% Avg Attendance | 68.57 Avg Marks
-- -----------------------------------------------------------------------------
SELECT 
    COUNT(student_id)            AS total_students,
    ROUND(AVG(attendance_percentage), 2) AS overall_avg_attendance,
    ROUND(AVG(average_marks), 2)         AS overall_avg_marks,
    ROUND(AVG(total_marks), 2)           AS overall_avg_total
FROM student_performance;


-- -----------------------------------------------------------------------------
-- QUERY 5: Pass vs Fail Distribution
-- Objective: Count how many students passed vs failed and calculate percentages.
-- Concepts: SELECT, GROUP BY, COUNT, ROUND
-- Expected Output: Pass: 87 (87.0%) | Fail: 13 (13.0%)
-- -----------------------------------------------------------------------------
SELECT 
    result,
    COUNT(*) AS student_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM student_performance), 2) AS percentage
FROM student_performance
GROUP BY result
ORDER BY student_count DESC;


-- -----------------------------------------------------------------------------
-- QUERY 6: Department-Wise Academic & Attendance Performance
-- Objective: Compare student count, average attendance, and average marks by department.
-- Concepts: SELECT, GROUP BY, AVG, COUNT, ORDER BY
-- Expected Output:
--   Information Technology: 20 students | 82.00% Att | 71.19 Avg Marks (Top)
--   Electrical Engineering: 20 students | 76.50% Att | 68.60 Avg Marks
--   Mechanical Engineering: 20 students | 78.15% Att | 68.13 Avg Marks
--   Computer Science:       20 students | 77.85% Att | 67.97 Avg Marks
--   Civil Engineering:      20 students | 77.75% Att | 66.98 Avg Marks
-- -----------------------------------------------------------------------------
SELECT 
    department,
    COUNT(student_id)                    AS total_students,
    ROUND(AVG(attendance_percentage), 2) AS avg_attendance_pct,
    ROUND(AVG(maths_marks), 2)           AS avg_maths,
    ROUND(AVG(science_marks), 2)         AS avg_science,
    ROUND(AVG(english_marks), 2)         AS avg_english,
    ROUND(AVG(average_marks), 2)         AS overall_avg_marks
FROM student_performance
GROUP BY department
ORDER BY overall_avg_marks DESC;


-- -----------------------------------------------------------------------------
-- QUERY 7: Students with Low Attendance (Below 75% Minimum Requirement)
-- Objective: Identify students at risk due to poor class attendance.
-- Concepts: SELECT, WHERE, ORDER BY
-- Expected Output: 26 students with attendance under 75% (minimum is 52%)
-- -----------------------------------------------------------------------------
SELECT 
    student_id,
    student_name,
    department,
    attendance_percentage,
    average_marks,
    result
FROM student_performance
WHERE attendance_percentage < 75
ORDER BY attendance_percentage ASC;


-- -----------------------------------------------------------------------------
-- QUERY 8: Root Cause Analysis of Failed Students (Failing Subjects Breakdown)
-- Objective: Detect which specific subject(s) each failed student scored under 40 in.
-- Concepts: SELECT, WHERE, CASE WHEN
-- Expected Output: Lists all 13 failed students with failed subject flags
-- -----------------------------------------------------------------------------
SELECT 
    student_id,
    student_name,
    department,
    attendance_percentage,
    maths_marks,
    science_marks,
    english_marks,
    CASE WHEN maths_marks < 40 THEN 'FAIL' ELSE 'PASS' END   AS maths_status,
    CASE WHEN science_marks < 40 THEN 'FAIL' ELSE 'PASS' END AS science_status,
    CASE WHEN english_marks < 40 THEN 'FAIL' ELSE 'PASS' END AS english_status
FROM student_performance
WHERE result = 'Fail'
ORDER BY attendance_percentage ASC;


-- -----------------------------------------------------------------------------
-- QUERY 9: Attendance Bracket Segmentation and Academic Correlation
-- Objective: Classify students into High, Moderate, and Low attendance tiers 
--            and evaluate how attendance impacts average marks and failure count.
-- Concepts: SELECT, CASE WHEN, GROUP BY, COUNT, AVG, SUM
-- Expected Output:
--   High (>=85%):      28 students | Avg 76.42 marks | 0 Failures (100.0% Pass)
--   Moderate (75-84%): 46 students | Avg 74.54 marks | 0 Failures (100.0% Pass)
--   Low (<75%):        26 students | Avg 49.56 marks | 13 Failures (50.0% Pass Rate)
-- -----------------------------------------------------------------------------
SELECT 
    CASE 
        WHEN attendance_percentage >= 85 THEN 'High Attendance (>=85%)'
        WHEN attendance_percentage >= 75 THEN 'Moderate Attendance (75-84%)'
        ELSE 'Low Attendance (<75%)'
    END AS attendance_tier,
    COUNT(*) AS total_students,
    ROUND(AVG(average_marks), 2) AS avg_marks,
    SUM(CASE WHEN result = 'Fail' THEN 1 ELSE 0 END) AS fail_count,
    ROUND(SUM(CASE WHEN result = 'Pass' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pass_rate_pct
FROM student_performance
GROUP BY 
    CASE 
        WHEN attendance_percentage >= 85 THEN 'High Attendance (>=85%)'
        WHEN attendance_percentage >= 75 THEN 'Moderate Attendance (75-84%)'
        ELSE 'Low Attendance (<75%)'
    END
ORDER BY avg_marks DESC;


-- -----------------------------------------------------------------------------
-- QUERY 10: Department-Wise Pass vs Fail Comparison
-- Objective: Compare pass rates across all 5 academic departments.
-- Concepts: SELECT, GROUP BY, SUM, CASE WHEN, ROUND
-- Expected Output:
--   Information Technology: 19 Pass, 1 Fail -> 95.0% Pass Rate
--   Electrical Engineering: 18 Pass, 2 Fail -> 90.0% Pass Rate
--   Mechanical Engineering: 18 Pass, 2 Fail -> 90.0% Pass Rate
--   Computer Science:       17 Pass, 3 Fail -> 85.0% Pass Rate
--   Civil Engineering:      15 Pass, 5 Fail -> 75.0% Pass Rate
-- -----------------------------------------------------------------------------
SELECT 
    department,
    COUNT(*) AS total_students,
    SUM(CASE WHEN result = 'Pass' THEN 1 ELSE 0 END) AS passed_students,
    SUM(CASE WHEN result = 'Fail' THEN 1 ELSE 0 END) AS failed_students,
    ROUND(SUM(CASE WHEN result = 'Pass' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pass_percentage
FROM student_performance
GROUP BY department
ORDER BY pass_percentage DESC;

-- =============================================================================
-- END OF SCRIPT
-- =============================================================================
