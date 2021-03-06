USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_PRC_VAL_DURMAC]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SVC_PRC_VAL_DURMAC]
   (   @dFechaCalculo   DATETIME
   ,   @TipoCalculo     CHAR(1)
   ,   @Familia         NUMERIC(9)
   ,   @Nemo            CHAR(20)
   ,   @Nominal         NUMERIC(21,4)
   ,   @Tir             FLOAT
   ,   @QueCalcular     CHAR(1)  -- 1: Duración Macaulay
                                 -- 2: Duración Modificada
                                 -- 3: Convexidad
   ,   @Resultado       FLOAT OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Macaulay         FLOAT
   ,       @Modificada       FLOAT
   ,       @Convexidad       FLOAT
   ,       @fTir             FLOAT
   ,       @fVan             FLOAT
   ,       @iConvex          FLOAT
   ,       @sPerCup          INTEGER
   
   DECLARE @DiasReales       CHAR(1)
   ,       @FechaInicio      DATETIME
   ,       @FechaTermino     DATETIME
   ,       @iRegistros       INTEGER
   ,       @iContador        INTEGER
   ,       @Diferencia       FLOAT
   ,       @iBaseIntPap      FLOAT
   DECLARE @dFecha1          DATETIME
   ,       @dFecha2          DATETIME

   SELECT  @fTir             = (@Tir / 100)

   SELECT @Resultado         = 0.0
   SELECT @Macaulay          = 0.0
   SELECT @Modificada        = 0.0
   SELECT @Convexidad        = 0.0
   SELECT @fVan              = 0.0
   SELECT @sPerCup           = 0

   CREATE TABLE #Flujos
   (   Familia          NUMERIC(5)            NOT NULL DEFAULT(0)   
   ,   Nemo             VARCHAR(20)           NOT NULL DEFAULT('')
   ,   Cupon            NUMERIC(5)            NOT NULL DEFAULT(0)
   ,   FecVen           DATETIME              NOT NULL DEFAULT('')
   ,   FecCup           DATETIME              NOT NULL DEFAULT('')
   ,   Interes          FLOAT                 NOT NULL DEFAULT(0.0)
   ,   Amortiza         FLOAT                 NOT NULL DEFAULT(0.0)
   ,   Flujo            FLOAT                 NOT NULL DEFAULT(0.0)
   ,   Saldo            FLOAT                 NOT NULL DEFAULT(0.0)
   ,   Factor           FLOAT                 NOT NULL DEFAULT(0.0)
   ,   FechaInicio      DATETIME              NOT NULL DEFAULT('')
   ,   FechaTermino     DATETIME              NOT NULL DEFAULT('')
   ,   Tir              FLOAT                 NOT NULL DEFAULT(0.0)
   ,   Periodo          NUMERIC(9)            NOT NULL DEFAULT(0)
   ,   DiasReales       FLOAT                 NOT NULL DEFAULT(0.0)
   ,   BaseInteresPap   FLOAT                 NOT NULL DEFAULT(0.0)
   ,   PlazoAnual       FLOAT                 NOT NULL DEFAULT(0.0)
   ,   Marca            CHAR(1)               NOT NULL DEFAULT('')
   ,   PorFlujo         FLOAT                 NOT NULL DEFAULT(0.0)
   ,   PlazoSig_A       FLOAT                 NOT NULL DEFAULT(0.0)
   ,   PlazoSig_B       FLOAT                 NOT NULL DEFAULT(0.0)
   ,   Puntero          INT Identity (1, 1)   NOT NULL
   )

   INSERT INTO #Flujos
   SELECT 'Familia'             = d.Cod_familia
   ,      'Nemo'                = d.cod_nemo
   ,      'Cupon'               = d.num_cupon
   ,      'FecVen'              = d.fecha_vcto
   ,      'FecCup'              = d.fecha_vcto_cupon
   ,      'Interes'             = d.interes
   ,      'Amortiza'            = d.amortizacion
   ,      'Flujo'               = d.flujo
   ,      'Saldo'               = d.saldo
   ,      'Factor'              = d.Factor
   ,      'FechaInicio'         = @dFechaCalculo
   ,      'FechaTermino'        = d.fecha_vcto_cupon
   ,      'Tir'                 = @ftir
   ,      'Periodo'             = s.per_cupones
   ,      'DiasReales'          = CASE WHEN s.dias_reales = 'T' THEN (DATEDIFF(DAY,@dfechacalculo,d.fecha_vcto_cupon) / CONVERT(FLOAT,s.base_tasa_emi)) -- MAP 20171219 CONVERT(FLOAT,0.0)
                                       ELSE                         (DATEDIFF(DAY,@dfechacalculo,d.fecha_vcto_cupon) / CONVERT(FLOAT,s.base_tasa_emi))
                                  END
   ,      'BaseInteresPap'      = s.base_tasa_emi
   ,      'PlazoAnual'          = CONVERT(FLOAT,0.0)
   ,      'Marca'               = s.dias_reales
   ,      'PorFlujo'            = (s.per_cupones/12.0)
   ,      'PlazoSig_A'          = CONVERT(FLOAT,0.0)
   ,      'PlazoSig_B'          = CONVERT(FLOAT,0.0)
   FROM    TEXT_DSA  d          RIGHT JOIN TEXT_SER s ON s.Cod_familia = d.Cod_familia AND s.cod_nemo = d.cod_nemo
   WHERE   d.cod_familia        = @Familia
   AND     d.cod_nemo           = @Nemo
   AND     fecha_vcto_cupon    >= @dFechaCalculo

   SELECT  @DiasReales       = Marca
   ,       @iBaseIntPap      = BaseInteresPap
   FROM    #Flujos

   IF @DiasReales = 'F'
   BEGIN
      SELECT  @iRegistros  = MAX(Puntero)
      ,       @iContador   = MIN(Puntero)
      FROM    #Flujos

      WHILE @iRegistros      >= @iContador
      BEGIN
         -- Real --
         SELECT @dFecha1      = FechaInicio
         ,      @dFecha2      = FechaTermino
         ,      @Diferencia   = 0
         ,      @iBaseIntPap  = BaseInteresPap
         FROM   #Flujos
         WHERE  Puntero       = @iContador
         
         EXECUTE dbo.Svc_fmu_dif_d30 @dFecha1 , @dFecha2 , @Diferencia OUTPUT

         UPDATE  #Flujos 
         SET     DiasReales =  @Diferencia
         ,       PlazoAnual =  @Diferencia / @iBaseIntPap
         WHERE   Puntero    =  @iContador
         -- Real --

         -- Real + 1 --
         IF (@iContador + 1) <= @iRegistros
         BEGIN
            SELECT @dFecha1      = FechaInicio
            ,      @dFecha2      = FechaTermino
            ,      @Diferencia   = 0
            ,      @iBaseIntPap  = BaseInteresPap
            FROM   #Flujos
            WHERE  Puntero       = (@iContador + 1)
         END ELSE
         BEGIN
            SELECT @dFecha1      = FechaInicio
            ,      @dFecha2      = FechaTermino
            ,      @Diferencia   = 0
            ,      @iBaseIntPap  = BaseInteresPap
            FROM   #Flujos
            WHERE  Puntero       = @iContador
         END
         EXECUTE dbo.Svc_fmu_dif_d30 @dFecha1 , @dFecha2 , @Diferencia OUTPUT

         UPDATE  #Flujos 
         SET     PlazoSig_A =  CASE WHEN (@iContador + 1) <= @iRegistros THEN @Diferencia / @iBaseIntPap
                                    ELSE                                     (@Diferencia / @iBaseIntPap) + PorFlujo
                               END
         WHERE   Puntero    =  @iContador
         -- Real + 1 --


         -- Real + 2 --
         IF (@iContador + 2) <= @iRegistros
         BEGIN
            SELECT @dFecha1      = FechaInicio
            ,      @dFecha2      = FechaTermino
            ,      @Diferencia   = 0
            ,      @iBaseIntPap  = BaseInteresPap
            FROM   #Flujos
            WHERE  Puntero       = (@iContador + 2)
         END ELSE
         BEGIN
            SELECT @dFecha1      = FechaInicio
            ,      @dFecha2      = FechaTermino
            ,      @Diferencia   = 0
            ,      @iBaseIntPap  = BaseInteresPap
            FROM   #Flujos
            WHERE  Puntero       = @iContador
         END
         EXECUTE dbo.Svc_fmu_dif_d30 @dFecha1 , @dFecha2 , @Diferencia OUTPUT

         UPDATE  #Flujos 
         SET     PlazoSig_B =  CASE WHEN (@iContador + 2) <= @iRegistros THEN @Diferencia / @iBaseIntPap
                                    ELSE                                     (@Diferencia / @iBaseIntPap) + (PorFlujo * 2)
                               END
         WHERE   Puntero    =  @iContador
         -- Real + 2 --

         SELECT  @iContador = @iContador + 1
      END
   END	
   -- MAP 20171219 
   ELSE
  BEGIN
      SELECT  @iRegistros  = MAX(Puntero)
      ,       @iContador   = MIN(Puntero)
      FROM    #Flujos
   
      WHILE @iRegistros      >= @iContador
      BEGIN
         -- Real --
         SELECT @dFecha1      = FechaInicio
         ,      @dFecha2      = FechaTermino
         ,      @Diferencia   = 0
         ,      @iBaseIntPap  = BaseInteresPap
         FROM   #Flujos
         WHERE  Puntero       = @iContador
         
         -- EXECUTE dbo.Svc_fmu_dif_d30 @dFecha1 , @dFecha2 , @Diferencia MAP 20171219
		 Select @Diferencia = datediff( dd, @dFecha1 , @dFecha2 )


         UPDATE  #Flujos 
         SET     DiasReales =  @Diferencia
         ,       PlazoAnual =  @Diferencia / @iBaseIntPap
         WHERE   Puntero    =  @iContador
         -- Real --

         -- Real + 1 --
         IF (@iContador + 1) <= @iRegistros
         BEGIN
            SELECT @dFecha1      = FechaInicio
            ,      @dFecha2      = FechaTermino
            ,      @Diferencia   = 0
            ,      @iBaseIntPap  = BaseInteresPap
            FROM   #Flujos
            WHERE  Puntero       = (@iContador + 1)
         END ELSE
         BEGIN
            SELECT @dFecha1      = FechaInicio
            ,      @dFecha2      = FechaTermino
            ,      @Diferencia   = 0
            ,      @iBaseIntPap  = BaseInteresPap
            FROM   #Flujos
            WHERE  Puntero       = @iContador
         END

         -- EXECUTE dbo.Svc_fmu_dif_d30 @dFecha1 , @dFecha2 , @Diferencia OUTPUT MAP 20171219
		 Select @Diferencia = datediff( dd, @dFecha1 , @dFecha2 )

         UPDATE  #Flujos 
         SET     PlazoSig_A =  CASE WHEN (@iContador + 1) <= @iRegistros THEN @Diferencia / @iBaseIntPap
                                    ELSE                                     (@Diferencia / @iBaseIntPap) + PorFlujo
                               END
         WHERE   Puntero    =  @iContador
         -- Real + 1 --


         -- Real + 2 --
         IF (@iContador + 2) <= @iRegistros
         BEGIN
            SELECT @dFecha1      = FechaInicio
            ,      @dFecha2      = FechaTermino
            ,      @Diferencia   = 0
            ,      @iBaseIntPap  = BaseInteresPap
            FROM   #Flujos
            WHERE  Puntero       = (@iContador + 2)
         END ELSE
         BEGIN
            SELECT @dFecha1      = FechaInicio
            ,      @dFecha2      = FechaTermino
            ,      @Diferencia   = 0
            ,      @iBaseIntPap  = BaseInteresPap
            FROM   #Flujos
            WHERE  Puntero       = @iContador
         END
         
		 -- EXECUTE dbo.Svc_fmu_dif_d30 @dFecha1 , @dFecha2 , @Diferencia OUTPUT MAP 20171219
		 Select @Diferencia = datediff( dd, @dFecha1 , @dFecha2 )


         UPDATE  #Flujos 
         SET     PlazoSig_B =  CASE WHEN (@iContador + 2) <= @iRegistros THEN @Diferencia / @iBaseIntPap
                                    ELSE                                     (@Diferencia / @iBaseIntPap) + (PorFlujo * 2)
                               END
         WHERE   Puntero    =  @iContador
         -- Real + 2 --

         SELECT  @iContador = @iContador + 1
      END 
   END  	
   -- MAP 20171219
   
   --   Svc_Prc_val_ins '20050523', 'P', 2, 2000, 'BRASIL07', '20070726', 8.664, 11.25, 11.25, 0, 360, 0, 100, 108.66, 0, 0, 105.00091, 0, '20050523', '20000726', '20070726', '18991230', '18991230', '20050523', 0, 0, 0, 0, '18991230', 0, 0, 0, 'S', 13, 0, 0, 0

   SELECT  @Macaulay       = SUM((PlazoAnual * Flujo)                                         / POWER((convert(float,1) + @ftir) , PlazoAnual)) / SUM((Flujo) / POWER((convert(float,1) + @ftir) , PlazoAnual))
   ,       @fVan           = SUM((Flujo )                                                     / POWER((convert(float,1) + (@Tir / convert(float,100))) , PlazoAnual))
   ,       @Convexidad     = SUM(((PlazoAnual) * ((PlazoAnual) + convert(float,1)) * (Flujo)) / POWER((convert(float,1) + @fTir), ((PlazoAnual)+convert(float,2)))) / SUM(((Flujo)) / POWER((convert(float,1) + @fTir),PlazoAnual))
   ,       @sPerCup        = (MAX(Periodo))
   FROM    #Flujos

   SELECT  @Convexidad     = ( SUM((PlazoSig_A * PlazoAnual * Flujo) / POWER( (1.0 + Tir) , PlazoSig_B)) 
                             / SUM( (Flujo / POWER( (1.0 + Tir),PlazoAnual ))) 
                             )
   --                        /  100.0 
   FROM    #Flujos
   
   IF @sPerCup = 99
   BEGIN
      SELECT @sPerCup = (1.0)
   END ELSE
   BEGIN
      SELECT @sPerCup = (12.0 / (@sPerCup*1.0))
   END

   SELECT @Modificada    = @Macaulay / (convert(float,1) + (@fTir / @sPerCup) )

   IF @QueCalcular = 1
   BEGIN
      SELECT @Resultado  = @Macaulay   -- CONVERT(NUMERIC(21,7),ROUND(@Macaulay,7))   -- @Macaulay
   END
   IF @QueCalcular = 2
   BEGIN
      SELECT @Resultado  = @Modificada -- CONVERT(NUMERIC(21,7),ROUND(@Modificada,7)) -- @Modificada
   END
   IF @QueCalcular = 3
   BEGIN
      SELECT @Resultado  = @Convexidad -- CONVERT(NUMERIC(21,7),ROUND(@Convexidad,7)) -- @Convexidad
   END

END
GO
