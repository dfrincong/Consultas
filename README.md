### Consultas sobre una tabla

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