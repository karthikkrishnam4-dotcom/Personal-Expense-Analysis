USE expense_analysis;

INSERT INTO
    expenses (
        expense_id,
        date,
        category,
        description,
        amount,
        payment_method
    )
VALUES (
        1,
        '2026-01-02',
        'Food',
        'Breakfast',
        80,
        'UPI'
    ),
    (
        2,
        '2026-01-03',
        'Transport',
        'Bus',
        40,
        'Cash'
    ),
    (
        3,
        '2026-01-05',
        'Food',
        'Lunch',
        150,
        'UPI'
    ),
    (
        4,
        '2026-01-07',
        'Entertainment',
        'Movie',
        250,
        'Card'
    ),
    (
        5,
        '2026-01-10',
        'Shopping',
        'Clothes',
        1200,
        'Card'
    ),
    (
        6,
        '2026-01-12',
        'Bills',
        'Mobile Recharge',
        299,
        'UPI'
    ),
    (
        7,
        '2026-01-15',
        'Food',
        'Dinner',
        220,
        'UPI'
    ),
    (
        8,
        '2026-01-18',
        'Transport',
        'Auto',
        120,
        'Cash'
    ),
    (
        9,
        '2026-01-20',
        'Entertainment',
        'Game',
        300,
        'UPI'
    ),
    (
        10,
        '2026-01-22',
        'Food',
        'Snacks',
        100,
        'Cash'
    ),
    (
        11,
        '2026-01-25',
        'Shopping',
        'Shoes',
        1800,
        'Card'
    ),
    (
        12,
        '2026-01-28',
        'Bills',
        'Electricity',
        650,
        'UPI'
    ),
    (
        13,
        '2026-02-02',
        'Food',
        'Breakfast',
        90,
        'UPI'
    ),
    (
        14,
        '2026-02-05',
        'Transport',
        'Bus',
        50,
        'Cash'
    ),
    (
        15,
        '2026-02-08',
        'Food',
        'Lunch',
        180,
        'UPI'
    ),
    (
        16,
        '2026-02-12',
        'Entertainment',
        'Movie',
        300,
        'Card'
    ),
    (
        17,
        '2026-02-15',
        'Shopping',
        'Accessories',
        500,
        'UPI'
    ),
    (
        18,
        '2026-02-18',
        'Bills',
        'Internet',
        700,
        'UPI'
    ),
    (
        19,
        '2026-02-20',
        'Food',
        'Dinner',
        250,
        'UPI'
    ),
    (
        20,
        '2026-02-24',
        'Transport',
        'Auto',
        150,
        'Cash'
    ),
    (
        21,
        '2026-03-03',
        'Food',
        'Lunch',
        160,
        'UPI'
    ),
    (
        22,
        '2026-03-07',
        'Shopping',
        'Bag',
        900,
        'Card'
    ),
    (
        23,
        '2026-03-15',
        'Bills',
        'Electricity',
        720,
        'UPI'
    ),
    (
        24,
        '2026-03-20',
        'Entertainment',
        'Movie',
        280,
        'Card'
    );
    SELECT * FROM expenses;

    SELECT * FROM expenses WHERE category = 'Food';

    SELECT * FROM expenses WHERE category = 'Food' AND amount > 150;

    SELECT *
FROM expenses
WHERE
    category = 'Food'
    OR category = 'Transport';

    SELECT * FROM expenses ORDER BY amount DESC;

    SELECT * FROM expenses ORDER BY amount DESC LIMIT 5;

    SELECT description, category, amount
FROM expenses
ORDER BY amount DESC
LIMIT 5;

SELECT DISTINCT category FROM expenses;

SELECT DISTINCT payment_method FROM expenses;

SELECT DISTINCT expense_id FROM expenses;

SELECT SUM(amount) AS total_spending FROM expenses;

SELECT AVG(amount) AS average_expense FROM expenses;

SELECT min(amount) AS average_expense FROM expenses;

SELECT max(amount) AS average_expense FROM expenses;

SELECT count(*) AS average_expense FROM expenses;

SELECT category, SUM(amount) AS total_spending
FROM expenses
GROUP BY
    category;

    SELECT category, SUM(amount) AS total_spending
FROM expenses
GROUP BY
    category
    HAVING sum(amount)>1000;

    SELECT
    description,
    amount,
    CASE
        WHEN amount < 200 THEN 'Low'
        WHEN amount <= 500 THEN 'Medium'
        ELSE 'High'
    END AS expense_level
FROM expenses;

SELECT
    CASE
        WHEN amount < 200 THEN 'Low'
        WHEN amount <= 500 THEN 'Medium'
        ELSE 'High'
    END AS expense_level,
    SUM(amount) AS total_spending
FROM expenses
GROUP BY
    CASE
        WHEN amount < 200 THEN 'Low'
        WHEN amount <= 500 THEN 'Medium'
        ELSE 'High'
    END;

    CREATE TABLE payment_methods (
    payment_method VARCHAR(30) PRIMARY KEY,
    type VARCHAR(30)
);

INSERT INTO
    payment_methods
VALUES ('UPI', 'Digital'),
    ('Cash', 'Physical'),
    ('Card', 'Digital');
    SELECT * FROM payment_methods:

    SELECT 
      e.description,
      e.category,
      e.payment_method,
      p.type
      FROM expenses e
      INNER JOIN payment_methods p
      on e.payment_method=p.payment_method;

      SELECT e.description, e.amount, e.payment_method, p.type
FROM expenses e
    LEFT JOIN payment_methods p ON e.payment_method = p.payment_method;

    SELECT e.description, e.amount, p.payment_method, p.type
FROM expenses e
    RIGHT JOIN payment_methods p ON e.payment_method = p.payment_method;

    SELECT p.type, SUM(e.amount) AS total_spending
FROM expenses e
    JOIN payment_methods p ON e.payment_method = p.payment_method
GROUP BY
    p.type;

    SELECT description, amount
FROM expenses
WHERE
    amount > (
        SELECT AVG(amount)
        FROM expenses
    );

    WITH
    average_expense AS (
        SELECT AVG(amount) AS avg_amount
        FROM expenses
    )
SELECT description, amount
FROM expenses
WHERE
    amount > (
        SELECT avg_amount
        FROM average_expense
    );
    SELECT
    description,
    amount,
    RANK() OVER (
        ORDER BY amount DESC
    ) AS expense_rank
FROM expenses;
SELECT description, amount, ROW_NUMBER() OVER (
        ORDER BY amount DESC
    ) AS row_num
FROM expenses;

SELECT description, amount, DENSE_RANK() OVER (
        ORDER BY amount DESC
    ) AS row_num
FROM expenses;
SELECT
    category,
    description,
    amount,
    RANK() OVER (
        PARTITION BY
            category
        ORDER BY amount DESC
    ) AS category_rank
FROM expenses;

SELECT
    date,
    description,
    amount,
    SUM(amount) OVER (
        ORDER BY date
    ) AS running_total
FROM expenses
ORDER BY date;
SELECT
    date,
    description,
    amount,
    LAG(amount) OVER (
        ORDER BY date
    ) AS previous_amount
FROM expenses
ORDER BY date;
SELECT
    date,
    description,
    amount,
    LEAD(amount) OVER (
        ORDER BY date
    ) AS previous_amount
FROM expenses
ORDER BY date;
SELECT date, YEAR(date) AS year FROM expenses;
SELECT date, MONTH(date) AS month FROM expenses;

SELECT date, MONTHNAME(date) AS month_name FROM expenses;

SELECT MONTH(date) AS month, SUM(amount) AS total_spending
FROM expenses
GROUP BY
    MONTH(date)
ORDER BY month;

SELECT date, DATE_FORMAT(date, '%b %Y') AS month_year
FROM expenses;

SELECT DATE_FORMAT(date, '%b %Y') AS month_year, SUM(amount) AS total_spending
FROM expenses
GROUP BY
    DATE_FORMAT(date, '%b %Y');

    SELECT category, COUNT(*) AS expense_count
FROM expenses
GROUP BY
    category;

    SELECT COUNT(DISTINCT category) AS total_categories
FROM expenses;

SELECT COUNT(DISTINCT payment_method) AS total_categories
FROM expenses;
SELECT * FROM expenses WHERE description IS NOT NULL;

SELECT COUNT(*) - COUNT(description) AS missing_descriptions
FROM expenses;

SELECT COALESCE(NULL, 0) AS result;

SELECT
    expense_id,
    COALESCE(description, 'No Description') AS description,
    amount
FROM expenses;

SELECT COALESCE(amount, 0) AS amount FROM expenses;

SELECT
    SUM(
        CASE
            WHEN category = 'Food' THEN amount
            ELSE 0
        END
    ) AS food_spending,
    SUM(
        CASE
            WHEN category = 'Transport' THEN amount
            ELSE 0
        END
    ) AS transport_spending,
    SUM(
        CASE
            WHEN category = 'Shopping' THEN amount
            ELSE 0
        END
    ) AS shopping_spending,
    SUM(
        CASE
            WHEN category = 'Bills' THEN amount
            ELSE 0
        END
    ) AS bills_spending,
    SUM(
        CASE
            WHEN category = 'Entertainment' THEN amount
            ELSE 0
        END
    ) AS entertainment_spending
FROM expenses;
SELECT
    COUNT(
        CASE
            WHEN category = 'Food' THEN 1
        END
    ) AS food_count,
    COUNT(
        CASE
            WHEN category = 'Transport' THEN 1
        END
    ) AS transport_count,
    COUNT(
        CASE
            WHEN category = 'Shopping' THEN 1
        END
    ) AS shopping_count
FROM expenses;
SELECT payment_method
FROM expenses
WHERE
    category = 'Food'
UNION
SELECT payment_method
FROM expenses
WHERE
    category = 'Shopping';
    SELECT payment_method
FROM expenses
WHERE
    category = 'Food'
UNION ALL
SELECT payment_method
FROM expenses
WHERE
    category = 'Shopping';
    SELECT
    p.type,
    SUM(e.amount) AS total_spending
FROM expenses e
JOIN payment_methods p
    ON e.payment_method = p.payment_method
GROUP BY p.type
HAVING SUM(e.amount) > 1000;

SELECT
    p.type,
    SUM(e.amount) AS total_spending
FROM expenses e
JOIN payment_methods p
    ON e.payment_method = p.payment_method
GROUP BY p.type
HAVING SUM(e.amount) > 1000;

SELECT
    CASE
        WHEN amount < 200 THEN 'Low'
        WHEN amount <= 500 THEN 'Medium'
        ELSE 'High'
    END AS expense_level,
    COUNT(*) AS number_of_expenses,
    SUM(amount) AS total_spending,
    AVG(amount) AS average_expense
FROM expenses
GROUP BY
    CASE
        WHEN amount < 200 THEN 'Low'
        WHEN amount <= 500 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY total_spending DESC;

select category,sum(amount) as total_spending
from expenses
GROUP BY category
ORDER BY total_spending DESC;

select payment_method,AVG(amount) as average_spend
from expenses
GROUP BY payment_method
ORDER BY average_spend DESC;

SELECT category,max(amount) as max_spend
from expenses
GROUP BY category;

SELECT * from expenses
where amount>(
    SELECT AVG(amount)
    from expenses
)

SELECT
    description,
    category,
    amount,
    ROW_NUMBER() OVER (
        ORDER BY amount DESC
    ) AS expense_rank
FROM expenses
ORDER BY amount DESC
LIMIT 3;
SELECT
    DATE_FORMAT(date, '%b %Y') AS month_year,
    SUM(amount) AS total_spending,
    COUNT(*) AS total_trans
FROM expenses
GROUP BY
    DATE_FORMAT(date, '%b %Y')
ORDER BY MIN(date);