# RetailPro - Análisis de Ventas

## 📊 Descripción del Proyecto

**RetailPro** es un sistema de análisis de datos de ventas minoristas que integra múltiples pisos de un edificio comercial que vende alimentos y bebidas. El proyecto procesa, transforma y analiza datos de ventas en tiempo real para generar insights comerciales accionables.

El objetivo es:
- Identificar patrones de venta por cliente, producto y región
- Segmentar clientes según comportamiento de compra
- Analizar rentabilidad por canal (AMBA vs Interior)
- Detectar productos estrella y riesgos de concentración
- Monitorear la salud de la base de clientes

---
Empezá Ahora
¿Cómo empezar en 3 pasos?

Descargá este repositorio (botón verde "Code" → Download ZIP)
Abrí tu cliente SQL (SSMS, MySQL Workbench, etc.)
Ejecutá los archivos en orden:
sql/01_crear_base_datos.sql → Crea la BD
sql/02_crear_tablas.sql → Crea las tablas
sql/03_insertar_datos_muestra.sql → Carga datos de ejemplo
sql/analisis/ventas_detalladas.sql → ¡Ves tu primer análisis!

Listo. Ya tenés datos funcionando.

¿Querés visualizarlos? Abrí Power BI y conectá a la base de datos. Todos los dashboards están en power_bi/.

---

## 🛠️ Herramientas Utilizadas

| Herramienta | Uso |
|------------|-----|
| **SQL Server / MySQL** | Gestión de base de datos `Ventas_Tech_DB` |
| **Excel** | Análisis exploratorio y validación de datos |
| **Power Query** | ETL - Extracción, transformación y limpieza de datos |
| **Power BI** | Dashboards y visualizaciones interactivas |
| **Git** | Control de versiones de scripts y documentación |

---

## 📁 Estructura del Repositorio

```
Ventas_Tech_DB/
├── README.md                          # Este archivo
├── sql/
│   ├── 01_crear_base_datos.sql       # Script de inicialización
│   ├── 02_crear_tablas.sql           # Definición de esquema (clientes, productos, ventas)
│   ├── 03_insertar_datos_muestra.sql # Datos de prueba
│   ├── analisis/
│   │   ├── ventas_detalladas.sql     # Query: análisis completo de ventas
│   │   ├── clientes_sin_ventas.sql   # Query: identificar clientes inactivos
│   │   └── ventas_por_canal.sql      # Query: análisis AMBA vs Interior
│   └── mantenimiento/
│       ├── indices.sql               # Optimización de índices
│       └── limpieza_datos.sql        # Queries para auditoría
├── power_bi/
│   ├── RetailPro_Dashboard.pbix      # Dashboard principal
│   └── Datos_Conexion.pbtx           # Template de conexión
├── power_query/
│   └── transformaciones.m            # Scripts de Power Query para ETL
├── documentacion/
│   ├── diccionario_datos.md          # Descripción de campos
│   ├── flujo_etl.md                  # Explicación del pipeline
│   └── guia_consultas.md             # Ejemplos de análisis
└── .gitignore                         # Archivos a ignorar (contraseñas, datos sensibles)
```

---

## 🚀 Requisitos Previos

### Para ejecutar los scripts SQL:
- **SQL Server 2016+** o **MySQL 5.7+** (o equivalente)
- **Cliente SQL** (SQL Server Management Studio, MySQL Workbench, o DBeaver)
- Permisos de creación de base de datos y tablas

### Para usar Power BI:
- **Power BI Desktop** (descarga gratuita)
- Acceso a la base de datos `Ventas_Tech_DB`

### Para Power Query:
- **Excel 2016+** o **Microsoft 365**

---

## 📋 Cómo Ejecutar los Scripts SQL

### 1️⃣ Paso 1: Crear la Base de Datos

```sql
-- Abrir una consola SQL (SSMS, MySQL Workbench, etc.)
-- Ejecutar el script de inicialización:

USE master;
GO
CREATE DATABASE Ventas_Tech_DB;
GO
USE Ventas_Tech_DB;
```

### 2️⃣ Paso 2: Crear el Esquema (Tablas y Relaciones)

```sql
-- Ejecutar: sql/02_crear_tablas.sql
-- Este script crea las tablas:
-- - clientes (id_cliente, nombre, email, ciudad, fecha_registro)
-- - productos (id_producto, nombre_producto, precio_unitario, stock)
-- - ventas (id_venta, id_cliente, id_producto, fecha_venta, cantidad, precio_unitario)

USE Ventas_Tech_DB;
GO
-- [Contenido del archivo 02_crear_tablas.sql]
```

### 3️⃣ Paso 3: Insertar Datos de Prueba

```sql
-- Ejecutar: sql/03_insertar_datos_muestra.sql
-- Esto carga datos iniciales para validación

USE Ventas_Tech_DB;
GO
-- [Contenido del archivo 03_insertar_datos_muestra.sql]
```

### 4️⃣ Paso 4: Ejecutar Queries de Análisis

```bash
# Opción A: Desde la línea de comandos (SQL Server)
sqlcmd -S "tu_servidor" -U "usuario" -P "contraseña" -d "Ventas_Tech_DB" -i "sql/analisis/ventas_detalladas.sql"

# Opción B: Desde MySQL
mysql -h localhost -u usuario -p Ventas_Tech_DB < sql/analisis/ventas_detalladas.sql

# Opción C: Manualmente en SSMS/Workbench
-- Copiar y pegar el contenido del archivo .sql y ejecutar
```

---

## 📊 Queries Principales

### 1. Análisis Detallado de Ventas
**Archivo**: `sql/analisis/ventas_detalladas.sql`

Retorna todas las ventas con información de cliente, producto, cantidad y total.

```sql
SELECT
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    p.nombre_producto,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
ORDER BY v.fecha_venta DESC;
```

### 2. Clientes sin Ventas (Churn)
**Archivo**: `sql/analisis/clientes_sin_ventas.sql`

Identifica clientes registrados que nunca realizaron compras (riesgo de pérdida).

```sql
SELECT
    c.id_cliente,
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL
ORDER BY c.fecha_registro DESC;
```

### 3. Ventas por Canal (AMBA vs Interior)
**Archivo**: `sql/analisis/ventas_por_canal.sql`

Análisis de rentabilidad segmentado por región geográfica.

```sql
SELECT
    c.ciudad,
    CASE 
        WHEN c.ciudad = 'Buenos Aires' THEN 'AMBA'
        ELSE 'Interior'
    END AS canal,
    SUM(v.cantidad * v.precio_unitario) AS total_venta,
    COUNT(*) AS cantidad_ventas,
    ROUND(AVG(v.cantidad * v.precio_unitario), 2) AS ticket_promedio
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
GROUP BY c.ciudad
ORDER BY total_venta DESC;
```

---

## 💡 Recomendaciones de Uso

### Para Análisis Exploratorio:
1. Ejecutar primero `ventas_detalladas.sql` para explorar los datos
2. Luego filtrar por período, cliente o producto según necesidad

### Para Monitoreo Operativo:
1. Ejecutar `clientes_sin_ventas.sql` semanalmente
2. Comparar `ventas_por_canal.sql` mes a mes
3. Detectar anomalías en volumen o valor promedio

### Para Dashboards:
1. Conectar Power BI a `Ventas_Tech_DB`
2. Usar los queries como origen de datos
3. Crear visualizaciones por canal, producto, período

---

## 🔐 Seguridad y Mejores Prácticas

⚠️ **IMPORTANTE**: 
- ❌ Nunca commitear credenciales de base de datos
- ✅ Usar `.gitignore` para excluir archivos sensibles
- ✅ Documentar la estructura de datos (diccionario_datos.md)
- ✅ Versionear cambios en esquema SQL
- ✅ Crear índices en columnas de JOIN frecuentes

---

## 📈 Próximas Mejoras

- [ ] Agregar análisis predictivo (tendencias de venta)
- [ ] Implementar alertas automáticas por concentración de riesgo
- [ ] Crear análisis de rentabilidad por producto/cliente
- [ ] Automatizar carga de datos (ETL programado)
- [ ] Agregar tests unitarios para queries críticos

---

## 👤 Autor

**Florencia G.**  
Proyecto: RetailPro v1.0

---

## 📞 Soporte

Para dudas o mejoras, abrir un **Issue** en el repositorio o contactar directamente.

---

## 📄 Licencia

Este proyecto es de código abierto para fines educativos.

---

**Última actualización**: Octubre 2026
