SELECT client.name, coupon.discount
FROM coupon_client
JOIN client on client.id = coupon_client.client_id
JOIN coupon on coupon.id = coupon_client.coupon_id
ORDER BY name DESC;

SELECT client.name, credit_card.number, credit_card.date_expire
FROM credit_card
JOIN client ON client.id = credit_card.client_id
ORDER BY client.name;

SELECT reservation.start,
       reservation.finish,
       sitting_table.capacity,
       sitting_table.id as "table"
FROM reservation
JOIN sitting_table on sitting_table.id = reservation.table_id
ORDER BY start;

SELECT name, description, price, type as menu_name
FROM meal
JOIN menu on meal.menu_id = menu.id
WHERE meal.is_available AND menu.is_available
ORDER BY type;

SELECT client.name as client, public.waiter.name as waiter, st.capacity as table_capacity
FROM ordering
JOIN client ON client.id = ordering.client
JOIN waiter ON ordering.waiter = waiter.id
JOIN sitting_table st on ordering.sitting_table = st.id;

SELECT client.name as client, meal.name as meal, meal.price
FROM ordering
JOIN order_meal om on ordering.id = om.order_id
JOIN meal on meal.id = om.meal_id
JOIN client on client.id = ordering.client
ORDER BY public.client.name;

SELECT public.client.name,
       SUM(meal.price) * 1.1 as bill,
       coupon.discount,
       SUM(meal.price) * 1.1 * (100-discount) / 100 as bill_with_discount
FROM ordering
JOIN client ON client.id = ordering.client
JOIN order_meal om ON ordering.id = om.order_id
JOIN meal ON meal.id = om.meal_id
LEFT OUTER JOIN coupon_client cc on client.id = cc.client_id
LEFT OUTER JOIN coupon on cc.coupon_id = coupon.id
GROUP BY public.client.name, coupon.discount
ORDER BY name;

SELECT st.id, st.capacity, meal.name, meal.price, meal.is_available
FROM ordering
JOIN sitting_table st ON st.id = ordering.sitting_table
JOIN order_meal om ON ordering.id = om.order_id
JOIN meal ON meal.id = om.meal_id
ORDER BY st.id;

SELECT st.id, st.capacity, waiter.name
FROM ordering
JOIN sitting_table st ON st.id = ordering.sitting_table
JOIN waiter ON waiter.id = ordering.waiter;

SELECT waiter.name
FROM ordering
JOIN sitting_table st ON st.id = ordering.sitting_table
RIGHT OUTER JOIN waiter ON waiter.id = ordering.waiter
WHERE st.id is NULL;

SELECT count(waiter.name) * 100 / 20 as "% of lazy waiters"
FROM ordering
JOIN sitting_table st ON st.id = ordering.sitting_table
RIGHT OUTER JOIN waiter ON waiter.id = ordering.waiter
WHERE st.id is NULL;

SELECT name, count(ordering.id) as c
FROM ordering
RIGHT OUTER JOIN client ON ordering.client = client.id
GROUP BY name
ORDER BY c DESC;

SELECT st.id, st.capacity
FROM reservation
RIGHT OUTER JOIN sitting_table st on st.id = reservation.table_id
WHERE reservation.start <= '2021-06-19' AND
      reservation.finish >= '2021-06-19'
ORDER BY st.capacity;