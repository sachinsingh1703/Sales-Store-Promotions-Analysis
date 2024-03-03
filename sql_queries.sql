
-- 1st Query
select * from retail_events_db.fact_events 
where base_price > 500 and promo_type='BOGOF';


-- 2nd Query
SELECT city, COUNT(*) AS city_count
FROM retail_events_db.dim_stores
GROUP BY city
ORDER BY city_count DESC;


-- 3rd Query
SELECT 
    campaign_id, 
    SUM(fact_events.quantity_before_promo * fact_events.base_price) / 1000000 AS revenue_before_promo, 
    SUM(fact_events.quantity_after_promo * fact_events.base_price) / 1000000 AS revenue_after_promo
FROM 
    retail_events_db.fact_events 
GROUP BY 
    campaign_id;


-- 4th Query
select 
distinct(promo_type), 
(SUM(quantity_after_promo) / SUM(quantity_before_promo)) * 100 as ISU_percentage
from retail_events_db.fact_events
group by promo_type order by ISU_percentage desc;


 -- 5th Query   
SELECT 
    fact_events.product_code, 
    dim_products.product_name, 
    dim_products.category,
    SUM(quantity_after_promo) / SUM(quantity_before_promo) * 100 AS Increment
FROM 
    retail_events_db.fact_events 
JOIN 
    retail_events_db.dim_products ON fact_events.product_code = dim_products.product_code
GROUP BY 
    fact_events.product_code, dim_products.product_name, dim_products.category
ORDER BY 
    Increment DESC;


