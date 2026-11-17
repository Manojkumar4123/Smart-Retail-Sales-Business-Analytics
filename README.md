Smart Retail Sales Business Analytics
Project: Retail Sales Analytics Using Excel, SQL, Python, and Power
BI
Domain: Retail, Sales & Inventory Analytics
Presented by: E. Manoj Kumar
1. Project Overview
This project builds an end-to-end retail analytics workflow using Excel,
MySQL, Python, and Power BI. It focuses on understanding sales
performance, customer purchasing behaviour, product performance, store
and staff performance, inventory levels, and customer value.

The project follows this workflow:

Excel → MySQL → Python → Power BI
- Excel is used to clean and prepare the source data.
- MySQL is used to store related retail tables and perform SQL
  analysis.
- Python is used for exploratory data analysis (EDA) and RFM-based
  customer segmentation.
- Power BI is used to present business metrics and insights through an
  interactive dashboard.
2. Problem Statement
Retail businesses need to monitor sales performance, understand customer
behaviour, and identify growth opportunities. This project uses
transactional and inventory data to create a structured analytics
solution that supports better-informed business decisions.
3. Key Objectives
- Track revenue and order trends.
- Identify top-performing products and categories.
- Compare sales across stores and staff.
- Summarize customer orders, purchase quantities, and revenue.
- Segment customers using Recency, Frequency, and Monetary (RFM)
  features.
- Identify products with low stock levels.
- Present the analysis through an interactive Power BI dashboard.
4. Tools and Technologies
  Tool                                Purpose
  Microsoft Excel                     Data cleaning, validation,
preparation, and PivotTables

  MySQL                               Relational data storage, joins,
aggregations, and business queries

  Python                              Exploratory Data Analysis and RFM
calculations

  Pandas                              Data loading and manipulation

  NumPy                               Numerical operations

  Matplotlib / Seaborn                Data visualization
Power BI                            Interactive reporting and
dashboarding
5. Dataset
The project brief describes a Retail Sales Data relational schema. It
identifies the following tables:
  Table                               Description
  customers                         Buyer details and location
information

  orders                            Customer transactions, including
staff and store references

  order_items                       Products and quantities within each
order

  products                          Product information

  brands                            Brand metadata

  categories                        Product category metadata

  stocks                            Inventory quantities across stores

  stores                            Store information
staffs                            Staff information
The source brief describes a relational schema to be exported or
prepared as CSV/Excel files and loaded into SQL. Actual row counts and
final column definitions should be documented after checking the working
dataset.
6. Project Workflow
Phase 1 --- Excel: Data Cleaning and Preparation
- Standardize column names across sheets.
- Check and remove duplicate records where appropriate.
- Identify and handle missing values.
- Convert date columns and numeric fields to suitable data types.
- Validate fields such as order status.
- Calculate total_price using the project-defined formula:
  (list_price * quantity) - discount.
- Use VLOOKUP or XLOOKUP to retrieve related product information.
- Create PivotTables to summarize sales by category.
- Review unusual price values and export cleaned CSV files for SQL
  import.
Phase 2 --- MySQL: Database Management and Analysis
- Create relational tables based on the project schema and
  relationships.
- Import the cleaned CSV files.
- Join orders, order items, and products to view order details.
- Calculate total sales by store.
- Identify the top five products by quantity sold.
- Prepare customer purchase summaries with order counts, item
  quantities, and revenue.
- Group customers into spending brackets.
- Analyze revenue by staff member.
- Identify products with stock quantity below 10.
- Create a customer_segments table for Python segmentation results.
Phase 3 --- Python: EDA and RFM Customer Segmentation
- Load the required SQL tables into Pandas DataFrames.
- Explore data using df.head(), df.info(), df.describe(), and
  df.value_counts().
- Create charts using Matplotlib or Seaborn.
- Calculate customer RFM features:
  - Recency: Number of days since the customer's most recent
    order.
  - Frequency: Number of orders placed by the customer.
  - Monetary: Total purchase value for the customer.
- Assign customer segment labels based on the calculated metrics.
- Export the segmentation results to the SQL customer_segments
  table.
Possible segment labels in the project materials include Champions,
Loyal Customers, At Risk, and Needs Attention. Final segment assignments
depend on the calculated customer metrics and scoring method.
Phase 4 --- Power BI: Dashboard and Reporting
The project brief proposes these reporting areas:
- Sales overview with sales trends, monthly sales, and order counts.
- Top products by revenue or quantity.
- Customer purchase analysis by city or state.
- Store-wise sales map.
- Low-stock alerts for products below the chosen threshold.
- Slicers for order status, product category, and store.
- Staff performance by revenue.
- KPI cards for total revenue, active customers, average order value,
  and total orders.
- Customer segment distribution and revenue by segment.
- Customer segment slicers for interactive analysis.
7. RFM Customer Segmentation
RFM analysis groups customers based on purchasing behaviour:

  Metric          Meaning
  Recency (R)     How recently a customer placed an order
Frequency (F)   How often a customer placed orders
Monetary (M)    How much a customer spent

The resulting customer groups can help a retail business plan relevant
retention, loyalty, and marketing activities.
8. Expected Business Benefits
- Understand sales trends and store-level performance.
- Identify products and categories contributing to sales.
- Recognize high-value and repeat customers.
- Identify customers who may need re-engagement.
- Monitor low-stock products and support inventory planning.
- Improve management reporting through an interactive dashboard.
These are intended uses of the analysis; specific findings and business
recommendations should be added after validating the actual results.
9. Deliverables
The project brief specifies the following deliverables:
- Cleaned Excel files.
- SQL database creation scripts and query scripts.
- Python notebook or script containing EDA and segmentation.
- Power BI .pbix dashboard.
- Final report documenting the workflow, insights, and visuals.
10. Project Status and Data Notes
This README describes the project scope and workflow from the supplied
project presentation and project brief. It does not claim specific sales
totals, customer counts, segment sizes, or other measured results.

The Power BI presentation preview labels its KPI values as placeholders
until the actual analysis is completed. Replace placeholders with
validated figures and add evidence-based insights before final
submission.
11. Author
E. Manoj Kumar

Project Title: Smart Retail Sales Business Analytics
Technology Workflow: Excel • MySQL • Python • Power BI
