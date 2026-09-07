Use MantenimientoEdilicio;

Select * From Edificios ;

-- -----------------------------
-- Escalares
-- -----------------------------

-- COUNT

-- La cantidad de edificios
select count(*) As CantEdificios from Edificios;

select count(IDEdificio) As CantiEdificios From Edificios;

-- La cantidad de edificios que tienen una persona de contacto
select count(NombreContacto) As CantEdificiosConContacto From Edificios;

-- La cantidad de edificios que tienen una localidad cargada
select count(IdLocalidad) As CantEdificiosConLocalidad From Edificios;

-- La cantidad de localidades distintas en las que hay edificios
select count(distinct IdLocalidad) as CantLocalidadesDistintas From Edificios;

-- La cantidad de localidades distintas en las que hay edificios comerciales
select count(distinct IdLocalidad) as CantLocalidadesDistintas From Edificios Where Tipo = 'C';


-- SUM y AVG: Exclusivamente trabajan con valores numéricos

-- El promedio de cantidad de pisos entre todos los edificios
Select AVG(Cast(CantidadPisos As Decimal)) As PromedioCantPisos From Edificios;

Select AVG(CantidadPisos * 1.0) As PromedioCantPisos From Edificios;

-- La suma de los m2 de todos los edificios
Select Sum(SuperficieM2) As TotalM2 From Edificios;

-- La suma de los m2 de todos los edificios comerciales
Select 'Comercial' As Tipo, Sum(SuperficieM2) As TotalM2 From Edificios Where Tipo = 'C'

-- Una consulta con los tres tipos de edificios y sus totales en m2
Select 'Comercial' As Tipo, Sum(SuperficieM2) As TotalM2 From Edificios Where Tipo = 'C'
UNION
Select 'Industrial', Sum(SuperficieM2) As TotalM2 From Edificios Where Tipo = 'I'
UNION
Select 'Residencial', Sum(SuperficieM2) As TotalM2 From Edificios Where Tipo = 'R'

-- Max y Min
Select Max(CantidadPisos) As CantPisosMaxima From Edificios;

Select Min(FechaNacimiento) As MasAntiguo From Operarios;

-- -----------------------------
-- Información agrupada: GROUP BY
-- -----------------------------

-- [COUNT] Obtener la cantidad de edificios que hay de cada tipo
-- (R = Residencial, C = Comercial, I = Industrial).
Select Tipo AS NombreTipo, SUM(SuperficieM2) As TotalM2
From Edificios
Group By Tipo;

-- Obtener la superficie total en m2 que administra la empresa en cada localidad y la cantidad de edificios.
-- Incluir aquellas localidades que no tienen edificios.
Select 
    Loc.Nombre,
    coalesce(SUM(Ed.SuperficieM2), 0) As TotalM2,
    Count(Ed.IdEdificio) As Cantidad
From Localidades As Loc
Left Join Edificios Ed On Loc.IdLocalidad = Ed.IdLocalidad
Group By Loc.Nombre;

-- Obtener la cantidad de ordenes de trabajo agrupado por año y por operario.

/*
    Año     Operario        Cantidad Ordenes
    2026    Simon           44
    2025    Velez           32
*/

Select
    Ope.Apellido,
    Ope.Nombre,
    Year(Ot.Fecha) as Anio,
    Count(Ot.IdOperario) As CantidadOrdenes
From Operarios Ope
Inner Join OrdenesTrabajo Ot On Ope.IdOperario = Ot.IdOperario
Group By Year(Ot.Fecha), Ope.Apellido, Ope.Nombre;

Select
    Year(Ot.Fecha) as Anio,
    Count(Distinct Ot.IdOperario) As CantidadOrdenes
From Operarios Ope
Inner Join OrdenesTrabajo Ot On Ope.IdOperario = Ot.IdOperario
Group By Year(Ot.Fecha);

--
-- Filtros sobre los resúmenes: HAVING
--

-- Por cada año, la cantidad de órdenes de trabajo. Sólo listar aquellos años que tuvieron 5 o más ordenes en el año.
Select
    Year(Ot.Fecha) as Anio,
    Count(Ot.IdOperario) As CantidadOrdenes
From Operarios Ope
Inner Join OrdenesTrabajo Ot On Ope.IdOperario = Ot.IdOperario
Group By Year(Ot.Fecha)
Having Count(Ot.IdOperario) >= 5;


-- Listar nombre de localidad, total de m2, cantidad de edificios.
-- Solamente listar los datos de las localidades que totalicen más de 10mil m2.
Select 
    Loc.Nombre,
    coalesce(SUM(Ed.SuperficieM2), 0) As TotalM2,
    Count(Ed.IdEdificio) As Cantidad
From Localidades As Loc
Left Join Edificios Ed On Loc.IdLocalidad = Ed.IdLocalidad
Group By Loc.Nombre
Having coalesce(SUM(Ed.SuperficieM2), 0) > 10000;

-- Listar nombre de localidad, total de m2, cantidad de edificios de tipo industrial.
-- Solamente listar los datos de las localidades que totalicen más de 10mil m2.
Select 
    Loc.Nombre,
    coalesce(SUM(Ed.SuperficieM2), 0) As TotalM2,
    Count(Ed.IdEdificio) As Cantidad
From Localidades As Loc
Left Join Edificios Ed On Loc.IdLocalidad = Ed.IdLocalidad
Where Ed.Tipo = 'I'
Group By Loc.Nombre
Having coalesce(SUM(Ed.SuperficieM2), 0) > 10000;