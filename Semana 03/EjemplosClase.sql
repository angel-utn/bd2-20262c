Use MantenimientoEdilicio;

-- Distinct
-- -----------------

-- Obtiene Id de Localidad y tipo edificio (con repeticiones)
Select IdLocalidad, Tipo From Edificios;

-- Obtiene Id de Localidad y Tipo de Edificio (sin repeticiones)
-- Sin repeticiones: La combinación de IdLocalidad y Tipo no admite registros repetidos en la selección
Select Distinct IdLocalidad, Tipo From Edificios;

-- Order By
-- ------------------------------------

-- Mostrar nombre, dirección y superficie en mts2 ordenado por superficie del mayor al menor
Select 
    Ed.Nombre, Ed.Direccion, Ed.SuperficieM2
From Edificios Ed
Order By Ed.SuperficieM2 Desc;

-- Mostrar nombre, dirección, cantidad de pisos y superficie en mts2. Ordenado cantidad de pisos de menor a mayor
--  y en caso de empate por superficie de mayor a menor.
Select 
    Ed.Nombre, Ed.Direccion, Ed.CantidadPisos, Ed.SuperficieM2
From Edificios Ed
Order By Ed.CantidadPisos Asc, Ed.SuperficieM2 Desc;

-- Mostrar Nombre, Apellido y Fecha de nacimientos de Operarios. Ordenado del más viejo al más joven.
Select Nombre, Apellido, FechaNacimiento From Operarios Order By FechaNacimiento Asc;


-- Top
-- -------------

-- Mostrar nombre, dirección y superficie en mts2 del edificio más grande en mts2
Select Top 1
    Ed.Nombre, Ed.Direccion, Ed.SuperficieM2
From Edificios Ed
Order By Ed.SuperficieM2 Desc;

-- Mostrar del contrato con mayor monto mensual. Incluir todos los que tengan el mayor monto mensual.
Select Top 1 with ties * From Contratos order by MontoMensual desc;

-- Where
-- ----------------------------

-- Operario con IdOperario igual a 10
Select * From Operarios Where IdOperario = 10;

-- Operario con IdOperario igual a 1000
Select * From Operarios Where IdOperario = 1000;

-- Edificios con más de 5000 m2
Select Ed.Nombre, Ed.Direccion, Ed.SuperficieM2 
From Edificios Ed
Where Ed.SuperficieM2 > 5000;

-- Edificios con 5000 m2 o más pero 9200 m2 o menos [5000, 9200]
Select Ed.Nombre, Ed.Direccion, Ed.SuperficieM2 
From Edificios Ed
Where Ed.SuperficieM2 >= 5000 And Ed.SuperficieM2 <= 9200;

-- Alternativa Between
Select Ed.Nombre, Ed.Direccion, Ed.SuperficieM2 
From Edificios Ed
Where Ed.SuperficieM2 Between 5000 and 9200;

-- Los Operarios que tienen IdEspecialidad 1, 3 o 5
Select Ope.Nombre, Ope.Apellido, Ope.IdEspecialidad
From Operarios Ope
Where Ope.IdEspecialidad = 1 Or Ope.IdEspecialidad = 3 Or Ope.IdEspecialidad = 5;

Select Ope.Nombre, Ope.Apellido, Ope.IdEspecialidad
From Operarios Ope
Where Ope.IdEspecialidad In (1, 3, 5);

-- Listado de todas las columnas de aquellos contratos que aún no finalizaron
Select * From Contratos Where FechaFin IS NULL;

-- Listado de todas las columnas de aquellos contratos que finalizaron
Select * From Contratos Where FechaFin IS NOT NULL;


-- Listar todas las columnas de todos los operarios con apellido 'Torres'
Select * From Operarios Where Apellido = 'Torres';

-- Listar todas las columnas de todos los operarios con apellido que comienzan con 'R'
Select * From Operarios Where Apellido Like 'R%';

Select * From Operarios Where Apellido LIKE 'ri%';

Select * From Operarios Where Apellido LIKE '%ri%';

Select * From Operarios Where Apellido LIKE '%r%i%';

Select * From Operarios Where Nombre Like '__r%';
