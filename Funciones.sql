CREATE FUNCTION dbo.OrdenesDeCompra (@Cve_cte int)

RETURNS	@OrdenesDeCompra TABLE(Codigo_Referencia int, Fecha_Pago date, Cve_cte int, Costo_Total_Cine money, Costo_Total_Productos money, Gran_Total money, Status_Cobro int, Cve_Sucursal int, Cve_Sala int, Cve_Tipo_Sala int, Cve_Horario int, Cve_Pelicula int, Status_Impresion int, Status_Reimpresion int)
AS
	BEGIN
		INSERT @OrdenesDeCompra
		SELECT * FROM Pago_Cliente
		WHERE Cve_cte = @Cve_cte
		RETURN 
	END;

	--Retorno:
		SELECT * FROM dbo.OrdenesDeCompra(1)

CREATE FUNCTION dbo.MontoTotal (@CodReferencia int)

RETURNS INT 
AS
	BEGIN
		DECLARE @CostoBoleto int 
		SELECT @CostoBoleto= (
			SELECT Costo_Boleto * COUNT(AL.Codigo_Referencia)
			FROM Detalle_Pago_Cliente AS DPC
			INNER JOIN Asignacion_Lugares AS AL ON AL.Codigo_Referencia = @CodReferencia
			WHERE DPC.Codigo_Referencia = @CodReferencia
			GROUP BY Costo_Boleto
		);
		RETURN @CostoBoleto
	END
	
	--Retorno:
	SELECT dbo.MontoTotal (123401) AS MontoTotal


CREATE FUNCTION dbo.DifDias (@FechaA datetime, @FechaB datetime)

RETURNS INT 
AS
	BEGIN
		DECLARE @Dias INT
		SET @Dias = DATEDIFF(dayofyear, @FechaA, @FechaB)
		RETURN @Dias
	END;

	--Retorno:
		SELECT Cve_Pelicula, dbo.DifDias (Fecha_Inicial, Fecha_Final) AS Dias
		FROM Sala_Horario_Pelicula

