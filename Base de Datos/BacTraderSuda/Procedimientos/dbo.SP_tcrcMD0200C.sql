USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_tcrcMD0200C]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_tcrcMD0200C]
 (  
        @Modcal     INTEGER,  
        @dFeccal    DATETIME,  
        @nCodigo    INTEGER,  
        @cMascara   CHAR(12),  
        @nMonemi    INTEGER,  
        @dFecemi    DATETIME,  
        @dFecven    DATETIME,  
        @fTasemi    FLOAT,  
        @fBasemi    FLOAT,  
        @fTasest    FLOAT,  
        @fNominal   FLOAT      OUTPUT,  
        @fTir       FLOAT      OUTPUT,  
        @fPvp       FLOAT      OUTPUT,  
        @fMT        FLOAT      OUTPUT,  
        @fMTUM      FLOAT      OUTPUT,  
        @fMT_cien   FLOAT      OUTPUT,  
        @fVan       FLOAT      OUTPUT,  
        @fVpar      FLOAT      OUTPUT,  
        @nNumucup   INTEGER    OUTPUT,  
        @dFecucup   DATETIME   OUTPUT,  
        @fIntucup   FLOAT      OUTPUT,  
        @fAmoucup   FLOAT      OUTPUT,  
        @fSalucup   FLOAT      OUTPUT,  
        @nNumpcup   INTEGER    OUTPUT,  
        @dFecpcup   DATETIME   OUTPUT,  
        @fIntpcup   FLOAT      OUTPUT,  
        @fAmopcup   FLOAT      OUTPUT,  
        @fSalpcup   INTEGER    OUTPUT,  
        @fDurat     FLOAT      OUTPUT,  
        @fConvx     FLOAT      OUTPUT,  
        @fDurmo     FLOAT      OUTPUT  
       )  
AS  
BEGIN  
   DECLARE @nTera      FLOAT  
   DECLARE @nCupones   NUMERIC(03,00)  
   DECLARE @nMonemis   NUMERIC(03,00)  
   DECLARE @x1         INTEGER  
   DECLARE @nSaldo     FLOAT  
   DECLARE @fVan_1     FLOAT  
   DECLARE @fVan_2     FLOAT  
   DECLARE @fVpar_1    FLOAT  
   DECLARE @fVpar_2    FLOAT  
   DECLARE @nValmon    NUMERIC(18,10)  
   DECLARE @auxMascara CHAR(12)  
   DECLARE @auxCup     NUMERIC(03,00)  
   DECLARE @auxFven    DATETIME  
   DECLARE @auxInt     NUMERIC(19,10)  
   DECLARE @auxAmort   NUMERIC(19,10)  
   DECLARE @auxFluj    NUMERIC(19,10)  
   DECLARE @auxSaldo   NUMERIC(19,10)  
   DECLARE @rango      NUMERIC(05,02)  
   DECLARE @decs       INTEGER  
   DECLARE @tkl        FLOAT  
   DECLARE @ut         FLOAT  
   DECLARE @ma         FLOAT  
   DECLARE @me         FLOAT  
   DECLARE @jVan       FLOAT  
   DECLARE @nCount     INTEGER  
   DECLARE @pervcupano INTEGER  
   DECLARE @fTasa      FLOAT         -- Libor ultimo cupon cortado  
   DECLARE @fTasaFlot  FLOAT         -- Tasa Flotante  
   DECLARE @cBonosFlot CHAR(01)      -- Flag que identifica a los papeles con tasa flotante  
   DECLARE @nCuponFlot FLOAT  
   SELECT @fTasaFlot = 0.0  
   SELECT @cBonosFlot = '0'  
     
     
   IF @cMascara = 'BCAPS-A1' BEGIN  
      SELECT @fTasaFlot = 1.5  
      SELECT @cBonosFlot = '1'  
   END  
     
   IF @cMascara = 'BCAPS-F' BEGIN  
   		EXEC SP_MD0700C
        @Modcal,        @dFeccal    ,
        @nCodigo ,   
        @cMascara ,  
        @nMonemi   , 
        @dFecemi    ,
        @dFecven    ,
        @fTasemi    ,
        @fBasemi    ,
        @fTasest    ,
        @fNominal   OUTPUT,
        @fTir       OUTPUT,
        @fPvp       OUTPUT,
        @fMT        OUTPUT,
        @fMTUM      OUTPUT,
        @fMT_cien   OUTPUT,
        @fVan       OUTPUT,
        @fVpar      OUTPUT,
        @nNumucup   OUTPUT,
        @dFecucup   OUTPUT,
        @fIntucup   OUTPUT,
        @fAmoucup   OUTPUT,
        @fSalucup   OUTPUT,
        @nNumpcup   OUTPUT,
        @dFecpcup   OUTPUT,
        @fIntpcup   OUTPUT,
        @fAmopcup   OUTPUT,
        @fSalpcup   OUTPUT,
        @fDurat     OUTPUT,
        @fConvx     OUTPUT,
        @fDurmo     OUTPUT
        RETURN
   END  
  
   IF @cMascara = 'BSTDS-BD' BEGIN  
      SELECT @fTasaFlot = 0.4  
      SELECT @cBonosFlot = '1'  
   END  
   SELECT @nTera  = -1.0  
   SET ROWCOUNT 1  
   SELECT       @nTera      = setera,  
                @dFecemi    = sefecemi,  
                @dFecven    = sefecven,  
                @nCupones   = secupones,  
                @nMonemis   = semonemi,  
                @pervcupano = (12/sepervcup)  
     FROM  VIEW_SERIE  
          WHERE semascara   = @cMascara  
   SET ROWCOUNT 0  
   IF @nTera = -1.0 BEGIN  
      SELECT @fAmoucup = 0.0  
      SELECT @dFecucup = ''  
      SELECT @fIntucup = 0.0  
      SELECT @fSalucup = 0.0  
      SELECT @fPvp     = 0.0  
      SELECT @fVan     = 0.0  
      SELECT @fVpar    = 0.0  
      RETURN  
   END  
   IF @dFeccal < @dFecemi BEGIN  
      SELECT 'NO','La serie tiene Fecha de emisi=n posterior a Fecha de Cÿlculo'  
      RETURN  
   END  
   IF @dFeccal > @dFecven  
   BEGIN  
   --   SELECT 'NO','La serie tiene Fecha de Vcto. Anterior a Fecha de Cÿlculo'  
--      RETURN  
 SELECT @dFeccal = @dFecven  
   END  

   SELECT @auxMascara = '*'  
   SELECT @auxMascara = tdmascara  
   FROM   VIEW_TABLA_DESARROLLO  
   WHERE  tdmascara=@cMascara  
   IF @auxMascara = '*' BEGIN  
      SELECT 'NO','Serie No ha sido encontrada en Tabla de Desarrollo'  
      RETURN  
   END  
   IF @dFeccal = @dFecven BEGIN  
      SELECT @dFecucup = @dFecven  
      SELECT     @nSaldo   = 0.0,  
                   @nNumucup = @nCupones,  
                   @fIntucup = tdinteres,  
     @fAmoucup = tdamort,  
                   @fSalucup = 0.0,  
                   @fMt      = 0.0,  
                   @fMtum    = 0.0,  
                   @fMt_cien = 0.0  
             FROM  VIEW_TABLA_DESARROLLO  
             WHERE tdmascara = @cMascara AND  
                   tdcupon   = @nCupones  
      SELECT @fPvp     = 0.0  
      SELECT @fVan     = 0.0  
      SELECT @fVpar    = 0.0  
      SELECT @nNumucup = @nCupones  
      SELECT @dFecucup = @dFecven  
      SELECT @nNumpcup = @nCupones  
      SELECT @dFecpcup = @dFecven  
      SELECT @fIntpcup = 0.0  
      SELECT @fAmopcup = 0.0  
      SELECT @fSalpcup = 0.0  
      RETURN  
   END  
  
 -- Para los Bonos del BCCH   
 DECLARE @ctipo_moneda CHAR (01) ,  
  @cdecimal NUMERIC (05)  
  
 SELECT @ctipo_moneda = CASE  
     WHEN mnmx='C' THEN '0'  
     ELSE '1'  
      END ,  
  @cdecimal = mndecimal  
 FROM VIEW_MONEDA  
 WHERE mncodmon=@nMonemis  
  
  
	IF @nMonemis=999 OR @ctipo_moneda='0'  
		SELECT @nValmon = 1  
	ELSE  
		SELECT @nValmon = Tipo_Cambio
		FROM	bacparamsuda.dbo.valor_moneda_contable
		WHERE fecha = @dFeccal AND  
		codigo_moneda= @nMonemis  

	IF @nValmon=0  
	BEGIN  
		SELECT @nValmon = Tipo_Cambio  
		FROM bacparamsuda.dbo.valor_moneda_contable  
		WHERE fecha =(SELECT MAX(fecha) FROM bacparamsuda.dbo.valor_moneda_contable WHERE codigo_moneda=@nMonemis AND Tipo_Cambio<>0) AND  
		Codigo_Moneda= @nMonemis       
	END  
  
   /*===========================================================================================================*/  
   /* Genera una Tabla temporal con la tabla de Desarrollo                                                      */  
   /*===========================================================================================================*/  
   SELECT       'tdmascara' = tdmascara,  
                'tdinteres' = tdinteres,  
                'tdamort'   = tdamort,  
                'tdsaldo'   = tdsaldo,  
                'tdflujo'   = tdflujo,  
                'tdfecven'  = tdfecven,  
                'tdcupon'   = tdcupon,  
                'tdlibor'   = CONVERT( FLOAT, 0 ),  
                'tdfecant'  = tdfecven,  
                'tdsaldoin' = tdsaldo  
          INTO  #tmpmdse  
          FROM  VIEW_TABLA_DESARROLLO  
          WHERE VIEW_TABLA_DESARROLLO.tdmascara  = @cMascara  
   /*===========================================================================================================*/  
   /* Recupera el próximo cupón y el anterior.                                                                  */  
   /*===========================================================================================================*/  
   SELECT @nSaldo   = 100.0  
   SELECT @dFecucup = @dFecemi  
   SELECT @nNumucup = 0  
   SELECT @fAmoucup = 0.0  
   SELECT @fIntucup = 0.0  
  SELECT @fSalucup = 0.0  
   /*===========================================================================================================*/  
   /* Próximo Cupón                                                                                             */  
   /*===========================================================================================================*/  
   SET ROWCOUNT 1  
   SELECT       @auxMascara = tdmascara,  
                @nNumpcup   = tdcupon,  
                @dFecpcup   = tdfecven,  
                @fIntpcup   = tdinteres,  
                @fAmopcup   = tdamort,  
                @auxFluj    = tdflujo,  
                @fSalpcup   = tdsaldo  
          FROM  #tmpmdse  
          WHERE tdfecven    > @dFeccal  
   SET ROWCOUNT 0  
   SELECT @fSalpcup = @nSaldo  
   /*===========================================================================================================*/  
   /* Cupón Anterior                                                                                            */  
   /*===========================================================================================================*/  
   SET ROWCOUNT 1  
   SELECT       @auxMascara = tdmascara,
                @nNumucup   = tdcupon,
                @dFecucup   = tdfecven,  
                @fIntucup   = tdinteres,  
              @fAmoucup   = tdamort,  
                @auxFluj    = tdflujo,  
                @nSaldo     = tdsaldo  
          FROM  #tmpmdse  
          WHERE tdfecven    < @dFecpcup  
          ORDER BY tdcupon DESC  
   SET ROWCOUNT 0  
   SELECT @fSalucup = @nSaldo  
   IF @nNumucup = 0 BEGIN  
      SELECT @nSaldo = 100.0  
   END ELSE BEGIN  
  SELECT       @nSaldo = tdsaldo  
             FROM  VIEW_TABLA_DESARROLLO  
             WHERE tdmascara = @cMascara  AND  
                   tdcupon   = @nNumuCup  
   END  
  
  
   if @ftasest=0.0  
 --select @ftasest=vmvalor from VIEW_VALOR_MONEDA   where  vmcodigo=302 and vmfecha=@dfeccal   
 select @ftasest=Tipo_Cambio from bacparamsuda.dbo.valor_moneda_contable   where  Codigo_Moneda=302 and fecha=@dfeccal   
  
  
  
   /*===========================================================================================================*/  
   /* Actualiza las fecha de vencimiento anterior                                                               */  
   /*===========================================================================================================*/  
   UPDATE       #tmpmdse  
          SET   tdfecant   = CASE WHEN tdcupon = 1   
                                       THEN @dfecemi  
                                       ELSE (SELECT tdfecven FROM #tmpmdse a WHERE a.tdcupon = (#tmpmdse.tdcupon - 1))  
                             END,  
                tdsaldoin  = CASE WHEN tdcupon = 1   
                                       THEN @fSalucup  
                                       ELSE (SELECT tdsaldo FROM #tmpmdse a WHERE a.tdcupon = (#tmpmdse.tdcupon - 1))  
                             END  
   /*===========================================================================================================*/  
   /* Busca la libor para cada cupon.                                                                           */  
   /*===========================================================================================================*/  
   UPDATE #tmpmdse  
   SET    tdlibor     = ISNULL( (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = tdfecant AND vmcodigo = 222), 0.0 )  
   WHERE  tdcupon    <= @nNumpCup  
  
   UPDATE #tmpmdse  
   SET    tdfecant    = @dFecuCup  
   WHERE  tdcupon     = 1  
  
   /*===========================================================================================================*/  
   /* Busca el primer cupon que no posea libor.                                                                 */  
   /*===========================================================================================================*/  
   SET ROWCOUNT 1  
   SELECT @nCuponFlot = tdcupon  
   FROM   #tmpmdse  
   WHERE  tdlibor     = 0.0  
   SET ROWCOUNT 0  
   SELECT @nCuponFlot = ISNULL( @nCuponFlot, @nNumpCup )  
   /*===========================================================================================================*/  
   /* 1. Asigna la tasa estimada desde el primer cupon que se encuentre con libor en 0.                         */  
   /* 2. Asigna la tasa estimada desde el proximo cupon que esta por vencer.                                    */  
   /*===========================================================================================================*/  
   UPDATE #tmpmdse  
   SET    tdlibor    = @fTasEst  
   WHERE (tdcupon   >= @nCuponFlot) OR (tdcupon >= @nNumpCup + 1)  
  
   UPDATE #tmpmdse  
   SET    tdlibor    = tdlibor +  @fTasaFlot  
  
   /*===========================================================================================================*/  
   /* Recupera la libor del ultimo cupon cortado en el caso de los (BCAPS-A1 y BSTDBS-BD).                      */  
   /*===========================================================================================================*/  
   IF @cBonosFlot = '1' BEGIN  
      IF @nNumuCup > 0 BEGIN  
         SELECT       @fTasa   = ISNULL( Tipo_Cambio, 0.0 )  
                FROM  bacparamsuda.dbo.valor_moneda_contable--VIEW_VALOR_MONEDA  
                WHERE fecha  = @dFecuCup   AND  
                      Codigo_Moneda = 222  
      END ELSE BEGIN  
         SELECT       @fTasa   = ISNULL( Tipo_Cambio, 0.0 )  
                FROM  bacparamsuda.dbo.valor_moneda_contable--VIEW_VALOR_MONEDA  
                WHERE fecha  = @dFecEmi    AND  
                      Codigo_Moneda = 222  
     END  
   END  
   SELECT @fTasa = ISNULL( @fTasa, 0.0 )  
   IF @fTasa = 0.0 BEGIN  
      SELECT @fTasa = @fTasEst  
   END  
   /*===========================================================================================================*/  
   /* Calculo del Valor Par                        */  
   /*===========================================================================================================*/  
   IF @cBonosFlot = '1' BEGIN  
      UPDATE       #tmpmdse  
             SET   tdinteres = ISNULL(  
                               ROUND( tdsaldoin * ( ( tdlibor * DATEDIFF( DAY, tdfecant, tdfecven ) ) / 36000 ), 6 ),  CASE WHEN @ctipo_moneda = '0' THEN @cdecimal ELSE 0 END)  
      UPDATE      #tmpmdse  
             SET  tdflujo   = tdamort + tdinteres  
      /*========================================================================================================*/  
      /* Valor Par                                                                                              */  
      /*========================================================================================================*/  
  
--SELECT * FROM #tmpmdse  
  
   
  
      SELECT @fVpar  = ROUND( CONVERT( FLOAT, @fSalucup ) *   
                              POWER( CONVERT( FLOAT, 1.0 ) + (((@fTasa + @fTasaFlot) *   
                              CONVERT( FLOAT, DATEDIFF( DAY, @dFecuCup, @dFecpCup ) )) / CONVERT( FLOAT, 36000.0 )),  
                              CONVERT( FLOAT, DATEDIFF( DAY, @dFecucup, @dFeccal ) ) / CONVERT( FLOAT, DATEDIFF( DAY, @dFecuCup, @dFecpCup ) ) ), 8 )  
  
      select @fTasemi = (@fTasa + @fTasaFlot)  
   END ELSE BEGIN  
      /*========================================================================================================*/  
      /* Valor Par                                                                                              */  
      /*========================================================================================================*/  
      SELECT @fVpar  = ROUND( @nSaldo * POWER( CONVERT( FLOAT, 1 ) + @nTera / CONVERT( FLOAT, 100 ),  
                                               DATEDIFF( DAY, @dFecucup, @dFeccal ) / CONVERT( FLOAT, 365 ) ), 8 )  
   END  
  
   /*************************************************************************************************************/  
   /*************************************************************************************************************/  
   /**   Modalidad 1 y 4 (Igconita Tasa de Interes y Valor Presente).                                          **/  
   /*************************************************************************************************************/  
   /*************************************************************************************************************/  
--select @fVpar  
--select tdflujo from #tmpmdse where tdfecven >= '20020701' order by tdcupon  
  
   IF @Modcal = 1 OR @Modcal = 4 BEGIN  
      /*========================================================================================================*/  
      /* Base 100                                                                                               */  
      /*========================================================================================================*/  
      SELECT @fMt_cien = ROUND( ( @fPvp / CONVERT( FLOAT, 100 ) ) * ( @fVpar / CONVERT( FLOAT, 100 ) ) *   
                                  CONVERT( FLOAT, 100 ), 4 )  
      /*========================================================================================================*/  
      /* Tir                                                                                                    */  
      /*========================================================================================================*/  
      SELECT @fTir   = 0.0  
      SELECT @Rango  = 50.0  
      SELECT @Decs   = 2  
      SELECT @tkl    = (CASE WHEN @nTera = 0 THEN @fTasEmi ELSE @nTera END)  
      SELECT @Ut     = @tkl  
      SELECT @nCount = 1  
      SELECT @Ma  = @Rango * 1.0  
      SELECT @Me  = @Rango * -1.0  
      WHILE @nCount <= 50 BEGIN  
         IF (1.0 + @tkl / 100.0) = 0.0 BEGIN  
            SELECT @jVan = 0.0  
        END ELSE BEGIN  
            SELECT @jVan = 0.0  
            SELECT @jVan = SUM( tdflujo / POWER( CONVERT( FLOAT, 1 ) + @tkl / CONVERT( FLOAT, 100 ),  
                                                 DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) )  
                   FROM  #tmpmdse  
      WHERE tdcupon > @nNumucup  
         END  
         SELECT @ut = ROUND( @tkl, @decs )  
         IF @jVan<@fMt_cien BEGIN  
            SELECT @ma = @tkl  
         END ELSE BEGIN  
            SELECT @me = @tkl  
         END  
         SELECT @tkl = (@ma - @me) / 2.0 + @me  
         IF @ut = ROUND( @tkl, @Decs ) BEGIN  
            SELECT @nCount = 51  
            IF ABS( ROUND( @ut, 0 ) ) = @rango BEGIN  
               SELECT @fTir = 0.0  
            END ELSE BEGIN  
               SELECT @fTir = ROUND(@ut,2)  
            END  
         END  
         SELECT @nCount = @nCount + 1  
   
      END  
      IF @nCount <> 52 BEGIN  
         SELECT @fTir = 0.0  
      END  
      /*========================================================================================================*/  
      /* Van                                                                                                    */  
      /*========================================================================================================*/  
      IF (1.0 + @fTir / 100.0 ) = 0.0 BEGIN  
         SELECT @jVan = 0.0  
      END ELSE BEGIN  
         SELECT @jVan   = 0.0  
         SELECT @fDurat = 0.0  
         SELECT @fConvx = 0.0  
         SELECT       @jVan   = SUM( tdflujo / POWER( CONVERT( FLOAT, 1 ) + @tkl / CONVERT( FLOAT, 100 ),  
                                                      DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) ),  
                      @fDurat = SUM( ( tdflujo * DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) /   
                                                 POWER( CONVERT( FLOAT, 1 ) + @fTir / CONVERT( FLOAT, 100 ),  
                                                 DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) ) ),  
                      @fConvx = SUM( ( tdflujo * DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) *  
                                                 ( ( DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) +  
                                                 CONVERT( FLOAT, 1 ) ) / POWER( CONVERT( FLOAT, 1 ) + @fTir /  
                                                 CONVERT( FLOAT, 100 ), DATEDIFF( DAY, @dFeccal, tdfecven ) /  
                                                 CONVERT( FLOAT, 365 ) ) )  
                FROM  #tmpmdse  
                WHERE tdcupon > @nNumucup  
      END  
      SELECT @fVan = @jVan  
      /*========================================================================================================*/  
      /* Duration y Convexidad                                                                                  */  
      /*========================================================================================================*/  
      SELECT @fDurat = ROUND( @fDurat / @fVan, 8 )  
      SELECT @fConvx = ROUND( ( @fConvx / POWER( CONVERT( FLOAT, 1 ) + @fTir / CONVERT( FLOAT, 100 ),  
                                                 CONVERT( FLOAT, 2 ) ) ) / @fVan, 8 )  
      SELECT @fDurmo = ROUND( @fDurat / ( CONVERT( FLOAT, 1 ) + ( ( @fTir / CONVERT( FLOAT, 100 ) ) / @pervcupano ) ), 8 )  
      /*========================================================================================================*/  
      /*========================================================================================================*/  
 IF @modcal = 1 BEGIN  
         SELECT @fMt = ( @fVpar / CONVERT( FLOAT, 100 ) ) * @fNominal * ( @fPvp / CONVERT( FLOAT, 100 ) )  
      END ELSE BEGIN  
         SELECT @fNominal = ROUND( ( 10000.0 * @fMt ) / ( @fPvp * @fVpar ), 4 )  
      END  
              
      IF @nMonemis = 999  
      BEGIN   
         SELECT @fMtum = ROUND(@fMt,0)  
      END ELSE  
      BEGIN  
         SELECT @fMtum = @fMt  
      END  
        
--      SELECT @fMt   = ROUND( @fMt * @nValmon, 0 )  
      SELECT @fMt   = ROUND( @fMt * @nValmon, CASE WHEN @ctipo_moneda = '0' THEN @cdecimal ELSE 0 END )  
   END  
   /*************************************************************************************************************/  
   /*************************************************************************************************************/  
   /**   Modalidad 2 y 5.                                                                    **/  
   /*************************************************************************************************************/  
   /*************************************************************************************************************/  
   IF @Modcal = 2 OR @Modcal = 5 BEGIN  
      SELECT @fVan     = 0.0  
      SELECT @fVan_1   = 0.0  
      SELECT @fVan_2   = 0.0  
      /*========================================================================================================*/  
      /** Calculo del Van                                                                                       */  
      /*========================================================================================================*/  
      SELECT       @fVan     = SUM( tdflujo / POWER( CONVERT( FLOAT, 1 ) +   
                                   (CASE WHEN @cBonosFlot = '1'  THEN @nTera ELSE @fTir END) / CONVERT( FLOAT, 100 ),  
                                                     DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) ),  
                   @fDurat   = SUM( ( tdflujo * DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) /  
                                                     POWER( CONVERT( FLOAT, 1 ) + @fTir / CONVERT( FLOAT, 100 ),  
                                                     DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT,365 ) ) ) ),  
                   @fConvx   = SUM( ( tdflujo * DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) *  
                                                     ( ( DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) +  
                                                     CONVERT( FLOAT, 1 ) ) / POWER( CONVERT( FLOAT, 1 ) + @fTir /  
                                                     CONVERT( FLOAT, 100 ), DATEDIFF( DAY, @dFeccal, tdfecven ) /  
                                                     CONVERT( FLOAT, 365 ) ) )  
             FROM  #tmpmdse  
             WHERE tdcupon   > @nNumucup  
  
      IF @cBonosFlot = '1' BEGIN  
         SELECT @fVan = ROUND( @fVan, 3 )  
      END  
      /*========================================================================================================*/  
      /* Duration y Convexidad                                                                                  */  
      /*========================================================================================================*/  
      SELECT @fDurat = ROUND( @fDurat / @fVan, 8 )  
      SELECT @fConvx = ROUND( ( @fConvx / POWER( CONVERT( FLOAT, 1 ) + @fTir / CONVERT( FLOAT, 100 ),  
                                                 CONVERT( FLOAT, 2 ) ) ) / @fVan, 8 )  
      SELECT @fDurmo = ROUND( @fDurat / ( CONVERT(FLOAT,1) + ( ( @fTir / CONVERT( FLOAT, 100 ) ) / @pervcupano ) ), 8 )  
      /*========================================================================================================*/  
      /* % Valor Par                                                */  
      /*========================================================================================================*/  
--        SELECT 'aca',@fVan , @fVpar   
      SELECT @fPvp  = ROUND( ( @fVan / @fVpar ) * CONVERT( FLOAT, 100 ), 2 )  
      IF @modcal = 2 BEGIN  
         SELECT @fMt  = ( @fPvp / CONVERT( FLOAT, 100 ) ) * ( @fVpar / CONVERT( FLOAT, 100 ) ) * @fNominal  
      END ELSE BEGIN  
         SELECT @fNominal = ROUND( ( ( 10000.0 * @fMt ) / ( @fPvp * @fVpar ) ), 4 )  
      END  
      SELECT @fMt_cien = ROUND( ( @fPvp / CONVERT( FLOAT, 100 ) ) * ( @fVpar / CONVERT( FLOAT, 100 ) ) *  
                         CONVERT( FLOAT, 100 ), 4 )  
      IF @nMonemis = 999  
      BEGIN   
         SELECT @fMtum    = ROUND(@fMt,0)  
      END ELSE  
      BEGIN  
         SELECT @fMtum    = @fMt  
      END  
--      SELECT @fMt      = ROUND( @fMt * @nValmon, 0 )  
      SELECT @fMt      = ROUND( @fMt * @nValmon, CASE WHEN @ctipo_moneda ='0' THEN @cdecimal ELSE 0 END )  
   END  
   /*************************************************************************************************************/  
   /*************************************************************************************************************/  
   /**   Modalidad 3.                                                                                          **/  
   /*************************************************************************************************************/  
   /*************************************************************************************************************/  
   IF @Modcal = 3 BEGIN  
      SELECT @fMtum    = ROUND( @fMt / @nValmon, 4 )  
      /*========================================================================================================*/  
      /* Base Cien                                                                                              */  
      /*========================================================================================================*/  
      SELECT @fMt_cien = ROUND(@fMtum/@fNominal*CONVERT(FLOAT,100),4)  
      /*========================================================================================================*/  
      /* Tir                                                                                                    */  
      /*========================================================================================================*/  
      SELECT @fTir   = 0.0  
      SELECT @Rango  = 80.0  
      SELECT @Decs   = 4  
      SELECT @tkl    = (CASE WHEN @nTera = 0.0 THEN @fTasEmi ELSE @nTera END)  
      SELECT @Ut     = @tkl  
      SELECT @nCount = 1  
      SELECT @Ma  = @Rango *  1.0  
      SELECT @Me  = @Rango * -1.0  
      WHILE @nCount <= 50 BEGIN  
         IF ( CONVERT( FLOAT, 1 ) + @tkl / CONVERT( FLOAT, 100 ) ) = 0.0 BEGIN  
            SELECT @jVan = 0.0  
         END ELSE BEGIN  
            SELECT @jVan = 0.0  
            SELECT @jVan = SUM( tdflujo / POWER( CONVERT( FLOAT, 1 ) + @tkl / CONVERT( FLOAT, 100 ),  
                                          DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) )  
                   FROM  #tmpmdse  
                   WHERE tdcupon > @nNumucup  
         END  
         SELECT @ut = ROUND( @tkl, @Decs )  
         IF @jVan < @fMt_cien BEGIN  
            SELECT @ma = @tkl  
         END ELSE BEGIN  
            SELECT @me = @tkl  
         END  
         SELECT @tkl = ( @ma - @me ) / CONVERT( FLOAT, 2 ) + @me  
         IF @ut = ROUND( @tkl, @Decs ) BEGIN  
            SELECT @nCount = 51  
            IF ABS( ROUND( @ut, 0 ) ) = @rango BEGIN  
               SELECT @fTir = 0.0  
            END ELSE BEGIN  
               SELECT @fTir = ROUND(@ut,2)  
            END  
         END  
         SELECT @nCount = @nCount + 1  
      END  
     
      IF @nCount <> 52 BEGIN  
         SELECT @fTir = 0.0  
      END  
      IF @cBonosFlot = '1' BEGIN  
         SELECT @tkl = ROUND( @tkl, 7)  
      END  
      /*========================================================================================================*/  
      /* Van                      */  
      /*========================================================================================================*/  
      IF ( 1.0 + @fTir / 100.0 ) = 0.0 BEGIN  
         SELECT @jVan = 0.0  
      END ELSE BEGIN  
         SELECT @jVan   = 0.0  
         SELECT @fDurat = 0.0  
         SELECT @fConvx = 0.0  
         SELECT       @jVan   = SUM( tdflujo / POWER( CONVERT( FLOAT, 1 ) + @tkl / CONVERT( FLOAT, 100 ),  
                                                      DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) ),  
                      @fDurat = SUM( ( tdflujo * DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) /  
                 POWER( CONVERT( FLOAT, 1 ) + @fTir / CONVERT( FLOAT, 100 ),  
                                                      DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) ) ),  
                      @fConvx = SUM( ( tdflujo * DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) *  
                                                      ( ( DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 365 ) ) +  
                                                      CONVERT( FLOAT, 1 ) ) / POWER( CONVERT( FLOAT, 1 ) + @fTir /  
                                                      CONVERT( FLOAT, 100 ), DATEDIFF( DAY, @dFeccal, tdfecven ) /  
                                                      CONVERT( FLOAT, 365 ) ) )  
                FROM  #tmpmdse  
                WHERE tdcupon > @nNumucup  
      END  
      SELECT @fVan = @jVan  
      /*========================================================================================================*/  
      /* Duration y Convexidad                                                                                  */  
      /*========================================================================================================*/  
      SELECT @fDurat = ROUND( @fDurat / @fVan, 8 )  
      SELECT @fConvx = ROUND( ( @fConvx / POWER( CONVERT( FLOAT, 1 ) + @fTir / CONVERT( FLOAT, 100 ),  
                                                 CONVERT( FLOAT, 2 ) ) ) / @fVan, 8 )  
      SELECT @fDurmo = ROUND( @fDurat / ( CONVERT( FLOAT, 1 ) + ( ( @fTir / CONVERT( FLOAT, 100 ) ) / @pervcupano ) ), 8 )  
      /*========================================================================================================*/  
      /* % Valor Par                                                                                            */  
      /*========================================================================================================*/  
      IF @cBonosFlot = '1' BEGIN  
         SELECT @fPvp = ROUND( (@fmt / (((@fVPar/100*@fnominal) * @nValMon))) * 100, 2 )  
         SELECT @fMt = ROUND( ( @fVpar / CONVERT( FLOAT, 100 ) ) * @fNominal * ( @fPvp / CONVERT( FLOAT, 100 ) ) * @nValMon, 0 )  
      END ELSE BEGIN  
         SELECT @fPvp = ROUND( ( @fVan / @fVpar ) * CONVERT( FLOAT, 100 ), 2 )  
--         SELECT @fMt  = ROUND( @fMt, CASE WHEN @ctipo_moneda = '0' THEN @cdecimal ELSE 0 END )  
         SELECT @fMt  = ROUND( @fMt, CASE WHEN @ctipo_moneda = '0' THEN @cdecimal ELSE 0 END )  
      END  
   END  
END  
-- Base de Datos --
GO
