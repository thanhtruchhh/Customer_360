# Customer Segmentation Using RFM Analysis

This project aims to segment customers based on their transaction data using the RFM (Recency, Frequency, Monetary) model. By leveraging customer data, this analysis helps identify key customer characteristics and develop targeted customer care strategies.

## Project Overview

### Problem Statement
The marketing team has launched an end-of-year sales campaign and needs to segment the current customer base into distinct groups to tailor customer care strategies effectively.

### Objective
The task is to segment a dataset of 100,000 customers into meaningful groups, enabling the customer service team to develop and implement efficient engagement plans.

### Goals
1. Identify common characteristics and significant differences among customer groups.
2. Segment customers based on predefined criteria using the RFM model.
3. Develop targeted customer care strategies for each segment.
4. Implement these strategies, monitor their effectiveness, and make necessary adjustments.
   
## Data 

### Data Sources
Customer transaction data from June to August 2022, including tables:
- **Location**: `ID`, `SubCompanyID`, `SubCompanyName`, `LocationID`, `BranchCode`, `BranchFullName`, `LocationName`, `Code`, `SubCompanyNameVN`, `BranchFullNameVN`, `LocationNameVN`.
- **Customer_Transaction**: `Transaction_ID`, `CustomerID`, `Purchase_Date`, `GMV`.
- **Customer_Registered Table**: `ID`, `Contract`, `LocationID`, `BranchCode`, `Status`, `created_date`, `stopdate`
  
### Data Consideration
- Only active customers (contracts not terminated) are considered.
- Only revenue-generating transactions (GMV > 0) are included.

## Tools
- **SQL**: Used for data analysis and querying the datasets.
- **Excel**: Utilized for data visualization.
- **PowerPoint**: Used to create the final report and presentation of findings.
## Methodology

### RFM Model

The RFM model analyzes customers based on three factors:
- **Recency (R)**: Time since the last transaction.
- **Frequency (F)**: Number of transactions.
- **Monetary (M)**: Total value of transactions.

### Calculating RFM Scores

- R, F, and M values are divided into four equal parts (quartiles), each assigned a score from 1 to 4.
- Higher scores indicate better performance (except for Recency, where a higher value indicates less recent activity and thus a lower score).

### Combining RFM Scores

- The R, F, and M scores are combined to create an overall RFM score for each customer.
- Customers are then segmented based on their RFM scores.

### BCG Matrix

The BCG matrix is used to map customer segments based on market share and market growth, identifying groups such as VIPs, potential customers, loyal customers, and casual customers.

<img width="537" alt="mapping bcg" src="https://github.com/thanhtruchhh/Customer_360/assets/145547282/26b9b6ee-a8e8-4ca9-aac5-bf0a5cabe9b0">

## Key Insights

- VIP customers, though only 25% of the total, generate the highest revenue, about 1.5 times more than the next segment.
<img width="397" alt="vip insights 1" src="https://github.com/thanhtruchhh/Customer_360/assets/145547282/cfa720a0-4ab1-44eb-9356-ed08312dd9f1">

<img width="519" alt="vip insights" src="https://github.com/thanhtruchhh/Customer_360/assets/145547282/e1566b65-8fa3-4b66-8422-b2a03d125c5d">

- Potential customers show high generosity in spending.
<img width="502" alt="potential insights" src="https://github.com/thanhtruchhh/Customer_360/assets/145547282/07347093-a5c2-4cbe-814c-32215efcc151">

- Loyal and casual customers spend relatively moderately.
<img width="417" alt="loyal   casual" src="https://github.com/thanhtruchhh/Customer_360/assets/145547282/72252253-5c6e-4351-813c-fe56c4fb3891">

---
*Read full [report] (https://github.com/thanhtruchhh/Customer_360/blob/main/RFM%20report.pdf) and [SQL query](https://github.com/thanhtruchhh/Customer_360/blob/main/RFM%20analysis.sql).*
