USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULA_DV01_DEV]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CALCULA_DV01_DEV]( @Fecha_Valoriza         DATETIME, --fecha hoy            --@Fecha_Inicio_Contrato
                                      @Fecha_Vcto_Papel       DATETIME,
                                      @papel                  CHAR(20),
                                      @Nominal                NUMERIC(20,6),
                                      @Tir                    NUMERIC(18,6),
                                      @DV01                   FLOAT = 0.0 Output )            


AS

BEGIN


DECLARE @Valor_Presente1               FLOAT
DECLARE @Valor_Presente2               FLOAT
DECLARE @Resultado                     FLOAT




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



         --- para obtener Duration
    SET NOCOUNT ON

    INSERT INTO #temporal1	

    EXECUTE dbo.SP_VALORIZA_INSTRUMENTOS_INV_EXT   @papel,                      -- Papel a valorizar
                                                   @Fecha_Vcto_Papel,           -- Fecha Vcto papel 
                                                   @Fecha_Valoriza,             -- Fecha a la cual se quiere valorizar 
                                                   @Nominal,                    -- valor a valorizar
                                                   @Tir,                        -- tasa
                                                   0,
                                                   0,
                                                   2
    SELECT @Valor_Presente1 =MT 
    FROM   #temporal1           

    Delete from #temporal1

    Set @Tir = @Tir +0.01

    INSERT INTO #temporal1	
    EXECUTE dbo.SP_VALORIZA_INSTRUMENTOS_INV_EXT   @papel,                      -- Papel a valorizar
                                                   @Fecha_Vcto_Papel,           -- Fecha Vcto papel 
                                                   @Fecha_Valoriza,             -- Fecha a la cual se quiere valorizar 
                                                   @Nominal,                    -- valor a valorizar
                                                   @Tir,                        -- tasa
                                                   0,
                                                   0,
                                                   2
    SELECT @Valor_Presente2 =MT 
    FROM   #temporal1     

--    SET  @Resultado = Round(abs(@Valor_presente2 - @Valor_presente1)*100.0,7)
    SET  @Resultado = Round(abs(@Valor_presente2 - @Valor_presente1),7)


    select  @DV01 = round( @Resultado , 7 )

    SET NOCOUNT OFF

  

END

GO
