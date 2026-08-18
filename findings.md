# Swiggy Restaurant Analysis — Key Findings

## Project Overview

This project analyzes 148,541 Swiggy restaurant listings using SQLite to identify patterns in restaurant ratings, cuisine preferences, restaurant-chain presence, pricing, and city-level performance.

## Key Insights

- **Mylapore, Chennai recorded the highest average rating:** Among areas with at least 50 rated restaurants, Mylapore, Chennai ranked first with an average rating of **4.23** across **94 rated restaurants**.

- **North Indian + Chinese was the most common cuisine combination:** This combination appeared in **6,471 restaurant listings**, followed by Indian (6,414), Chinese (5,051), and North Indian (4,775). This indicates strong representation of Indian and Chinese food categories on the platform.

- **Domino's Pizza had the largest restaurant footprint:** Domino's Pizza had **442 listed outlets**, followed by Pizza Hut (319), KFC (309), and Kwality Walls (300). This highlights the strong presence of large QSR and dessert chains in the dataset.

- **Restaurants were heavily concentrated in the ₹150–₹349 price range:** There were **53,849 restaurants (36.25%)** in the ₹150–₹249 range and **51,266 (34.51%)** in the ₹250–₹349 range. Combined, these two segments account for approximately **70.76%** of the dataset.

- **Restaurant density did not always correspond to higher ratings:** Bikaner had the highest restaurant count in the final city summary with **1,666 listings** and an average rating of **4.04**. In contrast, Kukatpally, Hyderabad had **1,009 listings** but an average rating of only **3.58**, showing that a larger restaurant supply does not necessarily imply higher customer satisfaction.

## Methodology

The analysis was performed using SQLite. The raw dataset was first inspected and a cleaned `swiggy_clean` view was created to:

- Trim unnecessary whitespace from text fields.
- Convert unavailable ratings (`--`) to `NULL`.
- Convert restaurant costs from text such as `₹200` into numeric values.
- Preserve the original `swiggy` table as the raw dataset.

SQL techniques used include:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `COUNT()`
- `COUNT(DISTINCT ...)`
- `AVG()`
- `MIN()` / `MAX()`
- `CASE`
- `CAST()`
- `ROUND()`

## Conclusion

The analysis shows a Swiggy restaurant ecosystem dominated by affordable-to-mid-range restaurants, strong Indian and Chinese cuisine representation, and extensive coverage from major QSR chains. City-level analysis also demonstrates that restaurant availability and customer ratings can vary independently, making both supply and customer satisfaction important metrics for business analysis.
