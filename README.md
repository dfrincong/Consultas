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
    SELECT IFNULL(e.nombre, 'TOTAL') nombre_empleado, IFNULL(c.nombre_cliente, 'TOTAL') nombre_cliente, COUNT(*) total FROM empleado e 
    INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
    GROUP BY e.nombre, c.nombre_cliente WITH ROLLUP;
    ```

---

## TIPS con UPDATE

1. Editar utilizando el valor ya guardado

    ```sql
    UPDATE pago SET total = total + 29 WHERE codigo_cliente = 38;
    SELECT * FROM pago;
    -- ejecutar el siguiente código para regresar al valor original
    UPDATE pago SET total = total - 29 WHERE codigo_cliente = 38;
    SELECT * FROM pago;
    ```

2. Multiple agrupamiento

    ```sql
    -- primero agrego un valor por defecto, porque no tiene
    ALTER TABLE pago ALTER COLUMN total SET DEFAULT 500;
    -- se actualiza dato con valor por defecto
    UPDATE pago SET total = DEFAULT WHERE codigo_cliente = 38;
    SELECT * FROM pago;
    -- ejecutar el siguiente código para regresar al valor original
    UPDATE pago SET total = 1171 WHERE codigo_cliente = 38;
    SELECT * FROM pago;
    ```

3. Editar obteniendo el valor por subconsulta

    ```sql
    UPDATE oficina SET linea_direccion2 = (
        SELECT CONCAT(nombre,' ',apellido1) FROM empleado 
        WHERE empleado.codigo_oficina = oficina.codigo_oficina AND codigo_empleado = 23
    ) 
    WHERE codigo_oficina = 'TOK-JP';
    SELECT * FROM oficina;
    -- ejecutar el siguiente código para regresar al valor original
    UPDATE oficina SET linea_direccion2 = '' WHERE codigo_oficina = 'TOK-JP';
    SELECT * FROM oficina;
    ```

4. Subconsultas en WHERE

    ```sql
    UPDATE oficina SET linea_direccion2 = 'Se cambió' 
    WHERE oficina.codigo_oficina IN (
        SELECT codigo_oficina FROM empleado WHERE codigo_empleado = 23
    );
    SELECT * FROM oficina;
    -- ejecutar el siguiente código para regresar al valor original
    UPDATE oficina SET linea_direccion2 = '' WHERE codigo_oficina = 'TOK-JP';
    SELECT * FROM oficina;
    ```

5. UPDATE con JOIN

    ```sql
    UPDATE oficina o
    INNER JOIN empleado e ON o.codigo_oficina = e.codigo_oficina 
    SET o.linea_direccion2 = e.nombre 
    WHERE e.codigo_empleado = 8;
    SELECT * FROM oficina;
    -- ejecutar el siguiente código para regresar al valor original
    UPDATE oficina SET linea_direccion2 = '' WHERE codigo_oficina = 'MAD-ES';
    SELECT * FROM oficina;
    ```

6. Utilizar JSON

    ```sql
    -- comvertir columna a tipo json ybactualizar el dato
    ALTER TABLE gama_producto MODIFY imagen JSON;
    UPDATE gama_producto SET imagen = '{"cambio":["tres","cuatro"]}'
    WHERE gama = 'Frutales';
    SELECT * FROM gama_producto;
    -- actualizar objeto json
    UPDATE gama_producto SET imagen = JSON_REPLACE(imagen, '$.cambio', JSON_ARRAY('uno', 'dos')) 
    WHERE gama = 'Frutales';
    SELECT * FROM gama_producto;
    -- ejecutar el siguiente código para regresar al valor original
    ALTER TABLE gama_producto MODIFY imagen VARCHAR(255);
    UPDATE gama_producto SET imagen = NULL WHERE gama = 'Frutales';
    SELECT * FROM gama_producto;
    ```
