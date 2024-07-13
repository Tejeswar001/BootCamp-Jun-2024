# Customer Churn Analysis

## Overview

Customer churn refers to the phenomenon of customers discontinuing their subscriptions or relationships with a company. This analysis aims to understand the factors influencing customer churn in a telecommunications company. Specifically, we explore how various factors such as payment method, contract type, and tenure affect the likelihood of customers churning.

## Notebook Structure

1. **Introduction**
    - Explanation of customer churn and its significance to businesses.
    - Brief description of the dataset and key columns (e.g., `Partner`, `Dependents`, `tenure`, `TotalCharges`).

2. **Import Libraries**
    - Importing necessary Python libraries for data manipulation and visualization.

3. **Load Data**
    - Loading the dataset into a pandas DataFrame.

4. **Data Exploration**
    - Checking for missing values and handling them appropriately.
    - Correcting data types where necessary (e.g., `TotalCharges` should be a float).

5. **Data Analysis and Visualization**
    - Analyzing the distribution of total charges by different payment methods and churn status.
    - Analyzing tenure by contract type and churn status.

6. **Visualizations**
    - **Total Charges by Payment Method and Churn**: A violin plot depicting how total charges vary with different payment methods and their association with churn.
    - **Tenure by Contract Type and Churn**: A violin plot illustrating how tenure varies with different contract types and its impact on churn.

## Conclusion

- Customers with month-to-month contracts and those paying by electronic check exhibit a higher likelihood of churn.
- Longer contract terms and automatic payment methods are associated with lower churn rates and higher total charges.
- Customers with longer tenures are less likely to churn, particularly those on one-year and two-year contracts.

## How to Run the Notebook

1. Clone the repository or download the notebook file.
2. Ensure you have the necessary libraries installed:
    ```bash
    pip install pandas numpy seaborn matplotlib
    ```
3. Open the notebook using Jupyter Notebook or any compatible environment:
    ```bash
    jupyter notebook Customer_churn_analysis_PROJECT_2.ipynb
    ```
4. Execute the cells sequentially to reproduce the analysis and visualizations.

## Acknowledgments

- The dataset utilized in this analysis is sourced from a telecommunications company.
- The visualizations and analysis techniques are inspired by common practices in data science and machine learning.

