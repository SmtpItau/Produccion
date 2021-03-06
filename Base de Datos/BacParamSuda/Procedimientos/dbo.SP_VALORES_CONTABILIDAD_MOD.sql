USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORES_CONTABILIDAD_MOD]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_VALORES_CONTABILIDAD_MOD]    
                        @Fecha_Hoy DATETIME
AS    
BEGIN    
    
	SET NOCOUNT ON   


    /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA OPCIONES                                            */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 13/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/



  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    DECLARE @VALOR_TC_CONTABLE TABLE
		(   vmfecha   DATETIME   NOT NULL DEFAULT('')        
		,   vmcodigo  INTEGER    NOT NULL DEFAULT(0)        
		,   vmvalor   FLOAT      NOT NULL DEFAULT(0.0))



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
   
   
	DECLARE @dFechaAnterior   DATETIME
	DECLARE @dFechaProceso    DATETIME
	DECLARE @dFechaProxima    DATETIME

   /*-----------------------------------------------------------------------------*/
   /* CON LA FECHA DEBEREMOS SACAR LOS HISTORICOS EN ACUERDO A LAS FECHAS         */
   /*-----------------------------------------------------------------------------*/
   	 SELECT	@dFechaAnterior   = fechaant
           ,@dFechaProceso    = fechaproc
           ,@dFechaProxima    = fechaprox
	   FROM BacSwapSuda.dbo.SWAPGENERALHIS with(nolock)
	  WHERE fechaproc         = @Fecha_Hoy


   /*-----------------------------------------------------------------------------*/
   /* SI ES FECHA ESPECIAL                                                        */
   /*-----------------------------------------------------------------------------*/
    DECLARE @FechaProximo   DATETIME
	DECLARE @FechaHoy       DATETIME
	DECLARE @FechaFinMes    DATETIME
	DECLARE @FechaHasta     DATETIME
	DECLARE @FechaAnt       DATETIME



	SET @FechaAnt       = @dFechaAnterior
	SET @FechaHoy       = @dFechaProceso
	SET @FechaProximo   = @dFechaProxima


	SET @FechaFinMes	= LTRIM(RTRIM(YEAR(@FechaHoy)))
						+ CASE	WHEN LEN(MONTH(@FechaHoy)) = 1 THEN '0' + LTRIM(RTRIM(MONTH(@FechaHoy)))
								ELSE                                      LTRIM(RTRIM(MONTH(@FechaHoy)))
							END
						+ '01'
	SET @FechaFinMes	= DATEADD(MONTH,1,@FechaFinMes)
	SET @FechaFinMes	= DATEADD(DAY,-1,@FechaFinMes)
	SET @FechaHasta		= @FechaHoy

	IF MONTH(@FechaHoy) < MONTH(@FechaProximo)
	BEGIN
		IF @FechaFinMes <> @FechaHoy BEGIN --> Fin de Mes Especial (Fin de Día un Día NO Habil)
			SET @FechaHasta = @FechaHoy
			SET @fecha_hoy  = @FechaFinMes
		END
	END



   /*-----------------------------------------------------------------------------*/
   /* VALORES DE MONEDA SEGUN FECHAS                                              */
   /*-----------------------------------------------------------------------------*/
     DECLARE @FechaValorMoneda	DATETIME
	 DECLARE @FechaValorMonAye	DATETIME


	EXECUTE BacParamSuda..SP_FECHA_VALOR_MONEDA @Fecha_Hoy       , @FechaValorMoneda OUTPUT
	EXECUTE BacParamSuda..SP_FECHA_VALOR_MONEDA @dFechaAnterior  , @FechaValorMonAye OUTPUT



   /*-----------------------------------------------------------------------------*/
   /* VALORES DE MONEDA                                                           */
   /*-----------------------------------------------------------------------------*/      
	DECLARE @VALOR_MONEDA TABLE
		(   vmfecha      DATETIME NOT NULL DEFAULT('')
		,   vmcodigo     INTEGER  NOT NULL DEFAULT(0)
		,   vmvalor      FLOAT    NOT NULL DEFAULT(0.0))

	INSERT INTO @VALOR_MONEDA SELECT vmfecha,         vmcodigo, vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE (vmfecha = @dFechaProceso OR vmfecha = @dFechaAnterior) AND vmcodigo NOT IN(998, 13)
	INSERT INTO @VALOR_MONEDA SELECT @dFechaProceso,  vmcodigo, vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha  = @FechaValorMoneda AND vmcodigo = 998
	INSERT INTO @VALOR_MONEDA SELECT @dFechaAnterior, vmcodigo, vmvalor FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha  = @FechaValorMonAye AND vmcodigo = 998
	INSERT INTO @VALOR_MONEDA SELECT @dFechaProceso,  999,      1.0
	INSERT INTO @VALOR_MONEDA SELECT @dFechaAnterior, 999,      1.0
	INSERT INTO @VALOR_MONEDA SELECT vmfecha,         13,       vmvalor FROM @VALOR_MONEDA                 WHERE vmcodigo = 994
	


   /*-----------------------------------------------------------------------------*/
   /* TIPO DE MONEDA CONTABLE                                                     */
   /*-----------------------------------------------------------------------------*/
	INSERT INTO @VALOR_TC_CONTABLE
	SELECT	Fecha
		,   CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
		,   Tipo_Cambio
	FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE
	WHERE (Fecha         = @dFechaAnterior OR Fecha = @dFechaProceso)
    AND    Codigo_Moneda NOT IN(13,995,997,998,999)
              
	INSERT INTO @VALOR_TC_CONTABLE 
	SELECT vmfecha, vmcodigo, vmvalor FROM @VALOR_MONEDA WHERE vmcodigo IN(994,995,997,998,999)




   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE VALORES                                                           */
   /*-----------------------------------------------------------------------------*/ 
    SELECT vmfecha      
		 , vmcodigo     
		 , vmvalor      
     FROM @VALOR_TC_CONTABLE
  


END

GO
