
USE AnalisisVentas;

SELECT
    sucursal,
    AVG(monto) AS media,
    MAX(monto) - MIN(monto) AS rango,
    STDEV(monto) AS desviacion_estandar_muestral
FROM ventas
GROUP BY sucursal;

