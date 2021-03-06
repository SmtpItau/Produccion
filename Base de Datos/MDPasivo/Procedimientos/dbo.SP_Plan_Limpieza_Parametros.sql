USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_Plan_Limpieza_Parametros]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_Plan_Limpieza_Parametros]
AS
BEGIN
set nocount on
DECLARE @n 	INT	
DECLARE @total	NUMERIC(10)
DECLARE @cont	NUMERIC(10)
	



DECLARE @Fec_1ANO	DATETIME
DECLARE @Fec_3MES	DATETIME
DECLARE @Fec_1MES	DATETIME

SELECT	@Fec_1ANO	= (GETDATE()-365)
SELECT	@Fec_3MES	= (GETDATE()-90)
SELECT	@Fec_1MES	= (GETDATE()-30)



PRINT ' '
-- *****************************************
PRINT 'LIMPIEZA RESULTADO_CONTABLE' 

 	SELECT	@n	= 1,
		@total	= 0,
		@cont	= 0

	SELECT	@total	 = COUNT(*)
	FROM	RESULTADO_CONTABLE
	WHERE	Fecha_Proceso < @Fec_3MES

 	WHILE @n > 0
 	BEGIN  
		BEGIN TRANSACTION
  		SET ROWCOUNT 5000
	
		DELETE	
		FROM	RESULTADO_CONTABLE
		WHERE	Fecha_Proceso < @Fec_3MES
 	
		SELECT @n = @@rowcount
		SELECT @cont = @cont + @n
		PRINT 'BORRADOS RESULTADO_CONTABLE: ' + LTRIM(RTRIM( CONVERT(CHAR(10),@cont))) + ' DE ' + LTRIM(RTRIM(CONVERT(CHAR(10),@total)))

  		SET ROWCOUNT 0
		COMMIT  		
 	END 


PRINT ' '
-- *****************************************
PRINT 'LIMPIEZA CONTABILIZA_MAYOR' 

 	SELECT	@n	= 1,
		@total	= 0,
		@cont	= 0

	SELECT	@total	 = COUNT(*)
	FROM CONTABILIZA_MAYOR
	WHERE fecha < @Fec_3MES

 	WHILE @n > 0
 	BEGIN  
		BEGIN TRANSACTION
  		SET ROWCOUNT 5000
	
		DELETE	
		FROM CONTABILIZA_MAYOR
		WHERE fecha < @Fec_3MES
 	
		SELECT @n = @@rowcount
		SELECT @cont = @cont + @n
		PRINT 'BORRADOS CONTABILIZA_MAYOR: ' + LTRIM(RTRIM( CONVERT(CHAR(10),@cont))) + ' DE ' + LTRIM(RTRIM(CONVERT(CHAR(10),@total)))
  		SET ROWCOUNT 0
		COMMIT  		
 	END 





PRINT ' '
-- *****************************************
PRINT 'LIMPIEZA LOG_AUDITORIA' 

 	SELECT	@n	= 1,
		@total	= 0,
		@cont	= 0

	SELECT	@total	 = COUNT(*)
	FROM LOG_AUDITORIA
	WHERE FechaProceso < @Fec_3MES

 	WHILE @n > 0
 	BEGIN  
		BEGIN TRANSACTION
  		SET ROWCOUNT 5000
	
		DELETE	
		FROM LOG_AUDITORIA
		WHERE FechaProceso < @Fec_3MES
 	
		SELECT @n = @@rowcount
		SELECT @cont = @cont + @n
		PRINT 'BORRADOS LOG_AUDITORIA: ' + LTRIM(RTRIM( CONVERT(CHAR(10),@cont))) + ' DE ' + LTRIM(RTRIM(CONVERT(CHAR(10),@total)))
  		SET ROWCOUNT 0
		COMMIT  		
 	END 


PRINT ' '
-- *****************************************
PRINT 'LIMPIEZA LIMITE_TRANSACCION_ERROR' 

 	SELECT	@n	= 1,
		@total	= 0,
		@cont	= 0

	SELECT	@total	 = COUNT(*)
	FROM	LIMITE_TRANSACCION_ERROR	A,
		LIMITE_TRANSACCION		B
	WHERE	a.Id_sistema		= b.Id_sistema
	AND	a.NumeroOperacion	= b.NumeroOperacion
	AND	b.FechaOperacion < @Fec_3MES


 	WHILE @n > 0
 	BEGIN  
		BEGIN TRANSACTION
  		SET ROWCOUNT 5000
	
--select * from LIMITE_TRANSACCION
--select * from LIMITE_TRANSACCION_error

		DELETE	A
		FROM	LIMITE_TRANSACCION_ERROR	A,
			LIMITE_TRANSACCION		B
		WHERE	a.Id_sistema		= b.Id_sistema
		AND	a.NumeroOperacion	= b.NumeroOperacion
		AND	b.FechaOperacion < @Fec_3MES
 	
		SELECT @n = @@rowcount
		SELECT @cont = @cont + @n
		PRINT 'BORRADOS LIMITE_TRANSACCION_ERROR: ' + LTRIM(RTRIM( CONVERT(CHAR(10),@cont))) + ' DE ' + LTRIM(RTRIM(CONVERT(CHAR(10),@total)))
  		SET ROWCOUNT 0
		COMMIT  		
 	END 


PRINT ' '
-- *****************************************
PRINT 'LIMPIEZA LIMITE_TRANSACCION'

 	SELECT	@n	= 1,
		@total	= 0,
		@cont	= 0

	SELECT	@total	 = COUNT(*)
	FROM	LIMITE_TRANSACCION
	WHERE	FechaOperacion < @Fec_3MES

 	WHILE @n > 0
 	BEGIN  
		BEGIN TRANSACTION
  		SET ROWCOUNT 5000
	
		DELETE	LIMITE_TRANSACCION
		WHERE	FechaOperacion < @Fec_3MES
 	
		SELECT @n = @@rowcount
		SELECT @cont = @cont + @n
		PRINT 'BORRADOS LIMITE_TRANSACCION: ' + LTRIM(RTRIM( CONVERT(CHAR(10),@cont))) + ' DE ' + LTRIM(RTRIM(CONVERT(CHAR(10),@total)))
  		SET ROWCOUNT 0
		COMMIT  		
 	END 


--select * from LINEA_TRANSACCION where FechaVencimiento < '20051231'
--select * from LINEA_TRANSACCION_detalle where NumeroOperacion = 22032

PRINT ' '
-- *****************************************
PRINT 'LIMPIEZA LINEA_TRANSACCION_DETALLE' 

 	SELECT	@n	= 1,
		@total	= 0,
		@cont	= 0

	SELECT	@total	 = COUNT(*)
	FROM	LINEA_TRANSACCION_DETALLE	A,
		LINEA_TRANSACCION		B
	WHERE	A.NumeroOperacion	= B.NumeroOperacion
	AND	A.NumeroDocumento	= B.NumeroDocumento
	AND	A.NumeroCorrelativo	= B.NumeroCorrelativo
	AND	A.Id_Sistema		= B.Id_Sistema
	AND	B.FechaVencimiento < @Fec_3MES

 	WHILE @n > 0
 	BEGIN  

		BEGIN TRANSACTION
  		SET ROWCOUNT 5000
	
		DELETE	A	
		FROM	LINEA_TRANSACCION_DETALLE	A,
			LINEA_TRANSACCION		B
		WHERE	A.NumeroOperacion	= B.NumeroOperacion
		AND	A.NumeroDocumento	= B.NumeroDocumento
		AND	A.NumeroCorrelativo	= B.NumeroCorrelativo
		AND	A.Id_Sistema		= B.Id_Sistema
		AND	B.FechaVencimiento < @Fec_3MES

 	
		SELECT @n = @@rowcount
		SELECT @cont = @cont + @n
		PRINT 'BORRADOS LINEA_TRANSACCION_DETALLE: ' + LTRIM(RTRIM( CONVERT(CHAR(10),@cont))) + ' DE ' + LTRIM(RTRIM(CONVERT(CHAR(10),@total)))
  		SET ROWCOUNT 0
		COMMIT

 	END 



PRINT ' '
-- *****************************************
PRINT 'LIMPIEZA LINEA_TRANSACCION' 

 	SELECT	@n	= 1,
		@total	= 0,
		@cont	= 0

	SELECT	@total	 = COUNT(*)
	FROM	LINEA_TRANSACCION
	WHERE	FechaVencimiento < @Fec_3MES

 	WHILE @n > 0
 	BEGIN  
		BEGIN TRANSACTION
  		SET ROWCOUNT 5000
	
		DELETE	LINEA_TRANSACCION
		WHERE	FechaVencimiento < @Fec_3MES

 	
		SELECT @n = @@rowcount
		SELECT @cont = @cont + @n
		PRINT 'BORRADOS LINEA_TRANSACCION: ' + LTRIM(RTRIM( CONVERT(CHAR(10),@cont))) + ' DE ' + LTRIM(RTRIM(CONVERT(CHAR(10),@total)))
  		SET ROWCOUNT 0
		COMMIT  		
 	END 


PRINT ' '
-- *****************************************
PRINT 'LIMPIEZA VALE_VISTA_EMITIDO' 

 	SELECT	@n	= 1,
		@total	= 0,
		@cont	= 0

	SELECT	@total	 = COUNT(*)
	FROM VALE_VISTA_EMITIDO
	WHERE fecha_generacion < @Fec_3MES

 	WHILE @n > 0
 	BEGIN  
		BEGIN TRANSACTION
  		SET ROWCOUNT 5000
	
		DELETE	
		FROM VALE_VISTA_EMITIDO
		WHERE fecha_generacion < @Fec_3MES
 	
		SELECT @n = @@rowcount
		SELECT @cont = @cont + @n
		PRINT 'BORRADOS VALE_VISTA_EMITIDO: ' + LTRIM(RTRIM( CONVERT(CHAR(10),@cont))) + ' DE ' + LTRIM(RTRIM(CONVERT(CHAR(10),@total)))
  		SET ROWCOUNT 0
		COMMIT  		
 	END 


--	DUMP TRAN PARAMETROS WITH NO_LOG

PRINT 'PROCESO TERMINADO'

set nocount off



END
 

GO
