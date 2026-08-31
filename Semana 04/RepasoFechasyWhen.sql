Use MantenimientoEdilicio
Go

-- Todos los operarios cuyo Nombre tenga exactamente 5 letras y la última de las letras del nombre
-- No sea una vocal 
Select * from Operarios Where Nombre Like  '____[^AEIOU]'

-- Manejo de fechas
-- ---------------------
Select 
    Year(FechaNacimiento) As Anio, 
    Month(FechaNacimiento) As Mes,
    DatePart(Day, FechaNacimiento) As Dia,
    DatePart(DAYOFYEAR, FechaNacimiento) As DiaDelAnio,
    DatePart(QUARTER, FechaNacimiento) As Cuatrimestre
From Operarios;

Select Getdate() As Ahora, DatePart(DAYOFYEAR, Getdate()) As DiaDelAnio;

Select DateAdd(Day, 1, Getdate()) As Mañana;
Select DateAdd(Day, -1, Getdate()) As Ayer;

Set dateformat 'DMY';
Select DateDiff(Day, '1/1/2026', '10/1/2026');

-- Decisión simple WHEN

-- Clasificar edificios por antigüedad 
-- (más de 30 años Antiguo, entre 10 y 30 años Intermedio, menos de 10 años Moderno)
Select 
 Ed.Nombre,
 Ed.AnioConstruccion,
 Year(Getdate()) - AnioConstruccion As Antiguedad,
 Case
    When Year(Getdate()) - AnioConstruccion > 30 Then 'Antiguo'
    When Year(Getdate()) - AnioConstruccion Between 10 And 30 Then 'Intermedio'
    Else 'Moderno' 
 End As TipoAntiguedad
From Edificios Ed;
