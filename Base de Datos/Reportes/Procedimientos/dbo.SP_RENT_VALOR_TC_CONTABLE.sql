USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENT_VALOR_TC_CONTABLE]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RENT_VALOR_TC_CONTABLE](
	@FECHA DATE = NULL,
	@OPCION INT = NULL
)
AS 
BEGIN
	SET NOCOUNT ON
	
	--DECLARE @FECHA DATE	 
	DECLARE @FECHA_PROC_FILTRO	DATE
	DECLARE @FECHA_INI_FILTRO	DATE
	DECLARE @ENTIDAD VARCHAR(30)
	
	IF @FECHA IS NULL 
		BEGIN
			SET @FECHA_PROC_FILTRO = (SELECT acfecproc FROM BacTraderSuda..MDAC with (nolock) ) 
		END 
	ELSE
		BEGIN
			SET @FECHA_PROC_FILTRO = @FECHA 
		END

	SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')

	IF OBJECT_ID('TEMPDB..##RENT_VALOR_TC_CONTABLE') IS NOT NULL BEGIN
		DROP TABLE ##RENT_VALOR_TC_CONTABLE
	END

	IF ISNULL(@OPCION,-1) <> -1 BEGIN
		select @FECHA AS [@FECHA],@FECHA_PROC_FILTRO AS [@FECHA_PROC_FILTRO],@FECHA_INI_FILTRO AS [@FECHA_INI_FILTRO]
	end

	
	DECLARE 
        	 @FECHAvaloriza         DATETIME     
        ,	 @FECHAdolar            DATETIME     
        ,	 @FECHA_MX  	        DATETIME
		,	 @acfecprox             DATETIME
		,	 @FECHA1				DATETIME
		,	 @vDolar_obs            NUMERIC(19,4)
		,	 @valorUF               NUMERIC(19,4)

	
	DECLARE @PrimerDiaMes	        CHAR(12)
		,	 @UltimoDiaMes	        CHAR(12)
        ,	 @valordolarant         NUMERIC(12,2)
        ,	 @valor_142             NUMERIC(12,2)
        ,	 @valor_72              NUMERIC(12,2)
        ,	 @valor_102             NUMERIC(12,2)
	
	/********************************************************************************************************/
	/*	extrae fecha de proceso de otro sistema, ya que renta fija no maneja correctamente					*/
	/*	los respaldos de esta.																				*/
	/*																										*/
	/********************************************************************************************************/
	IF ISNULL(@FECHA,'1900-01-01') = '1900-01-01' begin
	  --print '@fecha = null'
	  SELECT @fecha1		= acfecproc 
		,	 @acfecprox     = acfecprox
		,	 @FECHAvaloriza = acfecproc 
      FROM	 BacTraderSuda..MDAC		
	 
	end else begin
		--print 'fecha <> null'
		select	
			@fecha1	= fechaproc,
			@acfecprox = fechaprox,
			@FECHAvaloriza = fechaproc	
		from CbMdbOpc.dbo.OpcionesResGeneral		
		where fechaproc = @FECHA_PROC_FILTRO

		if isnull(@fecha1,'1900-01-01') = '1900-01-01' begin
			--print 'no encuentra fecha solicitada, asume fecha de proceso'
			
			SELECT @fecha1		= acfecproc 
			,	 @acfecprox     = acfecprox
			,	 @FECHAvaloriza = acfecproc 
			FROM	 BacTraderSuda..MDAC	
		end
	end

	IF ISNULL(@OPCION,-1) <> -1 BEGIN
		select @FECHAvaloriza [@FECHAvaloriza],@acfecprox [@acfecprox],@fecha1 [@fecha1]
	end
	/********************************************************************************************************/
	
			
	IF MONTH(@FECHAvaloriza) <> MONTH(@acfecprox)
		BEGIN
            SELECT @PrimerDiaMes  = SUBSTRING((CONVERT(CHAR(8),@acfecprox,112)),1,6) + '01'
            SELECT @UltimoDiaMes  = CONVERT(CHAR(8),CONVERT(DATETIME,DATEADD(DAY,-1,@PrimerDiaMes)),112)
            SELECT @FECHAvaloriza = CONVERT(DATETIME,@UltimoDiaMes,112)
            SELECT @FECHAdolar    = @fecha1
		END 
	ELSE
        BEGIN
            SELECT  @valordolarant= ISNULL(dolarObsFinMes,0) FROM BacBonosExtSuda..TEXT_ARC_CTL_DRI
            SELECT @PrimerDiaMes  = SUBSTRING((CONVERT(CHAR(8),@fecha1,112)),1,6) + '01'
            SELECT @UltimoDiaMes  = CONVERT(CHAR(8),CONVERT(DATETIME,DATEADD(DAY,-1,@PrimerDiaMes)),112)
            SELECT @FECHA_MX      = CONVERT(DATETIME,@UltimoDiaMes ,112)
         END

	--> UTILIZACION DE TIPO DE CAMBIO CONTABLE <--
	SELECT vmcodigo      = vmcodigo
	,      vmvalor       = vmvalor
	INTO   ##RENT_VALOR_TC_CONTABLE
	FROM   BacParamSuda..VALOR_MONEDA
	WHERE  vmfecha       = @fecha1
	AND    vmcodigo     IN(994,995)


    IF MONTH(@FECHAvaloriza) <> MONTH(@acfecprox) BEGIN
		--PRINT 'AUX_1'
		DECLARE @dFechaFinMes   DATETIME
		SELECT  @dFechaFinMes   = DATEADD(DAY,DATEPART(DAY,DATEADD(MONTH,1,@fecha1))*-1,DATEADD(MONTH,1,@fecha1))

		IF @dFechaFinMes = @FECHAvaloriza BEGIN
			--PRINT 'AUX_2'
			INSERT INTO ##RENT_VALOR_TC_CONTABLE
			SELECT vmcodigo      = vmcodigo
			,      vmvalor       = vmvalor
			FROM   BacParamSuda..VALOR_MONEDA
			WHERE  vmfecha       = @UltimoDiaMes
			AND    vmcodigo      IN(997,998)
		END ELSE BEGIN
			--PRINT 'AUX_3'
			INSERT INTO ##RENT_VALOR_TC_CONTABLE
			SELECT vmcodigo      = vmcodigo
			,      vmvalor       = vmvalor
			FROM   BacParamSuda..VALOR_MONEDA
			WHERE  vmfecha       = @fecha1
			AND    vmcodigo      IN(997,998)
		END
    END ELSE BEGIN
			--PRINT 'AUX_4'
            INSERT INTO ##RENT_VALOR_TC_CONTABLE
         
			SELECT vmcodigo      = vmcodigo
            ,      vmvalor       = vmvalor
            FROM   BacParamSuda..VALOR_MONEDA
            WHERE  vmfecha       = @fecha1
            AND    vmcodigo      IN(997,998)
     END

    INSERT INTO ##RENT_VALOR_TC_CONTABLE
    SELECT vmcodigo      = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
    ,      vmvalor       = Tipo_Cambio
    FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
    WHERE  Fecha         = @fecha1
    AND    Codigo_Moneda NOT IN(13,995,997,998,999)
	INSERT INTO ##RENT_VALOR_TC_CONTABLE
    SELECT 999 , 1.0

    ---SELECT @valordolarant   = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 13 -- 994
    ---SELECT @valor_142       = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 142 
    ---SELECT @valor_72        = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 72
    ---SELECT @valor_102       = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 102
	---SELECT @vDolar_obs      = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 13 -- 994
	---SELECT @valorUF         = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 998
	--> UTILIZACION DE TIPO DE CAMBIO CONTABLE <--


	IF ISNULL(@OPCION,-1)<> -1 BEGIN
		SELECT * FROM ##RENT_VALOR_TC_CONTABLE
	END 


END
GO
