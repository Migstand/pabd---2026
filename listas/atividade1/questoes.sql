-- Questão 1
select name from products
where price > 1000;

-- Questão 2
select name from products
order by price desc;

-- Questão 3
update products
set price = price*1.10
where name like '%Dell%';

-- Questão 4
delete from products where name like '%Macbook%';

-- Questão 5
delete from products
where id not in (
    select product_id
    from orders_products
);

-- Questão 6

-- Teste falho
-- select o.status orders, p.name products from orders o join products p on p.id in (select product_id from orders_products) where o.order_date >= now() - interval '30 days' order by p.name, o.status;

select id, status from orders
where order_date >= now() - interval '30 days';

-- Questão 7
select u.name users,
    o.id orders
from orders o
join users u
    on o.user_id = u.id
order by o.id, u.name;

-- Questão 8
select u.name users,
    o.id orders
from users u
left join orders o
    on o.user_id = u.id
order by o.id, u.name;

-- Questão 9
select id, name, email from users
where id in (
    select user_id
    from orders
);

-- Questão 10
select name from products
where id not in (
    select product_id
    from orders_products
);

-- Questão 11
select name from users
where id not in (
    select user_id
    from orders
);

-- Questão 12
select name from products
where price > (
    select round(avg(price), 2) media_preco from products)
order by price desc;

-- Questão 13
select u.name,
    count(o.user_id)
from users u
join orders o
    on u.id = o.user_id
group by u.name;

-- Questão 14
select p.name,
    count(op.product_id)
from products p
join orders_products op
    on op.product_id = p.id
group by p.name, op.product_id
order by count(op.product_id) desc
limit 3;

-- Questão 15
select
    u.name users,
    coalesce(count(o.user_id), '0') orders,
    coalesce(sum(o.total), '0') orders
from users u
left join orders o
    on u.id = o.user_id
group by u.id
order by count(o.total) desc;