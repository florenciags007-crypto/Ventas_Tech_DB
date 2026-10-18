
CREATE DATABASE AnalisisVentas;

USE AnalisisVentas;

CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    sucursal VARCHAR(20),
    dia INT,
    monto DECIMAL(10,2)
);

INSERT INTO ventas (id_venta, sucursal, dia, monto)
VALUES
(1, 'Norte', 1, 500),
(2, 'Norte', 2, 510),
(3, 'Norte', 3, 490),
(4, 'Norte', 4, 505),
(5, 'Norte', 5, 495),
(6, 'Sur', 1, 100),
(7, 'Sur', 2, 900),
(8, 'Sur', 3, 50),
(9, 'Sur', 4, 1200),
(10, 'Sur', 5, 250);