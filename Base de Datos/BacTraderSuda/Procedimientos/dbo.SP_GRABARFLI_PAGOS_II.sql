USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARFLI_PAGOS_II]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABARFLI_PAGOS_II]  (
              
                        @nNumoper NUMERIC (10,0)  ,  -- numero de operaci«n de venta  
                        @nRutcart NUMERIC (09,0)  ,  -- rut de la cartera  
                        @cTipcart NUMERIC (05,0)  ,  -- codigo del tipo de cartera  
                        @nNumdocu NUMERIC (10,0)  ,  -- numero del documento  
                        @nCorrela NUMERIC (03,0)  ,  -- correlativo de la operaci«n  
                        @nNominal NUMERIC (19,4)  ,  -- nominales vENDidos  
                        @nTir     NUMERIC (19,4)  ,  -- tir de venta  
                        @nPvp     NUMERIC (19,2)  ,  -- porcentaje valor par (v)  
                        @nVptirv  FLOAT           ,  -- valor presente a tir de venta(v)  
                        @nVp100   FLOAT           ,  -- valor presente venta en base 100 (v)  
                        @nTasest  NUMERIC (09,4) ,  -- tasa estimada (v)  
                        @nVpar    NUMERIC (19,8) ,  -- valor par (v)            
                        @nNumucup NUMERIC (03,0) ,  -- numero del oltimo cup«n vencido (v)  
                        @nRutcli  NUMERIC (09,0) ,  -- rut del cliente (v)  
                        @nCodcli  NUMERIC (09,0) ,  -- rut del cliente (v)  
                        @cTipcust CHAR (03) ,  -- tipo de custodia  
                        @nForpagi NUMERIC (05,0) ,  -- forma de pago al inicio  
                        @nForpagv  NUMERIC (05,0) ,  -- forma de pago al vencimiento  
                        @cRetiro   CHAR (01) ,  -- tipo de retiro  
                        @cUsuario  CHAR (12) ,  -- usuario  
                        @cTerminal CHAR (12) ,  -- terminal  
                        @cFecvtop CHAR (10) ,  -- fecha de vencimiento del pacto  
                        @nMonpact NUMERIC (3,0) ,  -- moneda del pacto   
                        @nTaspact NUMERIC (9,4) ,  -- tasa del pacto  
                        @nBaspact NUMERIC (3,0) ,  -- base del pacto  
                        @nValinip NUMERIC (19,4) ,  -- valor inicial del pacto en moneda del pacto  
                        @nValvtop NUMERIC (19,04) ,  -- valor vencimiento del pacto en moneda del pacto*  
                        @cInstser CHAR (12) ,  -- serie  
                        @nRutemi NUMERIC (09,00) ,  -- rut del emisor  
                        @nMonemi NUMERIC (03,00) ,  -- moneda de emisi«n  
                        @dFecemi DATETIME , -- fecha de emisi«n  *  
                        @dFecven DATETIME ,  -- feeeeeeeeeeeecha de vcto. *  
                        @nCorrvent NUMERIC (03,0) ,  -- correlativo venta con pacto  
                        @dFecpcup DATETIME ,  -- fecha de proximo cupon  *  
                        @dConvex FLOAT  ,  
                        @dDurmod FLOAT  ,  
                        @dDurmac FLOAT  ,  
                        @cCustodia CHAR (01) ,  
                        @cClavedcv CHAR (15) ,  
                        @fTotalpfe FLOAT  ,  
                        @fTotalcce FLOAT  ,  
                        @codigo_carterasuper  CHAR (01) ,  
                        @tipo_cartera_financiera CHAR (05) ,	-->	CAMBIO DE LARGO 1 A 5 CARACTERES
                        @mercado   CHAR (01) ,  
                        @sucursal   VARCHAR (05) ,  
                        @id_sistema   CHAR (03) ,  
                        @fecha_pagomañana  DATETIME ,  
                        @laminas   CHAR (01) ,  
                        @tipo_inversion   CHAR (01) ,  
                        @cuenta_corriente_inicio CHAR (15) ,  
                        @sucursal_inicio  VARCHAR (05) ,  
                        @cuenta_corriente_final  CHAR (15) ,  
                        @sucursal_final   VARCHAR (05) ,  
                        @observ    CHAR (70)   --falta @nIndCust numeric = 0   
   )  
AS  
BEGIN  
   SET NOCOUNT ON  
 --* variables para obtener datos de la tabla MDDI  
 DECLARE @fcapitalc NUMERIC(19,4) -- capitaldela compra MDDI actual     a tasa compra  
 DECLARE @finteresc NUMERIC(19,4) -- intereses de la compra MDDI actuales a tasa compra  
 DECLARE @freajustc NUMERIC(19,4) -- reajustes de la compra MDDI actuales a tasa compra  
 DECLARE @fcapitalci NUMERIC(19,4) -- capital de la compra MDDI actual     a tasa pacto  
 DECLARE @finteresci NUMERIC(19,4) -- intereses de la compra MDDI actuales a tasa pacto  
 DECLARE @freajustci NUMERIC(19,4) -- reajustes de la compra MDDI actuales a tasa pacto  
 DECLARE @fNominal NUMERIC(19,4) -- nominales disponibles MDDI actuales   
 DECLARE @ncapitalc NUMERIC(19,4) -- nuevo capital disponible a tasa compra  
 DECLARE @ninteresc NUMERIC(19,4) -- nuevos intereses MDDI    a tasa compra  
 DECLARE @nreajustc NUMERIC(19,4) -- nuevos reajustes MDDI    a tasa compra  
 DECLARE @ncapitalci NUMERIC(19,4) -- nuevo capital disponible a tasa pacto  
 DECLARE @ninteresci NUMERIC(19,4) -- nuevos intereses MDDI    a tasa pacto  
 DECLARE @nreajustci NUMERIC(19,4) -- nuevos reajustes MDDI    a tasa pacto   
 DECLARE @ctipoper CHAR(03) -- tipo operaci«n 'cp' « 'ci'  
 DECLARE @fFactor FLOAT  
 DECLARE @xFactor FLOAT  
   
 --* variables para obtener datos de la tabla MDCP / MDCI  
 DECLARE @fcapitalo NUMERIC(19,4) -- capital de la compra a tasa compra  
 DECLARE @fintereso NUMERIC(19,4) -- intereses de la compra a tasa compra  
 DECLARE @freajusto NUMERIC(19,4) -- reajustes de la compra a tasa compra  
 DECLARE @fNominalo NUMERIC(19,4) -- nominales originales  
 DECLARE @fcapitaloci NUMERIC(19,4) -- capital de la compra   a tasa pacto  
 DECLARE @finteresoci NUMERIC(19,4) -- intereses de la compra a tasa pacto  
 DECLARE @freajustoci NUMERIC(19,4) -- reajustes de la compra a tasa pacto  
 DECLARE @fNominalp NUMERIC(19,4) -- nominal $$ de la ci  
 DECLARE @fvalcomp NUMERIC(19,4) -- capital $$  
 DECLARE @fvalcompori NUMERIC(19,4) -- capital $$  
 DECLARE @fvalcomu NUMERIC(19,4) -- capital um  
 DECLARE @ncapitalo NUMERIC(19,4) -- nuevo capital de la compra   a tasa compra  
 DECLARE @nintereso NUMERIC(19,4) -- nuevo intereses de lacompra a tasa compra  
 DECLARE @nreajusto NUMERIC(19,4) -- nuevo reajustes de la compra a tasa compra  
 DECLARE @nNominalp  NUMERIC(19,0)   -- nuevo capital nominal $$ ci  
 DECLARE @ncapitaloci NUMERIC(19,4) -- nuevo capital de la compra   a tasa pacto  
 DECLARE @ninteresoci NUMERIC(19,4) -- nuevo intereses de la compra a tasa pacto  
 DECLARE @nreajustoci NUMERIC(19,4)   -- nuevo reajustes de la compra a tasa pacto  
 DECLARE @nvalcomuo NUMERIC(19,4) -- nuevo capital um MDCP original  
 DECLARE @nvalcompo NUMERIC(19,4) -- nuevo capital $$ MDCP original  
 DECLARE @nvalcompvo NUMERIC(19,4) -- capital $$ venta  
 DECLARE @nvalcomuvo NUMERIC(19,4) -- capital um venta  
 DECLARE @fvalcompo NUMERIC(19,4) -- capital $$ venta  
 DECLARE @fvalcomuo NUMERIC(19,4) -- capital um venta  
 DECLARE @nfeccompo      DATETIME  
 DECLARE @nTircompo      NUMERIC(8,4)  
 DECLARE @nVparo         NUMERIC(19,4)  
 DECLARE @nPvparo        NUMERIC(8,4)  
 --* datos referenciales en regla 3  
 DECLARE @nvptirc       NUMERIC(19,4) -- valor presente a tir compra en funcion de los nomimales intermediados  
 DECLARE @nvptirci      NUMERIC(19,4) -- valor presente a tasa de compra con pacto  en funcion de los nomimales intermediados  
 DECLARE @nNumucupc     NUMERIC(3,0) -- numero del ultimo cupon vencido a la fecha de compra  
 --* datos complementarios  
 DECLARE @nNumdocuo     NUMERIC(10,0) -- numero de documento original  
 DECLARE @nCorrelao     NUMERIC(3,0) -- correlativo original  
 DECLARE @cmascara      CHAR(12) -- serie generica del instrumento  
 DECLARE @ncodigo       NUMERIC(3,0) -- c«digo de la familia  
 DECLARE @cseriado      CHAR(1)  -- indica si es seriado o no  
 DECLARE @ntasemi       NUMERIC(9,4) -- tasa de emisi«n  
 DECLARE @nbasemi       NUMERIC(3,0)    -- base emisi«n  
 --** base de emisi¢n  
 DECLARE @chora        VARCHAR(15) -- hora  
 DECLARE @dfecpro      DATETIME -- fecha de proceso  
 DECLARE @dfecvtop     DATETIME -- fecha de vencimiento del pacto  
 DECLARE @cok          CHAR(1)  
 DECLARE @nTirc        NUMERIC(08,04) -- tir de compra.  
 DECLARE @dfeccomp     DATETIME -- fecha de compra.  
 DECLARE @dfecucup     DATETIME -- ultimo cup«n pagado  
 DECLARE @nvalcomp     NUMERIC(19,04) -- valor de compra.  
 DECLARE @nvalcompori  NUMERIC(19,04) -- valor de compra.  
 DECLARE @nvalcomu     NUMERIC(19,04) -- valor de compra um.  
 DECLARE @nvalmon      NUMERIC(19,04) -- valor de moneda (pacto)  
 DECLARE @fvalvenc     NUMERIC(19,4) -- capital um nuevo will  
 DECLARE @nvalvenc     NUMERIC(19,4)   -- nuevo reajustes de la compra a tasa pacto nuevo will  
 DECLARE @vNominal     NUMERIC(19,4)  
 DECLARE @fvptirc      NUMERIC(19,4)  
  
 SELECT @nNominalp = 0.0     ,  
        @nvalmon   = 1.0     ,  
        @chora     = CONVERT(CHAR(15),GETDATE(),114)  
 SELECT @dfecpro  = acfecproc FROM MDAC  
  
 IF @nMonpact=999  
  SELECT @nValvtop = ROUND(@nValvtop,0)  
 ELSE  
  SELECT @nvalmon = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nMonpact AND vmfecha=@dfecpro  
                  
 SELECT @dfecvtop = CONVERT(DATETIME,@cFecvtop,101)  
  
 SELECT @fNominal   = vinominal  ,    
        @fvptirc    = vivptirc  
 FROM MDVI  
 WHERE virutcart = @nRutcart AND vinumdocu = @nNumdocu AND vicorrela = @nCorrela AND vinumoper = @nNumoper  
  
 SELECT @nNominal = @fNominal - @nNominal     
  
 SELECT @fFactor    = 1    --1.0 - ( @nNominal / @fNominal )  
 SELECT @xFactor    = @nNominal / @fNominal  
  
 DECLARE @vinominal NUMERIC (19,4)  
 DECLARE @vivptirc  NUMERIC (19,4)  
 DECLARE @vivptirv  NUMERIC (19,4)  
 DECLARE @vivptirvi  NUMERIC (19,4)  
 DECLARE @vivalinip NUMERIC (19,4)  
 DECLARE @vivalvenp NUMERIC (19,4)  
 DECLARE @vptirvi  NUMERIC (19,4)  
 DECLARE @vivalcomu NUMERIC (19,4)  
 DECLARE @vivalcomp NUMERIC (19,4)  
 DECLARE @vicapitalv NUMERIC (19,4)  
 DECLARE @viinteresv NUMERIC (19,4)  
 DECLARE @vireajustv NUMERIC (19,4)  
 DECLARE @vicapitalvi NUMERIC (19,4)  
 DECLARE @viinteresvi NUMERIC (19,4)  
 DECLARE @vireajustvi NUMERIC (19,4)  
 DECLARE @vivalvent  NUMERIC (19,4)  
 DECLARE @vivalvemu  NUMERIC (19,4)  
 DECLARE @vivpvent   NUMERIC (19,4)  
 DECLARE @valor_compra_original NUMERIC (19,4)  
 DECLARE @valor_compra_um_original NUMERIC (19,4)  
 DECLARE @vivalvenc  NUMERIC (19,4)  
 DECLARE @vivcompori NUMERIC (19,4)  
  
 DECLARE @vinominal2 NUMERIC (19,4)  
 DECLARE @vivptirc2  NUMERIC (19,4)  
 DECLARE @vivptirv2  NUMERIC (19,4)  
 DECLARE @vivptirvi2  NUMERIC (19,4)  
 DECLARE @vivalinip2 NUMERIC (19,4)  
 DECLARE @vivalvenp2 NUMERIC (19,4)  
 DECLARE @vptirvi2  NUMERIC (19,4)  
 DECLARE @vivalcomu2 NUMERIC (19,4)  
 DECLARE @vivalcomp2 NUMERIC (19,4)  
 DECLARE @vicapitalv2 NUMERIC (19,4)  
 DECLARE @viinteresv2 NUMERIC (19,4)  
 DECLARE @vireajustv2 NUMERIC (19,4)  
 DECLARE @vicapitalvi2 NUMERIC (19,4)  
 DECLARE @viinteresvi2 NUMERIC (19,4)  
 DECLARE @vireajustvi2 NUMERIC (19,4)  
 DECLARE @vivalvent2  NUMERIC (19,4)  
 DECLARE @vivalvemu2  NUMERIC (19,4)  
 DECLARE @vivpvent2   NUMERIC (19,4)  
 DECLARE @valor_compra_original2 NUMERIC (19,4)  
 DECLARE @valor_compra_um_original2 NUMERIC (19,4)  
 DECLARE @vivalvenc2  NUMERIC (19,4)  
 DECLARE @vivcompori2 NUMERIC (19,4)  
  
/*  
 UPDATE pagos_fli   
 SET    panominal = panominal * @xfactor,  
 pavpresen = pavpresen * @xfactor  
 WHERE  parutcart = @nRutcart AND panumdocu=@nNumdocu AND pacorrela=@nCorrela AND panumoper=@nNumoper  
*/  
 SELECT @vinominal = vinominal ,  
        @vivptirc  = vivptirc ,  
        @vivptirv  = vivptirv ,  
        @vivalinip  = vivalinip,   
        @vivalvenp  = vivalvenp ,  
 @vivptirvi  = vivptirvi ,  
        @vivalcomu  = vivalcomu ,  
 @vivalcomp  = vivalcomp ,  
 @vicapitalv = vicapitalv ,  
 @viinteresv = viinteresv ,  
 @vireajustv = vireajustv ,  
 @vicapitalvi= vicapitalvi,  
 @viinteresvi = viinteresvi ,  
 @vireajustvi = vireajustvi ,  
 @vivalvent  = vivalvent  ,  
 @vivalvemu  = vivalvemu  ,  
 @vivpvent   = vivpvent ,  
 @valor_compra_original = valor_compra_original ,  
 @valor_compra_um_original = valor_compra_um_original ,  
 @vivalvenc  = vivalvenc,  
        @vivcompori = vivcompori  
 FROM MDVI  
 WHERE  virutcart=@nRutcart AND vinumdocu=@nNumdocu AND vicorrela=@nCorrela AND vinumoper=@nNumoper  
  
 UPDATE MDVI  
 SET    vinominal = vinominal * @xFactor,  
        vivptirc  = vivptirc * @xFactor,  
        vivptirv  = vivptirv * @xFactor,  
        vivalinip  = vivalinip - @nvptirv,  --* @xFactor,  
        vivalvenp  = vivalvenp - @nvptirv,  --* @xFactor,  
 vivptirvi  = vivptirvi * @xFactor,  
        vivalcomu  = vivalcomu * @xFactor,  
 vivalcomp  = vivalcomp * @xFactor,  
 vicapitalv = vicapitalv * @xFactor,  
 viinteresv = viinteresv * @xFactor,  
 vireajustv = vireajustv * @xFactor,  
 vicapitalvi= vicapitalvi * @xFactor,  
 viinteresvi = viinteresvi * @xFactor,  
 vireajustvi = vireajustvi * @xFactor,  
 vivalvent  = vivalvent   * @xFactor,  
 vivalvemu  = vivalvemu  * @xFactor,  
 vivpvent   = vivpvent * @xFactor,  
 valor_compra_original = valor_compra_original * @xFactor,  
 valor_compra_um_original = valor_compra_um_original * @xFactor,  
 vivalvenc  = vivalvenc * @xFactor  
  
 WHERE  virutcart=@nRutcart AND vinumdocu=@nNumdocu AND vicorrela=@nCorrela AND vinumoper=@nNumoper  
  
 SELECT @vinominal2 = vinominal ,  
        @vivptirc2  = vivptirc ,  
        @vivptirv2  = vivptirv ,  
        @vivalinip2  = vivalinip,   
        @vivalvenp2  = vivalvenp ,  
 @vivptirvi2  = vivptirvi ,  
        @vivalcomu2  = vivalcomu ,  
 @vivalcomp2  = vivalcomp ,  
 @vicapitalv2 = vicapitalv ,  
 @viinteresv2 = viinteresv ,  
 @vireajustv2 = vireajustv ,  
 @vicapitalvi2= vicapitalvi,  
 @viinteresvi2 = viinteresvi ,  
 @vireajustvi2 = vireajustvi ,  
 @vivalvent2  = vivalvent  ,  
 @vivalvemu2  = vivalvemu  ,  
 @vivpvent2   = vivpvent ,  
 @valor_compra_original2 = valor_compra_original ,  
 @valor_compra_um_original2 = valor_compra_um_original ,  
 @vivalvenc2  = vivalvenc  
  
  FROM MDVI  
 WHERE  virutcart=@nRutcart AND vinumdocu=@nNumdocu AND vicorrela=@nCorrela AND vinumoper=@nNumoper  
  
 SELECT @vinominal = @vinominal  - @vinominal2,  
        @vivptirc  = @vivptirc   - @vivptirc2,  
        @vivptirv  = @vivptirv   - @vivptirv2 ,  
        @vivalinip  = @vivalinip - @vivalinip2,  
        @vivalvenp  = @vivalvenp - @vivalvenp2 ,  
 @vivptirvi  = @vivptirvi - @vivptirvi2 ,  
        @vivalcomu  = @vivalcomu - @vivalcomu2 ,  
 @vivalcomp  = @vivalcomp - @vivalcomp2 ,  
 @vicapitalv = @vicapitalv - @vicapitalv2,  
 @viinteresv = @viinteresv - @viinteresv2,  
 @vireajustv = @vireajustv - @vireajustv2,  
 @vicapitalvi = @vicapitalvi - @vicapitalvi2,  
 @viinteresvi = @viinteresvi - @viinteresvi2,  
 @vireajustvi = @vireajustvi - @vireajustvi2,  
 @vivalvent  = @vivalvent  - @vivalvent2 ,  
 @vivalvemu  = @vivalvemu  - @vivalvemu2  ,  
 @vivpvent   = @vivpvent   - @vivpvent2 ,  
 @valor_compra_original = @valor_compra_original - @valor_compra_original2 ,  
 @valor_compra_um_original = @valor_compra_um_original - @valor_compra_um_original2,  
 @vivalvenc  = @vivalvenc - @vivalvenc2 ,  
        @nvptirc    = @vicapitalv + @viinteresv + @vireajustv,  
        @nvptirci   = @vicapitalvi+ @viinteresvi + @vireajustvi  
  
 UPDATE MDDI  
 SET    dinominal  = dinominal + @vinominal   ,  
        dicapitalc = dicapitalc + @vicapitalv    ,  
        diinteresc = diinteresc + @viinteresv    ,  
        direajustc = direajustc + @vireajustv    ,  
        divptirc   = divptirc   + @nvptirc       ,  
        dicapitaci = dicapitaci + @vicapitalvi    ,  
        diintereci = diintereci + @viinteresvi    ,  
        direajusci = direajusci + @vireajustvi    ,  
        divptirci  = divptirci   + @nvptirci     
 WHERE dirutcart=@nRutcart AND dinumdocu=@nNumdocu AND dicorrela=@nCorrela  
  
 UPDATE MDCP  
    SET  cpnominal                = cpnominal +  @vinominal   ,  
         cpvalcomp                = cpvalcomp +  @vivalcomp              ,  
         cpvalcomu                = cpvalcomu +  @vivalcomu               ,  
         cpcapitalc               = cpcapitalc + @vicapitalv               ,  
         cpinteresc               = cpinteresc + @viinteresv              ,  
         cpreajustc               = cpreajustc + @vireajustv              ,  
         cpvptirc                 = cpvptirc   + @nvptirc          ,  
         cpvcompori               = @vivcompori       ,   
         valor_compra_um_original = valor_compra_um_original + @valor_compra_um_original              ,  
         valor_compra_original    = valor_compra_original    + @valor_compra_original              ,  
         cpvalvenc                = cpvalvenc  + @vivalvenc      
     WHERE cprutcart=@nRutcart AND cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela  
  
 DELETE FROM MDVI   
 WHERE  virutcart=@nRutcart AND vinumdocu=@nNumdocu AND vicorrela=@nCorrela AND vinumoper=@nNumoper  
        AND vinominal=0    
  
  
 IF @@error=0  
                SELECT @cok = '1'  
 ELSE  
  SELECT @cok = '0'  
 SELECT @cok  
   SET NOCOUNT OFF  
END  
GO
