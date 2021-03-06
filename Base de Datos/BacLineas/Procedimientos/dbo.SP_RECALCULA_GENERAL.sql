USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALCULA_GENERAL]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RECALCULA_GENERAL]   
AS
BEGIN

   SET NOCOUNT ON

DECLARE 
	@fechini 		DATETIME
,	@valor_uf		FLOAT
,	@valor_dolar		FLOAT
,	@valor_pesos		FLOAT
,	@Moneda 		NUMERIC(03)
,	@TotalAsignado   	FLOAT
,	@TotalOcupado		FLOAT
,	@TotalDisponible	FLOAT
,	@TotalExceso		FLOAT
,	@Rut_Cliente		NUMERIC(10)
,	@Codigo_Cliente		NUMERIC(10)
,	@nregs  		INTEGER
,	@ncont  		INTEGER
,	@ocupado_sistema_dolar	FLOAT
,	@ocupado_sistema_pesos	FLOAT
,	@ocupado_sistema_uf	FLOAT
,	@ocupado_general	FLOAT
,	@disponible_general	FLOAT
,	@exceso_general		FLOAT
,   @FechaAnt           DATETIME -- PROD-11509
	

SELECT  @fechini = CONVERT(CHAR(8), acfecproc ,112)    
      , @FechaAnt = CONVERT(CHAR(8), acfecante, 112)  -- PROD-11509
FROM bactradersuda..mdac

	UPDATE	baclineas.dbo.linea_general with(rowlock)
		SET	moneda	= '999'
	WHERE	moneda	= '' OR moneda	= '0'

	UPDATE	baclineas.dbo.linea_sistema with(rowlock)
		SET	moneda	= '999'
	WHERE	moneda	= '' OR moneda	= '0'


SELECT * 
INTO #PASO_LINEA_GENERAL
FROM LINEA_GENERAL
WHERE RUT_CLIENTE > 0

SELECT @valor_uf 	= isnull(vmvalor,1) from VIEW_VALOR_MONEDA WHERE vmcodigo = 998 and vmfecha = @FechaAnt
SELECT @valor_dolar 	= isnull(Tipo_Cambio,1) from BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = 994 and Fecha = @FechaAnt  -- 11509
SELECT @valor_pesos 	= 1

 SELECT @nregs = COUNT(*)
 FROM #PASO_LINEA_GENERAL

 SELECT @ncont = 1

 WHILE @ncont <= @nregs
  BEGIN  

   SET ROWCOUNT @ncont

	   SELECT @Moneda 	= Moneda    	 	,
	    @TotalAsignado   	= TotalAsignado         ,
	    @TotalOcupado	= TotalOcupado       	,
	    @TotalDisponible	= TotalDisponible      	,
	    @TotalExceso	= TotalExceso   	,
	    @Rut_Cliente	= Rut_Cliente		,
	    @Codigo_Cliente	= Codigo_Cliente	
	   FROM  #PASO_LINEA_GENERAL

   SET ROWCOUNT 0
   SELECT @ncont = @ncont + 1


		SELECT 	@ocupado_sistema_dolar = isnull(sum(totalocupado),0)
		FROM 	LINEA_SISTEMA
		WHERE 	RUT_CLIENTE = @Rut_Cliente
		AND	CODIGO_CLIENTE = @Codigo_Cliente
		AND 	moneda = 13

		SELECT 	@ocupado_sistema_pesos = isnull(sum(totalocupado),0)
		FROM 	LINEA_SISTEMA
		WHERE 	RUT_CLIENTE = @Rut_Cliente
		AND	CODIGO_CLIENTE = @Codigo_Cliente
		AND 	moneda = 999

		SELECT 	@ocupado_sistema_uf = isnull(sum(totalocupado),0)
		FROM 	LINEA_SISTEMA
		WHERE 	RUT_CLIENTE = @Rut_Cliente
		AND	CODIGO_CLIENTE = @Codigo_Cliente
		AND 	moneda = 998

		SELECT @ocupado_general	= 0

		IF @Moneda = 999 
			SELECT @ocupado_general = ROUND(@ocupado_sistema_dolar * @valor_dolar,4) + ROUND(@ocupado_sistema_uf * @valor_uf,4) + ROUND(@ocupado_sistema_pesos,4)
					
		IF @Moneda = 13 
			SELECT @ocupado_general = ROUND(@ocupado_sistema_dolar,4) + ROUND(((@ocupado_sistema_uf * @valor_uf)/@valor_dolar),4) + ROUND(@ocupado_sistema_pesos / @valor_dolar,4)

		IF @Moneda = 998 
			SELECT @ocupado_general = ROUND(((@ocupado_sistema_dolar * @valor_dolar)/@valor_uf),4) + ROUND(@ocupado_sistema_uf,4) + ROUND(@ocupado_sistema_pesos / @valor_uf,4)

	SELECT 	@disponible_general = @TotalAsignado - @Ocupado_General
	SELECT 	@exceso_general = 0

	IF @Ocupado_general > @TotalAsignado
	BEGIN
		SELECT @exceso_general = @Ocupado_general - @TotalAsignado
		SELECT @disponible_general = 0
	END
	
	IF @Ocupado_general = @TotalAsignado
	BEGIN
		SELECT @exceso_general = 0
		SELECT @disponible_general = 0
	END


	UPDATE LINEA_GENERAL
	SET	TotalOcupado = @Ocupado_general
	,	TotalDisponible = @disponible_general
	,	TotalExceso = @exceso_general
	WHERE 	RUT_CLIENTE = @Rut_Cliente
	AND	CODIGO_CLIENTE = @Codigo_Cliente

 END

END
GO
