USE Ventas_Tech_DB;
SELECT
    v.fecha_venta,
    c.id_cliente,
    p.nombre_producto,
    v.cantidad,
    v.precio_unitario,
    p.id_producto,
    c.ciudad,
    (v.cantidad * v.precio_unitario) AS total_venta

FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto;

SELECT
    c.nombre,
    c.email,
    c.fecha_registro

FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

SELECT
    canal,
    SUM(total) AS total_por_canal,
    COUNT(*) AS cantidad_ventas
    
FROM (
    SELECT
        (v.cantidad * v.precio_unitario) AS total,
        'AMBA' AS canal
    FROM ventas AS v
    INNER JOIN clientes AS c
        ON v.id_cliente = c.id_cliente
    WHERE c.ciudad = 'Buenos Aires'

    UNION ALL

    SELECT
        (v.cantidad * v.precio_unitario) AS total,
        'Interior' AS canal
    FROM ventas AS v
    INNER JOIN clientes AS c
        ON v.id_cliente = c.id_cliente
    WHERE c.ciudad <> 'Buenos Aires'
) AS consolidado
GROUP BY canal;