--1. vw_clientes_frecuencia
--Clientes con más pedidos realizados en número de órdenes).
create or replace view vw_clientes_frecuencia as select c.company_name,count(o.order_id) as total_pedidos
from customers c
join orders o on c.customer_id = o.customer_id
group by c.company_name
order by total_pedidos desc;

--2. vw_tiempo_envio_promedio
-- Promedio de días entre la fecha del pedido y el envío, por país
create or replace view vw_tiempo_envio_promedio as select  o.ship_country, round(avg(o.shipped_date - o.order_date), 2) as dias_promedio_envio
from orders o
where o.shipped_date is not null
group by o.ship_country
order by dias_promedio_envio;

-- 3. vw_empleados_eficiencia
--Ventas promedio por orden para cada empleado.
create or replace view vw_empleados_eficiencia as select  concat (e.first_name,' ',e.last_name), count(distinct o.order_id) as total_ordenes,
sum(od.unit_price * od.quantity * (1 - od.discount)) / count(distinct o.order_id)  as promedio_venta_por_orden
from employees e
join orders o on e.employee_id = o.employee_id
join order_details od on o.order_id = od.order_id
group by e.employee_id, e.first_name, e.last_name
order by promedio_venta_por_orden desc;

-- 4. vw_productos_no_vendidos
-- Productos que no se han vendido nunca.
create or replace view vw_productos_no_vendidos as select p.product_name,  p.unit_price, p.units_in_stock
from products p
left join order_details od on p.product_id = od.product_id
where od.product_id is null;

-- B) Campo JSON
--Descripción:
-- Añadir un campo json a tabla order, para este caso sera informacion extra del pedido donde se integrara 'notas al pedido', 'metedo de pago','Feedback'.

ALTER TABLE orders ADD COLUMN extra_info JSONB;
UPDATE orders SET extra_info = '{
  "notas": "Entregar después de las 18h",
  "metodo_pago": "PayPal",
  "auditoria": {"usuario": "admin", "fecha": "2025-06-02"}
}'
WHERE order_id = 10248;


 UPDATE orders SET extra_info = '{
  "notas": "Entregar entregar en conserjería",
  "metodo_pago": "cash",
  "Feedback": {
    "usuario": "cliente33",
    "fecha": "2025-06-01",
    "comentario": "caja abierta"
  }
}'
WHERE order_id = 10263;
UPDATE orders 
SET extra_info = '{
  "notas": "Entregar en recepción",
  "metodo_pago": "tarjeta",
  "Feedback": {
    "usuario": "cliente12",
    "fecha": "2025-06-01",
    "comentario": "todo correcto"
  }
}'
WHERE order_id = 10260;

UPDATE orders 
SET extra_info = '{
  "notas": "Llamar antes de entregar",
  "metodo_pago": "efectivo",
  "Feedback": {
    "usuario": "cliente45",
    "fecha": "2025-05-30",
    "comentario": "demora en el envío"
  }
}'
WHERE order_id = 10261;

UPDATE orders 
SET extra_info = '{
  "notas": "Entrega sin contacto",
  "metodo_pago": "transferencia",
  "Feedback": {
    "usuario": "cliente77",
    "fecha": "2025-06-02",
    "comentario": "muy buena atención"
  }
}'
WHERE order_id = 10262;

UPDATE orders 
SET extra_info = '{
  "notas": "No dejar con portero",
  "metodo_pago": "paypal",
  "Feedback": {
    "usuario": "cliente89",
    "fecha": "2025-05-28",
    "comentario": "producto incompleto"
  }
}'
WHERE order_id = 10264;

UPDATE orders 
SET extra_info = '{
  "notas": "Dejar en conserjería",
  "metodo_pago": "cash",
  "Feedback": {
    "usuario": "cliente33",
    "fecha": "2025-06-01",
    "comentario": "caja abierta"
  }
}'
WHERE order_id = 10265;
