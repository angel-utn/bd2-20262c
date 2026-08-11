Use Clase01
Go

/*
INSERT INTO MiTabla (Columna1, Columna2, Columna3)
VALUES (Valor1, Valor2, Valor3)
*/

-- --------------------------------
-- Inserción de datos
-- --------------------------------

-- Proveedor
Insert Into Proveedor(IdProveedor, Nombre, Mail)
Values ('PR001', 'Velez SA', 'velezsa@velez.com');

Insert Into Proveedor(IdProveedor, Nombre, Mail)
Values('PR002', 'Lara Inc', 'larainc@lara.com');

Insert Into Proveedor(IdProveedor, Nombre, Mail)
Values('PR003', 'Lara Incorporated', 'lara@lara.com');

/*
INSERT INTO Proveedor (IdProveedor, Nombre, Mail)
VALUES
    ('PR001', 'Velez SA', 'velezsa@velez.com'),
    ('PR002', 'Lara Inc', 'larainc@lara.com'),
    ('PR003', 'Lara Incorporated', 'lara@lara.com');
*/


-- Marcas
INSERT INTO Marca (Nombre)
VALUES
    ('Samsung'),
    ('Apple'),
    ('Lenovo'),
    ('HP'),
    ('Logitech');

-- Articulos
Insert into Articulo (Nombre, Descripcion, IdProveedor, IdMarca, Costo, Precio, Stock)
Values ('iPhone', 'Teléfono caro', 'PR002', 101, 500, 2500, 15);

INSERT INTO Articulo
    (Nombre, Descripcion, IdProveedor, IdMarca, Costo, Precio, Stock)
VALUES
    ('Notebook Lenovo IdeaPad', 'Notebook 15 pulgadas, 8GB RAM y 256GB SSD', 'PR001', 102, 450000, 600000, 10),
    ('Mouse Logitech M185', 'Mouse inalámbrico USB', 'PR002', 104, 15000, 22000, 25),
    ('Teclado inalámbrico', 'Teclado inalámbrico con conexión USB', 'PR003', 103, 25000, 38000, 15),
    ('Monitor LED 24 pulgadas', 'Monitor Full HD de 24 pulgadas', 'PR001', NULL, 120000, 175000, 8);


-- Error de Foreign Key
Insert into Articulo (Nombre, Descripcion, IdProveedor, IdMarca, Costo, Precio, Stock)
Values ('iPhone 20', 'Teléfono caro', 'PR010', 101, 500, 2500, 15);

-- Error de Check - Costo
Insert into Articulo (Nombre, Descripcion, IdProveedor, IdMarca, Costo, Precio, Stock)
Values ('iPhone 20', 'Teléfono caro', 'PR003', 101, -500, 2500, 15);

-- Error de Check - Precio
Insert into Articulo (Nombre, Descripcion, IdProveedor, IdMarca, Costo, Precio, Stock)
Values ('iPhone 20', 'Teléfono caro', 'PR003', 101, 500, 400, 15);


-- --------------------------------
-- Modificación de datos
-- --------------------------------
Update Articulo Set Nombre = 'iPhone 17' Where IdArticulo = 1;

Update Articulo Set Stock = 1;

UPDATE ARticulo Set Descripcion = 'Teclado sin marca', IdMarca = null where IdArticulo = 7;

-- --------------------------------
-- Eliminación de datos
-- --------------------------------
Delete From Articulo Where Precio > 50000 And Precio < 100000;