USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_C08_TLOCK]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_C08_TLOCK]
       (
         @NumeroOperacion       NUMERIC(9)
       , @iEjecucionIniDia      INT
       , @dFechaProceso         CHAR(08) = '19000101'
       , @dFechaAnterior        CHAR(08) = '19000101'
       , @dFechaPrxProceso      CHAR(08) = '19000101'
       )
WITH RECOMPILE
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Tipo_Operacion               CHAR(1)  
   ,       @Tasa_Spot                    FLOAT
   ,       @Instrumento                  CHAR(20)  
   ,       @Fecha_Inicio_Contrato        DATETIME
   ,       @Fecha_Vcto_Contrato          DATETIME
   ,       @Fecha_Vcto_Papel             DATETIME
   ,       @Familia                      NUMERIC(5)
   ,       @Tasa_FDW_Teorica             FLOAT
   ,       @Tasa_Lock                    FLOAT    
   ,       @Dv01                         FLOAT
   ,       @CaValordia                   FLOAT
   ,       @C08ValorTasaLock             FLOAT
   ,       @C08ValorTasaFwdTeorica       FLOAT
   ,       @C08ValorTasaBenchMarck       FLOAT
   ,       @ValorPresenteTasaFwdTeorica  FLOAT
   ,       @Nominal                      FLOAT
   ,       @moneda                       INT
   ,       @Fecha_Rescata_Bench_Mark     DATETIME
   ,       @USD_Hoy                      FLOAT
   ,       @Tasa_BenchMarck              FLOAT
   ,       @DifTasas                     FLOAT
   ,       @Plazo_en_dias                INT
   ,       @Tipo_Producto                CHAR(5)
   ,       @TasaCurva			 FLOAT
   ,       @Valor_Futuro                 FLOAT

   -- Tabla para ejecutar el valorizador
   CREATE TABLE #Temporal1
   (   TR            FLOAT           --      5.3
   ,   TE            FLOAT           --      3.625
   ,   TV            FLOAT           --      3.625
   ,   TT            FLOAT           --      0
   ,   BA            FLOAT           --      365
   ,   BF            FLOAT           --      0
   ,   NOM           FLOAT           --      10000000
   ,   MT            FLOAT           --      9059857.878
   ,   VV            FLOAT           --      181250
   ,   VP            FLOAT           --      0
   ,   PVP           FLOAT           --      89.515019
   ,   VAN           FLOAT           --      23.75688913
   ,   FP            DATETIME        --      00:00.0
   ,   FE            DATETIME        --      00:00.0
   ,   FV            DATETIME        --      15/05/2013
   ,   FU            DATETIME        --      00:00.0
   ,   FX            DATETIME        --      00:00.0
   ,   FC            DATETIME        --      00:00.0
   ,   CI            FLOAT           --      5
   ,   CT            FLOAT           --      20
   ,   INDEV         FLOAT           --      108355.9783
   ,   PRINC         FLOAT           --      8951501.9
   ,   FIP           DATETIME        --      15/05/2005
   ,   CAP           FLOAT           --      0
   ,   INCTR         FLOAT           --      0
   ,   SPREAD        FLOAT           --      0
   ,   TD_SUMINT     FLOAT           --      36.25
   ,   TD_SUMAMO     FLOAT           --      100
   ,   TD_SUMFLU     FLOAT           --      136.25
   ,   TD_SUMSAL     FLOAT           --      1900
   ,   TD_SUMFDE     FLOAT           --      23.75688913
   ,   PX_IN         FLOAT           --      181250
   ,   PX_AM         FLOAT           --      0
   ,   V001          FLOAT           --      1.0265
   ,   V002          FLOAT           --      74
   ,   V003          FLOAT           --      184
   ,   V004          FLOAT           --      15.40217391
   ,   V005          FLOAT           --      1.083559783
   ,   V006          FLOAT           --      8951501.9
   ,   V007          FLOAT           --      0
   ,   V008          FLOAT           --      184
   ,   V009          FLOAT           --      110
   ,   V0010         FLOAT           --      0
   ,   FACTOR        FLOAT           --      1
   ,   DUR_MAC       FLOAT           --      6.561844817
   ,   DUR_MOD       FLOAT           --      6.392445024
   ,   CONVEXI       FLOAT)          --      48.15489175

	CREATE TABLE #temporal2_Curva
         (Tasa         FLOAT ,
          Spreed       FLOAT ,
          SpotCompra   FLOAT ,
          SpotVenta    FLOAT )

    IF @dFechaPrxProceso = '19000101' BEGIN
       SELECT   @dFechaProceso  = CONVERT(CHAR(8),acfecproc,112)
        ,	@dFechaAnterior = CONVERT(CHAR(8),acfecante,112)
        FROM    MFAC

        SELECT  @Fecha_Rescata_Bench_Mark = @dFechaProceso

        IF @iEjecucionIniDia = 1  -- Devengo ejecutado al inicio del día
            SELECT @Fecha_Rescata_Bench_Mark = @dFechaAnterior

           /* Obtiene datos de la operacion  */
        SELECT    @Instrumento            = caserie
        , @Fecha_Inicio_Contrato  = cafecha
        , @Fecha_Vcto_Contrato    = cafecvcto
        , @Tipo_Operacion         = catipoper
        , @Nominal                = camtomon1
        , @moneda                 = cacodmon1
        , @Tasa_Lock              = CaTipCam
        , @Tipo_Operacion         = CaTipOper
	, @Tipo_Producto	  = cacodpos1
        FROM    MFCA 
        WHERE    canumoper               = @NumeroOperacion
    END
    ELSE BEGIN
        SELECT    @Instrumento            = caserie
        , @Fecha_Inicio_Contrato  = cafecha
        , @Fecha_Vcto_Contrato    = cafecvcto
        , @Tipo_Operacion         = catipoper
        , @Nominal                = camtomon1
        , @moneda                 = cacodmon1
        , @Tasa_Lock              = CaTipCam
        , @Tipo_Operacion         = CaTipOper
	, @Tipo_Producto	  = cacodpos1
        FROM    MFCARES
        WHERE    CaFechaProceso        = @dFechaProceso
        AND    canumoper               = @NumeroOperacion
    END        

   /* Obtiene la fecha de vencimiento del papel */ 
   SELECT @Fecha_Vcto_Papel = Fecha_Vcto 
   ,   @Familia          = Cod_Familia
   FROM   INSTRUMENTOS_SUBYACENTES_INV_EXT
   WHERE  Cod_Nemo          = @Instrumento

   /* Capturar la tasa spot de la tabla BENCH_MARCK_INVEX */
   SELECT @Tasa_BenchMarck	= Tasa
   FROM   BENCH_MARCK_INVEX 
   WHERE  Instrumento	= @Instrumento 
   AND    Fecha		= @Fecha_Rescata_Bench_Mark



   /*2 */----------------------------------------------------------------------------------------------------------------
   SET @Plazo_en_dias   = DATEDIFF(dd, @dFechaProceso,@Fecha_Vcto_Contrato) 

   INSERT INTO #temporal2_Curva
   EXECUTE SP_RetornaTasaMoneda	@moneda
			,	@Plazo_en_dias
			,	'BFW' 
			,	@Tipo_Producto
			,	-1
			,	-1
			,	0
			,	@Tipo_Operacion

   SELECT @TasaCurva	= tasa
   FROM   #temporal2_Curva

   SELECT @moneda
			,	@Plazo_en_dias
			,	'BFW' 
			,	@Tipo_Producto
			,	-1
			,	-1
			,	0
			,	@Tipo_Operacion

/*   EXECUTE dbo.SP_CALCULA_FWD_TEORICA_DEV	@dFechaProceso 
					,	@Fecha_Vcto_Contrato 
					,	@Fecha_Vcto_Papel 
					,	@instrumento 
					,	@Nominal 
					,	@Tasa_BenchMarck	-- @Tasa_Spot 
					,	0 
					,	@moneda 
					,	@Tasa_FDW_Teorica    OUTPUT
					,	@dFechaProceso		-- SE ENVIA SOLO SI SE ESTA CALCULANDO RESULTADO BACK TEST
					,	@dFechaPrxProceso	-- SE ENVIA SOLO SI SE ESTA CALCULANDO RESULTADO BACK TEST

*/

   /*3 Calcular   el DV01 */----------------------------------------------------------------------------------------------
   
--   SELECT  @DifTasas = CASE WHEN @Tipo_Operacion = 'C' THEN @Tasa_Lock - @Tasa_FDW_Teorica ELSE - ( @Tasa_Lock - @Tasa_FDW_Teorica) END

   /* Razonamiento:
      Pensar en que se quiere utilidad para Compra:
      ValorPteContrato < ValorPteMercado
      => TasaContrato  > TasaMercado
      => @Tasa_Lock - @Tasa_FDW_Teorica > 0 para tener utilidad
   */

--   SELECT @CaValordia = @dv01 * (@DifTasas) * @Nominal / 100.0 --> Revisar la división

   DELETE #temporal1    
   ------------------------------------------------ VALORIZACION PRESENTE A TASA BENCHMARCK -----------------------------------------------------------

   INSERT INTO #temporal1    
   EXECUTE dbo.SP_VALORIZA_INSTRUMENTOS_INV_EXT  @Instrumento , @Fecha_Vcto_Papel , @dFechaProceso , @Nominal , @Tasa_BenchMarck , 0 , 0 , 2

   SELECT @C08ValorTasaBenchMarck = MT 
   FROM   #Temporal1

   DELETE #temporal1
   ---------------------------------------------- VALOR FUTURO ----------------------------------------------------------------------------------

   SELECT @Valor_Futuro	= ROUND(@C08ValorTasaBenchMarck * POWER(( 1.0 + (@Tasa_BenchMarck / 100.0) - (@TasaCurva / 100.0)) , ( @Plazo_en_dias / 360.0 )),4)

	SELECT ( 1.0 + (@Tasa_BenchMarck / 100.0) - (@TasaCurva / 100.0))

   ------------------------------------------------ VALORIZACION FUTURA EN MODALIDAD 3 ----------------------------------------------------------
   INSERT INTO #temporal1    
   EXECUTE dbo.SP_VALORIZA_INSTRUMENTOS_INV_EXT  @Instrumento , @Fecha_Vcto_Papel , @Fecha_Vcto_Contrato , @Nominal , 0 , 0 , 0 , 3, 0, @Valor_Futuro

   SELECT   @Tasa_FDW_Teorica		= TR
   ,        @C08ValorTasaFwdTeorica	= MT 
   FROM     #Temporal1




--   SELECT @C08ValorTasaFwdTeorica = MT 
--   FROM   #Temporal1

   DELETE #temporal1    

   --------------------------------------------------- VALORIZACION CON TASA DE OPERACION AL VCTO ----------------------------------------------------------

   INSERT INTO #temporal1   
   EXECUTE dbo.SP_VALORIZA_INSTRUMENTOS_INV_EXT  @Instrumento , @Fecha_Vcto_Papel , @Fecha_Vcto_Contrato , @Nominal , @Tasa_Lock , 0 , 0 , 2

   SELECT @C08ValorTasaLock = MT
   FROM   #Temporal1

   DELETE #temporal1    

   ----------------------------------------------------------------------------------------------------------------------------------------------

--   EXECUTE dbo.SP_CALCULA_DV01_DEV @dFechaProceso , @Fecha_Vcto_Papel , @instrumento , 100.0 , @Tasa_FDW_Teorica , @dv01 OUTPUT
   EXECUTE dbo.SP_CALCULA_DV01_DEV @Fecha_Vcto_Contrato , @Fecha_Vcto_Papel , @instrumento , @Nominal , @Tasa_Lock , @dv01 OUTPUT


   -- VALOR RAZONABLE EN UNIDAD MONETARIA
   IF @Tipo_Operacion = 'C' BEGIN 
         SELECT @CaValordia = (( (@Tasa_FDW_Teorica / 100.0) - (@Tasa_Lock / 100.0)) * @dv01  * 100.0 ) / ( 1.0 + (@TasaCurva / 100.0) * (@Plazo_en_dias / 360.0))
   END
   ELSE IF @Tipo_Operacion = 'V' BEGIN 
         SELECT @CaValordia = (( (@Tasa_Lock / 100.0) - (@Tasa_FDW_Teorica / 100.0)) * @dv01  * 100.0 ) / ( 1.0 + (@TasaCurva / 100.0) * (@Plazo_en_dias / 360.0))
   END

--   SELECT @ValorPresenteTasaFwdTeorica = @C08ValorTasaBenchMarck + @CaValorDia 

   SELECT   @USD_Hoy      = Tipo_Cambio
   FROM     BacParamSuda..VALOR_MONEDA_CONTABLE 
   ,        MFAC
   WHERE    Codigo_Moneda = 994 
   AND      Fecha         = CASE    WHEN @dFechaPrxProceso <> '19000101' THEN @dFechaProceso
                                     ELSE CASE WHEN @iEjecucionIniDia = 1 THEN acfecante 
                                               ELSE acfecproc END END --@dFechaProceso
/*
SELECT	'@NumeroOperacion'		= @NumeroOperacion
,	'@Tasa_Contrato'		= @Tasa_Lock
,	'@Tasa_BenchMarck'		= @Tasa_BenchMarck
,	'@TasaLiborUSD'			= @TasaCurva
,	'@Tasa_FDW_Teorica'		= @Tasa_FDW_Teorica
,	'@Valor_Futuro'			= @Valor_Futuro
,	'@C08ValorTasaFwdTeorica'	= @C08ValorTasaFwdTeorica
,	'@ValorPresenteTasaFwdTeorica'	= @ValorPresenteTasaFwdTeorica
,	'@C08ValorTasaContrato'		= @C08ValorTasaLock
,	'@C08ValorTasaBenchMarck'	= @C08ValorTasaBenchMarck
,	'@CaValordia'			= @CaValordia
,	'FRES_OBTENIDO'			= ROUND(@CaValordia * @USD_Hoy,0)
,	'@dv01'				= @dv01
*/

   IF @dFechaPrxProceso = '19000101' BEGIN -- PROCESO NORMAL DE DEVENGAMIENTO
         UPDATE   MFCA 
         SET      catasa_efectiva_moneda1 = @Tasa_FDW_Teorica
         ,        catasacon               = @dv01 
         ,        cavalordia              = @CaValordia
         ,        fres_obtenido           = ROUND(@CaValordia * @USD_Hoy,0) 
         ,        mtm_hoy_moneda1         = ROUND(CASE WHEN @Tipo_Operacion = 'C' THEN @C08ValorTasaFwdTeorica      ELSE @C08ValorTasaLock            END * @USD_Hoy,0)
         ,        mtm_hoy_moneda2         = ROUND(CASE WHEN @Tipo_Operacion = 'C' THEN @C08ValorTasaLock            ELSE @C08ValorTasaFwdTeorica      END * @USD_Hoy,0)
         ,        catasasinteticam1       = @Tasa_BenchMarck	--@Tasa_Spot
         ,        valorrazonableactivo    = ROUND(CASE WHEN @Tipo_Operacion = 'C' THEN @ValorPresenteTasaFwdTeorica ELSE @C08ValorTasaBenchMarck       END * @USD_Hoy,0)
         ,        valorrazonablepasivo    = ROUND(CASE WHEN @Tipo_Operacion = 'C' THEN @C08ValorTasaBenchMarck       ELSE @ValorPresenteTasaFwdTeorica END * @USD_Hoy,0)
         WHERE    canumoper               = @NumeroOperacion
   END
   ELSE BEGIN -- PROCESO DE CALCULO BACK TEST
         UPDATE    MFCARES
         SET       fres_obtenidoParPrx   = ROUND(@CaValordia * @USD_Hoy,0) 
         WHERE     CaFechaProceso        = @dFechaProceso
         AND       canumoper             = @NumeroOperacion
   END
END

GO
