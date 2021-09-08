USE BaseDatosCine

SELECT Sucursales.Cve_Sucursal, Nombre_Sucursal, COUNT(Cve_Sala) AS Num_Salas
FROM Sucursales INNER JOIN Salas_Cine
ON Sucursales.Cve_Sucursal = Salas_Cine.Cve_Sucursal
GROUP BY Nombre_Sucursal,Sucursales.Cve_Sucursal
ORDER BY Num_Salas DESC

SELECT Sala_Horario_Pelicula.Cve_Pelicula, Peliculas.Nombre_Pelicula, Tipo_Sala.Descripcion_Sala, COUNT(Horarios.Cve_Horario ) AS ContHorario 
FROM Sala_Horario_Pelicula
INNER JOIN Peliculas ON  Peliculas.Cve_Pelicula = Sala_Horario_Pelicula.Cve_Pelicula 
INNER JOIN Horarios ON Horarios.Cve_Horario = Sala_Horario_Pelicula.Cve_Horario 
INNER JOIN Tipo_Sala ON Tipo_Sala.Cve_Tipo_Sala = Sala_Horario_Pelicula.Cve_Tipo_Sala  
GROUP BY Sala_Horario_Pelicula.Cve_Pelicula, Peliculas.Nombre_Pelicula, Tipo_Sala.Descripcion_Sala
ORDER BY  Tipo_Sala.Descripcion_Sala, Peliculas.Nombre_Pelicula ASC

SELECT  S.Nombre_Sucursal, YEAR(PC.Fecha_Pago) AS Anio, SUM(dbo.MontoTotal(PC.Codigo_Referencia)) AS Total
FROM Pago_Cliente AS PC
INNER JOIN Asignacion_Lugares AS AL ON PC.Codigo_Referencia = AL.Codigo_Referencia
INNER JOIN Detalle_Pago_Cliente AS DPC ON PC.Codigo_Referencia = DPC.Codigo_Referencia
INNER JOIN Sucursales AS S ON PC.Cve_Sucursal = S.Cve_Sucursal
GROUP BY PC.Fecha_Pago, S.Nombre_Sucursal
ORDER BY YEAR(PC.Fecha_Pago)
