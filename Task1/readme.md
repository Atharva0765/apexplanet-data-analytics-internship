# Task 1 - Data Immersion & Wrangling
## Objective
To rapidly acquaint with the provided dataset and master 
the critical first step of any analysis: acquiring, 
cleaning, and preparing data for analysis.

## Dataset
- Name: Superstore Sales Dataset (train)
- Source: Kaggle
- Total Rows: 9,800
- Total Columns: 18

## Tools Used
- Microsoft Excel
- DBeaver (SQLite)

## Steps Completed

### Step 1 - Data Access & Familiarization
- Downloaded Superstore Sales dataset from Kaggle
- Studied all 18 columns
- Created Data Dictionary documenting each column's
  name, data type, meaning and business relevance

### Step 2 - Data Quality Assessment
- Checked missing values → 0 found
- Checked duplicate rows → 1 found and removed
- Checked Sales stats → Min: 0.44, Max: 22638, Avg: 230.77
- Checked Category and Region distribution
- Documented all findings in Quality Report

### Step 3 - Data Cleaning & Transformation
- Removed 1 duplicate row
- Fixed Postal Code → converted to text format
- Added new column → Shipping Duration (days)
- Saved final cleaned dataset

## Key Findings
- No missing values found
- 1 duplicate row removed
- Postal Code fixed (leading zero added)
- Shipping Duration added (2-7 days average)
- Sales outlier detected (Max: 22,638)

## Deliverables
- Superstore_Data_Dictionary.xlsx
- train_clean_dataset.csv
- cleaning_script.sql
