USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARVI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABARVI]  (
              
                        @nNumoper NUMERIC (10,0)  ,  -- numero de operaci«n de venta  
                        @nRutcart NUMERIC (09,0)  ,  -- rut de la cartera  
                        @cTipcart NUMERIC (05,0)  ,  -- codigo del tipo de cartera  
                        @nNumdocu NUMERIC (10,0)  ,  -- numero del documento  
                        @nCorrela NUMERIC (03,0)  ,  -- correlativo de la operaci«n  
                        @nNominal NUMERIC (19,4)  ,  -- nominales vENDidos  
                        @nTir  NUMERIC (19,4)  ,  -- tir de venta  
                        @nPvp  NUMERIC (19,2)  ,  -- porcentaje valor par (v)  
                        @nVptirv FLOAT  ,  -- valor presente a tir de venta(v)  
                        @nVp100  FLOAT  ,  -- valor presente venta en base 100 (v)  
                        @nTasest NUMERIC (09,4) ,  -- tasa estimada (v)  
                        @nVpar  NUMERIC (19,8) ,  -- valor par (v)            
                        @nNumucup NUMERIC (03,0) ,  -- numero del oltimo cup«n vencido (v)  
                        @nRutcli NUMERIC (09,0) ,  -- rut del cliente (v)  
                        @nCodcli NUMERIC (09,0) ,  -- rut del cliente (v)  
                        @cTipcust CHAR (03) ,  -- tipo de custodia  
                        @nForpagi NUMERIC (05,0) ,  -- forma de pago al inicio  
                        @nForpagv NUMERIC (05,0) ,  -- forma de pago al vencimiento  
                        @cRetiro CHAR (01) ,  -- tipo de retiro  
                        @cUsuario CHAR (12) ,  -- usuario  
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
                        @codigo_carterasuper  CHAR (06) ,  
                        @tipo_cartera_financiera CHAR (06) ,  
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
                        @observ  CHAR (70)   ,--falta @nIndCust numeric = 0   
					    @nTcIncio NUMERIC(19,4),  
					    @id_libro CHAR(06),          
					    @nTirTran NUMERIC(19,4),  
					    @nVpTran NUMERIC(19,4),  
					    @nDifTran_MO NUMERIC(19,4),  
					    @nDifTran_CLP NUMERIC(19,0) )
AS  
BEGIN  
   SET NOCOUNT ON  

--ITAU---------------------------------------
DECLARE 
						@Ejecutivo   INTEGER = 0,
						@cTipoCustodia INTEGER = 0,
						@pago_hoy CHAR(1) = 'H',
						@subforma NUMERIC(5) = 0,
						@subforma2 NUMERIC(5) = 0,
						@nTasCFdo  NUMERIC (9,4)

--ITAU---------------------------------------


SET  @Ejecutivo   = 0
SET @cTipoCustodia = 0
SET @pago_hoy  = 'H'
SET @subforma  = 0
SET @subforma2 = 0
SET @nTasCFdo  =0

     
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

 --ITAU-----------------------------------

	 DECLARE @nValCont NUMERIC(19,04) -- valor contable
	 DECLARE @fValCont NUMERIC(19,04) -- valor contable
	 DECLARE @fValContv NUMERIC(19,04) -- valor contable Venta
	 DECLARE @numcontrato NUMERIC(10)--numero contrato
	 DECLARE @nVptircv NUMERIC(19,4)
	 DECLARE @fvptirc NUMERIC(19,4)

--ITAU-----------------------------------

-- VB+-28/07/2009  
 DECLARE @fVPtirC_VI FLOAT  --> Creado para actualizar correctamente en la MDVI  
-- VB+-  
  
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
 DECLARE @nTirc       NUMERIC(08,04) -- tir de compra.  
 DECLARE @dfeccomp     DATETIME -- fecha de compra.  
 DECLARE @dfecucup     DATETIME -- ultimo cup«n pagado  
 DECLARE @nvalcomp     NUMERIC(19,04) -- valor de compra.  
 DECLARE @nvalcompori  NUMERIC(19,04) -- valor de compra.  
 DECLARE @nvalcomu     NUMERIC(19,04) -- valor de compra um.  
 DECLARE @nvalmon      NUMERIC(19,04) -- valor de moneda (pacto)  
 DECLARE @fvalvenc     NUMERIC(19,4) -- capital um nuevo will  
 DECLARE @nvalvenc     NUMERIC(19,4)   -- nuevo reajustes de la compra a tasa pacto nuevo will  
 DECLARE @nRedondeo    NUMERIC(3)  
 DECLARE @nvalmonPact  NUMERIC(19,04)  
 DECLARE @cMnMx        CHAR(1)  
  
 
 --ITAU-------------------------------
	select @numcontrato = 0
 --ITAU-------------------------------

 SELECT @nNominalp = 0.0     ,  
        @nvalmon   = 1.0     ,  
 @nvalmonPact = 1.0   ,  
        @chora     = CONVERT(CHAR(15),GETDATE(),114)  
 SELECT @dfecpro  = acfecproc FROM MDAC  
  
 IF @nMonpact=999  
  SELECT @nValvtop = ROUND(@nValvtop,0)  
 ELSE  
  IF @nMonpact = 13   
   SELECT @nvalmon = 1  
  ELSE   
  SELECT @nvalmon = vmvalor   
    FROM VIEW_VALOR_MONEDA   
   WHERE vmcodigo=@nMonpact   
     AND vmfecha=@dfecpro  
    
    
  
 IF @nMonemi = 13  
  SELECT @nRedondeo = mndecimal FROM view_moneda where mncodmon = @nMonemi  
 ELSE  
 SELECT @nRedondeo = 0  
  
 SELECT @cMnMx = ''  
 SELECT @cMnMx = mnmx from view_moneda WHERE mncodmon = @nMonpact  
  
 If @cMnMx = 'C' AND @nMonpact <> 13 BEGIN  
 SELECT @nvalmonPact = @nTcIncio  
 END  
  
 SELECT @dfecvtop = CONVERT(DATETIME,@cFecvtop,101)  
 SELECT @fcapitalc  = dicapitalc  ,  
        @finteresc  = diinteresc  ,  
        @freajustc  = direajustc  ,  
        @fNominal   = dinominal   ,  
        @fcapitalci = dicapitaci  ,  
        @finteresci = diintereci  ,         
        @freajustci = direajusci  ,  
        @ctipoper   = RTRIM(ditipoper), 

 --ITAU---------------------------------------------------- 
		@fValCont  = Valor_Contable,
		@fvptirc = divptirc,
 --ITAU----------------------------------------------------
        @nvptirc    = divptirc   ,  
 @fVPtirC_VI = divptirc     
 FROM MDDI  
 WHERE dirutcart = @nRutcart AND dinumdocu=@nNumdocu AND dicorrela=@nCorrela  
 SELECT @fFactor    = 1.0 - ( @nNominal / @fNominal )  
 SELECT @xFactor    = @nNominal / @fNominal  
 SELECT @ncapitalc  = ROUND(@fcapitalc * @fFactor,@nRedondeo)  
 SELECT @ninteresc  = ROUND(@finteresc * @fFactor,@nRedondeo)  
 SELECT @nreajustc  = ROUND(@freajustc * @fFactor,@nRedondeo)  
 SELECT @ncapitalci = ROUND(@fcapitalci * @fFactor,@nRedondeo)  
 SELECT @ninteresci = ROUND(@finteresci * @fFactor,@nRedondeo)  
 SELECT @nreajustci = ROUND(@freajustci * @fFactor,@nRedondeo)  
 SELECT @nvptirc    = ROUND(@nvptirc    * @ffactor,@nRedondeo)

 --ITAU----------------------------------------------------

	 SELECT @nValCont = ROUND(@fValCont * @fFactor,@nRedondeo)--29/08/2001

--ITAU----------------------------------------------------
   
 SELECT @nvptirci   = @ncapitalci + @ninteresci + @nreajustci  
  
 SELECT @fVPtirC_VI = (@fVPtirC_VI-@nvptirc) --> Valor Para la mdvi   
  
 UPDATE MDDI  
 SET    dinominal  = @fNominal - @nNominal    ,  
        dicapitalc = @ncapitalc     ,  
        diinteresc = @ninteresc     ,  
        direajustc = @nreajustc     ,  
--        divptirc   = @ncapitalc + @ninteresc + @nreajustc  ,  
        divptirc   = @nvptirc      ,  
        dicapitaci = @ncapitalci     ,  
        diintereci = @ninteresci     ,  
        direajusci = @nreajustci     ,  
        divptirci  = @nvptirci   
    WHERE dirutcart=@nRutcart AND dinumdocu=@nNumdocu AND dicorrela=@nCorrela  
   
 SELECT @nvalcomp = 0.0 ,  
        @nvalcomu = 0.0 ,  
        @dfecucup = ''  ,  
        @fvalvenc = 0.0 ,    ---nuevo will    
        @nvalvenc = 0.0      ---nuevo will    
 IF @ctipoper='CP'  
 BEGIN  
  SELECT  @fcapitalo   = cpcapitalc ,  
          @fintereso   = cpinteresc ,  
          @freajusto   = cpreajustc ,  
          @fcapitaloci = 0          ,  
          @finteresoci = 0          ,  
          @freajustoci = 0          ,  
          @fNominal    = cpnominal  ,  
          @nNumdocuo   = cpnumdocuo ,  
          @nCorrelao   = cpcorrelao ,  
          @cInstser    = cpinstser  ,  
          @cmascara    = cpmascara  ,  
          @ncodigo     = cpcodigo   ,  
          @cseriado    = cpseriado  ,  
          @dFecemi     = cpfecemi   ,  
          @dFecven     = cpfecven   ,  
          @nNumucupc   = cpnumucup  ,  
          @nTirc       = cptircomp  ,  
          @dfeccomp    = cpfeccomp  ,  
          @fvalcomp    = cpvalcomp  ,  
          @fvalcomu    = cpvalcomu  ,  
          @dfecucup    = cpfecucup  ,  
          @fvalcompori = cpvcompori ,  
          @fvalcomuo   = valor_compra_um_original  ,  
          @fvalcompo   = valor_compra_original     ,  
          @nfeccompo   = fecha_compra_original     ,  
          @nTircompo   = tir_compra_original       ,  
          @nVparo      = valor_par_compra_original ,  
          @nPvparo     = porcentaje_valor_par_compra_original,  

--ITAU------------------------------------------
		  @fValCont  = Valor_Contable  ,
		  @numcontrato =  isnull(numero_contrato,0),
		  @fvptirc = cpvptirc,
--ITAU------------------------------------------

          @fvalvenc    = cpvalvenc --nuevo will      
  FROM MDCP     
  WHERE cprutcart=@nRutcart AND cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela  
  SELECT @ncapitalc  = ROUND(@fcapitalc   * @fFactor,@nRedondeo)  
  SELECT @ninteresc  = ROUND(@finteresc   * @fFactor,@nRedondeo)  
  SELECT @nreajustc  = ROUND(@freajustc   * @fFactor,@nRedondeo)  
  SELECT @nvalcomp   = ROUND(@fvalcomp    * @fFactor,@nRedondeo)  
  SELECT @nvalcompori= ROUND(@fvalcompori * @fFactor,@nRedondeo)  
  SELECT @nvalcomu   = ROUND(@fvalcomu    * @fFactor,4)  
  SELECT @nvalcomuo  = ROUND(@fvalcomuo * @fFactor,4)     --29/01/2001  
  SELECT @nvalcompo  = ROUND(@fvalcompo * @fFactor,@nRedondeo)     --29/01/2001  

  --ITAU-------------------------------------------------
	SELECT @nValCont = ROUND(@fValCont * @fFactor,@nRedondeo)--17/08/2001
--ITAU-------------------------------------------------

  SELECT @nvalvenc   = round(@fvalvenc    * @ffactor,@nRedondeo)   -- nuevo will   
  
  UPDATE MDCP  
    SET  cpnominal                = @fNominal - @nNominal   ,  
         cpvalcomp                = @nvalcomp               ,  
         cpvalcomu                = @nvalcomu               ,  
         cpcapitalc               = @ncapitalc              ,  
         cpinteresc               = @ninteresc              ,  
         cpreajustc            = @nreajustc              ,  
--         cpvptirc                 = @nvalcomp + @ninteresc + @nreajustc ,  
         cpvptirc                 = @nvptirc      ,  
         cpvcompori               = @nvalcompori            ,  
         valor_compra_um_original = @nvalcomuo              ,  
         valor_compra_original    = @nvalcompo              ,  
         cpvalvenc                = @nvalvenc    -- nuevo will     
     WHERE cprutcart=@nRutcart AND cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela  
 END  
        ELSE  
 BEGIN  
  SELECT @fcapitalo    = cicapitalc       ,  
         @fintereso    = ciinteresc       ,  
         @freajusto    = cireajustc       ,  
         @fcapitaloci  = cicapitalci      ,  
         @finteresoci  = ciinteresci      ,  
         @freajustoci  = cireajustci      ,  
         @fNominal     = cinominal        ,  
         @nNumdocuo    = cinumdocuo       ,  
         @nCorrelao    = cicorrelao       ,  
         @cInstser     = ciinstser        ,  
         @cmascara     = cimascara        ,  
         @ncodigo      = cicodigo         ,  
         @cseriado     = ciseriado        ,  
         @dFecemi      = cifecemi         ,  
         @dFecven      = cifecven         ,  
         @nTirc        = citircomp        ,  
         @nNumucupc    = cinumucup        ,  
         @fNominalp    = cinominalp       ,  
         @fvalcomuo    = valor_compra_um_original  ,  
         @nvalcomuo    = valor_compra_um_original  ,  
         @fvalcomuo    = valor_compra_um_original  ,  
         @fvalcompo    = valor_compra_original     ,  
         @nvalcompo    = valor_compra_original     ,  
         @nfeccompo    = fecha_compra_original     ,  
         @nTircompo    = tir_compra_original       ,  
         @nVparo       = valor_par_compra_original , 
		 
--ITAU------------------------------------------
		 @fValCont  = Valor_Contable,
--ITAU------------------------------------------		 
		  
         @nPvparo      = porcentaje_valor_par_compra_original  
/* falta @tipo_inversion = tipo_inversion,  
  @tipo_cartera_financiera = tipo_cartera_financiera  
*/  
        FROM MDCI  
        WHERE cirutcart=@nRutcart AND cinumdocu=@nNumdocu AND cicorrela=@nCorrela  
  SELECT @xFactor   = @nNominal /  @fNominal  
  SELECT @nNominalp = ROUND(@fNominalp * @xFactor,@nRedondeo)  
  SELECT @nvalcomu  = ROUND(@fvalcomu  * @fFactor,4)  
--**  UPDATE MDCI SET  
--**   cinominalp = @fNominalp - @nNominalp  
--**  WHERE cirutcart=@nRutcart AND cinumdocu=@nNumdocu AND cicorrela=@nCorrela  
 END  
 /*------------------------------------------------------  
   nominal, capital, intereses y reajustes a MDMO y MDVI   
        --------------------------------------------------------*/  
 SELECT @fFactor     = @nNominal / @fNominal  
 SELECT @ncapitalo   = @fcapitalo   - @ncapitalc  
 SELECT @nintereso   = @fintereso   - @ninteresc  
 SELECT @nreajusto   = @freajusto   - @nreajustc  
 SELECT @nvptirc     = @ncapitalo+@nintereso+@nreajusto --> Se debe Ajustar  
 SELECT @ncapitaloci = 0  
 SELECT @ninteresoci = 0  
 SELECT @nreajustoci = 0  
-- SELECT @nvptirci = 0  
 SELECT @nvalcomp    = @fvalcomp    - @nvalcomp  
 SELECT @nvalcomu    = ROUND( @fvalcomu - @nvalcomu , 4)  
 SELECT @fvalcompo   = @fvalcompo    - @nvalcompo  
 SELECT @fvalcomuo   = ROUND( @fvalcomuo - @nvalcomuo , 4)  
 SELECT @nvalvenc    = @fvalvenc - @nvalvenc     -- nuevo will  
 
 --ITAU----------------------------------------------------
		SELECT @fValContv = ROUND( @fvalcont - @nvalcont , 4)
		SELECT @nVptircv = ROUND(  @fvptirc - @nvptirc , 4)
 --ITAU----------------------------------------------------

--** SELECT @nNominalp = @fNominalp   - @nNominalp  
 IF @cseriado='S'  
  SELECT @nRutemi = serutemi ,  
    @nMonemi = semonemi ,  
         @ntasemi = SETasemi ,  
         @nbasemi = sebasemi  
  FROM VIEW_SERIE  
  WHERE semascara=@cInstser  
 ELSE  
  SELECT @nRutemi = nsrutemi ,  
         @nMonemi = nsmonemi ,  
         @ntasemi = nstasemi ,  
         @nbasemi = nsbasemi  
  FROM VIEW_NOSERIE  
  WHERE @nRutcart=nsrutcart AND @nNumdocuo=nsnumdocu AND @nCorrelao= nscorrela  
 --******************************--  
 --** grabar movimiento diario **--  
 --******************************--  
 INSERT INTO MDMO  
   (  
               mofecpro ,  
               morutcart ,  
               motipcart ,  
               monumdocu ,  
               mocorrela ,  
               monumdocuo ,  
               mocorrelao ,                     
               monumoper ,  
               motipoper ,  
               motipopero ,  
               moinstser ,  
               momascara ,  
               mocodigo ,  
               moseriado ,  
               mofecemi ,  
               mofecven ,  
               morutemi ,  
               momonemi ,  
               motasemi ,  
               mobasemi ,  
               monominal ,  
               movpresen ,  
               monumucup ,  
               motir  ,  
               mopvp  ,            
               movpar  ,  
               motasest ,  
               mofecinip ,  
               mofecvenp ,  
               movalinip ,                      
               movalvenp ,  
               motaspact ,  
               mobaspact ,  
               momonpact ,  
               moforpagi ,                
               moforpagv ,  
               mocondpacto ,  
               morutcli ,  
               mocodcli ,  
               motipret ,  
               mohora  ,  
               mousuario ,  
               moterminal ,  
               mocapitali ,  
               movpreseni ,  
               mocapitalp ,  
               movpresenp ,  
               monominalp ,  
               movalcomp ,  
               movalcomu ,  
               mointeres ,  
               moreajuste ,  
               movalven ,  
               mocorvent ,  
               modcv  ,  
               moclave_dcv  ,  
               momtopfe ,  
               momtocce        ,  
               fecha_compra_original  ,  
               valor_compra_original  ,  
               valor_compra_um_original ,  
               tir_compra_original  ,  
               valor_par_compra_original ,  
               porcentaje_valor_par_compra_original,  
               codigo_carterasuper  ,  
               tipo_cartera_financiera  ,  
               mercado    ,  
               sucursal   ,  
               id_sistema   ,  
               fecha_pagomañana  ,  
               laminas    ,  
               tipo_inversion   ,  
               cuenta_corriente_inicio  ,  
               sucursal_inicio   ,  
               cuenta_corriente_final  ,  
               sucursal_final          ,  
               moobserv              ,  
               movalvenc ,  
               id_libro,   
			   moTirTran,  
			   moVPTran,  
			   moDifTran_MO,  
			   moDifTran_CLP,

--ITAU---------------------------------------
				Ejecutivo,
				Tipo_Custodia,
				Tasa_Contrato,
				Valor_Contable,
				numero_contrato,
				sub_forma_ini,
				sub_forma_venc,
				movptirc,
				moTasCFdo
--ITAU---------------------------------------
   )  
 VALUES  
   (  
            @dfecpro ,  
            @nRutcart ,  
            @tipo_cartera_financiera  ,  
            @nNumdocu ,  
            @nCorrela ,  
            @nNumdocuo ,  
            @nCorrelao ,  
            @nNumoper ,  
            'VI'  ,  
            @ctipoper       ,  
           @cInstser ,  
            @cmascara ,  
            @ncodigo ,  
            @cseriado ,  
            @dFecemi ,  
            @dFecven ,  
            @nRutemi ,        
            @nMonemi ,  
            ISNULL(@ntasemi,0) ,  
            ISNULL(@nbasemi,0) ,  
            ISNULL(@nNominal,0) ,  
       ISNULL(@nVptirv,0) ,                   
            @nNumucup  ,  
            ISNULL(@nTir,0)  ,                                
            ISNULL(@nPvp,0)  ,  
            ISNULL(@nVpar,0) ,  
            ISNULL(@nTasest,0) ,  
            @dfecpro ,  
            @dfecvtop ,  
            @nValinip ,  
            ISNULL(@nValvtop,0) ,  
            ISNULL(@nTaspact,0) ,  
            ISNULL(@nBaspact,0) ,  
            ISNULL(@nMonpact,0) ,  
            @nForpagi ,   
            @nForpagv ,  
            @cTipcust ,  
            @nRutcli ,             
            @nCodcli        ,  
            @cRetiro ,  
            @chora  ,  
            @cUsuario ,  
            @cTerminal ,  
            @nVptirv ,                  
            @nVptirv ,  
            ISNULL(@nValinip,0) ,  
            ISNULL(@nValinip,0) ,  
            @nNominalp  ,  
            ISNULL(@nvalcomp,0) ,  
            ISNULL(@nvalcomu,0) ,  
            ISNULL(@nintereso,0) ,  
            ISNULL(@nreajusto,0) ,  
            ISNULL(@nValinip,0) ,  
            @nCorrvent  ,  
            @cCustodia  ,  
            @cClavedcv  ,  
            @nTcIncio, --@fTotalpfe  , --VGS  
            @fTotalcce  ,    
            @nfeccompo  ,    
            @fvalcompo   ,  
            @fvalcomuo         ,  
            @nTircompo              ,  
            @nVparo                 ,  
            @nPvparo                ,  
            @codigo_carterasuper  ,  
            @tipo_cartera_financiera ,  
            @mercado   ,  
            @sucursal   ,  
            @id_sistema   ,  
            @fecha_pagomañana  ,  
            @laminas   ,  
            @tipo_inversion   ,  
            @cuenta_corriente_inicio ,  
            @sucursal_inicio  ,  
            @cuenta_corriente_final  ,  
            @sucursal_final         ,  
            @observ                 ,   
            ISNULL(@nvalvenc,0)    ,  
            @id_libro,     
			@nTirTran,  
			@nVpTran,  
			@nDifTran_MO,  
			@nDifTran_CLP,  

--ITAU---------------------------------------

			@Ejecutivo,
			@cTipoCustodia,
			ISNULL(@nTaspact,0),
			@fValContv,
			@numcontrato,
			@subforma,
			@subforma2,
			@nVptircv,
			@nTasCFdo

--ITAU---------------------------------------
   )  
 --******************************--  
 --** agregar ventas con pacto **-- --******************************--  
 INSERT INTO MDVI  
   (  
         virutcart               ,  
         vinumdocu               ,  
         vicorrela               ,  
         vinumoper               ,  
         vitipoper               ,  
         virutcli                ,  
         vicodcli                ,  
         vinominal               ,  
         vivalvent               ,  
         vivalvemu               ,  
         vivvum100               ,      
         vitirvent               ,  
         vitasest                ,  
         vipvpvent               ,  
         vivpvent                ,  
         vifecinip               ,  
         vifecvenp               ,  
         vivalinip               ,  
         vivalvenp               ,  
         vitaspact               ,  
         vibaspact               ,  
         vimonpact               ,  
         vivptirc                ,  
         vivptirci               ,  
         vivptirv                ,  
         vivptirvi               , -- 26  
         vicapitalv              ,  
         viinteresv              ,  
         vireajustv              ,  
         vicapitalvi             , -- 30  
         viinteresvi             ,  
         vireajustvi             ,  
         vinumucupc              ,  
         vinumucupv              ,   
         viinstser               ,  
         virutemi                ,  
         vimonemi                ,  
         vifecemi                ,  
         vifecven                ,  
vicodigo                ,  
         vitircomp               ,  
         vifeccomp               ,  
         vivalcomu               ,  
         vivalcomp               ,  
         viseriado               ,  
         vimascara               ,  
         vinominalp              ,  
         viforpagi               ,  
         viforpagv               ,  
         vicorvent               ,  
          vifecucup              ,  
         vifecpcup               ,  
         vivcompori              ,  
         vidurat                 ,  
         vidurmod                ,  
         viconvex                ,     
         viinteresci             ,  
         vivalinipci             ,  
         vivalvenpci             ,  
         fecha_compra_original   ,  
         valor_compra_original   ,  
         valor_compra_um_original,  
         tir_compra_original     ,  
         valor_par_compra_original ,  
         porcentaje_valor_par_compra_original,  
         codigo_carterasuper     ,  
         tipo_cartera_financiera ,  
         mercado      ,  
         sucursal                ,  
         id_sistema              ,  
         fecha_pagomañana        ,  
         laminas                 ,  
         tipo_inversion          ,  
         cuenta_corriente_inicio ,  
         sucursal_inicio         ,  
         cuenta_corriente_final  ,  
         sucursal_final          ,  
         viintermesv             ,  
         vireajumesv             ,  
         vivalvenc     ,  
         vitcinicio              ,  
         id_libro  ,

--ITAU---------------------------------------
			Ejecutivo,
			Tipo_Custodia,
			Tasa_Contrato,
			Valor_Contable,
			Numero_Contrato,
			viTasCFdo
--ITAU---------------------------------------
   )  
  VALUES  
   (  
         @nRutcart                ,  
         @nNumdocu                ,  
         @nCorrela                ,  
         @nNumoper                ,  
         @ctipoper                ,  
         @nRutcli                 ,  
         @nCodcli                 ,    
         @nNominal                ,  
         @nVptirv                 ,  
         CASE WHEN @cMnMx = 'C' AND @nMonemi = 13 THEN @nVptirv   
       WHEN @cMnMx <> 'C' AND @nMonemi = 13 THEN @nVptirv   
  ELSE ROUND(@nVptirv / @nvalmon,4) END,  
         @nVp100                  ,  
         @nTir                    ,  
         @nTasest                 ,  
         @nPvp                    ,  
         @nVptirv                 ,  
         @dfecpro                 ,  
         @dfecvtop                ,  
         @nValinip                ,  
         @nValvtop                ,  
         @nTaspact                ,  
         @nBaspact                ,  
         @nMonpact                ,  
         @fVPtirC_VI    , --> VB +-28/007/2009 @nvptirc                   
         @nvptirci                ,  
         @nVptirv                 ,  
         CASE WHEN @cMnMx = 'C' THEN ROUND(@nValinip / @nvalmonPact, 4) ELSE @nValinip END ,  
         @nvalcomp                ,  
         @nintereso               ,  
         @nreajusto               ,  
         CASE WHEN @cMnMx = 'C' THEN ROUND(@nValinip / @nvalmonPact, 4) ELSE @nValinip END                ,  
         0                        ,  
         0                        ,  
         @nNumucupc               ,  
         @nNumucup                ,  
         @cInstser                ,  
         @nRutemi                 ,  
         @nMonemi                 ,  
         @dFecemi                 ,  
         @dFecven                 ,  
         @ncodigo                 ,  
         @nTirc                   ,  
         @dfeccomp                ,  
         ISNULL(@nvalcomu,0)      ,  
         ISNULL(@nvalcomp,0)      ,  
         @cseriado                ,  
         @cmascara                ,  
         @nNominalp               ,  
         @nForpagi        ,  
         @nForpagv                ,  
         @nCorrvent      ,  
         @dfecucup                ,  
         @dFecpcup     ,  
--   @nvalcompori  
         0.0                      ,  
         @dDurmac                 ,  
         @dDurmod                 ,     
         @dConvex                 ,  
         0                        ,  
         0                        ,  
         0                        ,  
         @nfeccompo               ,  
         @fvalcompo               ,  
          @fvalcomuo              ,  
         @nTircompo               ,  
         @nVparo                  ,  
         @nPvparo                 ,  
         @codigo_carterasuper     ,  
         @tipo_cartera_financiera ,  
         @mercado                 ,  
         @sucursal                ,  
         @id_sistema              ,  
         @fecha_pagomañana        ,  
         @laminas                 ,  
         @tipo_inversion          ,  
         @cuenta_corriente_inicio ,  
         @sucursal_inicio         ,  
         @cuenta_corriente_final  ,  
         @sucursal_final          ,  
         0                        ,  
         0                        ,  
         @nvalvenc    ,  
         @nTcIncio                ,  
         @id_libro,

--ITAU---------------------------------------
			@Ejecutivo,
			@cTipoCustodia,
			ISNULL(@nTaspact,0) ,
			@fValContv,
			0,
			@nTasCFdo
--ITAU---------------------------------------

)  
--20190104.RCH.LCGP (SE REUTILZA VARIABLE @sucursal_final para identificar las operaciones del tipo VI / LCGP 
IF @sucursal_final='LCGP'
	INSERT INTO LCGP_VI (LCGP_OPERACION,LCGP_CORRELATIVO,LCGP_OPERACION_ORIGINAL,LCGP_CORRELATIVO_ORIGINAL, LCGP_OPERADOR,LCGP_FECHA) 	VALUES (@nNumoper,@nCorrela,@nNumdocu,@nCorrela,@cUsuario,@dfecpro)
--20190104.RCH.LCGP

 IF @@error=0  
   SELECT @cok = '1'  
 ELSE  
   SELECT @cok = '0'  
 SELECT @cok  
   SET NOCOUNT OFF  
END  
GO
