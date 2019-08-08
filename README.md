# Mobile Data Exploration - Determine the combination of softwares customers typically use up to the eventual Mobile purchase.  Extract a list of transactions for each customer and then count the unique software/tool combinations to understand most common paths 

## Software Requirements
Python

## Prerequisites
A purchase history csv to process

## Breakdown of Program
  1.  Read csv into a dataframe 
  2.  Create empty customer dictionary
  3.  Loop through dataframe adding customer_id (key), appending tools used to purchase into a list
  4.  Use the set method to unique the tools and then sort the list values 
  5.  Convert dictionary to dataframe, add a column which combines all non-null columns
  6.  Count tool combinations to understand which tools are most used in combination

