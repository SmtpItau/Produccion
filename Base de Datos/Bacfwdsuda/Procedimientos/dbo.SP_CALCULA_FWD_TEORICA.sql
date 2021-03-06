USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULA_FWD_TEORICA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CALCULA_FWD_TEORICA]( @Fecha_Inicio_Contrato        DATETIME,
                                             @Fecha_Vencimiento_Contrato   DATETIME,
                                             @Fecha_Vcto_Papel             DATETIME,
                                             @papel                        CHAR(20),
                                             @Nominal                      NUMERIC(20,6),
                                             @Tasa_spot                    NUMERIC(18,6),
                                             @Tasa_Contrato                NUMERIC(18,6), 
                                             @moneda_contrato              INT,  
											 @Tasa_Fw_Teorica              FLOAT =  0.0  OUTPUT  ) 


AS

BEGIN


DECLARE @Duration                      FLOAT
DECLARE @Tasa_mercado_plazo_contrato   FLOAT
DECLARE @Plazo_en_dias                 FLOAT
DECLARE @Plazo_en_anos                 FLOAT
--DECLARE @Tasa_Fw_Teorica               FLOAT
DECLARE @Tabla_Ejecuta_Valorizador     CHAR(50)

SET @Plazo_en_dias   = DATEDIFF(dd, @Fecha_Inicio_Contrato,@Fecha_Vencimiento_Contrato) 

SET @Plazo_en_anos   = (DATEDIFF(dd, @Fecha_Inicio_Contrato,@Fecha_Vencimiento_Contrato) /360.0)

CREATE TABLE #Temporal1(TR            FLOAT       --      5.3
                       ,TE            FLOAT       --      3.625
                       ,TV            FLOAT   --      3.625
                       ,TT            FLOAT   --      0
                       ,BA            FLOAT   --      365
                       ,BF            FLOAT   --      0
                       ,NOM           FLOAT   --      10000000
                       ,MT            FLOAT   --      9059857.878
                       ,VV            FLOAT   --      181250
                       ,VP            FLOAT   --      0
                       ,PVP           FLOAT   --      89.515019
                       ,VAN           FLOAT   --      23.75688913
                       ,FP            DATETIME        --      00:00.0
                       ,FE            DATETIME        --      00:00.0
                       ,FV            DATETIME        --      15/05/2013
                       ,FU            DATETIME        --      00:00.0
                       ,FX            DATETIME        --      00:00.0
                       ,FC            DATETIME        --      00:00.0
                       ,CI            FLOAT   --      5
                       ,CT            FLOAT   --      20
                       ,INDEV         FLOAT   --      108355.9783
                       ,PRINC         FLOAT   --      8951501.9
                       ,FIP           DATETIME        --      15/05/2005
                       ,CAP           FLOAT   --      0
                       ,INCTR         FLOAT   --      0
                       ,SPREAD        FLOAT   --      0
                       ,TD_SUMINT     FLOAT   --      36.25
                       ,TD_SUMAMO     FLOAT   --      100
                       ,TD_SUMFLU     FLOAT   --      136.25
                       ,TD_SUMSAL     FLOAT   --      1900
                       ,TD_SUMFDE     FLOAT   --      23.75688913
                       ,PX_IN         FLOAT   --      181250
                       ,PX_AM         FLOAT   --      0
                       ,V001          FLOAT   --      1.0265
                       ,V002          FLOAT   --      74
                       ,V003          FLOAT   --      184
                       ,V004          FLOAT   --      15.40217391
                       ,V005          FLOAT   --      1.083559783
                       ,V006          FLOAT   --      8951501.9
                       ,V007          FLOAT   --      0
                       ,V008          FLOAT   --      184
                       ,V009          FLOAT   --      110
                       ,V0010         FLOAT   --      0
                       ,FACTOR        FLOAT   --      1
                       ,DUR_MAC       FLOAT   --      6.561844817
        ,DUR_MOD       FLOAT   --      6.392445024
                       ,CONVEXI       FLOAT)  --      48.15489175


    CREATE TABLE #temporal2
         (Tasa         FLOAT ,
          Spreed       FLOAT ,
          SpotCompra   FLOAT ,
          SpotVenta    FLOAT )


    --- para obtener Duration
    SET NOCOUNT ON

    INSERT INTO #temporal1	
    EXECUTE dbo.SP_VALORIZA_INSTRUMENTOS_INV_EXT   @papel,                      -- Papel a valorizar
                                                   @Fecha_Vcto_Papel,           -- Fecha Vcto papel 
                                                   @Fecha_Vencimiento_Contrato, -- Fecha a la cual se quiere valorizar 
                                                   @Nominal,                    -- valor a valorizar
                                                   @Tasa_spot,                  -- tasa
                                                   0,
                                                   0,
                                                   2
    SELECT @Duration =DUR_MAC FROM #temporal1           


	-- Obtener la tasa mercado plazo remanente contrato ( 
    INSERT INTO #temporal2
    EXECUTE SP_RETORNATASAMONEDA @Moneda_Contrato, @Plazo_en_dias , 'BFW' , '11'

    SELECT @Tasa_Mercado_Plazo_contrato = Tasa
      FROM #temporal2






-- calculos

--      SET @Tasa_Fw_Teorica = @tasa_Spot/100.0 + ( @tasa_Spot/100.0 + @tasa_mercado_plazo_contrato/100.0 )/ (@tasa_mercado_plazo_contrato+@Plazo_en_anos)*@Plazo_en_anos)*100.0
	SET @Tasa_Fw_Teorica = @tasa_Spot + ( @tasa_Spot - @tasa_mercado_plazo_contrato ) / ( @Duration + @Plazo_en_anos ) * @Plazo_en_anos


-- Igual dejar el select para no afectar las llamadas desde los ejecutables
-- En todo caso verificar si no exige el parámetro  
      SELECT   @Tasa_Fw_Teorica  As p1, 
               @Duration         As p2,
               @tasa_mercado_plazo_contrato As p3,
               @Plazo_en_dias                As P4,
               @Plazo_en_anos                 As p5
               
      SET NOCOUNT OFF
END



GO
