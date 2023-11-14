CREATE DATABASE tienda_informatica;
USE tienda_informatica;
CREATE TABLE fabricante(
    id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
CREATE TABLE producto(
    id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    precio DOUBLE NOT NULL,
    id_fabricante INT NOT NULL
);
ALTER TABLE fabricante ADD CONSTRAINT PK_fabricante_id PRIMARY KEY (id);
ALTER TABLE producto ADD CONSTRAINT PK_producto_id PRIMARY KEY (id);
ALTER TABLE producto ADD CONSTRAINT FK_producto_id_fabricante_id_fabricante FOREIGN KEY(id_fabricante) REFERENCES fabricante(id);