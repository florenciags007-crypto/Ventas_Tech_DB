USE Ventas_Tech_DB;

WITH ventas_total AS (
    SELECT
        id_venta,
        cantidad * precio_unitario AS total_venta
    FROM ventas
)
SELECT DISTINCT 
    AVG(total_venta)                                             OVER () AS media,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_venta)     OVER () AS mediana
FROM ventas_total; 

WITH ventas_total AS (
    SELECT
        id_venta,
        cantidad * precio_unitario AS total_venta
    FROM ventas),

q AS (
  SELECT DISTINCT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_venta) OVER () AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_venta) OVER () AS q3
  FROM ventas_total
)
SELECT DISTINCT
  q1, q3,
  (q3 - q1)          AS iqr,
  q1 - 1.5*(q3 - q1) AS limite_inferior,
  q3 + 1.5*(q3 - q1) AS limite_superior
FROM q;
