CREATE PROC AgregarNuevoCliente
@Nombre_cte varchar(90), @Apellido_Pat varchar(90), @Apellido_Mat varchar(90), @Direccion nvarchar(90), @Cve_CP int, @Cve_Municipio int, @Cve_Estado int, @Cve_Pais int,@Id_Colonia int

AS
	INSERT INTO Clientes
	VALUES (@Nombre_cte, @Apellido_Pat, @Apellido_Mat, @Direccion, @Cve_CP, @Cve_Municipio, @Cve_Estado, @Cve_Pais, @Id_Colonia)

	--EJECUCION:
		SELECT * FROM Clientes
		EXEC AgregarNuevoCliente 'Foraneo','Oswaldo', 'Cocom','Yucatan','65140','6','2','1','2014'

CREATE PROC ActualizarPrecio

AS
	UPDATE Costos_Cine
	SET Costo = Costo*1.15
	WHERE Costo > 50

	--EJECUCION:
		SELECT * FROM Costos_Cine
		EXEC ActualizarPrecio

CREATE PROC ActualizarHorario
@ClavePelicula int, @ViejoHorario int, @ClaveSala int, @NuevoHorario int

AS
	UPDATE Sala_Horario_Pelicula
	SET Cve_Horario = @NuevoHorario
	WHERE Cve_Pelicula = @ClavePelicula AND Cve_Sala = @ClaveSala AND Cve_Horario = @ViejoHorario

	--EJECUCION:
		SELECT * FROM Sala_Horario_Pelicula
		EXEC ActualizarHorario 1209, 1001, 100, 1004