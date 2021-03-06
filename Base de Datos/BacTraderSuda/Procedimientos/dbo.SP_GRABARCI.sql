USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARCI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABARCI]
  (  
  @nrutcart NUMERIC (09,0) , -- rut de la cartera  
  @ctipcart NUMERIC (05,0) , -- codigo del tipo de cartera  
  @nnumdocu NUMERIC (10,0) , -- numero del documento  
  @ncorrela NUMERIC (03,0) , -- correlativo de la operación  
  @cmascara CHAR (12) , -- familia del instrumento  
  @cinstser CHAR (12) , -- serie                        
  @cgenemi CHAR (10) , -- generico del emisor  
  @cnemomon CHAR (05) , -- generico de la moneda  
  @nnominal NUMERIC (19,4) , -- nominales    
  @ntir  NUMERIC (19,4) , -- tir de compra  
  @npvp  NUMERIC (19,2) , -- porcentaje valor presente  
  @nvptirc FLOAT  , -- valor presente a tir de compra  
  @nvp100  FLOAT  , -- valor presente en base 100  
  @ntasest NUMERIC (09,4) , -- tasa estimada  
  @nvpar  NUMERIC (19,8) , -- valor par  
  @nnumucup NUMERIC (03,0) , -- numero del último cupón vencido  
  @ntirmcd NUMERIC (09,4) , -- tir de mercado  
  @npvpmcd NUMERIC (09,4) , -- %vc a mercado  
  @nvpmcd  FLOAT  , -- valor presente a mercado  
  @nvpmcd100 FLOAT  , -- valor presente a mercado en base 100  
  @cseriado CHAR (01) , -- indica si es seriado o no  
  @ncodigo NUMERIC (05,0) , -- codigo de la familia  
  @cserie  CHAR (12) , -- serie de la familia  
  @cfecemi CHAR (10) , -- fecha de emisión  
  @cfecven CHAR (10) , -- fecha de vencimiento  
  @nmonemi NUMERIC (03,0) , -- moneda del emisor  
  @nrutemi NUMERIC (09,0) , -- rut del emisor  
  @ntasemi NUMERIC (09,4) , -- tasa estimada  
  @nbasemi NUMERIC (03,0) , -- base estimada  
  @nrutcli NUMERIC (09,0) , -- rut del cliente          
  @ncodcli        NUMERIC (09,0) , -- codigo del cliente          
  @nforpagi NUMERIC (05,0) , -- forma de pago al inicio  
  @nforpagv NUMERIC (06,0) , -- forma de pago al vencimiento  
  @ctipcust CHAR (03) , -- tipo de custodia  
  @cretiro CHAR (01) , -- tipo de retiro  
  @cusuario CHAR  (12) , -- usuario  
  @cterminal CHAR (12) , -- terminal  
  @cfecvtop CHAR (10) , -- fecha de vencimiento del pacto  
  @nmonpact NUMERIC(3,0) , -- moneda del pacto  
  @ntaspact NUMERIC(9,4) , -- tasa del pacto  
  @nbaspact NUMERIC(3,0) , -- base del pacto   
  @nvalinip NUMERIC(19,4) , -- valor inicial del pacto en moneda del pacto  
  @nvalvtop NUMERIC(19,4) , -- valor vencimiento del pacto en moneda del pacto  
  @dfecpcup DATETIME , -- fecha proximo cupon  
  @ccustodia CHAR(1)  , -- vb+- 06/06/2000 se agrega grabar custodia   
  @cclave_dcv CHAR(10) , -- vb+- 06/06/2000 se agrega grabar clave dcv  
  @dconvexidad  FLOAT  , -- convexidad  
  @dduratmac  FLOAT  , -- durati¢n macaulay  
  @dduratmod FLOAT  ,  -- duration modificado  
  @ftotalpfe FLOAT  ,  
  @ftotalcce FLOAT  ,  
                -------------------------------------------------  
  @codigo_carterasuper  CHAR (01) ,  
  @tipo_cartera_financiera CHAR (05) ,	-->	SE CAMBIA LARGO DE 1 A 5 CARACTERES
  @mercado   CHAR (01) ,  
  @sucursal   VARCHAR (05) ,  
  @id_sistema   CHAR (03) ,  
  @fecha_pagomañana  DATETIME ,  
  @laminas   CHAR (01) ,  
  @tipo_inversion   CHAR (01) ,  
  @cuenta_corriente_inicio CHAR (15) ,  
  @sucursal_inicio  VARCHAR (05) ,  
  @cuenta_corriente_final  CHAR (15) ,  
  @sucursal_final   VARCHAR (05)    ,  
  @observ    CHAR (70),  
  @nTcInicio NUMERIC(19,4),  
  @id_libro   CHAR(10)   
 , @nTirTran NUMERIC(19,4)  
 , @nVpTran NUMERIC(19,4)  
 , @nDifTran_MO NUMERIC(19,4)  
 , @nDifTran_CLP NUMERIC(19,0) ,

--LD1_COR_035----------------------------------------------
	  @Ejecutivo   INTEGER = 0,
	  --@cTipoCustodia INTEGER = 0, --> @ccustodia 
	  @subformaPago  NUMERIC(5) = 0,
	  @subformaPago2  NUMERIC(5) = 0,
	  @nTasCFdo  NUMERIC (9,4)
--LD1_COR_035----------------------------------------------

) WITH RECOMPILE  
AS  
BEGIN  
   set nocount off  
   declare @nestado char(1)  ,  
    @fcontrol    datetime ,  
    @cok  char (01) ,  
    @chora char (15) ,  
    @dfecpro datetime ,  
    @dfecvtop datetime ,  
    @dfecvtopcl datetime ,  
    @dfecemi datetime ,  
    @dfecven datetime ,  
    @nvalmon numeric (19,04),  
    @nvalmonPact numeric (19,04),  
    @cMnMx   CHAR(1)  
 --** hora del sistema, fecha de proceso. **---  
 SELECT @cMnMx = ''  
 select @chora  = convert(char(15),getdate(),114)  
 select @dfecpro = acfecproc from MDAC  
 select @nvalmon = 1.0  
 SELECT @nvalmonPact = 1.0  
 select @nvalmon= isnull(vmvalor,0.0) from VIEW_VALOR_MONEDA where vmcodigo=@nmonemi and vmfecha=@dfecpro   
 SELECT @cMnMx = mnmx from view_moneda WHERE mncodmon = @nmonpact  
  
 if @nmonemi = 13   
    select @nvalmon = 1.0  
  
  
 If @cMnMx = 'C' AND @nmonpact <> 13 BEGIN  
 SELECT @nvalmonPact = @nTcInicio  
  
 END  
  
 select @dfecvtop = convert(datetime ,@cfecvtop,101)  
 select @dfecemi = convert(datetime ,@cfecemi ,101)  
 select @dfecven = convert(datetime ,@cfecven ,101)  
     insert into MDDI (  
                   dirutcart                         , -- 01  
                     ditipcart                                         , -- 02  
                     dinumdocu                                         , -- 03  
                     dicorrela                                         , -- 04  
                     dinumdocuo                                        , -- 05  
                     dicorrelao                                        , -- 06  
                     ditipoper                                         , -- 07  
                     diserie                  , -- 08  
                     diinstser                                         , -- 09  
                     digenemi                                          , -- 10  
                     dinemmon                                          , -- 11  
                     dinominal                                         , -- 12  
                     ditircomp                                         , -- 13  
                     dipvpcomp                                         , -- 14  
                     divptirc                                          , -- 15  
                     ditirmcd                                          , -- 16  
                     dipvpmcd                                          , -- 17  
                     divpmcd                                           , -- 18  
                     divpmcd100                                        , -- 19  
                     divptirci                                         , -- 20  ********  
                     difecsal                                          , -- 21  
                     dinumucup                                         , -- 22  
                     dicapitalc                                        , -- 23  
                     diinteresc                                        , -- 24  
                     direajustc                                        , -- 25  
                     dicapitaci                                        , -- 26  ********  
                     diintereci                                        , -- 27  
                     direajusci                                        , -- 28  
                     ---------------------------------------------------  
              codigo_carterasuper          ,  
              tipo_cartera_financiera          ,  
              mercado            ,  
              sucursal                   ,  
              id_sistema                   ,  
              fecha_pagomañana                  ,  
              laminas                   ,  
              tipo_inversion,  
       ditcinicio, -- 37  
       id_libro,

--LD1_COR_035----------------------------------------------
		tasa_contrato,
		valor_contable,
		ejecutivo,
		tipo_custodia,
		diTasCFdo
--LD1_COR_035----------------------------------------------

    ) -- 38  
             values (  
                     @nrutcart                                         , -- 01  
                     @ctipcart                                         , -- 02  
                     @nnumdocu                                         , -- 03  
                     @ncorrela                                         , -- 04  
                     @nnumdocu                                         , -- 05  
                     @ncorrela                                         , -- 06  
                     'CI'                                              , -- 07  
                     @cserie                                           , -- 08  
                     @cinstser                                         , -- 09  
                     @cgenemi                                          , -- 10  
                     @cnemomon       , -- 11  
                     @nnominal                                         , -- 12  
                     @ntir                                             , -- 13  
                     @npvp                                             , -- 14  
                     @nvptirc                                          , -- 15  
                     @ntirmcd                                          , -- 16  
                     @npvpmcd                                , -- 17  
                @nvpmcd      , -- 18  
              @nvpmcd100                 , -- 19  
                     CASE WHEN @cMnMx = 'C' THEN round(@nvalinip / @nvalmonPact, 4) ELSE @nvalinip END, -- 20  ***********  
                     @dfecvtop                                         , -- 21  
                     @nnumucup                                         , -- 22  
                     @nvptirc                                          , -- 23  
                     0.0                                               , -- 24  
                     0.0                                               , -- 25  
                     CASE WHEN @cMnMx = 'C' THEN round(@nvalinip / @nvalmonPact, 4) ELSE @nvalinip END, -- 26  *********  
                     0.0                                               , -- 27  
                     0.0                                               ,  -- 28  
                     ---------------------------------------------------  
                    @codigo_carterasuper          ,  
              @tipo_cartera_financiera          ,  
              @mercado            ,  
              @sucursal                   ,  
              @id_sistema           ,  
              @fecha_pagomañana                  ,  
              @laminas                   ,  
              @tipo_inversion ,  
       @nTcInicio, -- 37   
       @id_libro   ,

--LD1_COR_035----------------------------------------------
		     @ntaspact,
		     @nvptirc,
		     @Ejecutivo,
		     CASE WHEN @ccustodia ='C' THEN 1 ELSE  CASE WHEN @ccustodia='P' THEN 2 ELSE 3 END END,--@cTipoCustodia,
		     @nTasCFdo
--LD1_COR_035----------------------------------------------

) 
  
    IF @@Error <> 0   
   begin  --** abortar transacción. **--  
     select @cok = '0'  
   select @cok  
   RETURN  
   END  
  
 declare @valor datetime,@valores numeric(1)  
 select @valor=sefecven from VIEW_SERIE where semascara=@cmascara  
  
 insert into MDCI  
   (  
   cirutcart   ,--1  
   citipcart   ,--2  
   cinumdocu   ,--3  
   cicorrela   ,--4  
   cinumdocuo   ,--5  
   cicorrelao   ,--6  
   cirutcli   ,--7  
   cicodcli   ,  
   ciinstser   ,--8  
   cimascara   ,--9  
   cinominal   ,--10  
   cifeccomp   ,--11   
   civalcomp   ,--12  
   civalcomu   ,--13  
   civcum100   ,--14  
   citircomp   ,--15  
   citasest   ,--16  
   cipvpcomp   ,--17  
   civpcomp   ,--18  
   cinumucup   ,--19  
   cifecemi   ,--20  
   cifecven   ,--21  
   ciseriado   ,--22  
   cicodigo   ,--23  
   civptirc   ,--24  
   civptirci   ,--25  
   cicapitalc   ,--26  
   ciinteresc   ,--27  
   cireajustc   ,--28  
   cicapitalci   ,--29  
   ciinteresci   ,--30  
   cireajustci   ,--31  
   cifecinip   ,--32  
   cifecvenp   ,--33  
   civalinip   ,--34  
   civalvenp   ,--35  
   citaspact    ,--36  
   cibaspact   ,--37  
   cimonpact   ,--38  
   cirutemi   ,--39  
   cimonemi   ,--40  
   cinominalp   ,--41  
   ciforpagi   ,--42  
   ciforpagv   ,--43  
   cifecucup   ,--44  
   cicontador                      ,          -- este campo no existia en tabla que entrego david  
   cifecpcup   ,--46  
   cidcv    ,-- 47  
   cidurat    ,--48  
   cidurmod   ,  
   ciconvex   ,  
   ---------------------------------  
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
   sucursal_final,  
   valor_compra_original,  
   valor_compra_um_original  ,  
   fecha_compra_original     ,  
   tir_compra_original       ,  
   valor_par_compra_original ,  
   porcentaje_valor_par_compra_original ,  
   citcinicio,--70  
   id_libro, 

--LD1_COR_035----------------------------------------------
		Ejecutivo,
		Tipo_Custodia,
		Tasa_Contrato,
		Valor_Contable,
		ciTasCFdo
--LD1_COR_035----------------------------------------------

)  
  values  
   (  
   @nrutcart   ,--1  
   @ctipcart   ,--2  
   @nnumdocu   ,--3  
   @ncorrela   ,--4   
   @nnumdocu   ,--5  
   @ncorrela   ,--6  
   @nrutcli   ,--7  
   @ncodcli   ,  
   @cinstser   ,--8  
   @cmascara   ,--9     
   @nnominal   ,--10  
   @dfecpro   ,--11  
   @nvptirc   ,--12  
   round(@nvptirc / @nvalmon, 4) ,--13-- valor compra um  
   @nvp100    ,--14  
   @ntir    ,--15  
   @ntasest   ,--16  
   @npvp    ,--17  
   @nvpar    ,--18   
   @nnumucup   ,--19  
   @dfecemi   ,--20  
   @dfecven   ,--21  
   @cseriado   ,--22  
   @ncodigo   ,--23  
   @nvptirc   ,--24  
   CASE WHEN @cMnMx = 'C' THEN round(@nvalinip / @nvalmonPact, 4) ELSE @nvalinip END  ,--25    
   @nvptirc   ,--26  
   0    ,--27  
   0    ,--28  
   CASE WHEN @cMnMx = 'C' THEN round(@nvalinip / @nvalmonPact, 4) ELSE @nvalinip END   ,--29  
   0    ,--30  
   0    ,--31  
   @dfecpro   ,--32  
   @dfecvtop   ,--33  
   @nvalinip    ,--34  
   @nvalvtop   ,--35  
   @ntaspact   ,--36  
   @nbaspact   ,--37  
   @nmonpact   ,--38  
   @nrutemi   ,--39  
   @nmonemi   ,--40  
   round(@nnominal*@nvalmon,0) ,--41  
   @nforpagi   ,--42  
   @nforpagv   ,--43  
   @dfecpcup   ,--44  
   0         ,--45 -- contador  
   @dfecpcup   ,--46  
   @ccustodia    ,--47    
   @dduratmac    ,--48  
   @dduratmod   ,--49  
   @dconvexidad    ,  
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
   @sucursal_final,  
   @nvptirc,  
   round(@nvptirc / @nvalmon, 4),  
   @dfecpro,  
   @ntir,  
   @nvpar,  
   @npvp,  
   @nTcInicio,--70  
   @id_libro,

--LD1_COR_035----------------------------------------------
		@Ejecutivo,
		CASE WHEN @ccustodia ='C' THEN 1 ELSE  CASE WHEN @ccustodia='P' THEN 2 ELSE 3 END END,--@cTipoCustodia,
		@ntaspact,
		@nvptirc,
		@nTasCFdo
--LD1_COR_035----------------------------------------------


  )--71  
  
   IF @@Error <> 0   
  begin  --** abortar transacción. **--  
    select @cok = '0'  
  select @cok  
  RETURN  
  END  
   
  
   if @cseriado = 'N' begin  
      insert into VIEW_NOSERIE (  
                        nsrutcart                                      , -- 01  
                        nsnumdocu                                      , -- 02  
                        nscorrela                                      , -- 03  
                        nsrutemi                                       , -- 04  
                        nsmonemi                                       , -- 05  
                        nstasemi                                       , -- 06  
                        nsbasemi                                       , -- 07  
                        nsfecemi                                       , -- 08  
                        nsfecven                                       , -- 09  
                        nsserie                                        , -- 10  
                        nscodigo                                         -- 11  
                       )  
                values (  
                        @nrutcart                                      , -- 01  
                        @nnumdocu                                      , -- 02  
                        @ncorrela                                      , -- 03  
                        @nrutemi                                       , -- 04  
                        @nmonemi                                       , -- 05  
                        @ntasemi                                       , -- 06  
                        @nbasemi                                       , -- 07  
                        @dfecemi                                       , -- 08  
                        @dfecven                                       , -- 09  
                        @cinstser                                      , -- 10  
                        @ncodigo                                         -- 11  
                       )  
   end  
    INSERT INTO MDMO (  
                     mofecpro                                          , -- 01  
                     morutcart                                         , -- 02  
                     motipcart                                         , -- 03  
                     monumdocu                                         , -- 04
                     mocorrela        , -- 05
                     monumdocuo                                        , -- 06  
                     mocorrelao                                        , -- 07  
                     monumoper                                         , -- 08  
                     motipoper                                         , -- 09  
                     motipopero                                        , -- 10  
                     moinstser                                         , -- 11  
                     momascara                                         , -- 12  
                     mocodigo                                          , -- 13  
                 moseriado                                         , -- 14  
           mofecemi                                          , -- 15  
                     mofecven                                          , -- 16  
                     momonemi                                          , -- 17  
                     motasemi                                          , -- 18  
                     mobasemi                                          , -- 19  
                     morutemi                            , -- 20  
              monominal                                  , -- 21  
                     movpresen                                         , -- 22  
                     momtps                                            , -- 23  
                     momtum                                            , -- 24  
                     momtum100                                         , -- 25  
                     monumucup                                         , -- 26  
                     motir                                             , -- 27  
                     mopvp                                             , -- 28  
                     movpar                                            , -- 29  
                     motasest                                          , -- 30  
                     mofecinip                                         , -- 31  
                     mofecvenp                                         , -- 32  
                     movalinip                                         , -- 33  
                     movalvenp                                         , -- 34  
                     motaspact                                         , -- 35  
                     mobaspact                                         , -- 36  
                     momonpact                                         , -- 37  
                     moforpagi                                         , -- 38  
                     moforpagv                                         , -- 39  
                     mocondpacto                                         , -- 40  
                     morutcli                                          , -- 41  
              mocodcli            ,   
                     motipret                                          , -- 42  
                     mohora                                            , -- 43  
                     mousuario                                         , -- 44  
                     moterminal                                        , -- 45  
                     mocapitali   , -- 46  
                     movpreseni                                        , -- 47  
                     mocapitalp                                        , -- 48  
                     movpresenp                                        , -- 49                       
                     movalcomp                                         ,  
              modcv            ,   
              moclave_dcv           ,  
              momtopfe   ,   -- Este campo se reutiliza para grabar el tipo cambio que se utilizo al inicio de los   
     -- pactos MX (VGS 10/2004), ya que no existen limites PFE / CCE , etc en Corbanca)   
              momtocce                   ,  
                     ----------------------------  
                     codigo_carterasuper ,  
              tipo_cartera_financiera ,  
              mercado   ,  
              sucursal   ,  
              id_sistema   ,  
              fecha_pagomañana  ,  
              laminas   ,  
              tipo_inversion  ,  
              cuenta_corriente_inicio ,  
              sucursal_inicio  ,  
              cuenta_corriente_final ,  
              sucursal_final  ,  
              moobserv   ,  
              monominalp,  
       fecha_compra_original,  
       valor_compra_original,  
       valor_compra_um_original,  
       tir_compra_original,  
       valor_par_compra_original,  
       porcentaje_valor_par_compra_original ,   
       id_libro,     
		 moTirTran,  
		 moVPTran,  
		 moDifTran_MO,  
		 moDifTran_CLP,  

--LD1_COR_035----------------------------------------------
			Ejecutivo,
			Tipo_Custodia,
		    Tasa_Contrato,
		    Valor_Contable,
		    sub_forma_ini,
		    sub_forma_venc,
		    moTasCFdo

--LD1_COR_035----------------------------------------------
 


)  
 VALUES (  
                     @dfecpro                                          , -- 01  
                     @nrutcart                                         , -- 02  
                     @ctipcart                                         , -- 03  
                  @nnumdocu                                         , -- 04  
                     @ncorrela                                         , -- 05  
                     @nnumdocu                                         , -- 06  
                     @ncorrela                                         , -- 07  
                     @nnumdocu                                         , -- 08  
                     'CI'                                              , -- 09  
                     'CI'                                              , -- 10  
                     @cinstser                                         , -- 11  
                     @cmascara                                         , -- 12  
                     @ncodigo  , -- 13  
                     @cseriado              , -- 14  
                     @dfecemi                                , -- 15  
                     @dfecven                                          , -- 16  
                     @nmonemi                                          , -- 17  
                     @ntasemi                                          , -- 18  
                     @nbasemi                                          , -- 19  
                     @nrutemi                                          , -- 20  
                     @nnominal                                         , -- 21  
                     @nvptirc                                          , -- 22  
                     @nvptirc                                          , -- 23  
                     @nvptirc                                          , -- 24  
                     @nvp100                                           , -- 25  
                     @nnumucup                                         , -- 26  
                     @ntir                                             , -- 27  
                     @npvp                                             , -- 28  
                     @nvpar                                            , -- 29  
                     @ntasest                                          , -- 30  
                     @dfecpro                                          , -- 31  
                     @dfecvtop                                         , -- 32  
                     @nvalinip                                         , -- 33  
                     @nvalvtop                                         , -- 34  
                     @ntaspact                                         , -- 35  
                     @nbaspact                                         , -- 36  
                     @nmonpact                                         , -- 37  
                     @nforpagi                                         , -- 38  
                     @nforpagv                                         , -- 39  
                     @ctipcust                                         , -- 40  
                     @nrutcli                                          , -- 41  
              @ncodcli          ,   
                     @cretiro                                          , -- 42  
                 @chora                                            , -- 43  
                     @cusuario                        , -- 44  
                     @cterminal                                        , -- 45  
                     @nvptirc                                          , -- 46  
                     @nvptirc                                          , -- 47  
                     @nvalinip                                         , -- 48  
                     @nvptirc, --@nvalinip                                         , -- 49  
                     @nvptirc, --@nvalinip                                         , -- 52  
                    @ccustodia      ,  
              @cclave_dcv,  
               @nTcInicio  , -- VGS  
              @ftotalcce  ,  
                     ------------------------------------  
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
          @sucursal_final   ,  
          @observ    ,  
                     ROUND(@nnominal*@nvalmon,0),  
       @dfecpro,  
       @nvptirc,  
       ROUND((@nvptirc/@nvalmon),4),  
       @ntir,  
       @nvpar,  
       @npvp,  
       @id_libro,
		 @nTirTran,  
		 @nVpTran,  
		 @nDifTran_MO,  
		 @nDifTran_CLP, 

--LD1_COR_035----------------------------------------------
			@Ejecutivo,
			CASE WHEN @ccustodia ='C' THEN 1 ELSE  CASE WHEN @ccustodia='P' THEN 2 ELSE 3 END END,--@cTipoCustodia,
			@ntaspact,
			@nvalinip ,
			@subformaPago,
			@subformaPago2,
			@nTasCFdo
--LD1_COR_035----------------------------------------------

 
 )  
 IF @@error=0  
 BEGIN  --** confirmar transacción. **--  
  SELECT @cok = '1'  
 END  
 ELSE  
 BEGIN  --** abortar transacción. **--  
  SELECT @cok = '0'  
 END  
 SELECT @cok  
 RETURN  
END   /* fin procedimiento */  

GO
