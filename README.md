# Consultas multitabla

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
    
    ```

5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

    ```sql
    
    ```

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

    ```sql
    
    ```

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

    ```sql
    
    ```

8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

    ```sql
    
    ```

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

    ```sql
    
    ```

10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

    ```sql
    
    ```

11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

    ```sql
    
    ```