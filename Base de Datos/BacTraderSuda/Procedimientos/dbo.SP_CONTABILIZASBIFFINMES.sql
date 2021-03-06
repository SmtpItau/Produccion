USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTABILIZASBIFFINMES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_CONTABILIZASBIFFINMES]
					 (
             @Fecha DATETIME ,  
      @indi  numeric (01),  
       @var   numeric (02)  
      )  --( @cuser char(8), @cterminal char(12) )  
 as  
 begin  
 declare @cserie  char(12)  
 declare @ntir  numeric (09,4)  
 declare @nvalpresen numeric (19,4)  
-- declare @nfactor numeric (09,4)  
 declare @nvalmer numeric (19,4)  
 declare @ndiferen numeric (19,4)  
 declare @dfeccal datetime  
 declare @mascara char(12)  
 declare @cod_ser numeric (03,0)  
 declare @rutemi  numeric (09,0)  
-- declare @tasest  numeric (09,4)  
 declare @nominal        numeric (19,4)   
 declare @tipo_operacion char(03)  
 declare @codigo_carterasuper char(01)  
 declare @rmrutcart  numeric(09,0)  
 declare @rmnumdocu numeric(10,0)  
 declare @rmnumoper numeric(10,0)  
 declare @rmcorrela numeric(03,0)  
 declare @rmcodigo numeric(05,0)    
 declare @moneda_emision numeric(03,0)  
 declare @Tipo_Cartera_Financiera char(05)	-->	SE CAMBIA DE LARGO 1 A 5 CARACTERES
 declare @tmseriado  char(01)   
 declare @codCarteraFin numeric(01)  
 declare @Indicadaor_rever char(1)  
  
  
 DECLARE @dfecfmes DATETIME  
 DECLARE @Fecha_prox DATETIME  
 DECLARE @Rut_prop   NUMERIC(9,0)  
   
 SELECT  @fecha_prox = acfecprox   
        ,@Rut_prop   = acrutprop   
 FROM mdac  
  
----select @Fecha,@indi,@var  
  
        SELECT @dfecfmes = DATEADD(DAY,DATEPART(DAY,@fecha_prox) * -1,@fecha_prox)  
  
--select @dfecfmes ,'fecmes'  
  
 IF  @dfecfmes > @Fecha  AND  @dfecfmes < @fecha_prox  
      if @var=1  
  SELECT  @Fecha = @dfecfmes     
    
  
  
 select @dfeccal = MDAC.acfecproc  
        from  MDAC  
  
  
declare cursor1 cursor   
for select tipo_operacion,  
    codigo_carterasuper,   
    rmrutcart,  
    rmnumdocu,   
    rmnumoper,   
    rmcorrela,   
    rmcodigo,   
    moneda_emision,   
    rminstser,              
    tasa_mercado,   
    valor_presente,  
    valor_mercado,   
    diferencia_mercado,   
    rut_emisor,   
    tmmascara,   
    rmcodigo,   
    valor_nominal,   
--    Tipo_Cartera_Financiera ,  
    tmseriado/*,  
    ISNULL((SELECT tbcodigo1 FROM VIEW_TABLA_GENERAL_DETALLE  WHERE TBCATEG = 204 AND SUBSTRING(tbglosa,1,1) = Tipo_Cartera_Financiera),0)  */  
  
    from VALORIZACION_MERCADO    
    where  @Fecha = fecha_valorizacion  
       AND (rmcodigo <> 20  or   
            rut_emisor <> @Rut_prop )  
  
-- SELECT * FROM VALORIZACION_MERCADO where fecha_valorizacion ='20030624'  
 /*--------------------------------------------------  
  * borrar movimiento que refleje la contabilidad  
  *-------------------------------------------------*/  
  
 delete from MDMO  
 where motipoper='tm' and @indi = 1  
  
----select *  from mdmo where motipoper='TM'  
  
 /*--------------------------------  
  * sacar fecha de proceso  
  *-------------------------------*/   
  
 open cursor1  
 fetch next from cursor1 into    @tipo_operacion ,  
      @codigo_carterasuper ,  
     @rmrutcart ,   
     @rmnumdocu,  
     @rmnumoper,  
     @rmcorrela,   
     @rmcodigo,   
     @moneda_emision,        
      @cserie,  
     @ntir,   
     @nvalpresen,    
     @nvalmer,   
     @ndiferen,   
     @rutemi,   
     @mascara,   
     @cod_ser,    
     @nominal,  
---          @Tipo_Cartera_Financiera ,  
     @tmseriado /*,  
     @codCarteraFin */  
  
 select @dfeccal = MDAC.acfecproc  
        from  MDAC  
  
IF @var = -1  
   set @Indicadaor_rever = 'R'     
ELSE IF @var = 1   
   set @Indicadaor_rever = ' '     
  
  
  
--set  @codCarteraFin =  (SELECT tbcodigo1 FROM VIEW_TABLA_GENERAL_DETALLE  WHERE TBCATEG = 204 AND SUBSTRING(tbglosa,1,1) = @Tipo_Cartera_Financiera)  
  
  
  
 while ( @@fetch_status <> -1 )  
 begin  
  
  insert MDMO ( mofecpro  ,   
    morutcart ,  
--    motipcart ,  
    monumdocu ,  
    mocorrela ,  
    monumdocuo,  
    mocorrelao,  
    monumoper ,  
    motipoper ,  
    motipopero,  
    moinstser ,  
    momascara ,  
    mocodigo  ,  
    moseriado ,  
    mofecemi  ,  
    mofecven  ,  
    momonemi  ,  
    motasemi  ,  
    mobasemi  ,  
    morutemi  ,  
    monominal ,  
    movpresen ,  
    momtps    ,  
    momtum    ,  
    momtum100 ,  
monumucup ,  
    motir     ,  
    mopvp     ,  
    movpar    ,  
    motasest  ,  
    mofecinip ,  
    mofecvenp ,  
    movalinip ,  
    movalvenp ,  
    motaspact ,  
    mobaspact ,  
    momonpact ,  
    moFORPAGi ,  
    moFORPAGv ,  
    motipobono ,  
    mocondpacto ,  
    mopagohoy ,  
    morutcli  ,  
    mocodcli  ,  
    motipret  ,  
    mohora    ,  
    mousuario ,  
    moterminal,  
    mocapitali,  
    mointeresi,  
    moreajusti,  
    movpreseni,  
    mocapitalp,  
    mointeresp,  
    moreajustp,  
    movpresenp,  
    motasant  ,  
    mobasant  ,  
    movalant  ,  
    mostatreg ,  
    movpressb ,  
    modifsb    ,  
    codigo_carterasuper /*,  
    Tipo_Cartera_Financiera*/   )  
  values ( @dfeccal,  
    @rmrutcart,  
  --  @codCarteraFin,  
    @rmnumdocu,  
    @rmcorrela,  
    0,  
    0,  
    @rmnumoper,  
    'TM',  
    @tipo_operacion , --'TM',  
    @cserie,  
    @mascara,  
    @cod_ser,  
    @tmseriado , --'S',  
    '',  
    '',  
    @moneda_emision,  
    0,  
    0,  
    @rutemi,  
    @nominal,  
    @nvalpresen,  
    0,  
    0,  
    0,  
    0,  
    @ntir,  
    0,  
    0,  
    --@tasest,  
    0,  
    '',  
    '',  
    0,  
    0,  
    0,  
    0,  
    0,  
    0,  
    0,  
    '',  
    '',  
    '',  
    @rutemi,  
    1,  
    '',  
    convert( char(15),@dfeccal,108) ,  
    '',--@cuser,  
    '',--@cterminal,  
    0,  
    0,  
    0,  
    0,  
    0,  
    0,  
    0,  
    0,  
    0,  
    0,  
    0,  
    @Indicadaor_rever,  
    @nvalmer,  
    @ndiferen  * 1, --* @var,  
    @codigo_carterasuper /*,  
    @Tipo_Cartera_Financiera     */  
   )  
   
  
  
  
  fetch next from cursor1 into  @tipo_operacion,   
     @codigo_carterasuper ,  
    @rmrutcart,    
    @rmnumdocu,  
    @rmnumoper,   
    @rmcorrela,   
    @rmcodigo,   
    @moneda_emision,        
    @cserie,  
    @ntir,   
    @nvalpresen,    
    @nvalmer,   
    @ndiferen,   
    @rutemi,   
    @mascara,   
    @cod_ser,    
    @nominal,  
--        @Tipo_Cartera_Financiera ,  
    @tmseriado /*,  
    @codCarteraFin*/  
   
 end  
 close cursor1  
 deallocate cursor1  
     
 end  
  
  
-- SELECT * FROM VALORIZACION_MERCADO  
-- SELECT tbcodigo1 FROM VIEW_TABLA_GENERAL_DETALLE  WHERE TBCATEG = 204 AND SUBSTRING(tbglosa,1,1) =  'T'-- @Tipo_Cartera_Financiera  
-- select  * from mdmo where monumdocu=833350  
-- Sp_ContabilizaSbif '20020802',-1  
  

GO
