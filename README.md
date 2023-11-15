# 1.4.8 Subconsultas

## 1.4.8.1 Con operadores básicos de comparación

1. Devuelve el nombre del cliente con mayor límite de crédito.

    ```sql
    SELECT nombre_cliente FROM cliente WHERE limite_credito = (
        SELECT MAX(limite_credito) FROM cliente
    );
    ```

2. Devuelve el nombre del producto que tenga el precio de venta más caro.

    ```sql
    SELECT nombre FROM producto WHERE precio_venta = (
        SELECT MAX(precio_venta) FROM producto
    );
    ```

3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla `detalle_pedido`)

    ```sql
    SELECT nombre FROM producto p INNER JOIN detalle_pedido d ON p.codigo_producto = d.codigo_producto WHERE d.cantidad = ALL (
        SELECT SUM(cantidad) FROM detalle_pedido GROUP BY codigo_producto
    );
    ```

4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar `INNER JOIN`).

    ```sql
    SELECT DISTINCT c.nombre_cliente FROM cliente c INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente WHERE c.limite_credito > ANY (
        SELECT SUM(total) FROM pago GROUP BY codigo_cliente
    );
    ```

5. Devuelve el producto que más unidades tiene en stock.

    ```sql
    SELECT nombre FROM producto WHERE cantidad_en_stock = (
        SELECT MAX(cantidad_en_stock) FROM producto
    );
    ```

6. Devuelve el producto que menos unidades tiene en stock.

    ```sql
    SELECT nombre FROM producto WHERE cantidad_en_stock = (
        SELECT MIN(cantidad_en_stock) FROM producto
    );
    ```

7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de **Alberto Soria**.

    ```sql
    SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = (
        SELECT codigo_empleado FROM empleado WHERE nombre = 'Alberto' and apellido1 = 'Soria'
    );
    ```


## 1.4.8.2 Subconsultas con ALL y ANY

1. Devuelve el nombre del cliente con mayor límite de crédito.

    ```sql
    
    ```

2. Devuelve el nombre del producto que tenga el precio de venta más caro.

    ```sql
    
    ```

3. Devuelve el producto que menos unidades tiene en stock.

    ```sql
    
    ```


## 1.4.8.3 Subconsultas con IN y NOT IN

1. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.

    ```sql
    
    ```

2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

    ```sql
    
    ```

3. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.

    ```sql
    
    ```

4. Devuelve un listado de los productos que nunca han aparecido en un pedido.

    ```sql
    
    ```

5. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.

    ```sql
    
    ```

6. Devuelve las oficinas donde **no trabajan** ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama `Frutales`.

    ```sql
    
    ```

7. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

    ```sql
    
    ```


## 1.4.8.4 Subconsultas con EXISTS y NOT EXISTS

1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

    ```sql
    
    ```

2. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.

    ```sql
    
    ```

3. Devuelve un listado de los productos que nunca han aparecido en un pedido.

    ```sql
    
    ```

4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.

    ```sql
    
    ```
