# JobPulse — Data Analyst Job Market Analysis

SQL + Python project analyzing 2,000+ Data Analyst job postings to uncover hiring trends, top companies, and salary patterns across US cities.

## Problem statement

Anyone applying for a Data Analyst role faces the same questions: Which companies are actually hiring the most? Which cities have the strongest demand? Does a company's reputation (its Glassdoor rating) actually translate into a better salary offer, or is that assumption wrong?

This project answers those questions directly from data — cleaning a raw, messy job-postings dataset in SQL and analyzing it to surface concrete, evidence-backed answers instead of relying on general assumptions about the job market.

## Why this project

I built this to refresh my SQL and Python fundamentals with a hands-on, end-to-end project — going from a raw, messy dataset to clean data to actual insights, the way a real analyst workflow looks.

## Tools used

- **PostgreSQL** — data storage, cleaning, and analysis (window functions, CASE statements, aggregations)
- **Python (pandas, matplotlib)** — exploratory data analysis and visualization
- **Jupyter Notebook** — analysis environment

## Dataset

[Data Analyst Jobs (Glassdoor)](https://www.kaggle.com/datasets/andrewmvd/data-analyst-jobs) — 2,253 job postings scraped from Glassdoor, including job title, company, location, salary estimate, rating, industry, and more.

## Process

### 1. Load data
Raw CSV imported into a PostgreSQL table (`data_analyst_jobs`) using pgAdmin.

### 2. Clean data (SQL)
- **Removed 6 duplicate postings** using `ROW_NUMBER()` / `MIN(id)` logic
- **Fixed missing ratings**: 269 rows had a placeholder value of `-1` instead of a real rating — converted to `NULL` so they don't skew averages
- **Extracted numeric salary range** from text like `"$37K-$66K (Glassdoor est.)"` into two clean columns, `salary_min` and `salary_max`, using regex (`SUBSTRING`)

### 3. Analyze (SQL)
Wrote queries to answer:
- Which companies post the most Data Analyst jobs?
- Which cities have the highest demand?
- Within each city, which company dominates hiring? *(using the `RANK()` window function)*
- Does a company's Glassdoor rating correlate with the salary it offers?

Full queries: [`data_cleaning_and_analysis.sql`](./data_cleaning_and_analysis.sql)

### 4. Visualize (Python)
Connected Python to the cleaned PostgreSQL table and built exploratory charts: job distribution by city, top hiring companies, salary distribution, and rating vs. salary.

Notebook: [`eda_analysis.ipynb`](./eda_analysis.ipynb)

## Key findings

- **New York, NY dominates hiring** — 309 postings, more than double the next city (Chicago, 128)
- **Staffigo Technical Services, LLC** posted the most jobs overall (58), well ahead of any other single company — likely a staffing/recruiting agency rather than a direct employer
- **Hiring leaders vary a lot by city** — Apple leads in Santa Clara, Reliable Software Resources in New York, Avacend in Denver — showing demand isn't concentrated in just big tech
- **Company rating has little to no effect on salary offered.** Highly-rated companies (4+ stars) offered an average max salary of ~$93K, while low-rated companies (under 3 stars) offered ~$86K — a small gap that suggests rating and pay aren't strongly linked in this market

## Files in this repo

| File | Description |
|---|---|
| `DataAnalyst.csv` | Original raw dataset (Glassdoor, via Kaggle) |
| `cleaned_data_analyst_jobs.csv` | Cleaned dataset, exported after SQL processing |
| `data_cleaning_and_analysis.sql` | All SQL queries — cleaning + analysis |
| `eda_analysis.ipynb` | Python notebook — loads cleaned data, generates charts |
| `README.md` | This file |

## Author

**Aditya Sharma** — Data Analyst | SQL • Python • Power BI
[LinkedIn](https://linkedin.com/in/aditya-sharma-data-analyst) · [GitHub](https://github.com/aditya-datahub)
