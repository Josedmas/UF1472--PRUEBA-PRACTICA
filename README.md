# 📊 A) Vistas SQL - Análisis Northwind Modificado Jose Malaver

Este repositorio contiene 4 vistas para analizar datos de la base de datos en Northwind
He realizado una modificacion a la tabla (orders), donde añadi una nueva columnas JSONB para poder ingresar nuevos datos en cada orden.


## 📝 Contenido

### 🔹 `northwind.sql`
Contiene las instrucciones necesarias para crear todas las tablas, relaciones y datos de ejemplo de la clásica base de datos Northwind, utilizada para prácticas de SQL.

### 🔹 `vistas_northwind_modificadas.sql`
Incluye la creación de múltiples **vistas SQL** diseñadas para análisis de negocio, como por ejemplo:
- clientes_frecuencia
- tiempo_envio_promedio
- empleados_eficiencia
- productos_no_vendidos
- Campos JSON para información adicional por pedido (`extra_info`).

## 🛠️ Requisitos

- PostgreSQL 12 o superior (recomendado)
- PgAdmin o cliente SQL para ejecutar los scripts

## 🚀 Cómo usar

1. Clona este repositorio:
   ```bash
   git clone https://github.com/Josedmas/northwind.git
   cd northwind

---

## 📁 Contenido de Vistas

### 1. `vw_clientes_frecuencia`
**Descripción:**  
Clientes con más pedidos realizados, basado en el número de órdenes asociadas.

**SQL:**
```sql
create or replace view vw_clientes_frecuencia as select  c.company_name, count(o.order_id) as total_pedidos
from customers c
join orders o on c.customer_id = o.customer_id
group by c.company_name
order by total_pedidos desc;
```

---

### 2. `vw_tiempo_envio_promedio`
**Descripción:**  
Promedio de días entre la fecha del pedido y la fecha de envío, agrupado por país de destino.

**SQL:**
```sql
create or replace view vw_tiempo_envio_promedio as select  o.ship_country, round(avg(o.shipped_date - o.order_date), 2) as dias_promedio_envio
from orders o
where o.shipped_date is not null
group by o.ship_country
order by dias_promedio_envio;
```

---

### 3. `vw_empleados_eficiencia`
**Descripción:**  
Promedio de ventas por orden para cada empleado. 

**SQL:**
```sql
create or replace view vw_empleados_eficiencia as select  concat (e.first_name,' ',e.last_name), count(distinct o.order_id) as total_ordenes,
sum(od.unit_price * od.quantity * (1 - od.discount)) / count(distinct o.order_id)  as promedio_venta_por_orden
from employees e
join orders o on e.employee_id = o.employee_id
join order_details od on o.order_id = od.order_id
group by e.employee_id, e.first_name, e.last_name
order by promedio_venta_por_orden desc;
```

---

### 4. `vw_productos_no_vendidos`
**Descripción:**  
Listado de productos que no han sido vendidos nunca (no tienen registros en la tabla order_details).

**SQL:**
```sql
create or replace view vw_productos_no_vendidos as select p.product_name,  p.unit_price, p.units_in_stock
from products p
left join order_details od on p.product_id = od.product_id
where od.product_id is null;
```


---

# B) Campo JSON
**Descripción:**  
Añadir un campo json a tabla order, para este caso sera informacion extra del pedido donde se integrara 'notas al pedido', 'metedo de pago','Feedback'.

**SQL:**
```sql
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
```

## 🧩 Requisitos

- Base de datos: **Northwind**
- Motor compatible: PostgreSQL (adaptable a otros)
- Tablas requeridas: `customers`, `orders`, `order_details`, `products`, `employees`

---

## 🚀 Uso

1. Conecta a tu base de datos.
2. Ejecuta cada sentencia SQL incluida en este archivo.
3. Consulta las vistas creadas como si fueran tablas normales.

---

## 📌 Autor

*Creado por Jose Malaver, junio 2025*

---
