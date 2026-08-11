Create Database Clase01
Go
Use Clase01
Go
Create Table Marca (
  IdMarca int not null primary key identity(100, 1),
  Nombre varchar(50) not null
)
Go
Create Table Proveedor (
  IdProveedor varchar(6) not null primary key,
  Nombre varchar(50) not null,
  Mail varchar(100) not null unique
)
Go
Create Table Articulo(
  IdArticulo int not null primary key identity (1, 1),
  Nombre varchar(100) not null,
  Descripcion varchar(500) null,
  IdProveedor varchar(6) not null foreign key references Proveedor(IdProveedor),
  IdMarca int null foreign key references Marca(IdMarca),
  Costo money not null check (Costo > 0),
  Precio money not null,
  Stock int not null check (Stock >= 0)
)
Go
Alter Table Articulo
Add Constraint CHK_Precio Check (Precio > Costo)