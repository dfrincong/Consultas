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
    SELECT nombre_contacto FROM cliente WHERE nombre_contacto LIKE '%[aeo]';  -- no funciona
    SELECT nombre_contacto FROM cliente WHERE nombre_contacto LIKE ('%a','%e','%o'); -- no funciona
    SELECT nombre_contacto FROM cliente WHERE nombre_contacto LIKE '%a' OR nombre_contacto LIKE '%e' OR nombre_contacto LIKE '%o';
    ```

5. IN y subconsulta

    ```sql
    SELECT ciudad FROM oficina WHERE codigo_oficina IN (SELECT codigo_oficina FROM empleado WHERE apellido1 LIKE '%a');
    ```

6. Funciones

    ```sql
    SELECT * FROM pedido WHERE SUBSTRING(estado,1,1) = 'E';
    ```

