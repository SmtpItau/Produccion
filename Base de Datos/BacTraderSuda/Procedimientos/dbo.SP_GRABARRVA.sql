USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARRVA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARRVA]
  ( @nrutcart	NUMERIC (09,0)	,
    @nnumoper	NUMERIC (10,0)	,
    @ntasapacto	NUMERIC (09,4)	,
    @nvalant	NUMERIC (19,4)	,
    @cuser	CHAR(12)	,
    @cterminal	CHAR(12)	,
    @forpav	NUMERIC (05,0)	,
    @nTirTran	NUMERIC (19,4)	,
    @nVpTran	NUMERIC (19,4)	,
    @DifTran	NUMERIC	(19,4)	,
    @DifTranCLP NUMERIC (19,0),

--ITAU-----------------------------------------
		@subfpago		NUMERIC	(5,0),
		@nValOriginal   NUMERIC	(19,4),
		@Ejecutivo      NUMERIC (5),
		@Sucursal       NUMERIC (5),
		@observ         VARCHAR(70)
--ITAU-----------------------------------------

) WITH RECOMPILE
AS
BEGIN
         set nocount on

declare @nestado integer  ,
  @dfecvtop  datetime ,
  @ctipoper char (03) ,
  @dfeccal datetime ,
  @serie  char (12) ,
  @cforpago char(04) ,
  @iestado integer  ,
  @numopermo numeric (10,0) ,
  @monemi  numeric (03,0) ,
  @tasemi  numeric (09,4) ,
  @basemi  numeric (03,0) ,
  @rutemi  numeric (09,0) ,
  @mdse  char (01) ,
  @numdocu numeric (10,0) ,
  @correla numeric (03,0) ,
  @suma  numeric (10,0) ,
  @cod_ser integer  ,
  @nmonpact integer  ,
  @nvalmoni numeric (19,4) ,
  @nvalmonv numeric (19,4) ,
  @dfecinip datetime ,
  @dfecvenp datetime ,
  @nvalinip numeric (19,0) ,
  @nvalvtop numeric (19,4) ,
  @nintpac numeric (19,0) ,
  @ntaspact numeric (8,4) ,
  @nbaspact integer  ,
  @x  integer  ,
  @ndifpos numeric (19,0) ,
  @ndifneg numeric (19,0) ,
  @nrutcli numeric (10,0) ,
  @ncodcli numeric (10,0) ,  
  @nintpacdv numeric (19,0) ,
  @fnominal float  ,
  @nvalorant numeric (19,4) ,
  @nvalpacto numeric (19,0),

--ITAU-----------------------------------------
		@nvalinipo  numeric	(19,0),
		@nvalvtopo  numeric	(19,0),
		@freapacdv	FLOAT,
		@ForPIo		INTEGER,
		@ForpVo		INTEGER
--ITAU-----------------------------------------

 select @nmonpact = 0   ,
  @nbaspact = 0   ,
  @dfecinip = ''   ,
  @dfecvenp = ''   ,
  @nvalvtop = 0.0   ,
  @nvalinip = 0   ,
  @nintpac = 0   ,
  @ndifpos = 0   ,
  
  @ndifneg = 0   ,
  @nintpacdv = 0   ,
  @nvalmoni = 1.0   ,
  @nvalmonv = 1.0   ,
  @x  = 1   ,
  @suma  = 0
 create table #TEMP
            ( numdocu  numeric (10,0) not null ,
  correla  numeric (03,0) not null ,
  nominal  numeric (19,4) not null ,
  serie  char (12) not null ,
  cod_ser  numeric (05,0) not null ,
  valinip  numeric (19,0) not null ,
  valvtop  numeric (19,4) not null ,
  fecinip  datetime not null ,
  fecvenp  datetime not null ,
  monpact  integer  not null ,
  baspact  integer  not null ,
  intpact  numeric (19,0) not null ,
  rutcli  numeric(10,0) not null ,
  codcli  numeric(10,0) not null ,
  registro integer identity(1,1) not null ,
  valpacto numeric(19,0) not null,

--ITAU-----------------------------------------
		reapact     NUMERIC	(19,4)	not null,
		ForpagIo	INTEGER,
		ForpagVo	INTEGER	
--ITAU-----------------------------------------
 )
 insert into #TEMP
 select cinumdocu ,
  cicorrela , 
  cinominal ,
  ciinstser ,
  cicodigo ,
  civalinip ,
  civalvenp ,
  cifecinip ,
  cifecvenp ,
  cimonpact ,
  cibaspact ,
  ciinteresci ,
  cirutcli ,
  cicodcli ,
  civptirci,

--ITAU-----------------------------------------
		cireajustci,
		ciforpagi,
		ciforpagv	
--ITAU-----------------------------------------

 from MDCI
 where 
  cirutcart=@nrutcart 
 and cinumdocu=@nnumoper
 select @dfeccal = acfecproc from MDAC
 
 begin transaction   
 DELETE mdmo where monumoper = @nnumoper
 WHILE @x=1
 BEGIN
  
  select @serie = '*'
  
  set rowcount 1
  
  select 
   @numdocu = numdocu  ,
   @correla = correla  ,
   @fnominal = nominal  ,
   @nmonpact = monpact  ,
   @nvalinip = valinip  ,
   @nvalvtop = valvtop  ,
   @dfecinip = fecinip  ,
   @dfecvenp = fecinip  ,
   @serie  = isnull(serie,'*') ,
   @cod_ser = cod_ser  ,
   @nbaspact = baspact  ,
   @nintpacdv = intpact  ,
   @suma  = registro  ,
   @nrutcli = rutcli  ,
   @ncodcli = codcli  ,
   @nvalpacto = valpacto,

--ITAU-----------------------------------------
			@nvalinipo	= valinip,
			@nvalvtopo  = valpacto,
			@freapacdv	= reapact,
			@ForPIo		= ForpagIo,
			@ForpVo		= ForpagVo
--ITAU-----------------------------------------

  from 
   #TEMP
  where 
   registro>@suma
  set rowcount 0
  if @serie='*' break
  select @mdse  = inmdse from VIEW_INSTRUMENTO where incodigo=@cod_ser
  select @nintpac = 1.0 ,
   @nvalmonv = 1.0
  if @nmonpact<>999 AND @nmonpact <> 13
  begin
   select @nvalmoni = isnull(vmvalor,1.0) from VIEW_VALOR_MONEDA where vmcodigo=@nmonpact and vmfecha=@dfecinip
   SELECT @nvalmonv = ISNULL(vmvalor,1.0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonpact AND vmfecha=@dfeccal
  END

--  select @nintpac = round(round(@nvalinip/@nvalmoni,4)*((@ntasapacto/(@nbaspact*100.0))*datediff(day,@dfecinip,@dfeccal)+1)*@nvalmonv,0)-@nvalinip
--  select @nintpac = round(@nvalvtop/(((@ntasapacto/(@nbaspact*100.0))*datediff(day,@dfeccal,@dfecvenp))+1.0)*@nvalmonv,0)-@nvalinip
--  select @nvalinip,@ntasapacto,@nbaspact,datediff(day,@dfecinip,@dfeccal), @correla
  select  @nvalorant  = round(@nvalinip / @nvalmoni, 4)
  select @nvalorant = round(@nvalorant * (1.0 + (@ntasapacto / (@nbaspact*100.0)) * datediff(day,@dfecinip,@dfeccal)), 4)
  select  @nvalinip  = round(@nvalorant * @nvalmonv, 0)
  if @nvalpacto < @nvalinip select @ndifneg = @nvalinip  - @nvalpacto
  ELSE     SELECT @ndifpos = @nvalpacto - @nvalinip
  if @mdse='S'
   select @monemi = semonemi ,
    @tasemi = setasemi ,
    @basemi = sebasemi ,
    @rutemi = serutemi
   from VIEW_SERIE
   where secodigo=@cod_ser
  ELSE
   SELECT @monemi = nsmonemi ,
    @tasemi = nstasemi ,
    @basemi = nsbasemi ,
    @rutemi = nsrutemi
   FROM VIEW_NOSERIE
   WHERE 
    nsrutcart=@nrutcart 
   AND nsnumdocu=@numdocu 
   AND nscorrela=@correla 
   AND nscodigo=@cod_ser
  
  select @tasemi = isnull(@tasemi,0) 
  insert into 
  MDMO(
   mofecpro  ,
   morutcart  ,
   motipcart  ,
   monumdocu  ,
   mocorrela  ,
   monumdocuo  ,
   mocorrelao  ,
   monumoper   ,
   motipoper   ,
   motipopero  ,
   moinstser  ,
   momascara  ,
   mocodigo  ,
   moseriado  ,
   mofecemi  ,
   mofecven  ,
   momonemi  ,
   motasemi  ,
   mobasemi  ,
   morutemi  ,
   monominal  ,
   movpresen  ,
   momtps   ,
   momtum   ,
   momtum100  ,
   monumucup  ,
   motir   ,
   mopvp   ,
   movpar   ,
   motasest  ,
   mofecinip  ,
   mofecvenp  ,
   movalinip  ,
   movalvenp  ,
   motaspact  ,
   mobaspact  ,
   momonpact  ,
   moforpagi  ,
   moforpagv  ,
   motipobono  ,
   mocondpacto  ,
   mopagohoy  ,
   morutcli  ,
   mocodcli  ,
   motipret  ,
   mohora   ,
   mousuario  ,
   moterminal  ,
   mocapitali  ,
   mointeresi  ,
   moreajusti  ,
   movpreseni  ,
   mocapitalp  ,
   mointeresp  ,
   moreajustp  ,
   movpresenp  ,
   motasant  ,
   mobasant  ,
   movalant  ,
   mostatreg  ,
   movpressb  ,
   modifsb   ,
   monominalp   ,
   movalcomp    ,
   movalcomu    ,
   mointeres    ,
   moreajuste   ,
   mointpac     ,
   moreapac     ,
   moutilidad   ,
   moperdida    ,
   movalven     ,
   id_libro     ,
   moTirTran	,
   moVPTran	,
   moDifTran_MO ,	
   moDifTran_CLP,

--ITAU-----------------------------------------
		sub_forma_venc,
		Ejecutivo,
		moTasCFdo
--ITAU-----------------------------------------
   )
  select 
   @dfeccal  ,
   MDCI.cirutcart  ,
   MDCI.citipcart  ,
   MDCI.cinumdocu  ,
   MDCI.cicorrela  ,
   MDCI.cinumdocu  ,
   MDCI.cicorrela  ,
   MDCI.cinumdocu  ,
   'RVA'   ,
   'CI'   ,
   MDCI.ciinstser  ,
   MDCI.cimascara  ,
   MDCI.cicodigo  ,
   MDCI.ciseriado  ,
   MDCI.cifecemi  ,
   MDCI.cifecven  ,
   @monemi   ,
   @tasemi   ,
   @basemi   ,
   @rutemi   ,
   MDCI.cinominal  ,
   MDCI.civptirci  ,
   0   ,
   0.0   ,
   0.0   ,
   MDCI.cinumucup  ,
   MDCI.citircomp  ,
   0.0   ,
   0.0   ,
   0.0   ,
   MDCI.cifecinip  ,
   MDCI.cifecvenp  ,
   MDCI.civalinip  ,
   @nvalant  ,
   MDCI.citaspact  ,
   MDCI.cibaspact  ,
   MDCI.cimonpact  ,
   MDCI.ciforpagi  ,
   @forpav   ,
   ''   ,
   ''   ,
   ''   ,
   MDCI.cirutcli  ,
   MDCI.cicodcli  ,
   ''   ,
   convert(char(15),getdate(),108),
   @cuser   ,
   @cterminal  ,
   0   ,
   0   ,
   0   ,
   0   ,
   MDCI.civalinip  ,
   (@nvalant - MDCI.civalinip ),
   0   ,
   0   ,
   @ntasapacto  ,
   MDCI.cibaspact  ,
   @nvalant  ,
   ' '   ,
   0   ,
   0   ,
   MDCI.cinominalp  ,
   MDCI.civalcomp  ,
   MDCI.civalcomu  ,
   0   ,
   0   ,
   @nintpac  ,
   MDCI.cireajustci ,
   @ndifpos      ,
   @ndifneg      ,
   @nvalvtop     ,
   MDCI.id_libro ,
   @nTirTran	 ,
   @nVpTran	 ,
   @DifTran	 ,
   @DifTranCLP,
--ITAU-----------------------------------------
		@subfpago,
		@Ejecutivo,
		MDCI.ciTasCFdo
--ITAU-----------------------------------------
  from  
   MDCI
  where  
   MDCI.cirutcart=@nrutcart 
  and  MDCI.cinumdocu=@nnumoper 
  and MDCI.cicorrela=@correla
  if @@error<>0 
  begin
                        
   set nocount off
   rollback transaction
   select 0, 'Problemas en grabaci¢n de reventa anticipada en actualizacion de tabla movimiento'
   RETURN 1
  END

   
  INSERT INTO MDANT_CI
  SELECT *
  FROM  MDCI 
  WHERE cinumdocu=@nnumoper 
  AND cicorrela=@correla 
  AND cirutcart=@nrutcart


  delete from MDCI 
  where  cinumdocu=@nnumoper 
  and  cicorrela=@correla 
  and cirutcart=@nrutcart
  IF @@error<>0 BEGIN
          set nocount off
     rollback transaction
   SELECT 0, 'Problemas en grabaci¢n de reventas anticipadas en eliminacion de tabla de compras con pacto' 
   RETURN 1
  END


  INSERT INTO MDANT_CO
  SELECT *
  FROM  MDCO
  WHERE conumdocu=@nnumoper 
  AND  corutcart=@nrutcart

  DELETE  FROM MDCO 
  WHERE  conumdocu=@nnumoper 
  AND  corutcart=@nrutcart
  IF @@error<>0
  BEGIN
                        SET NOCOUNT OFF
   ROLLBACK TRANSACTION
   SELECT 0, 'Problemas en grabaci¢n de reventas anticipadas en eliminacion de tabla de cortes' 
   RETURN 1
  END

  INSERT INTO MDANT_DI (dirutcart, ditipcart, dinumdocu, dicorrela, dinumdocuo, dicorrelao, ditipoper, diserie, diinstser, digenemi, dinemmon, dinominal, ditircomp, dipvpcomp, divptirc, dipvpmcd, ditirmcd, divpmcd100, divpmcd, divptirci, difecsal, dinumucup, dicapitalc, diinteresc, direajustc, dicapitaci, diintereci, direajusci, dibase, dimoneda, diintermes, direajumes, codigo_carterasuper, Tipo_Cartera_Financiera, Mercado, Sucursal, Id_Sistema, Fecha_PagoMañana, Laminas, Tipo_Inversion, Estado_Operacion_Linea)
  SELECT                dirutcart, ditipcart, dinumdocu, dicorrela, dinumdocuo, dicorrelao, ditipoper, diserie, diinstser, digenemi, dinemmon, dinominal, ditircomp, dipvpcomp, divptirc, dipvpmcd, ditirmcd, divpmcd100, divpmcd, divptirci, difecsal, dinumucup, dicapitalc, diinteresc, direajustc, dicapitaci, diintereci, direajusci, dibase, dimoneda, diintermes, direajumes, codigo_carterasuper, Tipo_Cartera_Financiera, Mercado, Sucursal, Id_Sistema, Fecha_PagoMañana, Laminas, Tipo_Inversion, Estado_Operacion_Linea 
  FROM MDDI   WHERE dinumdocu=@nnumoper 
  AND dirutcart=@nrutcart


  DELETE FROM MDDI 
  WHERE dinumdocu=@nnumoper 
  AND dirutcart=@nrutcart
  IF @@error<>0
  BEGIN
                        SET NOCOUNT OFF
   ROLLBACK TRANSACTION
   SELECT 0, 'Problemas en grabaci¢n de reventas anticipadas en eliminacion de tabla de disponibilidad' 
   RETURN 1
  END
  CONTINUE  
 END
 SELECT @nnumoper,'Operacion de Reventa Anticipada finalizada con exito'
 SELECT @cforpago  =CONVERT(CHAR(4),@forpav)

        SET NOCOUNT OFF
        SELECT 'OK'
 COMMIT TRANSACTION
END

GO
