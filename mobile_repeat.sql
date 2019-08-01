-- determine previous purchase behavior of mobile customers
with customers as (
select
  m.purchase_customer_id as purchase_customer_id,
  d.first_purchase_tool as first_purchase_tool
from 
  (select 
     purchase_customer_id
   from dw_marketing.transaction_data_source
   where
     lower(tool) = 'blurb mobile - ios'
     and first_order_flag = 0
     and active_booking_line_item_flag = 'Y'
     and transaction_sequence = 0
   group by 1) m
  join dw_marketing.user_dna d on d.customer_id = m.purchase_customer_id
group by 1,2
order by 1
),

order_history as (
select
  c.purchase_customer_id,
  c.first_purchase_tool,
  t.tool as last_purchase_tool
from customers c
  join (select 
          purchase_customer_id, 
          max(order_number) as max_order_number
        from dw_marketing.transaction_data_source
        group by 1) l on c.purchase_customer_id = l.purchase_customer_id
  join (select
          purchase_customer_id,
          order_number,
          tool
        from dw_marketing.transaction_data_source
        group by 1,2,3) t on l.max_order_number = t.order_number
order by 1,2,3)

select
  h.purchase_customer_id,
  h.first_purchase_tool,
  h.last_purchase_tool,
  t.order_number,
  t.order_timestamp,
  t.tool
from order_history h
  join (select 
          purchase_customer_id, 
          order_number, 
          tool, 
          order_timestamp 
        from dw_marketing.transaction_data_source
        where 
          active_booking_line_item_flag = 'Y'
          and transaction_sequence = 0
        group by 1,2,3,4) t on t.purchase_customer_id = h.purchase_customer_id
where
  h.first_purchase_tool = 'Booksmart'
  and lower(h.last_purchase_tool) = 'blurb mobile - ios'
order by 1,2,3,4,5,6 
