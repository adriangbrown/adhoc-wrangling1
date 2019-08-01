#!usr/bin/env python

import pandas as pd
import itertools

def tool_usage(data):
  """Determine tools used w/ customer count"""
  # list unique tools for each customer ordered in list
  cust_dict = {}
  for i, row in data.iterrows(): # iterate through dataframe
    if row['customer_id'] not in cust_dict:
      #print i, row['customer_id'], row['tool']
      # add customer_id to empty_df if not in
      cust_dict[row['customer_id']] = [row['tool']]
    else:
      # add tool to list
      cust_dict[row['customer_id']].append(row['tool'])
  
  sorted_dict = {}      
  for k,v in cust_dict.items():
    # loop through dictionary and unique (set) tool list
    sorted_dict[k] = sorted(set(v)) 
  # convert dictionary to dataframe
  tool_df = pd.DataFrame.from_dict(sorted_dict, orient='index')
  tool_df['tool_list'] = tool_df[tool_df.columns].apply(
    lambda x: ','.join(x.dropna().astype(str)),
    axis=1)
  # Count tool/customer combinatations...sorted
  print tool_df['tool_list'].value_counts()

if __name__ == '__main__':
  names = ['customer_id', 'first_tool', 'last_tool', 'order_number', 'timestamp', 'tool']
  data = pd.read_csv('/Users/adrianbrown-mac/Google Drive/Python/mobile/mobile_repeat.csv', sep='|', header=None, names=names)
  tool_usage(data) 
