# TIPS SQL

A continuación se mostraran algunos tips con SELECT, WHERE, GROUP BY y UPDATE para SQL.

## TIPS con SELECT

1. Valores fijos

    ```sql
    SELECT codigo_producto, nombre, cantidad_en_stock, precio_venta, 'físico' AS clase_producto FROM producto LIMIT 50;
    ```

2. Operaciones con columnas

    ```sql
    SELECT cantidad_en_stock, precio_venta, (cantidad_en_stock * precio_venta) AS precio_total_por_producto FROM producto LIMIT 38;
    -- otro ejemplo
    SELECT CONCAT(nombre,' ',apellido1,' ',apellido2) AS nombre_completo FROM empleado;
    ```

3. Condiciones

    ```sql
    SELECT gama, CASE WHEN gama = 'Aromáticas' THEN 1 WHEN gama = 'Frutales' THEN 2 WHEN gama = 'Herbaceas' THEN 3 WHEN gama = 'Ornamentales' THEN 4 ELSE 5 END AS codigo_gama FROM gama_producto;
    ```

4. Subconsultas

    ```sql
    SELECT p.nombre, (SELECT COUNT(d.cantidad) FROM detalle_pedido d WHERE d.codigo_producto = p.codigo_producto) AS total FROM producto p HAVING total > 5;
    ```

5. Consulta sobre subconsulta

    ```sql
    SELECT nombre, total FROM (SELECT p.nombre, (SELECT COUNT(d.cantidad) FROM detalle_pedido d WHERE d.codigo_producto = p.codigo_producto) AS total FROM producto p HAVING total > 5) AS otra_tabla WHERE total = 7;
    ```

6. Columna autoincremental virtual

    ```sql
    SELECT ROW_NUMBER() OVER(ORDER BY(SELECT 1)) AS id_virtual, codigo_oficina, pais FROM oficina ORDER BY pais DESC;
    ```

---

## TIPS con WHERE

1. La base de datos

    ```sql
    SELECT codigo_producto, nombre, cantidad_en_stock, precio_venta FROM producto WHERE precio_venta > 100;
    ```

2. NOT IN

    ```sql
    SELECT CONCAT(nombre,' ',apellido1,' ',apellido2) AS nombre_completo FROM empleado WHERE nombre NOT IN('Carlos','Lorena','John');
    ```

3. Subconsulta

    ```sql
    SELECT * FROM pago WHERE (SELECT pais FROM cliente WHERE pago.codigo_cliente = cliente.codigo_cliente) <> 'Spain';
    ```

4. REGEX

    ```sql
    SELECT nombre_contacto FROM cliente WHERE nombre_contacto REGEXP '[aeo]$';
    ```

5. IN y subconsulta

    ```sql
    SELECT ciudad FROM oficina WHERE codigo_oficina IN (SELECT codigo_oficina FROM empleado WHERE apellido1 LIKE '%a');
    ```

6. Funciones

    ```sql
    SELECT * FROM pedido WHERE SUBSTRING(estado,1,1) = 'E';
    ```

---

## TIPS con GROUP BY

1. Multiple agrupamiento

    ```sql
    SELECT p.gama, p.dimensiones, COUNT(d.cantidad) total FROM producto p INNER JOIN detalle_pedido d ON p.codigo_producto = d.codigo_producto GROUP BY p.gama, p.dimensiones ORDER BY p.gama ASC;
    ```

2. Filtrar por aggregate functions
    ```sql
    SELECT p.gama, p.dimensiones, COUNT(d.cantidad) total FROM producto p INNER JOIN detalle_pedido d ON p.codigo_producto = d.codigo_producto GROUP BY p.gama, p.dimensiones HAVING total > 10 ORDER BY p.gama ASC;
    ```

3. Agrupado por funciones escalares

    ```sql
    SELECT SUBSTRING(p.nombre,1,3) iniciales_producto, p.nombre FROM producto p INNER JOIN detalle_pedido d ON p.codigo_producto = d.codigo_producto GROUP BY iniciales_producto, p.nombre ORDER BY iniciales_producto DESC;
    ```

4. Agrupado con UNION ALL

    ```sql
    SELECT columna , COUNT(*) FROM
        (SELECT p.forma_pago columna FROM cliente c INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
        UNION ALL
        SELECT nombre_cliente columna FROM cliente) AS t_resultante
    GROUP BY columna;
    ```

5. Concatenar resultados de agrupamiento

    ```sql
    SELECT o.ciudad, GROUP_CONCAT(CONCAT_WS(' ', e.nombre, e.apellido1) ORDER BY e.nombre ASC SEPARATOR ', ') AS empleados
    FROM empleado e
    INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    GROUP BY o.ciudad;
    ```

6. Totales por cada agrupamiento

    ```sql
    
    ```