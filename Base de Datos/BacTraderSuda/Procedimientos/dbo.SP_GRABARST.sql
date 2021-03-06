USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARST]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABARST]
   (  @nnumoper             NUMERIC (10,0) , -- numero de operaci½n de venta  
      @nrutcart             NUMERIC (09,0) , -- rut de la cartera  
      @ntipcart             NUMERIC (05,0) , -- codigo del tipo de cartera  
      @nnumdocu             NUMERIC (10,0) , -- numero del  documento  
      @ncorrela             NUMERIC (03,0) , -- correlativo de la operaci½n  
      @nnominal             NUMERIC (19,4) , -- nominales vENDidos  
      @ntir                 NUMERIC (19,4) , -- tir de venta  
      @npvp                 NUMERIC (19,2) , -- porcentaje valor par (v)  
      @nvpar                NUMERIC (19,8) , -- valor par (v)  
      @nvptirv              FLOAT          , -- valor presente a tir de venta (v)  
      @nnumucup             NUMERIC (03,0) , -- numero del œltimo cup½n vencido (v)  
      @nrutcli              NUMERIC (09,0) , -- rut del cliente (v)  
      @ncodcli              NUMERIC (09,0) , -- rut del cliente (v)  
      @cfecpro              DATETIME       , -- fecha de proces o (v)  
      @ntasest              NUMERIC (09,4) , -- tasa estimada (v)  
      @nmonemi              NUMERIC (03,0) , -- moneda del emISor  
      @nrutemi              NUMERIC (09,0) , -- rut del emISor  
      @ntasemi              NUMERIC (09,4) , -- tasa estimada  
      @nbasemi              NUMERIC (03,0) , -- base estimada  
      @ctipcust             CHAR    (01)   , -- tipo de custodia  
      @nforpagi             NUMERIC (05,0) , -- forma de pago  
      @cretiro              CHAR    (01)   , -- tipo de retiro  
      @cusuario             CHAR    (12)   , -- usuario  
      @cterminal            CHAR    (12)   , -- terminal  
      @cmascara             CHAR    (12)   , --  familia del instrumento  
      @cinstser             CHAR    (12)   , -- serie  
      @cgenemi             CHAR    (10)   , -- generico del emISor  
      @cnemomon             CHAR    (05)   , -- generico de la moneda  
      @cfecemi             DATETIME       , -- fecha de emISi½n  
      @cfecven             DATETIME       , -- fecha de venc imiento  
      @ncodigo             NUMERIC (05,0) , -- codigo de la familia  
      @ncorrvent                 INTEGER        , -- correlativo de ventas  
      @clave_dcv                 CHAR(10)       , -- clave dcv  
      @codigo_carterasuper       CHAR(01)       ,  
      @tipo_cartera_financiera   CHAR(05)       ,		-->	CAMBIO LARGO DE 1  A 5 CARACTERES
      @mercado             CHAR (01)      ,  
      @sucursal             VARCHAR (05)   ,  
      @id_sIStema                CHAR (03)      ,  
      @fecha_pagomañana          DATETIME       ,  
      @laminas             CHAR (01)      ,  
      @tipo_inversion            CHAR (01)      ,  
      @observ              CHAR (70)      ,  
      @id_libro    CHAR(06) ,  
      @FechaSorteo               DATETIME       ,  
      @VctoReal                  DATETIME         
  
   )  
AS  
BEGIN  
  
 SET NOCOUNT ON  
  
 DECLARE @nestado   INTEGER  ,  
         @fcontrol  DATETIME ,  
    @dfecvtop  DATETIME ,  
    @cTipoLchr CHAR (01) ,  
    @nRut      NUMERIC (09,0)  
  
  
 DECLARE @ffactor  FLOAT  
 DECLARE @fcapitalc  NUMERIC (19,4) -- capital de la compra MDDI actual  
 DECLARE @finteresc  NUMERIC (19,4) -- intereses de la compra MDDI actuales  
 DECLARE @freajustc  NUMERIC (19,4) -- reajustes de la compra MDDI actuales  
 DECLARE @fnominal  NUMERIC (19,4) -- nominales dISponibles MDDI actuales  
 DECLARE @ncapitalc  NUMERIC (19,4) -- nuevo capital dISponible  
 DECLARE @ninteresc  NUMERIC (19,4) -- nuevos intereses MDDI  
 DECLARE @nreajustc  NUMERIC (19,4) -- nuevos reajustes  MDDI  
 DECLARE @fvptirc  NUMERIC (19,4) -- valor presente MDDI actual  
  
 --* variables para obtener datos de la tabla MDCP  
 DECLARE @fcapitalo    NUMERIC (19,4) -- capital de la compra propia  
 DECLARE @fintereso   NUMERIC (19,4) -- intereses de la compra propia  
 DECLARE @freajusto   NUMERIC (19,4) -- reajustes de la compra propia  
 DECLARE @fnominalo   NUMERIC (19,4) -- nominales originales  
 DECLARE @fvalcomu   NUMERIC (19,4) -- capital  um de la compra propia  
 DECLARE @fvalcomp   NUMERIC (19,4) -- capital $$ de la compra propia  
 DECLARE @ncapitalo    NUMERIC (19,4) -- nuevo capital de la compra MDCP  
 DECLARE @nintereso   NUMERIC (19,4) -- nuevo intereses de la compra MDCP  
 DECLARE @nreajusto    NUMERIC (19,4) -- nuevo reajustes de la compra MDCP  
 DECLARE @nvalcomu   NUMERIC (19,4) -- nuevo capital um MDCP  
 DECLARE @nvalcomp   NUMERIC (19,4) -- nuevo capital $$ MDCP  
 DECLARE @nvalcompv   NUMERIC (19,4) -- capital $$ venta  
 DECLARE @nvalcomuv   NUMERIC (19,4) -- capital um venta  
 DECLARE @nvalcomuo   NUMERIC (19,4) -- nuevo capital um MDCP original  
 DECLARE @nvalcompo   NUMERIC (19,4) -- nuevo capital $$ MDCP original  
 DECLARE @nvalcompvo   NUMERIC (19,4) -- capital $$ venta  
 DECLARE @nvalcomuvo   NUMERIC (19,4) -- capital um venta  
 DECLARE @fvalcompo   NUMERIC (19,4) -- capital $$ venta  
 DECLARE @fvalcomuo   NUMERIC (19,4) -- capital um venta  
 DECLARE @nfeccompo      DATETIME  
 DECLARE @ntircompo      NUMERIC (8,4)  
 DECLARE @nvparo         NUMERIC (19,8) --88  
 DECLARE @npvparo        NUMERIC (8,4)  
 DECLARE @ninteresv   NUMERIC (19,2) -- interes venta  
 DECLARE @nreajustv   NUMERIC (19,2) -- reajuste venta  
 DECLARE @nutilidad   NUMERIC (19,2) -- utilidad venta  
 DECLARE @nperdida   NUMERIC (19,2) -- perdida venta  
 DECLARE @cseriado   CHAR (01)  
 DECLARE @calculo        NUMERIC(19,4)  
  
  
--** Calculos LCHR Emision Propia **--  
        DECLARE @fPrimadesco NUMERIC (19,4) , -- Prima o Descuento Hist¢rico  
  @fValtasemio NUMERIC (19,4) , -- Valor Tasa Emmisi¢n Hist¢rico  
  @nPrimadesco NUMERIC (19,4) , -- Prima o Descuento Hist¢rico  
  @nValtasemio NUMERIC (19,4) , -- Valor Tasa Emmisi¢n Hist¢rico  
  @nPrimadesv NUMERIC (19,4) ,  
  @nPrimadesvo NUMERIC (19,4) ,  
  @nValtasemv NUMERIC (19,4) ,  
  @nPriDesAcum NUMERIC (19,4) ,  
  @nPriDesDia NUMERIC (19,4) ,  
  @nDifPriDesVta NUMERIC (19,4) ,  
  @dFeccomp DATETIME ,  
  @dFecven DATETIME ,  
  @nValParVta NUMERIC (19,4) ,  
  @fValmon_Hoy FLOAT           ,  
  @nperdidaLetra NUMERIC (19,4)  ,  
  @var1   NUMERIC (19,4) ,  
  @nutilidadLetra NUMERIC(19,4) ,  
  @cTipo_Moneda_papel CHAR (01) , -- wms  
  @nDecimal  INTEGER  
  
 SELECT @nRut  = acrutprop ,  
  @cTipoLchr = ''  ,  
  @fValmon_Hoy = 0.0  ,  
  @nPrimadesv = 0  ,  
  @nValtasemv = 0  ,  
  @nPriDesDia = 0  ,  
  @nPriDesAcum = 0  ,  
  @nValParVta = 0  ,  
  @nDifPriDesVta = 0  
 FROM MDAC  
  
 SELECT @cTipo_Moneda_papel = CASE  
      WHEN mnmx='C' THEN '0'  
      ELSE '1'  
       END , -- wms  
  @nDecimal  = mndecimal  
 FROM VIEW_MONEDA  
 WHERE mncodmon=@nmonemi  
  
  
 SELECT   
  @fcapitalc = dicapitalc ,  
  @finteresc = diinteresc ,  
  @freajustc = direajustc ,  
  @fnominal  = dinominal ,  
  @fvptirc   = divptirc  
 FROM MDDI  
 WHERE @nrutcart=dirutcart AND @nnumdocu=dinumdocu AND @ncorrela=dicorrela  
  
 -- *******************************************************************************  
 -- * calculo del factor, nuevo capital, rejustes, intereses y valor presente MDDI*  
 -- *******************************************************************************  
  
 SELECT @ffactor = 1.00 - (@nnominal / CASE WHEN @fnominal = 0 THEN 1 WHEN  @fnominal IS NULL THEN 1 ELSE @fnominal END )  
  
  
 SELECT @ncapitalc = ROUND(@fcapitalc * @ffactor,0)  
 SELECT @ninteresc = ROUND(@finteresc * @ffactor,0)  
 SELECT @nreajustc = ROUND(@freajustc * @ffactor,0)  
 SELECT @fvptirc   = ROUND(@fvptirc   * @ffactor,0)  
   
 UPDATE MDDI  
 SET   
  dinominal  = dinominal - @nnominal,  
  dicapitalc = @ncapitalc,  
  diinteresc = @ninteresc,  
  direajustc = @nreajustc,  
  divptirc   = @fvptirc  
--  divptirc = @ncapitalc + @ninteresc + @nreajustc  
  
 WHERE @nrutcart=dirutcart AND @nnumdocu=dinumdocu AND @ncorrela=dicorrela  
 SELECT    
  @fcapitalo      = cpcapitalc,  
  @fintereso    = cpinteresc,  
  @freajusto    = cpreajustc,  
  @fvalcomu    = cpvalcomu,  
  @fvalcomp    = cpvalcomp,  
  @fvalcomuo      = valor_compra_um_original,   
  @fvalcompo      = valor_compra_original,    
  @nfeccompo      = fecha_compra_original,  
  @ntircompo      = tir_compra_original,  
  @nvparo         = valor_par_compra_original,    
  @npvparo        = porcentaje_valor_par_compra_original,  
  @cseriado       = cpseriado,  
  @cTipoLchr      = cptipoletra,  
  @fprimadesco    = cpprimadesc,       
  @fvaltasemio    = cpvaltasemi,       
  @dFeccomp   = ISNULL(cpfeccomp,''),  
  @dFecven   = ISNULL(cpfecven,'')  
 FROM MDCP  
 WHERE @nrutcart=cprutcart AND @nnumdocu=cpnumdocu AND @ncorrela=cpcorrela  
  
  
 SELECT @ncapitalo   = ROUND(@fcapitalo * @ffactor,CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
 SELECT @nintereso   = ROUND(@fintereso * @ffactor,CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
 SELECT @nreajusto   = ROUND(@freajusto * @ffactor,CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
 SELECT @nvalcomu    = ROUND(@fvalcomu  * @ffactor,4)  
 SELECT @nvalcomp    = ROUND(@fvalcomp  * @ffactor,CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
 SELECT @nvalcomuo   = ROUND(@fvalcomuo * @ffactor,4)  
 SELECT @nvalcompo   = ROUND(@fvalcompo * @ffactor,CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
 SELECT @nprimadesco = ROUND(@fprimadesco * @ffactor,0)  
 SELECT @nvaltasemio = ROUND(@fvaltasemio * @ffactor,0)  
  
/*  
 UPDATE  MDCP  
 SET   cpnominal     = cpnominal - @nnominal ,  
       cpcapitalc    = @ncapitalo     ,  
   cpinteresc    = @nintereso     ,  
   cpreajustc    = @nreajusto     ,  
 cpvalcomp = @nvalcomp   ,  
   cpvalcomu    = @nvalcomu      ,  
   valor_compra_original  = @nvalcompo     ,  
   valor_compra_um_original = @nvalcomuo   ,  
   cpvptirc    = @fvptirc              ,  
 cpprimadesc  = @nprimadesco  ,  
 cpvaltasemi  = @nvaltasemio  ,  
 cpprimdescacum  = CASE WHEN (@nRutemi=@nRut and @nCodigo=20 and @ffactor<1) THEN round((@nprimadesco/(DATEDIFF(DAY,@dFeccomp,@dFecven))),0)*(DATEDIFF(DAY,@dFeccomp,@cfecpro))  
                               ELSE 0  
                          END    
 WHERE  @nrutcart=cprutcart AND @nnumdocu=cpnumdocu AND @ncorrela=cpcorrela  
*/  
  
 SELECT @nvalcompv  = ROUND(@fvalcomp    - @nvalcomp,CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
 SELECT @nvalcomuv  = ROUND(@fvalcomu    - @nvalcomu ,4)  
 SELECT @nvalcompvo = ROUND(@fvalcompo   - @nvalcompo,CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
 SELECT @nvalcomuvo = ROUND(@fvalcomuo   - @nvalcomuo ,4)  
 SELECT @ninteresv  = ROUND(@fintereso   - @nintereso,CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
 SELECT @nreajustv  = ROUND(@freajusto   - @nreajusto,0)  
 SELECT @nprimadesv = ROUND(@fprimadesco - @nprimadesco,0)  
 SELECT @nvaltasemv = ROUND(@fvaltasemio - @nvaltasemio,0)  
 SELECT @nperdida = 0.0  
 SELECT @nutilidad = 0.0  
  
  
 IF @nRutemi=@nRut AND @nCodigo=20  
 BEGIN  
             if @nMonemi =999    --revisar  
                  set @fValmon_Hoy =1  --revisar  
             else    
  
  SELECT @fValmon_Hoy = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nMonemi AND vmfecha=@cFecpro  
                 
  SELECT @nPrimadesv = ROUND(@fPrimadesco - @nPrimadesco,0)  
  SELECT @nPrimadesvo = ROUND(@nPrimadesv,0)  
  SELECT @nValtasemv = ROUND(@fValtasemio - @nValtasemio,0)  
  
--  SELECT @nPriDesDia = ROUND(@fPrimadesco/DATEDIFF(DAY,@dFeccomp,@dFecven),0) antes  
  SELECT @nPriDesDia = ROUND(@nPrimadesv/DATEDIFF(DAY,@dFeccomp,@dFecven),0)/* Correcci¢n para que calcule bien prima o descuento  
               para venta de letras parciales*/  
  
  SELECT @nPriDesAcum = ROUND(@nPriDesDia*DATEDIFF(DAY,@dFeccomp,@cFecpro),0)  
  
  SELECT @nValParVta = ROUND(((@nNominal*@nVpar)/100.0)*@fValmon_Hoy,0)  
  SELECT  @calculo        = case when @nPrimadesv > 0 then @nPrimadesv else (@nPrimadesv) end   
  SELECT @nDifPriDesVta = ROUND(@nVptirv-(@nValParVta - @calculo),0)   
  SELECT @nDifPriDesVta  = round(@nDifPriDesVta,0)  
  
  SELECT @nPrimadesv = ROUND(@nPrimadesv - @nPriDesAcum,0)  
  SELECT  @var1           = ROUND(@nValparvta + @nPrimadesv,0)  
  
 END ELSE BEGIN  
  SELECT @nPrimadesvo = 0  
  SELECT  @nDifPriDesVta  = 0  
         SELECT  @var1   = ROUND(@nvalcompv+@ninteresv+@nreajustv,0)  
 END  
  
  
 IF @nvptirv > @var1  
 BEGIN  
        IF @nRutemi = @nRut AND @nCodigo = 20  
        BEGIN  
   SELECT @nutilidad = @nvptirv - (@nValparvta + @nPrimadesv) -- ( @nvalcompv + @ninteresv + @nreajustv )  
   SELECT @nperdida = 0.0  
   IF @nutilidad > 0   
            BEGIN  
         SELECT @nutilidadLetra  = round(@nutilidad,0)  
         SELECT @nperdidaLetra = 0.0  
      END ELSE BEGIN  
          SELECT @nperdidaLetra    = ROUND( @nutilidad,0)  
          SELECT @nutilidadLetra  = 0.0  
      END    
  END ELSE  BEGIN  
   SELECT @nutilidad = ROUND(@nvptirv - ( @nvalcompv + @ninteresv + @nreajustv ),CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
   SELECT @nperdida = 0.0  
                END  
----  
 END ELSE  
 BEGIN  
      IF @nRutemi=@nRut AND @nCodigo=20   
         begin        
  SELECT @nutilidadLetra = 0.0  
         SELECT @nperdida  =   @nvptirv - (@nValparvta + @nPrimadesv)  
         IF @nperdida > 0   
            BEGIN  
         SELECT @nutilidadLetra  = @nperdida  
         SELECT @nperdidaLetra = 0.0  
      END ELSE BEGIN  
            SELECT @nperdidaLetra = ROUND( @nperdida,0)  
      END    
        
    END ELSE BEGIN   
   SELECT @nutilidad = 0.0  
   SELECT @nperdida =  ROUND(@nvptirv -( @nvalcompv + @ninteresv + @nreajustv ),CASE WHEN @cTipo_Moneda_papel='0' THEN @nDecimal ELSE 0 END)  
  END  
  
 END  
     
   INSERT INTO MDMOPM  
   (   mofecpro     ,    --1  
       morutcart    , --2  
       motipcart    , --3  
       monumdocu    , --4  
       mocorrela    , --5  
       monumdocuo   , --6  
       mocorrelao   , --7  
       monumoper    , --8  
       motipoper    , --9  
       motipopero   , --10  
       moinstser    , --11  
       momascara    , --12  
       mocodigo     ,  --13  
       mofecemi     ,  --14  
       mofecven     ,  --15  
       momonemi     ,  --16  
       motasemi     ,  --17  
       mobasemi     ,  --18  
       morutemi     ,  --19  
       monominal    , --20  
       monumucup    , --21  
       motir        ,  --22  
       mopvp        ,  --23  
       movpar       ,  --24  
       motasest     ,  --25  
       moforpagi    , --26  
       mocondpacto  , --27  
       morutcli     ,  --28  
       mocodcli     ,  --29  
       motipret     ,  --30  
       mohora       ,  --31  
       mousuario    , --32  
       moterminal   , --33  
       mocapitali   ,       --34  
       movpreseni   ,       --35  
       movalcomp    ,        --36  
       movalcomu    ,        --37  
       mointeres    ,        --38  
       moreajuste   ,       --39  
       moutilidad   ,       --40  
       moperdida    ,        --41  
       movalven     ,         --42   
       movpresen    ,        --43  
       moseriado    ,        --44  
       mocorvent    ,       --45  
       moclave_dcv  ,      --46  
       modcv        ,           --47  
       fecha_compra_original                ,  
       valor_compra_original                ,   
       valor_compra_um_original             ,   
       tir_compra_original                  ,   
       valor_par_compra_original            ,  
       porcentaje_valor_par_compra_original ,  
       codigo_carterasuper   ,  
       tipo_cartera_financiera   ,   
       mercado     ,   
       sucursal    ,   
       id_sIStema    ,   
       fecha_pagomañana   ,   
       laminas     ,   
       tipo_inversion    ,  
       cuenta_corriente_inicio   ,  
       cuenta_corriente_final   ,  
       sucursal_inicio     ,  
       sucursal_final      ,  
       motipoletra     ,  
       moobserv  ,  
       moprimadesc   ,  
       movaltasemi  ,  
       SorteoLCHR       ,  
       mofecinip        ,  
       mofecvenp        ,  
       mostatreg        ,  
       moid_libro  
   )  
   VALUES  
   (   @VctoReal    , --@cfecpro  
       @nrutcart    ,  
       @ntipcart    ,  
       @nnumdocu    ,  
       @ncorrela    ,  
       @nnumdocu    ,  
       @ncorrela    ,  
       @nnumoper    ,  
       'VP'         ,  
       'CP'         ,  
       @cinstser    ,  
       @cmascara    ,  
       @ncodigo     ,  
       @cfecemi     ,  
       @cfecven     ,  
       @nmonemi     ,  
       @ntasemi     ,  
       @nbasemi     ,  
       @nrutemi     ,  
       @nnominal    ,  
       @nnumucup    ,  
       @ntir        ,  
       @npvp        ,  
       @nvpar       ,  
       @ntasest     ,  
       @nforpagi    ,  
       ' '          ,  
       @nrutcli     ,  
       @ncodcli     ,  
       @cretiro     ,  
       convert(CHAR(08),getdate(),114)  ,  
       @cusuario    ,  
       @cterminal    ,   
       @nDifPriDesVta,     --** Aqui Pones Caluclos @nDifPriDesVta para LCHR Emisi¢n Propia **-  
       @nPrimadesvo,     --** Respaldo Descuento o Prima para Anulaciones **--  
       ISNULL(@nvalcompv,0)    ,  
       ISNULL(@nvalcomuv,0)    ,  
       ISNULL(@ninteresv,0)    ,  
       ISNULL(@nreajustv,0)    ,  
       CASE when @nRutemi=@nRut AND @nCodigo=20 then ISNULL(@nutilidadLetra,0) else ISNULL(@nutilidad,0) end,  
       CASE when @nRutemi=@nRut AND @nCodigo=20 then ISNULL(@nperdidaLetra*-1,0)  else ISNULL(@nperdida,0) END,  
       ISNULL(@nvptirv,0),  
       CASE when @nRutemi = @nRut AND @nCodigo=20 then ROUND(@nValparvta,0) ELSE ISNULL(@nvalcompv+@ninteresv+@nreajustv,0) END,  
       @cseriado     ,  
       @ncorrvent    ,  
       @clave_dcv    ,  
       @ctipcust     ,  
       @nfeccompo    ,     
       @nvalcompvo   ,  
       @nvalcomuvo   ,  
       @ntircompo    ,  
       @nvparo       ,  
       @npvparo      ,        
       @codigo_carterasuper    ,  
       @tipo_cartera_financiera   ,  
       @mercado     ,  
       @sucursal     ,  
       @id_sIStema     ,  
       @fecha_pagomañana    ,  
       @laminas     ,  
       @tipo_inversion     ,  
       ''      ,  
       ''      ,  
       ''                      ,  
       ''                      ,  
       @cTipoLchr              ,  
       @observ                ,  
       ROUND(@nprimadesv,0)    ,  
       ROUND(@nValparvta,0)    ,  
       'S'                     ,  
       @cfecpro                ,  
       @FechaSorteo            ,  
       'P'   ,  
       @id_libro  
   )  
  
   SET NOCOUNT OFF  
   SELECT 'OK'  
  
END  
GO
