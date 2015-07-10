SELECT p.name as product_name, COUNT(oi.id) as num_orders,
	ifnull(SUM(oi.quantity), 0.00) as quantity,
    p.price as price,
    ifnull(SUM(oi.quantity) * p.price, 0.0000) as total_price
FROM products p
LEFT JOIN order_items oi ON p.id = oi.products_id
GROUP BY p.name
ORDER BY p.name