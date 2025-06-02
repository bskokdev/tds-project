-- SQL PART
-- DD S15 L01: String concatenation and DISTINCT
SELECT
  username || ' | ' || email AS pipe_concat,
  CONCAT(full_name, CONCAT(' - ', NVL(expertise, 'Generalist'))) AS function_concat,
  full_name || ' - ' || NVL(expertise, 'Generalist') AS pipe_concat_alternative
FROM Contributor
WHERE ROWNUM <= 5;

SELECT DISTINCT primary_language FROM Project;

-- DD S16 L02: WHERE conditions and case functions
SELECT * FROM Contributor
WHERE UPPER(expertise) = 'DEVOPS';

SELECT INITCAP(full_name) AS proper_name FROM Contributor;

-- DD S16 L03: Advanced filtering
SELECT * FROM Contribution
WHERE lines_of_code BETWEEN 100 AND 500;

SELECT * FROM Project
WHERE repository_url LIKE 'https://github.com/%';

SELECT * FROM Issue
WHERE priority IN ('High', 'Critical');

SELECT * FROM Contributor
WHERE email IS NOT NULL AND expertise IS NOT NULL;

-- DD S17 L01: Logical operators
SELECT * FROM Issue
WHERE (priority = 'High' OR status_id = 1)
  AND NOT (assignee_id IS NULL);

-- DD S17 L02: Sorting
SELECT * FROM Contribution
ORDER BY lines_of_code DESC;

-- DD S17 L03: Single and aggregate functions
SELECT MIN(lines_of_code), MAX(lines_of_code),
       AVG(lines_of_code), SUM(lines_of_code), COUNT(*)
FROM Contribution;

-- SQL S01 L01: String functions
SELECT
    LOWER(username), UPPER(expertise), INITCAP(full_name),
    SUBSTR(email, 1, 5),
    INSTR(email, '@'), LPAD(contributor_id, 5, '0'),
    RPAD(full_name, 20, '.'), TRIM(' ' FROM expertise)
FROM Contributor CROSS JOIN DUAL;

-- SQL S01 L02: Numeric functions
SELECT
    ROUND(123.4567, 2), TRUNC(123.4567, 2),
    MOD(1500, 1000)
FROM DUAL;

-- SQL S01 L03: Date functions
SELECT
    MONTHS_BETWEEN(SYSDATE, creation_date),
    ADD_MONTHS(creation_date, 3),
    NEXT_DAY(creation_date, 'FRIDAY'),
    LAST_DAY(creation_date),
    ROUND(creation_date, 'MONTH'),
    TRUNC(creation_date, 'YEAR')
FROM Project;

-- SQL S02 L01: Conversion functions
SELECT
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
    TO_NUMBER('123.45'),
    TO_DATE('2024-01-15', 'YYYY-MM-DD')
FROM DUAL;

-- SQL S02 L03: Conditional logic
SELECT
    c.full_name,
    -- DECODE example with contributor's most used project language
    DECODE(
        (SELECT p.primary_language
         FROM Project p
         JOIN Contribution ct ON p.project_id = ct.project_id
         WHERE ct.contributor_id = c.contributor_id
         AND ROWNUM = 1),  -- get just one language per contributor
        'Java', 'JVM',
        'JavaScript', 'Web',
        'Python', 'Data',
        'Other'
    ) AS language_category,

    -- CASE example with contributor stats
    CASE
        WHEN c.total_contributions > 100 THEN 'Expert'
        WHEN c.total_contributions > 50 THEN 'Advanced'
        WHEN c.total_contributions > 0 THEN 'Beginner'
        ELSE 'New'
    END AS experience_level,

    -- Complex CASE with multiple conditions
    CASE
        WHEN c.total_contributions > 100 AND
             EXISTS (SELECT 1 FROM Mentorship WHERE mentor_id = c.contributor_id)
        THEN 'Senior Mentor'
        WHEN c.total_contributions > 50 THEN 'Mid-Level'
        WHEN EXISTS (SELECT 1 FROM Mentorship WHERE mentee_id = c.contributor_id)
        THEN 'In Training'
        ELSE 'General Contributor'
    END AS role_type
FROM
    Contributor c
WHERE
    ROWNUM <= 10
ORDER BY
    c.total_contributions DESC;

-- SQL S03 L01: Basic joins
SELECT * FROM Project NATURAL JOIN Status;

SELECT * FROM Contributor CROSS JOIN Project
WHERE ROWNUM < 5;

-- SQL S03 L02: Standard joins
SELECT p.name, c.username
FROM Project p JOIN Contributor c ON p.maintainer_id = c.contributor_id;

SELECT p.name, t.name
FROM Project p JOIN ProjectTechnology pt USING (project_id)
               JOIN Technology t USING (technology_id);

-- SQL S03 L03: Outer joins
SELECT p.name, COUNT(c.contribution_id)
FROM Project p LEFT JOIN Contribution c ON p.project_id = c.project_id
GROUP BY p.name;

SELECT c.username, COUNT(i.issue_id)
FROM Contributor c RIGHT JOIN Issue i ON c.contributor_id = i.reporter_id
GROUP BY c.username;

-- SQL S03 L03: FULL OUTER JOIN
SELECT
    NVL(c.usernme, 'No contributor') AS contributor,
    NVL(o.name, 'No organization') AS organization,
    NVL(co.role, 'No role') AS current_role
FROM Contributor c
FULL OUTER JOIN ContributorOrganization co ON c.contributor_id = co.contributor_id
FULL OUTER JOIN Organization o ON co.organization_id = o.organization_id;

-- SQL S03 L04: Self join and hierarchical
SELECT t1.name AS technology, t2.name AS parent
FROM Technology t1 LEFT JOIN Technology t2 ON t1.parent_technology_id = t2.technology_id;

SELECT LPAD('--', 2*(LEVEL-1)) || name AS hierarchy
FROM Technology
START WITH parent_technology_id IS NULL
CONNECT BY PRIOR technology_id = parent_technology_id;

-- SQL S04 L02: Basic aggregates
SELECT
    AVG(lines_of_code), COUNT(*), MIN(table_date),
    MAX(table_date), SUM(lines_of_code),
    VARIANCE(lines_of_code), STDDEV(lines_of_code)
FROM Contribution;

-- SQL S04 L03: Count variants
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT contributor_id) AS unique_contributors,
    COUNT(lines_of_code) AS non_null_loc,
    NVL(AVG(lines_of_code), 0) AS avg_loc
FROM Contribution;

-- SQL S05 L01: Grouping
SELECT project_id, AVG(lines_of_code)
FROM Contribution
GROUP BY project_id
HAVING AVG(lines_of_code) > 50;

-- SQL S05 L02: Advanced grouping
SELECT primary_language, status_id, COUNT(*)
FROM Project
GROUP BY ROLLUP(primary_language, status_id);

-- SQL S05 L02: GROUP BY CUBE
SELECT
    NVL(TO_CHAR(p.status_id), 'All Statuses') AS status,
    NVL(p.primary_language, 'All Languages') AS language,
    COUNT(*) AS project_count,
    AVG(NVL(c.lines_of_code, 0)) AS avg_lines
FROM Project p
LEFT JOIN Contribution c ON p.project_id = c.project_id
GROUP BY CUBE(p.status_id, p.primary_language)
ORDER BY
    GROUPING(p.status_id),
    GROUPING(p.primary_language),
    p.status_id,
    p.primary_language;

-- SQL S05 L03: Set operations

-- 1. UNION (distinct combined records)
SELECT contributor_id AS id, 'Contribution' AS source
FROM Contribution
WHERE project_id = 1  -- Example filter
UNION
SELECT reporter_id AS id, 'Issue Reporter' AS source
FROM Issue
WHERE status_id = 2   -- Example filter
ORDER BY id;

-- 2. UNION ALL (all records including duplicates)
SELECT contributor_id AS id, 'Contribution' AS source, table_date AS activity_date
FROM Contribution
UNION ALL
SELECT reporter_id AS id, 'Issue Reported' AS source, creation_date AS activity_date
FROM Issue
ORDER BY activity_date DESC
FETCH FIRST 10 ROWS ONLY;

-- 3. INTERSECT (only common records)
SELECT contributor_id
FROM Contributor
WHERE join_date > DATE '2014-01-01'
INTERSECT
SELECT contributor_id
FROM Contribution
WHERE lines_of_code > 10
ORDER BY contributor_id;

-- 4. MINUS (records in first query but not second)
SELECT contributor_id
FROM Contributor
WHERE expertise LIKE '%DevOps%'
MINUS
SELECT mentor_id
FROM Mentorship
WHERE mentee_id IS NOT NULL
ORDER BY contributor_id DESC;

-- SQL S06 L01: Subqueries
SELECT name FROM Project
WHERE project_id = (SELECT MAX(project_id) FROM Project);

-- SQL S06 L03: Multi-row subqueries
SELECT name FROM Project
WHERE project_id IN (SELECT project_id FROM Contribution GROUP BY project_id HAVING COUNT(*) > 0);

-- SQL S06 L04: WITH clause
WITH TopContributors AS (
    SELECT contributor_id FROM Contributor ORDER BY total_contributions DESC FETCH FIRST 5 ROWS ONLY
)
SELECT * FROM Contribution WHERE contributor_id IN (SELECT contributor_id FROM TopContributors);

-- SQL S07 L02: UPDATE/DELETE
UPDATE Contributor SET expertise = 'Senior ' || expertise
WHERE total_contributions > 100;

DELETE FROM ProjectTechnology WHERE added_date < ADD_MONTHS(SYSDATE, -12);

-- SQL S08 L03: Table maintenance
ALTER TABLE Contributor ADD (twitter_handle VARCHAR2(50));

COMMENT ON TABLE Project IS 'Main project information repository';

-- SQL S10 L02: Constraints
ALTER TABLE Contribution ADD (
    CONSTRAINT ck_contribution_type CHECK (type IN ('CODE', 'DOCS', 'TEST')),
    CONSTRAINT fk_contribution_project FOREIGN KEY (project_id)
        REFERENCES Project(project_id) ON DELETE CASCADE
    );

-- SQL S10 L03: Constraint queries
SELECT constraint_name, constraint_type, search_condition
FROM USER_CONSTRAINTS
WHERE table_name = 'CONTRIBUTION';

-- SQL S11 L01: Views
CREATE OR REPLACE FORCE VIEW ActiveContributors AS
SELECT * FROM Contributor WHERE total_contributions > 0
WITH CHECK OPTION;

-- SQL S11 L03: Inline view
SELECT p.name, c.count
FROM Project p,
     (SELECT project_id, COUNT(*) as count FROM Contribution GROUP BY project_id) c
WHERE p.project_id = c.project_id;

-- SQL S12 L01: Sequences
CREATE SEQUENCE issue_seq
    START WITH 1000 INCREMENT BY 1
    NOCACHE NOCYCLE;

-- SQL S12 L02: Indexes
CREATE INDEX idx_contributor_email ON Contributor(email);

-- SQL S13 L01: Privileges
GRANT SELECT, INSERT ON Contributor TO reporter_role;
REVOKE DELETE ON Project FROM developer_role;

-- SQL S13 L03: Regex
SELECT full_name FROM Contributor
WHERE REGEXP_LIKE(email, '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$');

-- SQL S15 L01: Legacy joins
SELECT p.name, c.username
FROM Project p, Contributor c
WHERE p.maintainer_id = c.contributor_id(+);

-- SQL S16 L03: Miscellaneous
-- Additional functions not covered elsewhere
SELECT
    GREATEST(10, 20, 15),
    LEAST(10, 20, 15),
    NULLIF(10, 10),
    COALESCE(NULL, NULL, 'default')
FROM DUAL;
