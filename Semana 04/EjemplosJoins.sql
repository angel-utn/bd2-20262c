Use MantenimientoEdilicio;
Go

-- Inner Join

-- Obtener Nombre del Edificio, Direccion y Nombre de Localidad
Select 
    Ed.Nombre,
    Ed.Direccion,
    L.Nombre
From Edificios Ed
Inner Join Localidades L On Ed.IdLocalidad = L.IdLocalidad;

-- Listado de operarios con nombre y apellidos, nombre de localidad y nombre de especialidad
-- Solamente incluir aquellos empleados especialistas en Gas o Pintura
Select
    Ope.Apellido,
    Ope.Nombre,
    Esp.Nombre,
    Esp.PrecioHoraReferencia
From Operarios Ope
Inner Join Especialidades Esp
On Esp.IdEspecialidad = Ope.IdEspecialidad
Where Esp.Nombre In ('Gas', 'Pintura')


-- Listado de operarios con nombre y apellidos, nombre de localidad y nombre de especialidad
-- y el nombre de la localidad del empleado
Select
    Ope.Apellido,
    Ope.Nombre,
    Esp.Nombre As 'Especialidad',
    Esp.PrecioHoraReferencia,
    Loc.Nombre As 'Localidad'
From Operarios Ope
Inner Join Especialidades Esp
On Esp.IdEspecialidad = Ope.IdEspecialidad
Inner Join Localidades Loc
On Loc.IdLocalidad = Ope.IdLocalidad

-- Nombre y apellido de Operarios y Fecha y Descripción de las órdenes de trabajo.
Select
    Ope.Apellido,
    Ope.Nombre,
    Ord.Fecha,
    Ord.Descripcion
From Operarios Ope
Inner Join OrdenesTrabajo Ord On Ope.IdOperario = Ord.IdOperario
Order by Ope.Apellido Asc;

-- Left Join
-- Nombre y apellido de Operarios y Fecha y Descripción de las órdenes de trabajo.
-- Si algún empleado no tuvo órdenes de trabajo debe figurar en el listado.
Select
    Ope.Apellido,
    Ope.Nombre,
    Ord.Fecha,
    Ord.Descripcion
From Operarios Ope
Left Join OrdenesTrabajo Ord On Ope.IdOperario = Ord.IdOperario
Order by Ope.Apellido Asc;

-- Right Join
-- Datos de los edificios y el nombre de la localidad
-- Si hay localidades sin edificios construidos incluirlas en el listado
Select
    Ed.Nombre, 
    Loc.Nombre As 'Localidad'
From Edificios Ed
Right Join Localidades Loc
On Loc.IdLocalidad = Ed.IdLocalidad;

-- Datos de los edificios y el nombre de la localidad
-- Si hay localidades sin edificios construidos incluirlas en el listado
Select
    Ed.Nombre, 
    Loc.Nombre As 'Localidad'
From Edificios Ed
Right Join Localidades Loc
On Loc.IdLocalidad = Ed.IdLocalidad
Where Ed.IdEdificio Is Null;




-- Full Join

Select
    Ope.Apellido,
    Ope.Nombre,
    Loc.Nombre As 'Localidad'
From Operarios Ope
Full Join Localidades Loc
On Loc.IdLocalidad = Ope.IdLocalidad;

-- Cross Join
-- Listado de operarios con nombre y apellidos, nombre de localidad y nombre de especialidad
-- Solamente incluir aquellos empleados especialistas en Gas o Pintura
Select
    Ope.Apellido,
    Ope.Nombre,
    Esp.Nombre,
    Esp.PrecioHoraReferencia,
    Ope.Mail
From Operarios Ope
Cross Join Especialidades Esp
Order by Ope.Apellido;

-- Self Join
-- Pares de edificios que son del mismo tipo y misma cantidad de pisos. Incluir Nombre, Dirección, Tipo, Cantidad de Pisos
Select 
    Ed1.IdEdificio,
    Ed1.Nombre,
    Ed1.Tipo,
    Ed1.CantidadPisos,
    Ed2.IdEdificio,
    Ed2.Nombre,
    Ed2.Tipo,
    Ed2.CantidadPisos
From Edificios Ed1
Inner Join Edificios Ed2 On Ed1.IdEdificio < Ed2.IdEdificio
Where Ed1.Tipo = Ed2.Tipo And Ed1.CantidadPisos = Ed2.CantidadPisos

