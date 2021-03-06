USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTE_LINEAS_POR_SISTEMA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_REPORTE_LINEAS_POR_SISTEMA](	@sistema	CHAR(3)	,
							@fecha_proceso	CHAR(8)
					       		)
AS
BEGIN

	SET NOCOUNT ON
 
	DECLARE	@feriado	INTEGER	,
		@valuta24	CHAR(8)	,
		@valuta48	CHAR(8)	,
		@fecha		DATETIME

	-- Calcula Valuta de 24 Horas
	SELECT 	@feriado 	= -1
	SELECT 	@fecha		= CONVERT( DATETIME , @fecha_proceso )
	SELECT 	@fecha 		= DATEADD( DAY , 1 , @fecha )
		
	WHILE @feriado = -1
		BEGIN
			
			EXECUTE SP_FERIADO @fecha, 6 , @feriado OUTPUT
		
			IF @feriado = -1
				SELECT @fecha = DATEADD( DAY , 1 , @fecha )

		END	
	SELECT	@valuta24 = CONVERT( CHAR(8) , @fecha , 112 )
	
	-- Calcula Valuta de 48 Horas
	SELECT 	@feriado 	= -1
	SELECT 	@fecha = DATEADD( DAY , 1 , @fecha )

	WHILE @feriado = -1
		BEGIN
			
			EXECUTE SP_FERIADO @fecha, 6 , @feriado OUTPUT
		
			IF @feriado = -1
				SELECT @fecha = DATEADD( DAY , 1 , @fecha )

		END	
	SELECT	@valuta48 = CONVERT( CHAR(8) , @fecha , 112 )

	SELECT	'Rut' = CONVERT(CHAR(9),b.clrut) + '-' + b.cldv	,
		b.clcodigo					,
		b.clnombre					,
		a.Bloqueado					,
		a.TotalAsignado					,
		a.TotalOcupado					,
		a.TotalDisponible				,
		a.TotalExceso					,
		'Estado' = CASE WHEN a.Bloqueado <> 'N' 		 THEN 'Bloqueado'
				WHEN a.FechaVencimiento < @fecha_proceso THEN 'Vencida'
				ELSE 'Vigente'
			   END					,
		c.nombre_sistema				,
		'Fecha_Proceso' = CONVERT( CHAR(10) , CONVERT( DATETIME , @fecha_proceso ) , 103 )																										 ,
		'24' = ISNULL( ( SELECT SUM(MontoTransaccion) FROM linea_transaccion WHERE CONVERT(CHAR(8),linea_transaccion.FechaVencimiento,112) = @valuta24 AND b.clrut = linea_transaccion.Rut_Cliente AND b.clcodigo = linea_transaccion.Codigo_Cliente AND linea_transaccion.id_sistema = @sistema ) , 0 ) ,
		'48' = ISNULL( ( SELECT SUM(MontoTransaccion) FROM linea_transaccion WHERE CONVERT(CHAR(8),linea_transaccion.FechaVencimiento,112) = @valuta48 AND b.clrut = linea_transaccion.Rut_Cliente AND b.clcodigo = linea_transaccion.Codigo_Cliente AND linea_transaccion.id_sistema = @sistema ) , 0 ) ,
		'nombreentidad' = (SELECT rcnombre FROM entidad)
	FROM	linea_sistema	a	,
		cliente		b	,
		sistema_cnt	c
	WHERE 	a.Id_Sistema = @sistema			AND
		(b.clrut     = a.Rut_Cliente 		AND 
		 b.clcodigo  = a.Codigo_Cliente )	AND
		c.id_sistema = @sistema			AND
		( a.TotalAsignado <> 0			OR
		  a.TotalOcupado  <> 0		)
	ORDER BY b.clnombre
		
	SET NOCOUNT OFF

END

-- sp_reporte_lineas_por_sistema 'BFW','20020116'
-- select * from linea_transaccion WHERE ID_SISTEMA = 'BFW' and fechavencimiento in( '20020117','20020118')
-- SELECT * FROM linea_sistema
-- sp_helptext sp_feriado
GO
