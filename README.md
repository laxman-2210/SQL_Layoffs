# Layoffs Data Cleaning & Analysis with SQL

This project contains SQL scripts designed to **clean**, **transform**, and **analyze** a dataset on layoffs across different companies, industries, and countries. It demonstrates practical use of **data cleaning techniques**, **CTEs**, **window functions**, **data transformation**, and **basic analytics** using MySQL.

---

## 📁 File Included

- `practice.sql` — The main SQL script containing all queries, transformations, and analysis logic.

---

## ⚙️ Key Operations Performed

### 🔧 Data Staging & Cleaning
- **Created staging tables** (`layoffs_staging`, `layoffs_staging2`) for data manipulation.
- Used **`ROW_NUMBER()`** to identify and remove duplicate records.
- Trimmed whitespace from `company` and `country` names.
- Standardized industry labels (e.g., merging various `Crypto` variants into one).
- Converted `date` from text to proper `DATE` format using `STR_TO_DATE()` and altered the column type.
- Handled missing/null `industry`, `total_laid_off`, and `percentage_laid_off` values.
- Deleted rows with no layoff data.

### 📊 Data Analysis
- Found companies/industries/countries with the highest layoffs.
- Identified years and dates with the largest layoff volumes.
- Calculated **average total layoffs** and **average layoff percentage** by company and industry.
- Aggregated total layoffs by:
  - `industry`
  - `company`
  - `country`
  - `year`

---

## 🧠 Concepts Used

- **Common Table Expressions (CTEs)**
- **Window Functions** (`ROW_NUMBER()`)
- **String Functions** (`TRIM`, `SUBSTRING`)
- **Date Functions** (`STR_TO_DATE`, `YEAR`)
- **Joins** (for null value imputation)
- **Aggregate Functions** (`SUM`, `AVG`, `MAX`)
- **Data Cleaning Practices** in SQL

---

## 💡 How to Use

1. Make sure you have MySQL installed and configured.
2. Load your original `layoffs` table into your database.
3. Execute the script `practice.sql` step-by-step or run it in your SQL IDE (e.g., MySQL Workbench).
4. Observe the cleaned data in `layoffs_staging2`.
5. Analyze the final results using the queries provided.

---

## ✅ Output Tables

- `layoffs_staging2`: Final cleaned and structured table ready for reporting or exporting to dashboards.

---

## 📌 Note

This project is built for practice purposes. You can extend it by connecting the cleaned data to BI tools like Power BI or Tableau, or even turn it into an API with a backend.

---

## 📬 Contact

If you have any questions or suggestions, feel free to open an issue or connect via GitHub Discussions.


