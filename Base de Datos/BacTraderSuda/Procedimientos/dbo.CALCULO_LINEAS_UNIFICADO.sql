USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[CALCULO_LINEAS_UNIFICADO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[CALCULO_LINEAS_UNIFICADO]( @dFechaProceso DATETIME)
AS
BEGIN

	DECLARE @iX		NUMERIC(5)
	,	@nContador	NUMERIC(5)
	,	@nRut		NUMERIC(9)
	,	@iCod		NUMERIC(3)			;
	
	DECLARE @sNombre	VARCHAR(100)			;

	CREATE TABLE #clientes
	( 	RUT 		NUMERIC(9)
	,  	CODIGO		NUMERIC(5)
	,	NOMBRE		CHAR(100) 
	,	iOtro		INTEGER	NULL DEFAULT 0	)		;

        TRUNCATE TABLE #clientes

	INSERT INTO #clientes(rut,codigo,nombre)
	EXECUTE baccamsuda.dbo.sp_leer_clientes_lineas  	;

	SELECT *,'nReg'= IDENTITY(NUMERIC(10)) 
	  INTO #cli3 
	  FROM #clientes					;


	   SET @iX        = 0					;

	   SET @nContador = (SELECT MAX(Nreg) FROM #cli3)	;

	 WHILE @iX<=@nContador
	 BEGIN
         	   SET @iX                = @iX + 1		;

		SELECT 	@nRut 		= RUT
		,	@iCod		= codigo
		,	@sNombre	= nombre
      		  FROM #cli3
      		 WHERE Nreg               = @iX   	;

		EXECUTE baccamsuda.dbo.SP_RECALCALCULO_LINEAS_SPOT_otro @nrut
	END


END



GO
