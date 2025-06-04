
# 📦 Northwind Database (Versión Modificada para PostgreSQL)

Este proyecto contiene un volcado de base de datos del clásico conjunto de datos **Northwind**, adaptado para funcionar con **PostgreSQL**. La base de datos está diseñada para representar una empresa de distribución de productos alimenticios y contiene datos sobre clientes, pedidos, empleados, productos, envíos y más.

##  📁 Estrutura del repositorio
```
├── documentacion/
│   └── README.md             # Documentación donde se explicación de algunas vistas y el uso de JSONB en la tabla `orders`
├── README.md                 # Archivo raíz de documentación (puede ser copia o resumen)
├── dump_modificado_northwind.sql  # Script SQL con la base de datos Northwind modificada
```
## 🛠 Requisitos

- PostgreSQL 12+
- Herramienta `psql` o algún cliente como DBeaver, PgAdmin, etc.

## 📥 Instalación

1. Clonar repositorio
```
   git clone https://github.com/Josedmas/UF1472--PRUEBA-PRACTICA
```

2. Crea una base de datos nueva en PostgreSQL:
   ```bash
   createdb northwind
   ```

2. Importa el archivo SQL:
   ```bash
   psql -U tu_usuario -d northwind -f dump_modificado_northwind.sql
   ```

## 🗂 Estructura de la Base de Datos

### Tablas principales

- `categories`: Categorías de productos
- `customers`: Clientes
- `employees`: Empleados de ventas
- `orders`: Pedidos realizados
- `order_details`: Detalles de cada pedido
- `products`: Productos ofrecidos
- `suppliers`: Proveedores
- `shippers`: Empresas de envío
- `territories`, `employee_territories`, `region`: Información geográfica y asignación de vendedores
- `customer_demographics`, `customer_customer_demo`: Segmentación de clientes
- `us_states`: Estados de EE.UU.

### Características adicionales

- Uso de campos `jsonb` como `extra_info` en `orders` y `category_details` en `products`.
- Vistas (`VIEW`) para facilitar análisis y reportes.

### Vistas útiles

- `vw_clientes_frecuencia`: Frecuencia de pedidos por cliente
- `vw_empleados_eficiencia`: Promedio de venta por orden por empleado
- `vw_productos_mas_vendidos`: Productos más vendidos e ingresos generados
- `vw_ventas_dia`, `vw_ventas_pais`, `vw_ventas_empleado`: Reportes de ventas segmentadas
- `vw_ordenes_detalladas`: Pedidos pendientes con información relevante
- `vw_rangos_precio`, `vw_rango_min_max`: Análisis de precios por categoría
- `vw_stock_bajo`: Productos con bajo inventario


## 📊 Casos de uso típicos

- Consultas analíticas sobre ventas y eficiencia de empleados.
- Detección de productos no vendidos.
- Análisis por país, ciudad, categoría o fecha.
- Generación de reportes de inventario y stock crítico.

