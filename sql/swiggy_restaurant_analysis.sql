-- ============================================================
-- SWIGGY RESTAURANT ANALYSIS
-- SQLite SQL Project
-- Raw dataset: 148,541 restaurant listings
-- ============================================================

-- ============================================================
-- 1. DATA INSPECTION
-- ============================================================

-- Check the imported data
SELECT *
FROM swiggy
LIMIT 10;

-- Check table structure
PRAGMA table_info(swiggy);

-- Total number of restaurant records
SELECT COUNT(*) AS total_restaurants
FROM swiggy;

-- Total number of cities
SELECT COUNT(DISTINCT city) AS total_cities
FROM swiggy;

-- Check rating values
SELECT
    rating,
    COUNT(*) AS restaurant_count
FROM swiggy
GROUP BY rating
ORDER BY restaurant_count DESC;

-- Check rating-count values
SELECT
    rating_count,
    COUNT(*) AS restaurant_count
FROM swiggy
GROUP BY rating_count
ORDER BY restaurant_count DESC;

-- Check cost values
SELECT
    cost,
    COUNT(*) AS restaurant_count
FROM swiggy
GROUP BY cost
ORDER BY restaurant_count DESC;


-- ============================================================
-- 2. DATA CLEANING
-- ============================================================

-- Keep the original swiggy table unchanged.
-- Create a cleaned view for analysis.

DROP VIEW IF EXISTS swiggy_clean;

CREATE VIEW swiggy_clean AS
SELECT
    id,
    TRIM(name) AS name,
    TRIM(city) AS city,

    -- Convert unavailable ratings to NULL and
    -- convert valid ratings from TEXT to REAL.
    CASE
        WHEN rating = '--' OR TRIM(rating) = '' THEN NULL
        ELSE CAST(rating AS REAL)
    END AS rating,

    rating_count,

    -- Remove the currency symbol and commas,
    -- then convert cost to INTEGER.
    CASE
        WHEN cost IS NULL OR TRIM(cost) = '' THEN NULL
        ELSE CAST(
            REPLACE(
                REPLACE(cost, '₹', ''),
                ',', ''
            ) AS INTEGER
        )
    END AS cost,

    TRIM(cuisine) AS cuisine,
    lic_no,
    link,
    address,
    menu
FROM swiggy;

-- Verify cleaned data
SELECT *
FROM swiggy_clean
LIMIT 10;

-- Check rating completeness
SELECT
    COUNT(*) AS total_restaurants,
    COUNT(rating) AS restaurants_with_rating,
    COUNT(*) - COUNT(rating) AS restaurants_without_rating
FROM swiggy_clean;

-- Check cleaned cost statistics
SELECT
    MIN(cost) AS minimum_cost,
    MAX(cost) AS maximum_cost,
    ROUND(AVG(cost), 2) AS average_cost
FROM swiggy_clean;


-- ============================================================
-- 3. CITY ANALYSIS
-- ============================================================

-- Top 20 cities by number of restaurants
SELECT
    city,
    COUNT(*) AS restaurant_count
FROM swiggy_clean
GROUP BY city
ORDER BY restaurant_count DESC
LIMIT 20;

-- Highest-rated cities
-- Minimum 50 rated restaurants
SELECT
    city,
    COUNT(rating) AS rated_restaurants,
    ROUND(AVG(rating), 2) AS average_rating
FROM swiggy_clean
WHERE rating IS NOT NULL
GROUP BY city
HAVING COUNT(rating) >= 50
ORDER BY average_rating DESC
LIMIT 20;

-- Lowest-rated cities
-- Minimum 50 rated restaurants
SELECT
    city,
    COUNT(rating) AS rated_restaurants,
    ROUND(AVG(rating), 2) AS average_rating
FROM swiggy_clean
WHERE rating IS NOT NULL
GROUP BY city
HAVING COUNT(rating) >= 50
ORDER BY average_rating ASC
LIMIT 20;

-- Overall average rating
SELECT
    ROUND(AVG(rating), 2) AS overall_average_rating
FROM swiggy_clean
WHERE rating IS NOT NULL;

-- City-wise average cost
-- Minimum 50 restaurants
SELECT
    city,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(cost), 2) AS average_cost
FROM swiggy_clean
WHERE cost IS NOT NULL
GROUP BY city
HAVING COUNT(*) >= 50
ORDER BY average_cost DESC
LIMIT 20;

-- Final city summary
SELECT
    city,
    COUNT(*) AS total_restaurants,
    COUNT(rating) AS rated_restaurants,
    ROUND(AVG(rating), 2) AS average_rating,
    ROUND(AVG(cost), 2) AS average_cost
FROM swiggy_clean
GROUP BY city
HAVING COUNT(*) >= 50
ORDER BY total_restaurants DESC
LIMIT 30;


-- ============================================================
-- 4. CUISINE ANALYSIS
-- ============================================================

-- Most common cuisine combinations
SELECT
    cuisine,
    COUNT(*) AS restaurant_count
FROM swiggy_clean
WHERE cuisine IS NOT NULL
  AND TRIM(cuisine) <> ''
GROUP BY cuisine
ORDER BY restaurant_count DESC
LIMIT 20;


-- ============================================================
-- 5. RESTAURANT AND CHAIN ANALYSIS
-- ============================================================

-- Most common restaurant names
SELECT
    name,
    COUNT(*) AS restaurant_count
FROM swiggy_clean
WHERE name IS NOT NULL
  AND TRIM(name) <> ''
GROUP BY name
ORDER BY restaurant_count DESC
LIMIT 20;

-- Restaurant chains with the most outlets
SELECT
    name,
    COUNT(*) AS outlet_count,
    COUNT(DISTINCT city) AS city_count
FROM swiggy_clean
WHERE name IS NOT NULL
  AND TRIM(name) <> ''
GROUP BY name
HAVING COUNT(*) >= 5
ORDER BY outlet_count DESC
LIMIT 20;

-- Restaurant chains present in the most cities
SELECT
    name,
    COUNT(DISTINCT city) AS city_count,
    COUNT(*) AS outlet_count
FROM swiggy_clean
WHERE name IS NOT NULL
  AND TRIM(name) <> ''
GROUP BY name
HAVING COUNT(DISTINCT city) >= 5
ORDER BY city_count DESC, outlet_count DESC
LIMIT 20;

-- Restaurant names with at least five outlets
SELECT
    name,
    COUNT(*) AS outlet_count,
    ROUND(AVG(rating), 2) AS average_rating
FROM swiggy_clean
WHERE rating IS NOT NULL
GROUP BY name
HAVING COUNT(*) >= 5
ORDER BY outlet_count DESC
LIMIT 20;


-- ============================================================
-- 6. PRICING ANALYSIS
-- ============================================================

-- Overall average cost
SELECT
    ROUND(AVG(cost), 2) AS average_cost
FROM swiggy_clean
WHERE cost IS NOT NULL;

-- Minimum and maximum cost
SELECT
    MIN(cost) AS minimum_cost,
    MAX(cost) AS maximum_cost
FROM swiggy_clean
WHERE cost IS NOT NULL;

-- Most common price points
SELECT
    cost,
    COUNT(*) AS restaurant_count
FROM swiggy_clean
WHERE cost IS NOT NULL
GROUP BY cost
ORDER BY restaurant_count DESC
LIMIT 20;

-- Price range distribution
SELECT
    CASE
        WHEN cost < 150 THEN 'Below 150'
        WHEN cost BETWEEN 150 AND 249 THEN '150 - 249'
        WHEN cost BETWEEN 250 AND 349 THEN '250 - 349'
        WHEN cost BETWEEN 350 AND 499 THEN '350 - 499'
        ELSE '500+'
    END AS price_range,
    COUNT(*) AS restaurant_count
FROM swiggy_clean
WHERE cost IS NOT NULL
GROUP BY price_range
ORDER BY restaurant_count DESC;


-- ============================================================
-- 7. RATING ANALYSIS
-- ============================================================

-- Rating distribution
SELECT
    rating,
    COUNT(*) AS restaurant_count
FROM swiggy_clean
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY rating DESC;

-- Restaurants without ratings
SELECT
    COUNT(*) AS restaurants_without_rating
FROM swiggy_clean
WHERE rating IS NULL;

-- Percentage with ratings
SELECT
    ROUND(
        100.0 * COUNT(rating) / COUNT(*),
        2
    ) AS percentage_with_rating
FROM swiggy_clean;

-- Percentage without ratings
SELECT
    ROUND(
        100.0 * (COUNT(*) - COUNT(rating)) / COUNT(*),
        2
    ) AS percentage_without_rating
FROM swiggy_clean;

-- Top cities by number of restaurants rated 4.0+
SELECT
    city,
    COUNT(*) AS highly_rated_restaurants
FROM swiggy_clean
WHERE rating >= 4.0
GROUP BY city
ORDER BY highly_rated_restaurants DESC
LIMIT 20;


-- ============================================================
-- 8. HIGHLY RATED / AFFORDABLE RESTAURANTS
-- ============================================================

-- Restaurants rated 4.5 or higher
SELECT
    name,
    city,
    rating,
    cost,
    cuisine
FROM swiggy_clean
WHERE rating >= 4.5
ORDER BY rating DESC, name
LIMIT 50;

-- Highly rated and affordable restaurants
SELECT
    name,
    city,
    rating,
    cost,
    cuisine
FROM swiggy_clean
WHERE rating >= 4.3
  AND cost <= 250
ORDER BY rating DESC, cost ASC
LIMIT 50;


-- ============================================================
-- 9. COMBINED CITY PERFORMANCE
-- ============================================================

SELECT
    city,
    COUNT(*) AS restaurant_count,
    COUNT(rating) AS rated_restaurants,
    ROUND(AVG(rating), 2) AS average_rating,
    ROUND(AVG(cost), 2) AS average_cost
FROM swiggy_clean
GROUP BY city
HAVING COUNT(*) >= 50
ORDER BY restaurant_count DESC
LIMIT 20;


-- ============================================================
-- END OF PROJECT
-- ============================================================
