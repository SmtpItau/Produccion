USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARCP_PASIVO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABARCP_PASIVO]
    (  
    @nrutcart NUMERIC (09,0) = 00, -- rut de la cartera  
    @ctipcart NUMERIC (05,0) = 00, -- codigo del tipo de cartera  
    @nnumdocu NUMERIC (10,0) = 00, -- numero del documento  
    @ncorrela NUMERIC (03,0) = 00, -- correlativo de la operacirn  
    @cmascara CHAR (12) = '', -- familia del instrumento  
    @cinstser CHAR (12) = '', -- serie  
    @cgenemi CHAR (10) = '', -- generico del emisor  
    @cnemomon CHAR (05) = '', -- generico de la moneda  
    @nnominal NUMERIC (19,4) = 00, -- nominles    
    @ntir  NUMERIC (19,4) = 00, -- tir de compra   
    @npvp  NUMERIC (19,2) = 00, -- porcentaje valor presente  
    @nvpar  NUMERIC (19,8) = 00, -- valor par  
    @nvptirc FLOAT  = 00, -- valor presente a tir de compra  
    @nnumucup NUMERIC (03,0) = 00, -- numero del oltimo  cuprn vencido  
    @nrutcli NUMERIC (09,0) = 00, -- rut del cliente  
                                @ncodcli        NUMERIC (09,0)  = 00, -- c½digo de cliente  
    @cfecpro DATETIME = '', -- fecha de proceso  
    @ntasest NUMERIC (09,4) = 00, -- tasa estimada  
    @cfecemi DATETIME = '', -- fecha de emisirn  
    @cfecven DATETIME = '', -- fecha de vencimiento  
     @cmdse  CHAR (01) = '', -- indica si es seriado o no  
    @ncodigo NUMERIC (05) = 00, -- codigo de la familia  
    @cserie  CHAR (12) = '', -- serie de la familia  
    @nmonemi NUMERIC (03) = 00, -- moneda del emisor  
    @nrutemi NUMERIC (09) = 00, -- rut del emisor  
     @ntasemi NUMERIC (09,4) = 00, -- tasa estimada  
    @nbasemi NUMERIC (03) = 00, -- base estimada  
    @ctipcust CHAR (03) = '', -- tipo de custodia  
    @nforpagi NUMERIC (05) = 00, -- forma de pago  
    @cretiro CHAR (01) = '', -- tipo de retiro  
    @cusuario CHAR  (12) = '', -- usuario  
    @cterminal CHAR (12) = '', -- terminal  
    @dfecpcup DATETIME = '', -- fecha de cup½n  
    @csi_dcv CHAR (01) = '', -- custodia dcv  
    @cclave_dcv CHAR (10) = '', -- clave dcv  
              @dconvexidad  FLOAT  = 00, -- convexidad  
    @dduratmac  FLOAT  = 00, -- durati¢n macaulay  
    @dduratmod FLOAT  = 00,  -- duration modificado  
    @codigo_carterasuper   CHAR    (01)  = '',  
    @tipo_cartera_financiera CHAR (05) = '',		-->	CAMBIO DE LARGO 1 A 5 CARACTERES
    @mercado   CHAR (01) = '',  
    @sucursal   varCHAR (05) = '',  
    @id_sistema   CHAR (03) = '',  
    @fecha_pagomañana  DATETIME = '',  
    @laminas   CHAR (01) = '',  
    @tipo_inversion   CHAR (01) = ''  
    )  
AS  
BEGIN  
 SET NOCOUNT ON  
 DECLARE @ok  CHAR (01) ,  
  @cseriado CHAR (01) ,  
  @nvalmon FLOAT  ,  
  @cfamilia CHAR (10) ,  
  @j  INTEGER  ,  
  @nlutil  INTEGER  ,  
  @cTipoLchr CHAR (01) ,  
  @nRut  NUMERIC (09,0)  
 DECLARE @cProg  CHAR (10) ,  
  @iModcal INTEGER  ,  
  @iMonemi INTEGER  ,  
  @fPvp  FLOAT  ,  
  @fMT  FLOAT  ,  
  @fMTUM  FLOAT  ,  
  @fMT_cien FLOAT  ,  
  @fVan  FLOAT  ,  
  @fVpar  FLOAT  ,  
  @dFecucup DATETIME ,  
  @fIntucup FLOAT  ,  
  @fAmoucup FLOAT  ,  
  @fSalucup FLOAT  ,  
  @nNumpcup INTEGER  ,  
  @fIntpcup FLOAT  ,  
  @fAmopcup FLOAT  ,  
  @fSalpcup FLOAT  ,  
  @fDurat  FLOAT  ,  
  @fConvx  FLOAT  ,  
  @fDurmo  FLOAT  ,  
  @nError  INTEGER ,  
  @fTirCol  FLOAT  
 SELECT @fTirCol = @nTir  
 select @cProg = inprog from view_instrumento where incodigo = 15  
 SELECT @ok  = '0'  ,  
  @nvalmon = 1.0  ,  
  @cmascara = '*'  ,  
  @cTipoLchr = ''  ,  
  @nRut  = acrutprop   
 FROM MDAC  
 SELECT @cmascara = semascara  
 FROM VIEW_SERIE  
 WHERE seserie=@cinstser  
 IF @cmdse='S'  
 BEGIN  
  IF @cmascara='*'  
  BEGIN  
   SELECT @cfamilia = '*'  
   IF SUBSTRING(@cinstser,1,3)='PCD' AND SUBSTRING(@cinstser,1,6)<>'PCDUS$'  
    SELECT @cfamilia='PCDUF'  
   ELSE  
   BEGIN  
    SELECT @j = dataLENgth(@cinstser)  
    WHILE @j <>0  
    BEGIN  
     SELECT @cfamilia=inserie FROM VIEW_INSTRUMENTO WHERE inserie=SUBSTRING(@cinstser,1,@j)  
     IF @cfamilia<>'*'  
      BREAK  
     SELECT @j = @j-1  
    END  
   END  
   IF @cfamilia='*'  
   BEGIN  
    IF SUBSTRING(@cinstser,1,3)='PTF'  
     SELECT  @cfamilia = 'PTF'  
   END  
   IF @cfamilia='*'  
    SELECT  @cfamilia = 'LCHR'  
   SET ROWCOUNT 1  
   SELECT @nlutil = LEN(msmascara)  
   FROM VIEW_MASCARA_INSTRUMENTO  
   WHERE msfamilia=@cfamilia  
   SET ROWCOUNT 0  
   SELECT @cmascara = '*'  
   SELECT @cmascara = semascara,  
    @iMonemi =semonemi  
   FROM VIEW_SERIE  
   WHERE seserie=SUBSTRING(@cinstser,1,@nlutil)  
  END  
 END  
 ELSE  
  SELECT @cmascara = @cserie  
 IF @nmonemi<>999 AND @nmonemi<>13  
  SELECT @nvalmon = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonemi AND vmfecha=@cfecpro  
 --** Valorizaci¢n al 100% **--  
 SELECT @iModcal = 1 ,  
  @fPvp  = 100,  
   @cProg  = 'Sp_'  +  @cProg  
-- select @cProg ,@iModcal, @cfecpro, @ncodigo, @cinstser, @nMonemi, @cfecemi, @cFecven, @nTasemi, @nBasemi,@ntasest,  
 --  @nNominal, @nTir , @fPvp  
 EXECUTE @nError =  @cProg @iModcal, @cfecpro, @ncodigo, @cinstser, @nMonemi, @cfecemi, @cFecven, @nTasemi, @nBasemi, @ntasest,  
   @nNominal OUTPUT, @nTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,  
   @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,  
   @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT  
 INSERT MDPASIVO  
   (cprutcart,  
   cptipcart,  
   cpnumdocu,  
   cpcorrela,  
   cpnumdocuo,  
   cpcorrelao,  
   cpinstser,  
   cpmascara,  
   cpnominal,  
   cpnominal_R,  
   cpfeccol,  
   cpvalcol,  
   cpvalcomu,  
   cptircol,  
   cptasest,  
   cppvpcolc,  
   cpnumucup,  
   cpfecven,  
   cpseriado,  
   cpcodigo,  
   cpinteres_emis,  
   cpreajust_emis,  
   cpinteres_col,  
   cpreajust_col,  
   cpcontador,  
   cpfecpcup,  
   cpdurat,  
   cpdurmod,  
   cpconvex,  
   fecha_colocacion_original,  
   valor_colocacion_original,  
   valor_colocacion_um_original,  
   tir_colocacion_original,  
   Id_Sistema,  
   cpvalemis,  
   cpvalemimu,  
   cpmonemi,  
   cpfecemi,  
   cpvptircol,  
   cpvpemis)  
    VALUES( @nrutcart,  
   @ctipcart,  
   @nnumdocu,  
   @ncorrela,  
   @nnumdocu,  
   @ncorrela,  
   @cinstser,  
   @cmascara,  
   @nnominal,  
   @nnominal,  
   @cfecpro,  
   @nvptirc,  
   round(@nvptirc/@nvalmon,4),  
   @fTirCol,  
   @ntasest,  
   @npvp,  
   @nnumucup,  
   @cfecven,  
   @cmdse,  
   @ncodigo,  
   0,  
   0,  
   0,  
   0,  
   0,  
   @dfecpcup ,  
   @dduratmac ,  
   @dduratmod,  
   @dconvexidad ,  
   @cfecpro,  
   @nvptirc,  
   round(@nvptirc/@nvalmon,4),  
   @fTirCol,  
   'BTR',  
   @fMt,  
   @fMtum,  
   @nmonemi,   
   @cfecemi,  
   @nvptirc,  
   @fmt  
   )  
INSERT MDMO  
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
   momonemi ,  
   motasemi ,  
   mobasemi ,  
   morutemi ,  
   monominal ,  
   movpresen ,  
--   momtps  ,  
--   momtum  ,  
--   momtum100 ,  
   monumucup ,  
   motir  ,  
   mopvp  ,  
   movpar  ,  
    motasest ,          
   moforpagi ,  
   mocondpacto ,  
   morutcli ,  
   mocodcli ,  
   motipret ,  
   mohora  ,  
   mousuario ,  
   moterminal ,  
   mocapitali ,  
   movpreseni ,  
   movalcomp ,  
   movalcomu       ,  
                        moclave_dcv     ,  
                        modcv           ,  
   mocodexceso ,  
   momtopfe ,  
   momtocce ,  
   fecha_compra_original  ,  
   valor_compra_original  ,  
   valor_compra_um_original ,  
   tir_compra_original  ,  
   valor_par_compra_original ,  
   porcentaje_valor_par_compra_original,  
   codigo_carterasuper ,   
   tipo_cartera_financiera ,   
   mercado   ,   
   sucursal  ,   
   id_sistema  ,   
   fecha_pagomañana ,   
   laminas   ,   
   tipo_inversion  ,  
   cuenta_corriente_inicio ,  
   cuenta_corriente_final ,  
   sucursal_inicio  ,  
   sucursal_final  ,  
   motipoletra  
   )  
 VALUES  
   (  
   @cfecpro ,  
   @nrutcart ,  
   @ctipcart ,  
   @nnumdocu ,  
   @ncorrela ,  
   @nnumdocu ,  
   @ncorrela ,  
   @nnumdocu ,  
   'CPP'  ,  
   'CPP'  ,  
   @cinstser ,  
   @cmascara ,  
   @ncodigo ,  
   @cmdse  ,  
   @cfecemi ,  
   @cfecven ,  
   @nmonemi ,  
   @ntasemi ,  
   @nbasemi ,  
   @nrutemi ,  
   @nnominal ,  
   @nvptirc ,  
--   @nvptirc ,  
--    @nvptirc ,  
--   @nvptirc/@nnominal*100.0 ,  
   @nnumucup ,  
   @fTirCol  ,  
   @npvp  ,  
   @nvpar  ,  
   @ntasest ,  
   0 ,  
   '' ,  
   0 ,  
   0 ,  
   '' ,  
   convert(CHAR(15),getdate(),114) ,  
   @cusuario ,  
   @cterminal ,  
   @nvptirc ,  
   @nvptirc ,  
   @nvptirc ,    
   round(@nvptirc/@nvalmon,4),  
                        '',  
                        '' ,  
   0,  
   0,  
   0,  
   @cfecpro   ,  
   @nvptirc   ,  
   round(@nvptirc/@nvalmon,4) , -- valor compra um original  
   @fTirCol    ,     
   @npvp    ,  
   @nvpar    ,  
   '',  
   '',  
   ''  ,  
   '' ,  
   'BTR'  ,   
   '',   
   ''  ,   
   ''  ,  
   ''   ,  
   ''   ,  
   ''   ,  
   ''   ,  
   ''  
   )  
 IF @@error<>0  
  SELECT @ok = '0'  
 IF @@error=0  
  SELECT @ok = '1'  
     
        SET NOCOUNT OFF  
 SELECT @ok  
END  
GO
