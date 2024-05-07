
# coding: utf-8

# # Extra Credit Notebook
# 

# This project will take sample consumer data on who buys a car and assess which indicators are most likely to predict who will buy a car

# In[1]:


# Not-exhaustive project checklist
# Note: this is not a writing assignment, but you should still incorporate comments or headers throughout
# -- This will help others who review your work, but will also help you keep track of what you're doing
# -- Just think about what would help you understand a peer's project when you have to grade theirs later


# 1) Dataset included
# 1a) Dataset explained/documented when used
# 2) Analysis performed
# 2a) Analysis steps documented, explained briefly
# 3) Visualizations/outputs
# 4) Conclusion
# ---Did you answer your questions?
# ---Did you find anything else?
# ---What problems did you run into?
# ---Any suggestions for future research?

# Critical checks before submission
# - Does the noteboook run without error? (Kernel>restart & run all => no errors at all? No long periods of processing?)
# - Do you have your dataset included here? You shouldn't be connecting to any external data
# - - Even if external datasets work here, they WILL NOT work for peer-grading, and you may get a 0.


# ### Explanation of dataset and what we will be doing

# In[4]:


#The data set I will be reading is called car_purchasing and in csv format. It hosts the following fields, customer name, customer e-mail, country, gender, age, annual Salary, credit card debt, net worth, car purchase amount
#We are going to use this dataset to generate some insights on things like who are the most likely people to buy a car and which indicators prove that


# In[5]:


#Start by loading data and looking at first couple of rows


# In[7]:


import pandas as pd

# Try reading with a different encoding
df = pd.read_csv('car_purchasing.csv', encoding='ISO-8859-1')

# Display the first few rows of the dataset
print(df.head())


# In[ ]:


#Now lets clean the data checking for missing data in each column and then decide if we need to impute or delete any entries based on what we find


# In[8]:


# Check for missing values
print("Missing values in each column:")
print(df.isnull().sum())

# Check data types
print("\nData types of each column:")
print(df.dtypes)


# In[ ]:


#Great, now that we have cleaned and check our data...
#Lets complete a Statistical Summary: This will provide a quick overview of the numerical data.


# In[9]:


# Display statistical summary of numerical data
print("Statistical Summary:")
print(df.describe())


# In[ ]:


#Now that we can see the numbers at a high level...
#Lets complete a Correlation Analysis: To understand relationships between numerical variables, particularly how they relate to the car purchase amount.


# In[10]:


# Compute correlation matrix
correlation_matrix = df.corr()

# Display the correlation matrix
print("Correlation matrix:")
print(correlation_matrix)


# In[ ]:


#Now lets generate some Visualizations:
#Histograms for the distribution of ages, salaries, net worth, and car purchase amounts.
#Scatter plots to visualize correlations, especially related to the car purchase amount.
#A boxplot to check for outliers in the financial figures like salary, debt, and purchase amounts.


# In[11]:


import matplotlib.pyplot as plt
import seaborn as sns

# Set the aesthetic style of the plots
sns.set_style("whitegrid")

# Histograms for numerical data
df.hist(bins=15, figsize=(15, 10))
plt.suptitle('Distribution of Numerical Data')
plt.show()

# Scatter plot of annual salary vs car purchase amount
plt.figure(figsize=(10, 6))
sns.scatterplot(x='annual Salary', y='car purchase amount', hue='gender', data=df)
plt.title('Annual Salary vs Car Purchase Amount by Gender')
plt.xlabel('Annual Salary')
plt.ylabel('Car Purchase Amount')
plt.show()

# Boxplot for financial data
plt.figure(figsize=(10, 6))
sns.boxplot(data=df[['annual Salary', 'credit card debt', 'net worth', 'car purchase amount']])
plt.title('Financial Data Overview')
plt.show()


# In[14]:


#Great, now lets move on to our final write up of what we did and what we found


# In[15]:


## Introduction

#This project explores the potential factors influencing car purchase amounts based on various demographic and financial attributes. The dataset, "car_purchasing.csv," includes details such as customer name, email, country, gender, age, annual salary, credit card debt, net worth, and car purchase amount. Understanding these relationships can help in predicting customer behavior and refining sales strategies.


# In[16]:


## Data Cleaning

#The dataset was examined for any missing values and inappropriate data types. The findings confirmed that there were no missing values, and all data types were suitable for analysis. This ensures that the subsequent analyses will be based on complete and accurately typed data.


# In[17]:


## Data Analysis

### Statistical Summary
#A statistical summary was provided to understand the central tendency, dispersion, and shape of the dataset’s numerical attributes.

### Correlation Analysis
#Correlation analysis was performed to identify the relationships between different numerical variables, particularly focusing on how various factors like salary and net worth correlate with the car purchase amount.

### Visualizations
#Visualizations were created to further illustrate the distribution of data and relationships between variables:
#- Histograms show the distribution of age, salary, net worth, and car purchase amounts.
#- Scatter plots help visualize how annual salary correlates with car purchase amounts, segmented by gender.
#- Boxplots are used to review the spread and identify outliers in financial data.


# In[18]:


## Results

#The analysis revealed several key insights:
#- There is a positive correlation between annual salary and car purchase amount, suggesting that higher earners tend to buy more expensive cars.
#- Age and net worth also show interesting patterns and correlations with car purchase amounts that could be further explored.
#- The visualizations highlighted a generally right-skewed distribution in car purchase amounts, indicating a concentration of customers in the lower price ranges.


# In[20]:


## Suggestions for Future Research

#Future research could expand on this analysis by:
#- Incorporating additional variables such as employment type or education level to see if these factors also influence car purchasing decisions.
#- Employing predictive modeling techniques to forecast car purchase amounts based on the identified correlations.
#- Conducting a similar analysis across different regions or countries to compare behavioral trends in car purchasing globally.

