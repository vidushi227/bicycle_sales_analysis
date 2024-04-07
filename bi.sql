--overall sales review

select brands.brand_name,categories.category_name,CONCAT(customers.first_name,' ',customers.last_name) as customer_name,
customers.city,customers.state,orders.order_id,orders.required_date,orders.shipped_date,products.product_name,products.model_year,concat(staffs.first_name,' ',staffs.last_name) as staff_name,
staffs.store_id,
stores.store_name,stores.city as store_city,stores.state as store_state,
sum(order_items.quantity)as total_units,(order_items.list_price-order_items.list_price*order_items.discount) as selling_price_per_quantity,sum(order_items.quantity*(order_items.list_price-order_items.list_price*discount)) as total_revenue_earned
from order_items join orders
on order_items.order_id = orders.order_id  
join customers on customers.customer_id = orders.customer_id
join products on products.list_price = order_items.list_price
join categories on categories.category_id =products.category_id
join brands on products.brand_id = brands.brand_id
join staffs on orders.staff_id = staffs.staff_id
join stocks on orders.store_id = stocks.store_id
join stores on stores.store_id = orders.store_id
group by
brands.brand_name,categories.category_name,CONCAT(customers.first_name,' ',customers.last_name),
customers.city ,customers.state ,orders.order_id,orders.required_date,orders.shipped_date,products.product_name,products.model_year,concat(staffs.first_name,' ',staffs.last_name) ,
staffs.store_id,
stores.store_name,stores.city ,stores.state ,(order_items.list_price-order_items.list_price*order_items.discount);

--total number of brands
select count(*)
from brands
 
---total number categories
 select count(*)
 from categories
 
 ---total number of products
  select count(*)
  from products
  
  ---total number of stores
  
  select count(*)
  from stores

---total  revenue earned by selling bicycles by all stores

select sum(total_revenue)
from order_items
 --- total quantity
 select sum(quantity)
 from order_items

--- total revenue earned by each store

select sum(order_items.quantity*(order_items.list_price-order_items.list_price*order_items.discount)) as total_revenue,stores.store_name,
sum(order_items.quantity) as total_units_sold
from order_items join orders on order_items.order_id = orders.order_id join
stores
on orders.store_id = stores.store_id
group by stores.store_name


---brand sold for highest revenue and units 

select brands.brand_name,sum(order_items.quantity*(order_items.list_price-order_items.list_price*order_items.discount)) as total_revenue,
sum(order_items.quantity) as total_unit_sold
from order_items
join products
on products.list_price = order_items.list_price
join brands
on brands.brand_id = products.brand_id
group by brands.brand_name
order by sum(order_items.quantity*(order_items.list_price-order_items.list_price*order_items.discount)) desc

---products total revenue and units sold

select products.product_name,sum(order_items.quantity*(order_items.list_price-order_items.list_price*order_items.discount)) as total_revenue,
sum(order_items.quantity)
from order_items
join products
on products.list_price = order_items.list_price
group by products.product_name
order by sum(order_items.quantity*(order_items.list_price-order_items.list_price*order_items.discount)) desc

----employee who sold for maximum revenue
select concat(staffs.first_name,' ',staffs.last_name) as employee_name,sum(order_items.quantity*(order_items.list_price-order_items.list_price*order_items.discount)) as total_revenue,
sum(order_items.quantity) as total_units
from order_items
join orders
on orders.order_id = order_items.order_id
join staffs
on staffs.staff_id = orders.staff_id
group by concat(staffs.first_name,' ',staffs.last_name)
order by sum(order_items.quantity*(order_items.list_price-order_items.list_price*order_items.discount)) desc
 
---average of total revenue
 select avg(total_revenue)
 from order_items

-- average revenue earned by each branch

select avg(total_revenue) as avg_revenue, brands.brand_name
from order_items
join products on products.list_price = order_items.list_price
join brands
on brands.brand_id = products.brand_id
group by brands.brand_name


--stores who earned more than the avgerage revenue

select stores.store_name,sum(order_items.total_revenue) as total_revenue,avg(order_items.total_revenue)
from order_items
join orders
on orders.order_id = order_items.order_id
join stores
on orders.store_id = stores.store_id
group by stores.store_name
having  sum(order_items.total_revenue) > (select avg(order_items.total_revenue)
								 from order_items) 
								 

---products average revenue

select products.product_name,avg(order_items.total_revenue),sum(order_items.total_revenue)
from order_items
join products
on products.list_price = order_items.list_price
group by products.product_name
having sum(order_items.total_revenue) > (select avg(order_items.total_revenue) from order_items )

---total quantity sold

select sum(quantity)
from order_items

----total quantity sold of each brand and products and total quantity of products sold by each store
 select brands.brand_name, sum(order_items.quantity) as total_units_sold,stores.store_name,products.product_name
 from order_items
 join products on products.list_price = order_items.list_price
 join brands on brands.brand_id = products.brand_id
 join orders
 on orders.order_id = order_items.order_id
 join stores
 on stores.store_id = orders.store_id
 group by  brands.brand_name,stores.store_name,products.product_name
 
















