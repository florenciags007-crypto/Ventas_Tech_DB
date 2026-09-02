USE Ventas_Tech_DB;

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) >
             (SELECT AVG(total_mensual)
              FROM (
                  SELECT SUM(cantidad * precio_unitario) AS total_mensual
                  FROM ventas
                  GROUP BY MONTH(fecha_venta)
              ) AS meses)
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- 1 El mes de marzo registró una facturación total de $6444.
-- 2. Los 5 clientes realizaron más de un pedido, por lo que todos pueden considerarse clientes recurrentes.
-- 3. El producto 1 fue el que generó mayor facturación, con un total de $3600.
  