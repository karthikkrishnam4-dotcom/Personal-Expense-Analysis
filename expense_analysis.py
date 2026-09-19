import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("data/expenses.csv")

print(df.head())

print("\nDataset Information:")
print(df.info())

print("\nMissing Values:")
print(df.isnull().sum())

# Convert date column
df["date"] = pd.to_datetime(df["date"])

print("\nAfter Date Conversion:")
print(df.info())
print("\nBasic Expense Statistics:")

print("Total Spending:", df["amount"].sum())
print("Average Expense:", df["amount"].mean())
print("Minimum Expense:", df["amount"].min())
print("Maximum Expense:", df["amount"].max())
print("Number of Expenses:", df["amount"].count())

category_spending = df.groupby("category")["amount"].sum()

print("\nSpending by Category:")
print(category_spending)

payment_spending = (
    df.groupby("payment_method")["amount"]
      .sum()
      .sort_values(ascending=False)
)

print("\nSpending by Payment Method:")
print(payment_spending)

df["month"] = df["date"].dt.strftime("%b %Y")

print("\nData with Month:")
print(df[["date", "month"]].head())

monthly_spending = (
    df.groupby("month")["amount"]
      .sum()
)

print("\nMonthly Spending:")
print(monthly_spending)

top_expenses = df.sort_values(
    by="amount",
    ascending=False
).head(5)

print("\nTop 5 Highest Expenses:")
print(top_expenses[["description", "category", "amount"]])

lowest_expenses = df.sort_values(
    by="amount",
    ascending=True
).head(5)

print("\n5 Lowest Expenses:")
print(lowest_expenses[["description", "category", "amount"]])

category_analysis = df.groupby("category")["amount"].agg(
    total_spending="sum",
    average_spending="mean"
).sort_values(
    by="total_spending",
    ascending=False
)

print("\nCategory Analysis:")
print(category_analysis)

category_transactions = (
    df.groupby("category")
      .size()
      .sort_values(ascending=False)
)

print("\nNumber of Transactions by Category:")
print(category_transactions)

category_average = (
    df.groupby("category")["amount"]
      .mean()
      .sort_values(ascending=False)
)

print("\nAverage Spending per Transaction:")
print(category_average)

monthly_analysis = df.groupby("month").agg(
    total_spending=("amount", "sum"),
    total_transactions=("amount", "count")
)

print("\nMonthly Analysis:")
print(monthly_analysis)

payment_analysis = df.groupby("payment_method").agg(
    total_spending=("amount", "sum"),
    average_spending=("amount", "mean"),
    total_transactions=("amount", "count")
).sort_values(
    by="total_spending",
    ascending=False
)

print("\nPayment Method Analysis:")
print(payment_analysis)

daily_spending = (
    df.groupby("date")["amount"]
      .sum()
      .sort_values(ascending=False)
)

print("\nDaily Spending:")
print(daily_spending.head(5))
# Category-wise spending
category_spending = (
    df.groupby("category")["amount"]
      .sum()
      .sort_values(ascending=False)
)

plt.figure(figsize=(8, 5))

plt.bar(
    category_spending.index,
    category_spending.values
)

plt.title("Spending by Category")
plt.xlabel("Category")
plt.ylabel("Total Spending (₹)")

plt.xticks(rotation=45)
plt.tight_layout()

plt.show()

plt.figure(figsize=(8, 5))

plt.plot(
    monthly_analysis.index,
    monthly_analysis["total_spending"],
    marker="o"
)

plt.title("Monthly Spending")
plt.xlabel("Month")
plt.ylabel("Total Spending (₹)")

plt.tight_layout()
plt.show()
plt.figure(figsize=(8, 5))

sns.barplot(
    x=category_spending.index,
    y=category_spending.values
)

plt.title("Spending by Category")
plt.xlabel("Category")
plt.ylabel("Total Spending (₹)")

plt.xticks(rotation=45)
plt.tight_layout()
plt.show()
plt.figure(figsize=(8, 5))

sns.barplot(
    x=payment_analysis.index,
    y=payment_analysis["total_spending"]
)

plt.title("Spending by Payment Method")
plt.xlabel("Payment Method")
plt.ylabel("Total Spending (₹)")

plt.tight_layout()
plt.show()
plt.figure(figsize=(8, 5))

sns.histplot(
    df["amount"],
    bins=8
)

plt.title("Distribution of Expenses")
plt.xlabel("Expense Amount (₹)")
plt.ylabel("Number of Transactions")

plt.tight_layout()
plt.show()

plt.figure(figsize=(8, 5))

sns.boxplot(
    y=df["amount"]
)

plt.title("Expense Distribution and Outliers")
plt.ylabel("Expense Amount (₹)")

plt.tight_layout()
plt.show()
df["year"] = df["date"].dt.year
df["month_number"] = df["date"].dt.month
df["day"] = df["date"].dt.day

correlation = df[
    ["amount", "year", "month_number", "day"]
].corr()

plt.figure(figsize=(7, 5))

sns.heatmap(
    correlation,
    annot=True,
    cmap="coolwarm",
    fmt=".2f"
)

plt.title("Correlation Heatmap")
plt.tight_layout()
plt.show()

plt.figure(figsize=(8, 5))

sns.lineplot(
    x=monthly_analysis.index,
    y=monthly_analysis["total_spending"],
    marker="o"
)

plt.title("Monthly Spending Trend")
plt.xlabel("Month")
plt.ylabel("Total Spending (₹)")

plt.tight_layout()
plt.show()

# -----------------------------
# PROJECT INSIGHTS
# -----------------------------

print("\n" + "=" * 40)
print("PROJECT INSIGHTS")
print("=" * 40)

print("Total Spending: ₹", df["amount"].sum())
print("Average Expense: ₹", round(df["amount"].mean(), 2))

highest_category = category_analysis["total_spending"].idxmax()
highest_category_amount = category_analysis["total_spending"].max()

print(
    f"Highest Spending Category: "
    f"{highest_category} (₹{highest_category_amount})"
)

highest_payment = payment_analysis["total_spending"].idxmax()
highest_payment_amount = payment_analysis["total_spending"].max()

print(
    f"Highest Spending Payment Method: "
    f"{highest_payment} (₹{highest_payment_amount})"
)

highest_month = monthly_analysis["total_spending"].idxmax()
highest_month_amount = monthly_analysis["total_spending"].max()

print(
    f"Highest Spending Month: "
    f"{highest_month} (₹{highest_month_amount})"
)

highest_expense = df.loc[df["amount"].idxmax()]

print(
    f"Highest Individual Expense: "
    f"{highest_expense['description']} "
    f"(₹{highest_expense['amount']})"
)