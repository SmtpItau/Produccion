USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GENERA_SET_PRECIOS]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_GENERA_SET_PRECIOS]
AS  
BEGIN  
  
/****************************************************************************************************/  
/****************************************************************************************************/  
/* SETEO PARA PODER COMPILAR EL PROCEDIMIENTO ALMACENADO                                            */  
/****************************************************************************************************/  
/****************************************************************************************************/  
   SET NOCOUNT ON  
  
  
/****************************************************************************************************/  
/****************************************************************************************************/  
/* NOTA: EL PROCEDIMIENTO NO REQUIERE PARAMETROS.                                                   */  
/****************************************************************************************************/  
/****************************************************************************************************/  
/****************************************************************************************************/  
/*      Procedimiento almacenado que actualiza el set de precios para las opciones CALL y PUT en el */  
/* servidor "CORPSQL03" base de datos "OptionSimulator".                                            */  
/*                                                                                                  */  
/****************************************************************************************************/  
/* SPREAD                                                                                           */  
/* ======                                                                                           */  
/*      Lee la tabla "SpreadDefault" que se encuentra en el servidor CORPSQL03, la cual tiene los   */  
/* Spread que se deben aplicar al dolar contable, curvas y smile.                                   */  
/****************************************************************************************************/  
/* FECHAS                                                                                           */  
/* ======                                                                                           */  
/*      Recupera la fecha de proceso anterior, actual y proxima de BACTRADERSUDA.                   */  
/****************************************************************************************************/  
/* Dolar Contable                                                                                   */  
/* ==============                                                                                   */  
/*      Toma el dolar observado del servidor SPROD01 y le suma un spread 0.01 al set de precios     */  
/* call, le resta el spread * 0.01 al set de precios put.                                           */  
/*                                                                                                  */  
/* Curvas                                                                                           */  
/* ======                                                                                           */  
/*      Obtiene las curvas 'CURVASWAPCLP' y 'CURVASWAPUSDLOCAL' y las graba mas menos un spread     */  
/* en el set de precios repectivo.                                                                  */  
/*                                                                                                  */  
/* NOTA: Actualmente no se esta considerando el sumarle un spread a las curvas por el campo de      */  
/*       Curvas esta en 0.                                                                          */  
/*                                                                                                  */  
/* Smile                              */  
/* =====                                                                        */  
/*      Obtiene el smile de volatilidad y lo graba mas menos un spread en el set de precios         */  
/* repectivo.                                                                                       */  
/*                                                                                                  */  
/* Feriado                                                                                          */  
/* =======                                                                                          */  
/*      Elimina y vuelve a insertar el calendario de feriados.                                      */  
/*                                                                                                  */  
/****************************************************************************************************/  
  
    /************************************************************************************************/  
    /* Definición de variables del procedimiento                                                    */  
    /************************************************************************************************/  
    DECLARE @spreadspot        FLOAT  
    DECLARE @spreadyield       FLOAT  
    DECLARE @spreadsmile       FLOAT  
    DECLARE @Spot              FLOAT  
    DECLARE @FechaAnterior     DATETIME  
    DECLARE @FechaProceso      DATETIME  
    DECLARE @ProximaFecha      DATETIME  
    DECLARE @SaveDate          DATETIME  
    DECLARE @SaveDateBucle     DATETIME  
    DECLARE @ID                FLOAT  
    DECLARE @CountSpot         INT  
    DECLARE @CountYield        INT  
    DECLARE @CountSmile        INT  
  
    /************************************************************************************************/  
    /* Obtiene la fecha de proceso anterior, actual y proxima de la base de datos BACTRADERSUDA     */  
    /************************************************************************************************/  
    SELECT @FechaAnterior = acfecante  
         , @FechaProceso  = acfecproc  
         , @ProximaFecha  = acfecprox  
         , @SaveDate      = acfecproc  
      FROM BacTraderSuda.dbo.MDAC  
  
    /************************************************************************************************/  
    /* Obtiene los spread que se aplican al Dolar Contable, Curvas y Smile                          */  
    /************************************************************************************************/  
    SELECT @spreadspot  = spreadspot  
         , @spreadyield = spreadyield  
         , @spreadsmile = spreadsmile  
      FROM LNKOPTSIM.OptionSimulator.dbo.SpreadDefault  
  
    /************************************************************************************************/  
    /* Obtiene el dolar contable para la fecha de proceso.                                          */  
    /************************************************************************************************/  
    SELECT @CountSpot    = COUNT(*)  
      FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE  
     WHERE Fecha         = @FechaProceso  
       AND Codigo_Moneda = 994  
  
    /************************************************************************************************/  
    /* Obtiene las curvas para la fecha de proceso.                                                 */  
    /************************************************************************************************/  
    SELECT @CountYield      = COUNT(*)  
      FROM BacParamSuda.dbo.CURVAS   
     WHERE FechaGeneracion  = @FechaProceso  
       AND CodigoCurva     in ( 'CurvaSwapCLP', 'CurvaSwapUSDLocal' )  
       AND Tipo             = 'TIR'  
  
    /************************************************************************************************/  
    /* Obtiene las curvas para la fecha de proceso.    */  
    /************************************************************************************************/  
    SELECT @CountSmile = COUNT(*)  
      FROM LnkOpc.CbMdbOpc.dbo.Smile  
     WHERE SmlFecha    = @FechaProceso  
  
    /************************************************************************************************/  
    /* Valida que exista el spot, curvas o smile para el día de hoy.                                */  
    /************************************************************************************************/  
    IF @CountSpot = 0 OR @CountYield = 0 OR @CountSmile = 0  
    BEGIN  
        /********************************************************************************************/  
        /* Se asigna la fecha anterior de proceso, en el caso de que no exista los datos            */  
        /* (Esto debiera ser temporal, debido a que en un proceso normal nunca debiera pasar esto)  */  
        /********************************************************************************************/  
        SET @FechaProceso = @FechaAnterior  
    END  
  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*                         ACTUALIZACIÓN DEL SPOT                                               */  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
  
    /************************************************************************************************/  
    /* Obtiene el dolar contable para la fecha de anterior.                                         */  
    /************************************************************************************************/  
    SELECT @Spot = Tipo_Cambio  
      FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE  
     WHERE Fecha         = @FechaProceso  
       AND Codigo_Moneda = 994  
  
  
    /************************************************************************************************/  
    /* Grabar los datos de spot desde fecha proceso + 1 hasta la fecha del proximo proceso.         */  
    /************************************************************************************************/  
    SET @SaveDateBucle = @SaveDate  
  
    WHILE (@SaveDateBucle <= @ProximaFecha)  
    BEGIN  
  
        /********************************************************************************************/  
        /* Eliminar los datos del proximo día hábil de la tabla                                     */  
        /*             LNKOPTSIM.OptionSimulator.dbo.tblCurrencySetPricing                          */  
        /********************************************************************************************/  
        DELETE LNKOPTSIM.OptionSimulator.dbo.tblCurrencySetPricing  
         WHERE exchangeratedate  = @SaveDateBucle  
           AND setpricing       in ( 2, 5, 6 )  
  
        /********************************************************************************************/  
        /* Generación ID para spot                                                                  */  
        /********************************************************************************************/  
        SET @ID = CONVERT( FLOAT, YEAR(@SaveDateBucle) ) * POWER(10.0, 12 ) +  
                  CONVERT( FLOAT, MONTH(@SaveDateBucle) ) * POWER(10.0, 10 ) +   
                  CONVERT( FLOAT, DAY(@SaveDateBucle) ) * POWER(10.0, 8 ) +  
                  2.0 * POWER(10.0, 7 ) + 1  
  
        /********************************************************************************************/  
        /* Insertar Dolar Contable LNKOPTSIM.OptionSimulator.dbo.tblCurrencySetPricing              */  
        /********************************************************************************************/  
        INSERT INTO LNKOPTSIM.OptionSimulator.dbo.tblCurrencySetPricing  
                        (  
                          id  
                        , exchangeratedate  
                        , exchangerateid  
                        , setpricing  
                        , valuebid  
                        , valuemid  
                        , valueask  
                        , creatordate  
                        )  
               VALUES   (  
                          @ID  
                        , @SaveDateBucle  
                        , 1  
                        , 2  
                        , @Spot  
                        , @Spot  
                        , @Spot  
                        , GETDATE()  
                        )  
  
        /********************************************************************************************/  
        /* Generación ID para spot call                                                             */  
        /********************************************************************************************/  
        SET @ID = CONVERT( FLOAT, YEAR(@SaveDateBucle) ) * POWER(10.0, 12 ) +  
                  CONVERT( FLOAT, MONTH(@SaveDateBucle) ) * POWER(10.0, 10 ) +   
                  CONVERT( FLOAT, DAY(@SaveDateBucle) ) * POWER(10.0, 8 ) +  
                  5.0 * POWER(10.0, 7 ) + 1  
  
        /********************************************************************************************/  
        /* Insertar Dolar Contable call LNKOPTSIM.OptionSimulator.dbo.tblCurrencySetPricing         */  
        /********************************************************************************************/  
        INSERT INTO LNKOPTSIM.OptionSimulator.dbo.tblCurrencySetPricing  
                        (  
                          id  
                        , exchangeratedate  
                        , exchangerateid  
                        , setpricing  
                        , valuebid  
                        , valuemid  
                        , valueask  
                        , creatordate  
                        )  
               VALUES   (  
                          @ID  
                        , @SaveDateBucle  
                        , 1  
                        , 5  
                        , @Spot + @spreadspot * 0.01  
                        , @Spot + @spreadspot * 0.01  
                        , @Spot + @spreadspot * 0.01  
                        , GETDATE()  
                        )  
  
        /********************************************************************************************/  
        /* Generación ID para spot put                                                              */  
        /********************************************************************************************/  
        SET @ID = CONVERT( FLOAT, YEAR(@SaveDateBucle) ) * POWER(10.0, 12 ) +  
                  CONVERT( FLOAT, MONTH(@SaveDateBucle) ) * POWER(10.0, 10 ) +   
                  CONVERT( FLOAT, DAY(@SaveDateBucle) ) * POWER(10.0, 8 ) +  
                  6.0 * POWER(10.0, 7 ) + 1  
  
        /********************************************************************************************/  
        /* Insertar Dolar Contable put LNKOPTSIM.OptionSimulator.dbo.tblCurrencySetPricing          */  
        /********************************************************************************************/  
        INSERT INTO LNKOPTSIM.OptionSimulator.dbo.tblCurrencySetPricing  
                        (  
                          id  
                        , exchangeratedate  
                        , exchangerateid  
                        , setpricing  
                        , valuebid  
                        , valuemid  
                        , valueask  
                , creatordate  
                        )  
               VALUES   (  
                          @ID  
                        , @SaveDateBucle  
   , 1  
                        , 6  
                        , @Spot - @spreadspot * 0.01  
                        , @Spot - @spreadspot * 0.01  
                        , @Spot - @spreadspot * 0.01  
                        , GETDATE()  
                        )  
  
        SET @SaveDateBucle = DATEADD( DAY, 1, @SaveDateBucle )  
  
    END  
  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*                         ACTUALIZACIÓN LAS CURVAS                                             */  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
  
    /************************************************************************************************/  
    /* Obtiene los datos de la curva 'CURVASWAPCLP' y 'CURVASWAPUSDLOCAL' del día.                  */  
    /************************************************************************************************/  
    SELECT 'ID'    = IDENTITY(int, 1,1)  
         , 'Yield' = CodigoCurva  
         , 'Tenor' = DIAS   
         , 'Bid'   = ValorBid  
         , 'Ask'   = ValorAsk  
         , 'Mid'   = (ValorBid + ValorAsk) / 2  
      INTO #tmpCurvas  
      FROM BacParamSuda.dbo.CURVAS   
     WHERE FechaGeneracion  = @FechaProceso  
       AND CodigoCurva     in ( 'CurvaSwapCLP', 'CurvaSwapUSDLocal' )  
       AND Tipo             = 'TIR'  
  
    /************************************************************************************************/  
    /* Grabar los datos de spot desde fecha proceso + 1 hasta la fecha del proximo proceso.         */  
    /************************************************************************************************/  
    SET @SaveDateBucle = @SaveDate  
  
    WHILE (@SaveDateBucle <= @ProximaFecha)  
    BEGIN  
  
                /********************************************************************************************/  
        /* Eliminar los datos del proximo día hábil de la tabla                                     */  
        /*             LNKOPTSIM.OptionSimulator.dbo.tblYieldSetPricing                             */  
        /********************************************************************************************/  
        DELETE LNKOPTSIM.OptionSimulator.dbo.tblYieldSetPricing  
         WHERE yielddate   = @SaveDateBucle  
           AND setpricing in ( 5, 6 )  
  
        /********************************************************************************************/  
        /* Generación ID para la curva call                                                         */  
        /********************************************************************************************/  
        SET @ID = CONVERT( FLOAT, YEAR(@SaveDateBucle) ) * POWER(10.0, 12 ) +  
                  CONVERT( FLOAT, MONTH(@SaveDateBucle) ) * POWER(10.0, 10 ) +   
                  CONVERT( FLOAT, DAY(@SaveDateBucle) ) * POWER(10.0, 8 ) +  
                  5.0 * POWER(10.0, 7 )  
  
        /********************************************************************************************/  
        /* Insertar las curvas call LNKOPTSIM.OptionSimulator.dbo.tblYieldSetPricing                */  
        /********************************************************************************************/  
        INSERT INTO LNKOPTSIM.OptionSimulator.dbo.tblYieldSetPricing  
                        (  
                          id  
                     , yielddate  
                        , yieldname  
                        , setpricing  
                        , tenor  
                        , valuebid  
                        , valueask  
                        , valuemid  
                        , creatordate  
                        )  
               SELECT     ID + @ID  
                    ,     @SaveDateBucle  
                    ,     Yield  
                    ,     5  
                    ,     Tenor  
                    ,     Bid + @spreadyield * 0.01  
                    ,     Ask + @spreadyield * 0.01  
                    ,     Mid + @spreadyield * 0.01  
                    ,     GETDATE()  
                 FROM     #tmpCurvas  
  
        /********************************************************************************************/  
        /* Generación ID para la curva put                                                          */  
        /********************************************************************************************/  
        SET @ID = CONVERT( FLOAT, YEAR(@SaveDateBucle) ) * POWER(10.0, 12 ) +  
                  CONVERT( FLOAT, MONTH(@SaveDateBucle) ) * POWER(10.0, 10 ) +   
                  CONVERT( FLOAT, DAY(@SaveDateBucle) ) * POWER(10.0, 8 ) +  
                  6.0 * POWER(10.0, 7 )  
  
        /********************************************************************************************/  
        /* Insertar las curvas put LNKOPTSIM.OptionSimulator.dbo.tblYieldSetPricing                 */  
        /********************************************************************************************/  
        INSERT INTO LNKOPTSIM.OptionSimulator.dbo.tblYieldSetPricing  
                        (  
                          id  
                        , yielddate  
                        , yieldname  
                        , setpricing  
                        , tenor  
                        , valuebid  
                        , valueask  
                        , valuemid  
                        , creatordate  
                        )  
               SELECT     ID + @ID  
                    ,     @SaveDateBucle  
                    ,     Yield  
                    ,     6  
                    ,     Tenor  
                    ,     Bid - @spreadyield * 0.01  
                    ,     Ask - @spreadyield * 0.01  
                    ,     Mid - @spreadyield * 0.01  
                    ,     GETDATE()  
                 FROM     #tmpCurvas  
  
        SET @SaveDateBucle = DATEADD( DAY, 1, @SaveDateBucle )  
  
    END  
  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*                         ACTUALIZACIÓN EL SMILE                                               */  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
  
    /************************************************************************************************/  
    /* Obtiene los datos del smile del día.                                                         */  
    /************************************************************************************************/  
    SELECT 'ID'         = IDENTITY(int, 1,1)  
         , 'Underlying' = SmlParFor  
         , 'Structure'  = SmlEstructura  
         , 'Delta'      = SmlDelta  
         , 'Tenor'      = SmlDias  
         , 'Bid'        = SmlBid  
         , 'Ask'        = SmlAsk  
         , 'Mid'        = SmlMid   
      INTO #tmpSmile  
      FROM LnkOpc.CbMdbOpc.dbo.Smile  
     WHERE SmlFecha = @FechaProceso  
  
    /************************************************************************************************/  
    /* Grabar los datos de smile desde fecha proceso + 1 hasta la fecha del proximo proceso.        */  
    /************************************************************************************************/  
    SET @SaveDateBucle = @SaveDate  
  
    WHILE (@SaveDateBucle <= @ProximaFecha)  
    BEGIN  
  
        /********************************************************************************************/  
        /* Eliminar los datos del proximo día hábil de la tabla                                     */  
        /*             LNKOPTSIM.OptionSimulator.dbo.tblSmileSetPricing                             */  
        /********************************************************************************************/  
        DELETE LNKOPTSIM.OptionSimulator.dbo.tblSmileSetPricing  
         WHERE smiledate   = @SaveDateBucle  
           AND setpricing in ( 5, 6 )  
  
        /********************************************************************************************/  
        /* Generación ID para la smile call                                                         */  
        /********************************************************************************************/  
        SET @ID = CONVERT( FLOAT, YEAR(@SaveDateBucle) ) * POWER(10.0, 12 ) +  
                  CONVERT( FLOAT, MONTH(@SaveDateBucle) ) * POWER(10.0, 10 ) +   
                  CONVERT( FLOAT, DAY(@SaveDateBucle) ) * POWER(10.0, 8 ) +  
                  5.0 * POWER(10.0, 7 )  
  
        /********************************************************************************************/  
        /* Insertar las smile call LNKOPTSIM.OptionSimulator.dbo.tblSmileSetPricing                 */  
        /********************************************************************************************/  
        INSERT INTO LNKOPTSIM.OptionSimulator.dbo.tblSmileSetPricing  
                        (  
                          id  
                        , smiledate  
                        , setpricing  
                        , currencypair  
                        , structure  
                        , delta  
                        , tenorname  
                        , tenor  
                        , valuebid  
                        , valueask  
                        , valuemid  
                        , creatordate  
                        )  
               SELECT     ID + @ID  
                    ,     @SaveDateBucle  
                    ,     5  
                    ,     Underlying  
                    ,     Structure  
                    ,     Delta  
                    ,     CONVERT( varchar(10), Tenor ) + 'D'  
                    ,     Tenor  
                    ,     Bid + CASE WHEN Structure = 1 THEN @spreadsmile * 0.01 ELSE 0 END  
                    ,     Ask + CASE WHEN Structure = 1 THEN @spreadsmile * 0.01 ELSE 0 END  
                    ,     Mid + CASE WHEN Structure = 1 THEN @spreadsmile * 0.01 ELSE 0 END  
                    ,     GETDATE()  
                 FROM     #tmpSmile  
  
        /********************************************************************************************/  
        /* Generación ID para la smile put                                                          */  
        /********************************************************************************************/  
        SET @ID = CONVERT( FLOAT, YEAR(@SaveDateBucle) ) * POWER(10.0, 12 ) +  
                  CONVERT( FLOAT, MONTH(@SaveDateBucle) ) * POWER(10.0, 10 ) +   
                  CONVERT( FLOAT, DAY(@SaveDateBucle) ) * POWER(10.0, 8 ) +  
                  6.0 * POWER(10.0, 7 )  
  
        /********************************************************************************************/  
        /* Insertar las smile put LNKOPTSIM.OptionSimulator.dbo.tblSmileSetPricing                  */  
        /********************************************************************************************/  
        INSERT INTO LNKOPTSIM.OptionSimulator.dbo.tblSmileSetPricing  
                        (  
                          id  
                        , smiledate  
                   , setpricing  
                        , currencypair  
                        , structure  
                        , delta  
                        , tenorname  
                        , tenor  
                        , valuebid  
                        , valueask  
                        , valuemid  
                        , creatordate  
                        )  
               SELECT     ID + @ID  
                    ,     @SaveDateBucle  
                    ,     6  
                    ,     Underlying  
                    ,     Structure  
                    ,     Delta  
                    ,     CONVERT( varchar(10), Tenor ) + 'D'  
                    ,     Tenor  
                    ,     Bid + CASE WHEN Structure = 1 THEN @spreadsmile * 0.01 ELSE 0 END
                    ,     Ask + CASE WHEN Structure = 1 THEN @spreadsmile * 0.01 ELSE 0 END
                    ,     Mid + CASE WHEN Structure = 1 THEN @spreadsmile * 0.01 ELSE 0 END
                    ,     GETDATE()  
                 FROM     #tmpSmile  
  
        SET @SaveDateBucle = DATEADD( DAY, 1, @SaveDateBucle )  
  
    END  
  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*                        ACTUALIZACIÓN LA TABLA DE FERIADOS                                    */  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
  
    /************************************************************************************************/  
    /* Limpia la tabla de feriados                                                                  */  
    /************************************************************************************************/  
    DELETE LNKOPTSIM.OptionSimulator.dbo.Feriado  
  
    /************************************************************************************************/  
    /* Inserta los feriados.                                                    */  
    /************************************************************************************************/  
    INSERT INTO LNKOPTSIM.OptionSimulator.dbo.Feriado  
                    (  
                      feano  
                    , feplaza  
                    , feene  
                    , fefeb  
                    , femar  
                    , feabr  
                    , femay  
                    , fejun  
                    , fejul  
                    , feago  
                    , fesep  
                    , feoct  
                    , fenov  
                    , fedic  
                    )  
           SELECT   feano  
                    , feplaza  
                    , feene  
                    , fefeb  
                    , femar  
                    , feabr  
                    , femay  
                    , fejun  
                    , fejul  
                    , feago  
                    , fesep  
                    , feoct  
                    , fenov  
                    , fedic  
             FROM   BacParamSuda.dbo.Feriado  
  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*==============================================================================================*/  
    /*                             BORRA TABLAS TEMPORALES                                          */  
    /*==============================================================================================*/  
   /*==============================================================================================*/  
    /*==============================================================================================*/  
    DROP TABLE #tmpSmile  
    DROP TABLE #tmpCurvas  
  
   /****************************************************************************************************/  
   /****************************************************************************************************/  
   SET NOCOUNT OFF  
  
  
END  
GO
