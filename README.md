# Consultas multitabla Jardinería

## Composición interna

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

    ```sql
    SELECT c.nombre_cliente, CONCAT(e.nombre,' ', e.apellido1) AS nombre_rep_ventas FROM cliente c, empleado e WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado;
    -- segunda opción
    SELECT c.nombre_cliente, CONCAT(e.nombre,' ', e.apellido1) AS nombre_rep_ventas FROM cliente c INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
    ```

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

    ```sql
    SELECT DISTINCT c.nombre_cliente, e.nombre FROM cliente c INNER JOIN pago p ON p.codigo_cliente = c.codigo_cliente INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
    ```

3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

    ```sql
    SELECT c.nombre_cliente, e.nombre FROM cliente c LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado WHERE p.codigo_cliente IS NULL;
    ```

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

    ```sql
    SELECT DISTINCT c.nombre_cliente, e.nombre, o.ciudad FROM cliente c INNER JOIN pago p ON p.codigo_cliente = c.codigo_cliente INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;
    ```

5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

    ```sql
    SELECT c.nombre_cliente, e.nombre, o.ciudad FROM cliente c LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE p.codigo_cliente IS NULL;
    ```

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

    ```sql
    SELECT DISTINCT CONCAT(o.linea_direccion1,' ',o.linea_direccion2) 'dirección oficinas en Fuenlabrada' FROM cliente c INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE c.ciudad = 'Fuenlabrada';
    ```

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

    ```sql
    SELECT c.nombre_cliente, e.nombre, o.ciudad FROM cliente c INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;
    ```

8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

    ```sql
    SELECT emp.nombre 'nombre empleado', jef.nombre 'nombre del jefe' FROM empleado emp INNER JOIN empleado jef ON emp.codigo_jefe = jef.codigo_empleado;
    -- segunda opción (salen los que no tienen jefe especificado)
    SELECT emp.nombre 'nombre empleado', jef.nombre 'nombre del jefe' FROM empleado emp LEFT JOIN empleado jef ON emp.codigo_jefe = jef.codigo_empleado; 
    ```

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

    ```sql
    SELECT emp.nombre 'nombre empleado', jef.nombre 'nombre del jefe', jefdjef.nombre 'nombre del jefe del jefe' FROM empleado emp LEFT JOIN empleado jef ON emp.codigo_jefe = jef.codigo_empleado LEFT JOIN empleado jefdjef ON jef.codigo_jefe = jefdjef.codigo_empleado;
    ```

10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

    ```sql
    -- primera opción agregando las fechas de entrega que aparecen como NULL
    SELECT DISTINCT c.nombre_cliente FROM cliente c LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente WHERE p.fecha_entrega > p.fecha_esperada;
    -- segunda opción agregando las fechas de entrega que aparecen como NULL
    SELECT DISTINCT c.nombre_cliente, p.fecha_esperada, p.fecha_entrega, p.estado, p.comentarios FROM cliente c LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente WHERE (p.fecha_entrega > p.fecha_esperada) OR ((p.fecha_entrega IS NULL) AND (p.estado = 'Entregado'));
    -- tercera opción (del profe Miguel para analizar si le falta algo más a la consulta)
    SELECT DISTINCT c.nombre_cliente, p.fecha_esperada, p.fecha_entrega, p.estado, p.comentarios FROM cliente c LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente WHERE p.estado = 'Pendiente';
    ```

11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

    ```sql
    SELECT  DISTINCT c.nombre_cliente, g.gama FROM cliente c INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente INNER JOIN detalle_pedido d ON p.codigo_pedido = d.codigo_pedido INNER JOIN producto pro ON d.codigo_producto = pro.codigo_producto INNER JOIN gama_producto g ON pro.gama = g.gama;
    ```

## Composición externa


1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

    ```sql
    SELECT c.codigo_cliente, c.nombre_cliente FROM cliente c LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente WHERE p.codigo_cliente IS NULL;
    ```

2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

    ```sql
    SELECT c.codigo_cliente, c.nombre_cliente FROM cliente c LEFT JOIN pedido p ON p.codigo_cliente = c.codigo_cliente WHERE p.codigo_cliente IS NULL;
    ```

3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

    ```sql
    SELECT c.codigo_cliente, c.nombre_cliente FROM cliente c LEFT JOIN pago pa ON pa.codigo_cliente = c.codigo_cliente LEFT JOIN pedido pe ON pe.codigo_cliente = c.codigo_cliente WHERE pa.codigo_cliente IS NULL AND pe.codigo_cliente IS NULL;
    ```

4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

    ```sql
    SELECT e.codigo_empleado, e.nombre FROM empleado e LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE o.codigo_oficina IS NULL;
    ```

5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

    ```sql
    SELECT e.codigo_empleado, e.nombre FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas WHERE c.codigo_empleado_rep_ventas IS NULL;
    ```

6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

    ```sql
    SELECT e.codigo_empleado, e.nombre, o.* FROM empleado e LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina WHERE c.codigo_empleado_rep_ventas IS NULL;
    ```

7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

    ```sql
    SELECT o.codigo_oficina, c.codigo_cliente, e.nombre FROM empleado e LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas WHERE o.codigo_oficina IS NULL AND c.codigo_empleado_rep_ventas IS NULL;
    ```

8. Devuelve un listado de los productos que nunca han aparecido en un pedido.

    ```sql
    SELECT pro.codigo_producto, pro.nombre FROM producto pro LEFT JOIN detalle_pedido d ON pro.codigo_producto = d.codigo_producto WHERE d.codigo_producto IS NULL;
    ```

9. Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.

    ```sql
    SELECT pro.nombre, pro.descripcion, g.imagen FROM producto pro LEFT JOIN detalle_pedido d ON pro.codigo_producto = d.codigo_producto INNER JOIN gama_producto g ON pro.gama = g.gama WHERE d.codigo_producto IS NULL;
    ```

10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

    ```sql
    SELECT o.codigo_oficina FROM oficina o 
    LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina 
    INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
    INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
    INNER JOIN detalle_pedido d ON p.codigo_pedido = d.codigo_pedido 
    INNER JOIN producto pro ON d.codigo_producto = pro.codigo_producto 
    INNER JOIN gama_producto g ON pro.gama = g.gama 
    WHERE e.codigo_oficina IS NULL AND g.gama = 'Frutales';
    ```

11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

    ```sql
    SELECT DISTINCT c.codigo_cliente, c.nombre_cliente FROM pago pa RIGHT JOIN cliente c ON pa.codigo_cliente = c.codigo_cliente INNER JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente WHERE pa.codigo_cliente IS NULL;
    ```

12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

    ```sql
    SELECT emp.* FROM empleado emp LEFT JOIN empleado jef ON emp.codigo_jefe = jef.codigo_empleado LEFT JOIN cliente c ON emp.codigo_empleado = c.codigo_empleado_rep_ventas WHERE c.codigo_empleado_rep_ventas IS NULL;
    ```
