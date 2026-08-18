# Swiggy Restaurant Analysis Using SQL

## Overview

This project analyzes **148,541 Swiggy restaurant listings** across Indian cities using **SQLite and SQL**. The goal is to transform raw restaurant data into meaningful business insights by examining restaurant ratings, cuisine patterns, restaurant-chain presence, pricing, and city-level performance.

## Objectives

- Analyze the distribution of Swiggy restaurants across cities.
- Identify areas with the highest average restaurant ratings.
- Find the most common cuisine combinations.
- Identify restaurant chains with the largest outlet presence.
- Analyze restaurant pricing patterns.
- Compare restaurant density, ratings, and average cost across cities.

## Dataset

The project uses the Swiggy Restaurants Dataset containing restaurant-level information such as:

- Restaurant ID
- Restaurant name
- City
- Rating
- Rating count
- Cost
- Cuisine
- License number
- Restaurant link
- Address
- Menu link

The raw dataset contains **148,541 restaurant records**.

## Tools & Technologies

- **SQLite**
- **DB Browser for SQLite**
- **SQL**
- Git / GitHub

## SQL Concepts Used

- Data cleaning
- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`
- Aggregate functions
- `COUNT()`
- `COUNT(DISTINCT ...)`
- `AVG()`
- `MIN()` / `MAX()`
- `CASE`
- `CAST()`
- `ROUND()`
- SQL Views

## Project Structure

```text
swiggy-sql-analysis/
│
├── sql/
│   └── swiggy_restaurant_analysis.sql
│
├── findings.md
│
└── README.md
```

## Key Findings

1. Mylapore, Chennai recorded the highest average rating at **4.23** among areas with at least 50 rated restaurants.
2. **North Indian + Chinese** was the most common cuisine combination with **6,471 listings**.
3. **Domino's Pizza** had the largest listed restaurant footprint with **442 outlets**.
4. Approximately **70.76%** of restaurants fell within the **₹150–₹349** price range.
5. Restaurant density did not always correspond to higher customer ratings; for example, Bikaner had 1,666 listings with a 4.04 average rating, while Kukatpally had 1,009 listings with a 3.58 average rating.

## Detailed Findings

See [`findings.md`](findings.md) for the detailed analysis and methodology.

## Author

**Likhith M**
