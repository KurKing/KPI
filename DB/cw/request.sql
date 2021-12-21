SELECT client.name, coupon.discount
FROM coupon_client
RIGHT OUTER JOIN client on client.id = coupon_client.client_id
RIGHT OUTER JOIN coupon on coupon.id = coupon_client.coupon_id
ORDER BY discount DESC;

SELECT client, credit_card
FROM credit_card
JOIN client ON client.id = credit_card.client_id
ORDER BY client.name;

SELECT reservation.start, reservation.finish, sitting_table.capacity, sitting_table.id as "table"
FROM reservation
RIGHT OUTER JOIN sitting_table on sitting_table.id = reservation.table_id
ORDER BY sitting_table.id;

SELECT name, description, price, meal.is_available, type, menu.is_available, meal.is_available AND menu.is_available
FROM meal
RIGHT OUTER JOIN menu on meal.menu_id = menu.id
WHERE meal.is_available AND menu.is_available
ORDER BY type;

SELECT client.name, public.waiter.name, st.capacity
FROM ordering
JOIN client ON client.id = ordering.client
JOIN waiter ON ordering.waiter = waiter.id
JOIN sitting_table st on ordering.sitting_table = st.id;

SELECT client.name, meal.name
FROM ordering
JOIN order_meal om on ordering.id = om.order_id
JOIN meal on meal.id = om.meal_id
JOIN client on client.id = ordering.client
ORDER BY public.client.name;
