# Import necessary libraries
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

# Load an example dataset
df = sns.load_dataset('tips')

# Display the first few rows of the dataset
print("First few rows of the dataset:")
print(df.head())

# Set the aesthetic style of the plots
sns.set_style('whitegrid')

# Distribution Plot
plt.figure(figsize=(10, 6))
# Plot a distribution of total bill amounts
sns.histplot(df['total_bill'])
# Add KDE plot for the same data
sns.kdeplot(df['total_bill'], color='red')
plt.title('Distribution of Total Bill')
plt.xlabel('Total Bill')
plt.ylabel('Frequency')
plt.show()

# Scatter Plot
plt.figure(figsize=(10, 6))
# Scatter plot of total bill vs tip
sns.scatterplot(x='total_bill', y='tip', data=df)
plt.title('Total Bill vs Tip')
plt.xlabel('Total Bill')
plt.ylabel('Tip')
plt.show()

# Box Plot
plt.figure(figsize=(10, 6))
# Box plot of total bill by day
sns.boxplot(x='day', y='total_bill', data=df)
plt.title('Total Bill by Day')
plt.xlabel('Day')
plt.ylabel('Total Bill')
plt.show()

# Pair Plot
# Pair plot of the dataset, showing pairwise relationships and distributions
sns.pairplot(df)
plt.show()

# Heatmap
plt.figure(figsize=(10, 6))
# Calculate the correlation matrix
corr = df.corr()
# Heatmap of the correlation matrix with annotations
sns.heatmap(corr, annot=True, cmap='coolwarm')
plt.title('Correlation Matrix')
plt.show()

# Violin Plot
plt.figure(figsize=(10, 6))
# Violin plot of total bill by day
sns.violinplot(x='day', y='total_bill', data=df)
plt.title('Violin Plot of Total Bill by Day')
plt.xlabel('Day')
plt.ylabel('Total Bill')
plt.show()

# Bar Plot
plt.figure(figsize=(10, 6))
# Bar plot of total bill by sex
sns.barplot(x='sex', y='total_bill', data=df, ci=None)
plt.title('Bar Plot of Total Bill by Sex')
plt.xlabel('Sex')
plt.ylabel('Total Bill')
plt.show()

# Count Plot
plt.figure(figsize=(10, 6))
# Count plot of the number of records by day
sns.countplot(x='day', data=df)
plt.title('Count Plot of Records by Day')
plt.xlabel('Day')
plt.ylabel('Count')
plt.show()

# Strip Plot
plt.figure(figsize=(10, 6))
# Strip plot of total bill by day
sns.stripplot(x='day', y='total_bill', data=df, jitter=True)
plt.title('Strip Plot of Total Bill by Day')
plt.xlabel('Day')
plt.ylabel('Total Bill')
plt.show()

# Swarm Plot
plt.figure(figsize=(10, 6))
# Swarm plot of total bill by day
sns.swarmplot(x='day', y='total_bill', data=df)
plt.title('Swarm Plot of Total Bill by Day')
plt.xlabel('Day')
plt.ylabel('Total Bill')
plt.show()

# lmplot (Linear Model Plot)
# Plot total bill vs tip with a linear fit
sns.lmplot(x='total_bill', y='tip', data=df, aspect=2, height=6)
plt.title('Linear Model Plot of Total Bill vs Tip')
plt.xlabel('Total Bill')
plt.ylabel('Tip')
plt.show()
