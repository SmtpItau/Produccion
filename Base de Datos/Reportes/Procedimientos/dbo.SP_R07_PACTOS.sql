USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_R07_PACTOS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_R07_PACTOS]
(
		@dFechaProceso		 DateTime = NULL	
)
AS  
BEGIN
SET NOCOUNT ON

Declare @SEP VarChar(1); Set @SEP = ';'

Declare @TipoSalida	bit = 0	--flag para definir tipo de salida SQL



if @dFechaProceso is null
begin
	select @dFechaProceso=acfecproc from bactradersuda..mdac
end

--set @dFechaProceso ='20210530'

	Declare @Pacto	as Table (
		fechaproceso								datetime,
		localidad									varchar(10),--3),
		vehiculo									varchar(20),--15),
		tipoproducto								varchar(30),--25),
		numerooperacion								varchar(50),--15),
		tipoflujo									VARCHAR(3),
		producto									varchar(15),
		cliente										varchar(15),--numeric(9),
		nombrecliente								VARCHAR(70),
		fechaemision								datetime,
		fechavencimiento							datetime,
		tenor										int,
		codigocarterafinanciera						int,--NUMERIC(9),
		carterafinanciera							VARCHAR(50),
		codigocarteranormativa						VARCHAR(20),--varchar(1),
		carteranormativa							VARCHAR(50),
		codigolibro									int,
		libro										VARCHAR(50)	,
		codigomoneda								int,--NUMERIC(9),
		moneda										VARCHAR(5),--3),
		montoinicio									numeric(19,4),--numeric(24,8) ,
		tasa										numeric(19,4),--numeric(24,8) ,
		montovencimiento							numeric(19,4),--numeric(24,8) ,
		monedavalorpresente							VARCHAR(10),--3),
		valorpresentemo								numeric(19,4),--numeric(24,8) ,
		valorpresente								numeric(19,4),--numeric(24,8) ,
		interesdiario								numeric(19,4),--numeric(24,8) ,
		reajustediario								numeric(19,4),--numeric(24,8) ,
		interesacumulado							numeric(19,4),--numeric(24,8) ,
		reajusteacumulado							numeric(19,4),--numeric(24,8) ,
		proximovalorpresente						numeric(19,4),--numeric(24,8) ,
		proximovalorpresentemo						numeric(19,4),--numeric(24,8),
		tip_crt										VARCHAR	(5)		,
		[plazo_al_vcto]								int				,
		[cod_subcrt_norm]							VARCHAR(20)		,
		[val_ini_pacto_en_pesos]					numeric(19,4),--NUMERIC (24,8)	,
		[val_final_del_pacto_mo]					numeric(19,4),--NUMERIC (24,8)	,
		[interes_mensual]							numeric(19,4),--NUMERIC (24,8)	,
		[reajuste_mensual]							numeric(19,4),--NUMERIC (24,8)	,
		[cod_cta_cont]								VARCHAR(20)		,
		[cta_ifrs]									VARCHAR(20)		,
		documento									NUMERIC(9)		,
		correlativo									NUMERIC(9)	    
	)

Declare @R07_PACTO_SALIDA	as Table
	(
	REG_SALIDA		Varchar(700))

	Insert INTO @Pacto
	SELECT	rsfecctb  
            ,	'CL'  
            ,	'CORPBANCA'  
            ,	 case when rscartera = '112' THEN 'Compra con Pacto' ELSE 'Venta con Pacto' END  
            ,	 cast( rsnumdocu  as varchar(15)) + '-' +  cast(rsnumoper  as varchar(15)) +'-'+ cast(rscorrela as varchar(15)) 
            ,	 case when rscartera = '112' then 'ACT' else 'PAS' end  
            ,	 rstipopero  
		    ,	 CAST( rsrutcli AS VARCHAR(10) ) + Cli.cldv  
		    ,    Cli.clnombre  
            ,    rsfecinip  
            ,    rsfecvtop  
            ,    DATEDIFF( DAY, rsfecctb, rsfecvtop )  
          	,	 rstipcart			
			,	 ltrim(convert(varchar,fi.tbglosa))	 
			,	 rs.codigo_carterasuper	 
			,	 ltrim(convert(varchar,su.tbglosa)) 
			,	 rsid_libro			 
			,	 ltrim(convert(varchar,li.tbglosa))	 
            ,    rsmonpact  
            ,    mnnemo 
            ,    SUM(rsvalinip)  
            ,    rstaspact  
            ,    SUM(rsvalvtop)  
            ,    'CLP'  
            ,    SUM(rsvppresenx * case when rscartera = '112' then 1.0 else -1.0 end)  
            ,    SUM(rsvppresenx * case when rscartera = '112' then 1.0 else -1.0 end)  
            ,    SUM(rsinteres * case when rscartera = '112' then 1.0  else -1.0 end )  
            ,    SUM(rsreajuste * case when rscartera = '112' then 1.0  else -1.0 end)  
            ,    SUM(rsinteres_acum * case when rscartera = '112' then 1.0  else -1.0 end)  
            ,    SUM(rsreajuste_acum * case when rscartera = '112' then 1.0  else -1.0 end)  
            ,    SUM(rsvppresenx * case when rscartera = '112' then 1.0  else -1.0 end)  
            ,    SUM(rsvppresenx * case when rscartera = '112' then 1.0  else -1.0 end)  
			,	 ''				as	tip_crt	
			,	datediff(day,rsfecctb,rsfecvtop)			as	[plazo_al_vcto]	
			,	''				as  [cod_subcrt_norm]	
			,	sum(rsvalcomp)	as  [val_ini_pacto_en_pesos]
			,	0				as  [val_final_del_pacto_mo]
			,	sum(rsintermes)	as	[interes_mensual]							
			,	sum(rsreajumes)	as	[reajuste_mensual]						
			,	''				as  [cod_cta_cont]					
			,	''				as	[cta_ifrs]		
			,	rsnumdocu		as	documento					
			,	rscorrela		as correlativo		

   FROM	BacTraderSuda.dbo.mdrs				Rs	with(nolock)   
        left join  BacParamSuda.dbo.Cliente Cli	with(nolock)     ON  Cli.clrut         = rsrutcli  AND  Cli.clcodigo      = rscodcli  
        left join  BacParamSuda.dbo.Emisor  Emi	with(nolock)     ON  Emi.emrut         = rsrutemis  
        left join  BacParamSuda.dbo.Moneda  Mo	with(nolock)     ON  Mo.mncodmon	   = rsmonpact  
		left join  bacparamsuda.dbo.tabla_general_detalle li with(nolock)		ON li.tbcateg=1552 AND li.tbcodigo1 = rsid_libro
		left join  bacparamsuda.dbo.tabla_general_detalle fi with(nolock)		ON fi.tbcateg=204 AND fi.tbcodigo1 = rstipcart
		left join  bacparamsuda.dbo.tabla_general_detalle su with(nolock)		ON su.tbcateg=1111 AND su.tbcodigo1 = rs.codigo_carterasuper
    WHERE rsfecctb     = @dFechaProceso  AND rstipoper    = 'DEV'    AND rscartera    in ( '112', '115' )  
    GROUP BY  
            rsfecctb  , rscartera  , rsnumoper  , rsnumdocu, rscorrela, rstipopero  
        , CAST(rsrutcli AS VARCHAR(10) ) + Cli.cldv  , Cli.clnombre  , rsfecinip  
        , rsfecvtop  , rstipcart  , fi.tbglosa , rs.codigo_Carterasuper  
        , su.tbglosa , rsid_libro  , li.tbglosa  , rsmonpact  
        , mo.mnnemo  , rstaspact  


	--Actualización intereses, reajustes y valor presente  CI
  /*  UPDATE @Pacto
	SET  valorpresentemo			= rsvppresen
		, interesdiario				= rsinteres
		, reajustediario			= rsreajuste
		, interesacumulado			= rsinteres_acum
		, reajusteacumulado			= rsreajuste_acum
		, proximovalorpresente		= rsvppresenx
		, proximovalorpresentemo	= rsvppresenx
		, [interes_mensual]			= rs.rsintermes 
		, [reajuste_mensual]		= rs.rsreajumes
	from bactradersuda..mdrs rs
	where rs.rsfecha=@dFechaProceso and documento=rs.rsnumdocu and correlativo=rs.rscorrela and rscartera=112

	--Actualización intereses, reajustes y valor presente VI
	UPDATE @Pacto
	SET  valorpresentemo			= rsvppresen
		, interesdiario				= rsinteres
		, reajustediario			= rsreajuste
		, interesacumulado			= rsinteres_acum
		, reajusteacumulado			= rsreajuste_acum
		, proximovalorpresente		= rsvppresenx
		, proximovalorpresentemo	= rsvppresenx
		, [interes_mensual]			= rs.rsintermes 
		, [reajuste_mensual]		= rs.rsreajumes
	from bactradersuda..mdrs rs
	where rs.rsfecha=@dFechaProceso and documento=rs.rsnumdocu and correlativo=rs.rscorrela and rscartera=115
	*/
	--CUENTA CONTABLE CARTERA VENTA CON PACTO
	UPDATE @Pacto
	SET [cod_cta_cont] =CtaContable
	FROM @Pacto,
		BACTRADERSUDA..CARTERA_CUENTA   
	WHERE 
			Sistema		= 'BTR'  
		AND t_operacion	=	'VI'
		AND NumDocu		= documento  
		AND Correla		= correlativo  
		AND variable	= 'valor_venta'   
		
   -- CUENTA CONTABLE CARTERA COMPRAS CON PACTO 
	UPDATE @Pacto
	SET [cod_cta_cont] = CtaContable
	FROM @Pacto,
		BACTRADERSUDA..CARTERA_CUENTA   
	WHERE 
		 Sistema  = 'BTR'  
	AND t_operacion = 'CI'   
	AND t_movimiento = 'MOV'  
	AND NumDocu  = documento  
	AND	Correla  = correlativo  
	AND	variable = 'valor_compra'  

	UPDATE @Pacto
	SET nombrecliente		= UPPER(dbo.fnLimpiarCaracteres(nombrecliente))
	,   carterafinanciera	= UPPER(dbo.fnLimpiarCaracteres(carterafinanciera))

	IF @TipoSalida=0
	Begin
	--LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), flujoclp ) ) , '.', ','))
		/*Insert into @R07_PACTO_SALIDA
		select 
			LTRIM(CONVERT(CHAR(10),fechaproceso,105))		+ @SEP + LTRIM(localidad)					+ @SEP	+	LTRIM(vehiculo)								+ @SEP +
			LTRIM(tipoproducto)								+ @SEP + LTRIM(convert(varchar(50),numerooperacion))	+ @SEP  +   LTRIM(tipoflujo)	+ @SEP +
			LTRIM(tip_crt)									+ @SEP + LTRIM(cliente)						+ @SEP	+   LTRIM(CONVERT(CHAR(10),fechaemision,105)) 	+ @SEP +
			LTRIM(CONVERT(CHAR(10),fechavencimiento,105)) 	+ @SEP + LTRIM(plazo_al_vcto)				+ @SEP  +   LTRIM(codigocarterafinanciera)				+ @SEP +
			LTRIM(codigocarteranormativa)					+ @SEP + LTRIM(cod_subcrt_norm)				+ @SEP  + 	LTRIM(codigolibro)							+ @SEP +
			LTRIM(moneda)									+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), montoinicio ) ))					+ @SEP +  	LTRIM(RTRIM(CONVERT( NUMERIC(19,4), val_ini_pacto_en_pesos ) ) )				+ @SEP +
			LTRIM(RTRIM(CONVERT( NUMERIC(19,4), valorpresentemo ) ))				+ @SEP + LTRIM(valorpresente)							+ @SEP +	LTRIM(RTRIM(CONVERT( NUMERIC(19,4), tasa ) ))								+ @SEP +
			LTRIM(RTRIM(CONVERT( NUMERIC(19,4), val_final_del_pacto_mo ) ) )			+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), interesdiario ) ) )				+ @SEP 	+	LTRIM(RTRIM(CONVERT( NUMERIC(19,4), reajustediario ) ))		+ @SEP +
			LTRIM(RTRIM(CONVERT( NUMERIC(19,4), interes_mensual ) ) )				+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), reajuste_mensual ) ))			+ @SEP 	+	LTRIM(RTRIM(CONVERT( NUMERIC(19,4), interesacumulado ) ) )	+ @SEP +
			LTRIM(RTRIM(CONVERT( NUMERIC(19,4), reajusteacumulado ) ) )				+ @SEP + LTRIM(cod_cta_cont)							+ @SEP +	LTRIM(cta_ifrs)				+ @SEP  +
			LTRIM(producto)									+ @SEP + LTRIM(nombrecliente)				+ @SEP 	+	LTRIM(tenor)								+ @SEP +
			LTRIM(carterafinanciera)						+ @SEP + LTRIM(carteranormativa)			+ @SEP 	+	LTRIM(libro)								+ @SEP +
			LTRIM(codigomoneda)								+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), montovencimiento ) ))				+ @SEP +	LTRIM(monedavalorpresente)	+ @SEP +
			LTRIM(RTRIM(CONVERT( NUMERIC(19,4), proximovalorpresente ) ))			+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), proximovalorpresentemo ) ),' ',''))		AS   REG_SALIDA	
		from @Pacto

		Select  * from @R07_PACTO_SALIDA
		*/
		Insert into @R07_PACTO_SALIDA
		select 
			LTRIM(CONVERT(CHAR(10),fechaproceso,105))		+ @SEP + LTRIM(localidad)					+ @SEP	+	LTRIM(vehiculo)								+ @SEP +
			LTRIM(tipoproducto)								+ @SEP + LTRIM(convert(varchar(50),numerooperacion))	+ @SEP  +   LTRIM(tipoflujo)				+ @SEP +
			LTRIM(tip_crt)									+ @SEP + LTRIM(cliente)						+ @SEP	+   LTRIM(CONVERT(CHAR(10),fechaemision,105)) 	+ @SEP +
			LTRIM(CONVERT(CHAR(10),fechavencimiento,105)) 	+ @SEP + LTRIM(plazo_al_vcto)				+ @SEP  +   LTRIM(codigocarterafinanciera)				+ @SEP +
			LTRIM(codigocarteranormativa)					+ @SEP + LTRIM(cod_subcrt_norm)				+ @SEP  + 	LTRIM(codigolibro)							+ @SEP +
			LTRIM(moneda)									+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), montoinicio ) ) , '.', ','))    				+ @SEP +  LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), val_ini_pacto_en_pesos ) ) , '.', ','))								+ @SEP +
			LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), valorpresentemo ) ) , '.', ','))				+ @SEP +	LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), valorpresente ) ) , '.', ','))		+ @SEP +  LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), tasa ) ) , '.', ','))			   	+ @SEP +
			LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), val_final_del_pacto_mo ) ) , '.', ',')) 		+ @SEP +	LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), interesdiario ) ) , '.', ','))		+ @SEP +  LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), reajustediario ) ) , '.', ','))	+ @SEP +
			LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), interes_mensual ) ) , '.', ','))    			+ @SEP +	LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), reajuste_mensual ) ) , '.', ','))	+ @SEP +  LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), interesacumulado ) ) , '.', ',')) + @SEP +
			LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), reajusteacumulado ) ) , '.', ',')) 				+ @SEP +	LTRIM(cod_cta_cont)							+ @SEP +	LTRIM(cta_ifrs)			+ @SEP +
			LTRIM(producto)									+ @SEP + LTRIM(nombrecliente)				+ @SEP +	LTRIM(tenor)								+ @SEP +
			LTRIM(carterafinanciera)						+ @SEP + LTRIM(carteranormativa)			+ @SEP +	LTRIM(libro)								+ @SEP +
			LTRIM(codigomoneda)								+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), montovencimiento ) ) , '.', ','))				+ @SEP +	LTRIM(monedavalorpresente)	+ @SEP +
			LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), proximovalorpresente ) ) , '.', ','))			+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), proximovalorpresentemo ) ) , '.', ','))	AS   REG_SALIDA	
		from @Pacto

		Select  * from @R07_PACTO_SALIDA
	end
	Else
	Begin 
		select * from  @Pacto
	End
END

--GO
--EXEC SP_R07_PACTOS '20210422'



GO
