import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
          
df = pd.read_csv('mymoviedb.csv',lineterminator='\n')

##df.head() will give you 1st 5 rows of the data
#print(df.head())

#df.info() gives a basic info about data ...datatype,is there any null value
#print(df.info())

#df['Genre'].head() this will me only Genre column data and only 1st 5 rows
#print(df['Genre'].head())

#df.duplicated() this will give inform if there is any duplicate value
#print(df.duplicated())

#df.duplicated().sum() this will return the total of duplicated row
print(df.duplicated().sum())

'''1. We have a dataframe consisting of 9827 rows and 9 columns
2. Our dataset looks a bit tidy with no NaNs nor duplicated value.
3. Release_Date column needs to be casted into date time and to extract only the year value.
4. Overview, Original_Language and Poster_Url wouldn't be so useful during analysis, so we'll drop them.
5. There is noticable outlier in Popularity column
6. Vote_Average better be categorized for proper analysis.
7. Genre column has comma separated values and white spaces that needs to be handled and casted into category. 
'''

df['Release_Date']= pd.to_datetime(df['Release_Date'])
print(df['Release_Date'].dtypes)


#Dropping the column
cols = ['Overview','Original_Language','Poster_Url']
df.drop(cols,axis=1,inplace=True)
print(df.columns)
print(df.head())

def categorize_col(df,col,labels):
    edges = [df[col].describe()['min'],
             df[col].describe()['25%'],
             df[col].describe()['50%'],
             df[col].describe()['75%'],
             df[col].describe()['max']]

    df[col] = pd.cut(df[col], edges, labels = labels, duplicates = 'drop')
    return df

labels = ['not_popular','below_average','average','popular']
categorize_col(df,'Vote_Average',labels)
df['Vote_Average'].unique()

# -----------------------------
# Genre Analysis
# -----------------------------
# Split comma-separated genres and convert into separate rows
genres = (
    df['Genre']
    .dropna()
    .str.split(', ')
    .explode()
)

print("\nGenre Summary:")
print(genres.describe())

print("\nTop 10 Genres:")
print(genres.value_counts().head(10))


# -----------------------------
# Visualization
# -----------------------------
sns.set_style('whitegrid')

plt.figure(figsize=(12, 8))

sns.countplot(
    y=genres,
    order=genres.value_counts().index,
    color='#4287f5'
)

plt.title('Genre Column Distribution', fontsize=16)
plt.xlabel('Count', fontsize=12)
plt.ylabel('Genre', fontsize=12)
plt.tight_layout()

plt.show()

             
