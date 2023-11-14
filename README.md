# Consultas sobre una tabla

## Primera parte (Simulacro tienda_informatica)

1. Lista el nombre de todos los productos que hay en la tabla `producto`.

    ```sql
    SELECT nombre FROM producto;
    ```
2. Lista los nombres y los precios de todos los productos de la tabla `producto`.

    ```sql
    SELECT nombre, precio FROM producto;
    ```
3. Lista todas las columnas de la tabla `producto`.

    ```sql
    SELECT * FROM producto;
    ```
4. Lista el nombre de los productos, el `precio` en euros y el `precio` en dólares estadounidenses (USD).

    ```sql
    SELECT nombre, precio/1.09 AS precio_en_euros, precio/1.07 AS precio_en_dolares FROM producto;
    ```
5. Lista el nombre de los productos, el `precio` en euros y el `precio` en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: `nombre de producto`, `euros`, `dólares`.

    ```sql
     SELECT nombre AS 'nombre de producto', precio/1.09 AS 'euros', precio/1.07 AS 'dólares' FROM producto;
    ```
6. Lista los nombres y los precios de todos los productos de la tabla `producto`, convirtiendo los nombres a mayúscula.

    ```sql
    SELECT UPPER(nombre), precio FROM producto;
    ```
7. Lista los nombres y los precios de todos los productos de la tabla `producto`, convirtiendo los nombres a minúscula.

    ```sql
    SELECT LOWER(nombre), precio FROM producto;
    ```
8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.

    ```sql
    SELECT nombre, SUBSTRING(UPPER(nombre),1,2) FROM fabricante;
    ```
9. Lista los nombres y los precios de todos los `productos` de la tabla producto, redondeando el valor del precio.

    ```sql
    SELECT nombre, ROUND(precio) FROM producto;
    ```
10. Lista los nombres y los precios de todos los `productos` de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.

    ```sql
    SELECT nombre, TRUNCATE(precio,0) FROM producto;
    ```
11. Lista el identificador de los fabricantes que tienen productos en la tabla `producto`.

    ```sql
    SELECT id_fabricante FROM producto;
    -- segunda opción
    SELECT f.id FROM fabricante AS f INNER JOIN producto AS p ON f.id = p.id_fabricante;
    ```
12. Lista el identificador de los fabricantes que tienen `productos` en la tabla producto, eliminando los identificadores que aparecen repetidos.

    ```sql
    SELECT id_fabricante FROM producto GROUP BY id_fabricante;
    -- segunda opción
    SELECT f.id FROM fabricante AS f INNER JOIN producto AS p ON f.id = p.id_fabricante GROUP BY f.id;
    ```
13. Lista los nombres de los fabricantes ordenados de forma ascendente.

    ```sql
    SELECT nombre FROM fabricante ORDER BY nombre ASC;
    ```
14. Lista los nombres de los fabricantes ordenados de forma descendente.

    ```sql
    SELECT nombre FROM fabricante ORDER BY nombre DESC;
    ```
15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.

    ```sql
    SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;
    ```
16. Devuelve una lista con las 5 primeras filas de la tabla `fabricante`.

    ```sql
    SELECT * FROM fabricante WHERE id <= 5;
    -- segunda opción (mejor)
    SELECT * FROM fabricante LIMIT 5;
    ```
17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla `fabricante`. La cuarta fila también se debe incluir en la respuesta.

    ```sql
    SELECT * FROM fabricante WHERE id BETWEEN 4 AND 5;
    -- segunda opción (mejor)
    SELECT * FROM fabricante LIMIT 2 OFFSET 3;
    ```
18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas `ORDER BY` y `LIMIT`)

    ```sql
    SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
    ```
19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas `ORDER BY` y `LIMIT`)

    ```sql
    SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
    ```
20. Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.

    ```sql
    SELECT nombre FROM producto WHERE id_fabricante = 2;
    -- segunda opción
    SELECT p.nombre FROM producto AS p INNER JOIN fabricante AS f ON p.id_fabricante = f.id WHERE p.id_fabricante = 2;
    ```

## Segunda parte (Jardineria)

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

    ```sql
    SELECT codigo_oficina, ciudad FROM oficina;
    ```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

    ```sql
    SELECT ciudad, telefono FROM oficina WHERE pais = 'España';
    ```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

    ```sql
    SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = 7;
    ```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

    ```sql
    SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE puesto = 'Director General';
    ```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

    ```sql
    SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto <> 'Representante ventas';
    ```

6. Devuelve un listado con el nombre de los todos los clientes españoles.

    ```sql
    SELECT nombre_cliente FROM cliente WHERE pais = 'Spain';
    ```

7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.

    ```sql
    SELECT DISTINCT estado FROM pedido;
    ```

8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

    Utilizando la función YEAR de MySQL.
    Utilizando la función DATE_FORMAT de MySQL.
    Sin utilizar ninguna de las funciones anteriores.

    ```sql
    -- primera opción
    SELECT DISTINCT codigo_cliente FROM pago WHERE YEAR(fecha_pago) = '2008';
    -- segunda opción
    SELECT DISTINCT codigo_cliente FROM pago WHERE DATE_FORMAT(fecha_pago, "%Y") = '2008';
    -- tercera opción
    SELECT DISTINCT codigo_cliente FROM pago WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';
    ```

9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.

    ```sql
    SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega > fecha_esperada OR (fecha_entrega IS NULL AND estado = 'Entregado');
    ```

10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

    Utilizando la función ADDDATE de MySQL.
    Utilizando la función DATEDIFF de MySQL.
    ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?

    ```sql
    -- primera opcion
    SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega <= ADDDATE(fecha_esperada, INTERVAL -2 DAY);
    -- segunda opción
    SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE DATEDIFF(fecha_entrega,fecha_esperada) <= -2;
    -- tercera opción
    SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega <= fecha_esperada - INTERVAL 2 DAY;
    ```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

    ```sql
    SELECT * FROM pedido WHERE estado = 'Rechazado' AND fecha_pedido BETWEEN '2009-01-01' AND '2009-12-31';
    ```

12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.

    ```sql
    SELECT * FROM pedido WHERE DATE_FORMAT(fecha_entrega, "%m") = '01';
    ```

13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

    ```sql
    SELECT * FROM pago WHERE (fecha_pago BETWEEN '2008-01-01' AND '2008-12-31') AND forma_pago = 'Paypal' ORDER BY fecha_pago DESC;
    ```

14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.

    ```sql
    SELECT DISTINCT forma_pago FROM pago;
    ```

15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.

    ```sql
    SELECT nombre, precio_venta FROM producto WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100 ORDER BY precio_venta DESC;
    ```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
    
    ```sql
    SELECT nombre_cliente FROM cliente WHERE ciudad = 'Madrid' AND (codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas = 30);
    ```
