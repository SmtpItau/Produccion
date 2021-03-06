USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[QUERY_RESULTADO_MESA_ENTREFECHAS_2]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[QUERY_RESULTADO_MESA_ENTREFECHAS_2]
	(	@FechaDesde			DATETIME
	,	@FechaHasta			DATETIME
	,	@MedaDistibucion	int = 1
	,	@Pivotal			int = 0				--> Pivotal
	,	@nRut				numeric(11) = 0		--> Pivotal
	)
as
begin

	set nocount on

	if @Pivotal = 1
	begin
		TRUNCATE TABLE dbo.TBL_RESULTADOS_MESA_PIVOTAL
	end

	declare @dFechaProceso   datetime
		set @dFechaProceso   = ( SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )          
	      
	declare @dFechaAnterior  datetime
		set @dFechaAnterior  = ( SELECT acfecante FROM BacTraderSuda.dbo.MDAC with(nolock) )          

	if @dFechaProceso < @FechaDesde or @dFechaProceso < @FechaHasta
	begin
		return
	end

	CREATE TABLE #RESULTADOS_MESA
	(	Modulo				CHAR(3)
	,	Producto			VARCHAR(50)
	,	Numero_Operacion	NUMERIC(9)
	,	Documento			NUMERIC(9)
	,	Correlativo			NUMERIC(21,4)
	,	Serie				VARCHAR(20)
	,	RutCliente			NUMERIC(12)
	,	CodCliente			INT
	,	DvCliente			CHAR(1)
	,	NombreCliente		VARCHAR(150)
	,	TipoOperacion		VARCHAR(25)
	,	Monto				NUMERIC(21,4)
	,	MonTransada			CHAR(5)
	,	MonConversion		CHAR(5)
	,	TCCierre			NUMERIC(21,4)
	,	TCCosto				NUMERIC(21,4)
	,	ParidadCierre		NUMERIC(21,4)
	,	ParidadCosto		NUMERIC(21,4)
	,	MontoPesos			NUMERIC(21,4)
	,	Operador			VARCHAR(15)
	,	MontoDolares		NUMERIC(21,4)
	,	ResultadoMesa		NUMERIC(21,4)
	,	Fecha				DATETIME
	,	Relacionado			VARCHAR(35)
	,	FolioRelacionado	NUMERIC(9)
	--	Nuevos
	,	FechaEmision		DATETIME
	,	FechaVcto			DATETIME
	)

    CREATE INDEX #ix_orden ON #RESULTADOS_MESA ( fecha, Modulo, Producto,  RutCliente, CodCliente, Numero_Operacion, Documento, Correlativo )      

	-->	   Renta Fija Moneda Nacional
	---------------------------------
	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BTR'        
		,   Producto            = CASE	WHEN Movto.motipoper = 'CP' THEN 'COMPRA PROPIA'
										WHEN Movto.motipoper = 'CI' THEN 'COMPRA C/ PACTO'
										WHEN Movto.motipoper = 'VP' THEN 'VENTA PROPIA'
										WHEN Movto.motipoper = 'VI' THEN 'VENTA C/ PACTO'
										WHEN Movto.motipoper = 'IB' THEN 'INTERBANCARIO'
									END
		,   Numero_Operacion    = Movto.monumoper
		,   Numero_Documento    = Movto.monumdocu
		,   Numero_Correlativo  = Movto.mocorrela
		,   Serie               = Movto.moinstser
		,   RutCliente          = clie.clrut
		,   CodCliente			= clie.clcodigo
		,   DvCliente           = clie.cldv
		,   NombreCliente       = clie.clnombre
		,   TipoOperacion       = CASE	WHEN Movto.motipoper = 'CP' THEN 'C'
										WHEN Movto.motipoper = 'CI' THEN 'C'
										WHEN Movto.motipoper = 'VP' THEN 'V'
										WHEN Movto.motipoper = 'VI' THEN 'V'
										WHEN Movto.motipoper = 'IB' THEN Movto.moinstser
									END
		,   Monto               = Movto.movpresen
		,   MonTransada         = Mone.mnnemo
		,   MonConversion       = Mone.mnnemo
		,   TCCierre            = Movto.motir	--> CASE WHEN Movto.motipoper in('VI')		THEN Movto.motaspact ELSE Movto.motir END
		,   TCCosto             = Movto.moTirTran
		,   ParidadCierre       = 0.0
		,   ParidadCosto        = 0.0
		,   MontoPesos          = CASE WHEN Movto.motipoper in('VI', 'VP')	THEN Movto.movalven ELSE Movto.movpresen END
		,   Operador            = Movto.mousuario
		,   MontoDolares        = 0.0
		,   ResultadoMesa       = Movto.moDifTran_CLP
		,   Fecha				= Movto.mofecpro
		,   Relacionado         = '--'
		,   FolioRelacionado    = 0
		,	FechaEmision		= Movto.mofecinip
		,	FechaVcto			= Movto.mofecvenp
	FROM	(	select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	monumdocu		= 0		--> monumdocu
					,	mocorrela		= 0		-->	mocorrela
					,	moinstser		= ''	--> moinstser
					,	movpresen		= SUM( movpresen )
					,	motir			= SUM( motir	 * movpresen) / SUM( movpresen )
					,	moTirTran		= SUM( moTirTran * movpresen) / SUM( movpresen )
					,	movalven		= SUM( movalven )
					,	mousuario		= mousuario
					,	moDifTran_CLP	= SUM( moDifTran_CLP )
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	moneda			= momonemi
					,	mofecinip		= mofecinip 
					,	mofecvenp		= mofecvenp
				from	BacTraderSuda.dbo.MDMO	with(nolock)
				where	mofecpro		BETWEEN @FechaDesde AND @Fechahasta
				and		motipoper		IN('CP', 'VP', 'IB' )	--> IN('CP', 'CI', 'VP', 'VI', 'IB')
				and		mostatreg		<> 'A'
				and	(	morutcli		= @nRut or @nRut = 0)
				group	
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonemi
					,	mofecinip 
					,	mofecvenp

				union

				select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	monumdocu		= 0		--> monumdocu
					,	mocorrela		= 0		-->	mocorrela
					,	moinstser		= ''	--> moinstser
					,	movpresen		= SUM( movpresen )
					,	motir			= SUM( motir	 * movpresen) / SUM( movpresen )
					,	moTirTran		= SUM( moTirTran * movpresen) / SUM( movpresen )
					,	movalven		= SUM( movalven )
					,	mousuario		= mousuario
					,	moDifTran_CLP	= SUM( moDifTran_CLP )
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	moneda			= momonemi
					,	mofecinip		= mofecinip 
					,	mofecvenp		= mofecvenp
				from	BacTraderSuda.dbo.MDMH	with(nolock)
				where	mofecpro		BETWEEN @FechaDesde AND @Fechahasta
				and		motipoper		IN('CP', 'VP', 'IB' )	--> IN('CP', 'CI', 'VP', 'VI', 'IB')
				and		mostatreg		<> 'A'
				and	(	morutcli		= @nRut or @nRut = 0)
				group	
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonemi
					,	mofecinip 
					,	mofecvenp

				union all

				select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	monumdocu		= 0		--> monumdocu
					,	mocorrela		= 0		-->	mocorrela
					,	moinstser		= ''	--> moinstser
					,	movpresen		= SUM( movpresen )
					,	motir			= SUM( motaspact * movpresen) / SUM( movpresen )
					,	moTirTran		= SUM( moTirTran * movpresen) / SUM( movpresen )
					,	movalven		= SUM( movalven )
					,	mousuario		= mousuario
					,	moDifTran_CLP	= MAX( moDifTran_CLP )
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	moneda			= momonpact
					,	mofecinip		= mofecinip 
					,	mofecvenp		= mofecvenp
				from	BacTraderSuda.dbo.MDMO	with(nolock)
				where	mofecpro		BETWEEN @FechaDesde AND @Fechahasta
				and		motipoper		IN('CI', 'VI')	--> IN('CP', 'CI', 'VP', 'VI', 'IB')
				and		mostatreg		<> 'A'
				and	(	morutcli		= @nRut or @nRut = 0)
				group	
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonpact
					,	mofecinip 
					,	mofecvenp

				union

				select	mofecpro		= mofecpro
					,	motipoper		= motipoper
					,	monumoper		= monumoper
					,	monumdocu		= 0		--> monumdocu
					,	mocorrela		= 0		-->	mocorrela
					,	moinstser		= ''	--> moinstser
					,	movpresen		= SUM( movpresen )
					,	motir			= SUM( motaspact * movpresen) / SUM( movpresen )
					,	moTirTran		= SUM( moTirTran * movpresen) / SUM( movpresen )
					,	movalven		= SUM( movalven )
					,	mousuario		= mousuario
					,	moDifTran_CLP	= MAX( moDifTran_CLP )
					,	morutcli		= morutcli
					,	mocodcli		= mocodcli
					,	moneda			= momonpact
					,	mofecinip		= mofecinip 
					,	mofecvenp		= mofecvenp
				from	BacTraderSuda.dbo.MDMH	with(nolock)
				where	mofecpro		BETWEEN @FechaDesde AND @Fechahasta
				and		motipoper		IN('CI', 'VI')	--> IN('CP', 'CI', 'VP', 'VI', 'IB')
				and		mostatreg		<> 'A'
				and	(	morutcli		= @nRut or @nRut = 0)
				group	
				by		mofecpro
					,	motipoper
					,	monumoper
					,	mousuario
					,	morutcli
					,	mocodcli
					,	momonpact
					,	mofecinip 
					,	mofecvenp
			)	Movto

			left join
			(	select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100)
				from	BacParamSuda.dbo.cliente with(nolock)
			)	Clie	On	Clie.clrut		= Movto.morutcli
						and Clie.clcodigo	= Movto.mocodcli

			left join	
			(	select	mncodmon, mnnemo = ltrim(rtrim( mnnemo ))
				from	BacParamSuda.dbo.Moneda with(nolock)
			)	Mone	on Mone.mncodmon = Movto.moneda


	-->	   Spot
	---------------------------------
	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BCC'        
		,   Producto            = Spot.motipmer
		,   Numero_Operacion    = Spot.monumope
		,   Numero_Documento    = 0
		,   Numero_Correlativo  = 0
		,   Serie               = ''
		,   RutCliente          = clie.clrut
		,   CodCliente          = clie.clcodigo
		,   DvCliente           = clie.cldv
		,   NombreCliente       = clie.clnombre
		,   TipoOperacion       = Spot.motipope
		,   Monto               = Spot.momonmo
		,   MonTransada         = Spot.mocodmon
		,   MonConversion       = Spot.mocodcnv
		,   TCCierre            = Spot.moticam
		,   TCCosto             =	CASE	WHEN isnull(comex.id, 'NO COMEX') = 'NO COMEX'	THEN Spot.motctra
											WHEN Spot.mocodmon  =	'USD'					THEN Spot.CMX_TC_Costo_Trad
											WHEN Spot.mocodmon  <>	'USD'					THEN Spot.motctra
										END
/*		,   TCCosto             = CASE	WHEN Spot.moterm = 'COMEX' AND Spot.mocodmon  = 'USD' THEN Spot.CMX_TC_Costo_Trad
										WHEN Spot.moterm = 'COMEX' AND Spot.mocodmon <> 'USD' THEN Spot.motctra
										ELSE Spot.motctra
									END	*/
		,   ParidadCierre       = Spot.moparme
		,   ParidadCosto        =	CASE	WHEN isnull(comex.id, 'NO COMEX') = 'NO COMEX'	THEN Spot.mopartr
											WHEN Spot.mocodmon	=	'USD'					THEN Spot.mopartr
											WHEN Spot.mocodmon	<>	'USD'					THEN Spot.CMX_TC_Costo_Trad
										END
/*		,   ParidadCosto        = CASE	WHEN Spot.moterm = 'COMEX' AND Spot.mocodmon  = 'USD' THEN Spot.mopartr
										WHEN Spot.moterm = 'COMEX' AND Spot.mocodmon <> 'USD' THEN Spot.CMX_TC_Costo_Trad
										ELSE Spot.mopartr  
									END	*/
		,   MontoPesos          = Spot.momonpe
		,   Operador            = Spot.mooper
		,   MontoDolares        = Spot.moussme
		,   ResultadoMesa       =	CASE	WHEN isnull(comex.id, 'NO COMEX') = 'NO COMEX'	THEN Spot.moDifTran_Clp 
											ELSE Spot.moResultado_Comercial_Clp 
										END
--		,   ResultadoMesa       = CASE WHEN Spot.moterm = 'COMEX' THEN Spot.moResultado_Comercial_Clp ELSE Spot.moDifTran_Clp END
		,   Fecha               = Spot.mofech
		,   Relacionado         = CASE	WHEN Spot.monumfut > 0 AND Spot.moterm = 'SWAP SPOT'								THEN 'Swap Spot'
										WHEN Spot.monumfut > 0 AND Spot.moterm = 'EMPRESAS' AND Spot.morutcli = 96665450	THEN 'Neteo'
										ELSE																					 'Sin Relación'     
									END
		,	FolioRelacionado    = CASE	WHEN Spot.monumfut > 0 AND Spot.moterm = 'SWAP SPOT'								THEN Spot.monumfut
										WHEN Spot.monumfut > 0 AND Spot.moterm = 'EMPRESAS' AND Spot.morutcli = 96665450	THEN Spot.monumfut
										ELSE																					 0
									END
		,	FechaEmision		= Spot.mofech
		,	FechaVcto			= Spot.mofech
	FROM	(	select	monumope, motipmer, motipope, mocodmon, mocodcnv, moterm, momonmo, moussme, moticam, motctra, moparme, mopartr, momonpe
					,	cmx_tc_costo_trad, moresultado_comercial_clp, modiftran_clp
					,	morutcli, mocodcli, mooper, monumfut, mofech
				from	BacCamSuda.dbo.Memo	with(nolock)
				where	mofech		BETWEEN @FechaDesde and @Fechahasta
				and		moestatus	<> 'A' 
				and		moterm		NOT IN('FORWARD', 'SWAP', 'OPCIONES', 'DATATEC', 'BOLSA')
				and	(	morutcli	= @nRut or @nRut = 0	)

				union

				select	monumope, motipmer, motipope, mocodmon, mocodcnv, moterm, momonmo, moussme, moticam, motctra, moparme, mopartr, momonpe
					,	cmx_tc_costo_trad, moresultado_comercial_clp, modiftran_clp
					,	morutcli, mocodcli, mooper, monumfut, mofech
				from	BacCamSuda.dbo.Memoh with(nolock)
				where	mofech		BETWEEN @FechaDesde and @Fechahasta
				and		moestatus	<> 'A' 
				and		moterm		NOT IN('FORWARD', 'SWAP', 'OPCIONES', 'DATATEC', 'BOLSA')
				and	(	morutcli	= @nRut or @nRut = 0	)
			)	Spot

			inner join
			(	select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100)
				from	BacParamSuda.dbo.cliente with(nolock)
			)	Clie	On	Clie.clrut		= Spot.morutcli
						and Clie.clcodigo	= Spot.mocodcli
			left join
			(	select	Id		= nemo
				from	BacParamSuda.dbo.TABLA_GENERAL_DETALLE with(nolock)
				where	tbcateg = 8602 
			)	comex	On	comex.id =  Spot.moterm



	-->	   Forward
	---------------------------------
	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BFW'
		,	Producto            = prod.descripcion
		,   Numero_Operacion    = Forward.monumoper
		,   Numero_Documento    = 0
		,   Numero_Correlativo  = Forward.motipcamSpot
		,   Serie               = ''
		,   RutCliente          = clie.clrut
		,   CodCliente          = clie.clcodigo
		,   DvCliente           = clie.cldv
		,   NombreCliente       = clie.clnombre
		,   TipoOperacion       = Forward.motipoper
		,   Monto               = Forward.momtomon1
		,   MonTransada         = mon1.mnnemo
		,   MonConversion       = mon2.mnnemo
		,   TCCierre            = CASE	WHEN Forward.mocodpos1 = 1  THEN Forward.motipcam
										WHEN Forward.mocodpos1 = 2  THEN Forward.mopremon1
										WHEN Forward.mocodpos1 = 3  THEN Forward.motipcam
										WHEN Forward.mocodpos1 = 13 THEN Forward.motipcam
									END
		,   TCCosto             = CASE	WHEN Forward.mocodpos1 = 1  THEN Forward.mopreciopunta        
										WHEN Forward.mocodpos1 = 2  THEN Forward.mopremon2        
										WHEN Forward.mocodpos1 = 3  THEN Forward.mopreciopunta        
										WHEN Forward.mocodpos1 = 13 THEN Forward.mopreciopunta        
									END
		,   ParidadCierre       = CASE	WHEN Forward.mocodpos1 = 1  THEN Forward.moparmon1
										WHEN Forward.mocodpos1 = 2  THEN Forward.motipcam
										WHEN Forward.mocodpos1 = 3  THEN 0.0
										WHEN Forward.mocodpos1 = 13 THEN 0.0
									END
		,   ParidadCosto        = CASE	WHEN Forward.mocodpos1 = 1  THEN Forward.moparmon2
										WHEN Forward.mocodpos1 = 2  THEN Forward.moparmon1
										WHEN Forward.mocodpos1 = 3  THEN 0.0
										WHEN Forward.mocodpos1 = 13 THEN 0.0
									END
		,   MontoPesos          = Forward.moequmon1
		,   Operador            = Forward.mooperador
		,   MontoDolares        = CASE Forward.mocodpos1 WHEN 2 THEN Forward.momtomon2 ELSE Forward.moequusd1 END
		,   ResultadoMesa       = CASE	WHEN Forward.mocodpos1 = 2 THEN ROUND(Forward.Resultado_Mesa * Forward.tipo_cambio, 0)
										ELSE							Forward.Resultado_Mesa
									END
		,   Fecha               = Forward.mofecha
		,   Relacionado         = CASE WHEN Cartera.var_moneda2  <> 0 THEN 'Operacion Relacionada MX/CLP' ELSE '--' END
		,   FolioRelacionado    = 0
		,	FechaEmision		= Forward.mofecha
		,	FechaVcto			= Forward.mofecvcto
	FROM	(	select	mofecha,  mocodpos1, monumoper, motipoper, mooperador, momtomon1, momtomon2, moequusd1, moequmon1, motipcamSpot
					,	motipcam, mopremon1, mopremon2, moparmon1, moparmon2, mopreciopunta, mocodmon1, mocodmon2
					,	mocodigo, mocodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio, mofecvcto
				from	BacFwdSuda.dbo.Mfmo		with(nolock)
						left  join 
						(	select	fecha, codigo_moneda, tipo_cambio
							from	BacParamSuda.dbo.valor_moneda_contable with(nolock)
							where	fecha	= (select acfecante from BacFwdSuda.dbo.Mfac with(nolock) )
						)	vcont	On	vcont.codigo_moneda = 994

				where	mofecha			between @FechaDesde and @Fechahasta
				and		moestado		<> 'A'
				and	(	mocodigo		= @nRut or @nRut = 0)

				union

				select	mofecha,  mocodpos1, monumoper, motipoper, mooperador, momtomon1, momtomon2, moequusd1, moequmon1, motipcamSpot
					,	motipcam, mopremon1, mopremon2, moparmon1, moparmon2, mopreciopunta, mocodmon1, mocodmon2
					,	mocodigo, mocodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio, mofecvcto
				from	BacFwdSuda.dbo.mfmoh with(nolock)
						left  join 
						(	select	fecha, codigo_moneda, tipo_cambio
							from	BacParamSuda.dbo.valor_moneda_contable with(nolock) 
							where	codigo_moneda			= 994
						)	vcont	On	vcont.fecha			= mofecha --> ctro.acfecante
									and vcont.codigo_moneda = 994

				where	mofecha			between @FechaDesde and @Fechahasta
				and		moestado		<> 'A'
				and	(	mocodigo		= @nRut or @nRut = 0)
			)	Forward

			left  join
			(	select	canumoper, var_moneda2
				from	BacFwdSuda.dbo.Mfca	with(nolock)
			)	Cartera On	Cartera.canumoper  = Forward.monumoper      

			inner join 
			(	select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
				from	BacParamSuda.dbo.cliente with(nolock)
			)	Clie	On	Clie.clrut		= Forward.mocodigo
						and Clie.clcodigo	= Forward.mocodcli

			inner join	
			(	select	codigo_producto, descripcion 
				from	BacParamSuda.dbo.Producto with(nolock)
				where	Id_Sistema = 'BFW'
			)	Prod	On Prod.codigo_producto = Forward.mocodpos1

			left  join 
			(	select	mncodmon, mnnemo 
				from	BacParamSuda.dbo.Moneda with(nolock)
			)	mon1	on mon1.mncodmon = Forward.mocodmon1        
            left  join 
            (	select	mncodmon, mnnemo 
				from	BacParamSuda.dbo.Moneda with(nolock)
			)	mon2	on mon2.mncodmon = Forward.mocodmon2        


	-->	   Swap
	---------------------------------
	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo				= 'PCS'        
		,   Producto			= CASE	WHEN Swap.tipo_swap = 1 THEN 'SWAP DE TASAS'    
										WHEN Swap.tipo_swap = 2 THEN 'SWAP DE MONEDAS'        
										WHEN Swap.tipo_swap = 3 THEN 'FORWARD RATE AGREETMEN'        
										WHEN Swap.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'        
									END
		,   Numero_Operacion	= Swap.numero_operacion        
		,   Documento			= 0        
		,   Correlativo			= 0        
		,   Serie				= ''        
		,   RutCliente			= clie.clrut        
		,   CodCliente			= clie.clcodigo        
		,   DvCliente			= clie.cldv        
		,   NombreCliente		= clie.clnombre        
		,   TipoOperacion		= 'C'        
		,   Monto				= Swap.compra_capital        
		,   MonTransada			= Swap.compra_moneda
		,   MonConversion		= Swap.venta_moneda
		,   TCCierre			= Swap.compra_valor_tasa        
		,   TCCosto				= Swap.Tasa_Transfer        
		,   ParidadCierre		= Swap.venta_valor_tasa        
		,   ParidadCosto		= Swap.Tasa_Transfer        
		,   MontoPesos			= Swap.venta_capital        
		,   Operador			= Swap.operador        
		,   MontoDolares		= 0        
		,   ResultadoMesa		= Swap.Res_Mesa_Dist_CLP         
		,   Fecha				= Swap.fecha_cierre
		,   Relacionado			= '--'        
		,   FolioRelacionado	= 0
		,	FechaEmision		= Swap.fecha_cierre
		,	FechaVcto			= Swap.fecha_termino
	from	(	select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa, Compra.Tasa_Transfer
				,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador,		Compra.Res_Mesa_Dist_CLP, Compra.fecha_cierre
				,		Venta_Moneda	= Venta.Venta_Moneda
				,		Compra_Moneda	= Mon.mnnemo
				,		compra.Rut_Cliente, compra.codigo_cliente
				,		Compra.fecha_termino
				from	BacSwapSuda.dbo.MovDiario Compra with(nolock)
						inner join (	select	Contrato = numero_operacion, Flujo = Min( numero_flujo )
										from	BacSwapSuda.dbo.MovDiario	with(nolock)
										where	fecha_cierre BETWEEN @FechaDesde AND @Fechahasta
										and		Estado <> 'C' and tipo_flujo = 1
										group by numero_operacion
									)	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
												and	GrpSwap.Flujo		= Compra.numero_flujo

						inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo
										from	BacSwapSuda.dbo.MovDiario	with(nolock)
												inner join (	select	mncodmon, mnnemo 
																from	BacParamSuda.dbo.Moneda with(nolock)
															)	Mon On	Mon.mncodmon	= Venta_Moneda
										where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
										and		Estado			<> 'C'
										and		tipo_flujo		= 2
									)	Venta	On	Venta.numero_operacion	= Compra.numero_operacion
												and	Venta.numero_flujo		= Compra.numero_flujo
						inner join (	select	mncodmon, mnnemo
										from	BacParamSuda.dbo.Moneda with(nolock)
									)	Mon On	Mon.mncodmon	= Compra.compra_Moneda
				where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
				and		Estado			<> 'C'
				and		tipo_flujo		= 1
				and	(	rut_cliente		= @nRut or @nRut = 0)

				union

				select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa, Compra.Tasa_Transfer
				,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador,		Compra.Res_Mesa_Dist_CLP, Compra.fecha_cierre
				,		Venta_Moneda	= Venta.Venta_Moneda
				,		Compra_Moneda	= Mon.mnnemo
				,		compra.Rut_Cliente, compra.codigo_cliente
				,		fecha_termino	= Compra.fecha_termino
				from	BacSwapSuda.dbo.MovHistorico	Compra	with(nolock)

						inner join (	select	Contrato = numero_operacion, Flujo = Min( numero_flujo )
										from	BacSwapSuda.dbo.MovHistorico with(nolock)
										where	fecha_cierre BETWEEN @FechaDesde AND @Fechahasta
										and		Estado <> 'C' and tipo_flujo = 1
										group by numero_operacion
									)	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
												and	GrpSwap.Flujo		= Compra.numero_flujo

						inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo
										from	BacSwapSuda.dbo.MovHistorico	with(nolock)
												inner join (	select	mncodmon, mnnemo 
																from	BacParamSuda.dbo.Moneda with(nolock)
															)	Mon On	Mon.mncodmon	= Venta_Moneda
										where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
										and		Estado			<> 'C'
										and		tipo_flujo		= 2
									)	Venta	On	Venta.numero_operacion	= Compra.numero_operacion
												and	Venta.numero_flujo		= Compra.numero_flujo

						inner join (	select	mncodmon, mnnemo
										from	BacParamSuda.dbo.Moneda with(nolock)
									)	Mon On	Mon.mncodmon	= Compra.compra_Moneda

				where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
				and		Estado			<> 'C'
				and		tipo_flujo		= 1
				and	(	rut_cliente		= @nRut or @nRut = 0)
			)	Swap

			inner join
			(	select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
				from	BacParamSuda.dbo.cliente with(nolock)
			)	Clie	On	Clie.clrut		= Swap.Rut_Cliente
						and Clie.clcodigo	= Swap.codigo_cliente


	-->	   Anticipos Swap Parte 1
	---------------------------------
	INSERT INTO #RESULTADOS_MESA
	select	Modulo				= 'PCS'
	,		Producto			= 'ANT ' + Prod.Glosa
	,		Numero_Operacion	= his.numero_operacion
	,		Documento			= 0
	,		Correlativo			= 0
	,		Serie				= ''
	,		RutCliente			= clie.Rut
	,		CodCliente			= clie.Codigo
	,		DvCliente			= clie.Dv
	,		NombreCliente		= clie.Nombre
	,		TipoOperacion		= 'C'
	,		Monto				= his.compra_capital
	,		MonTransada			= mon1.mnnemo
	,		MonConversion		= mon2.mnnemo
	,		TCCierre			= his.compra_valor_tasa
	,		TCCosto				= 0.0
	,		ParidadCierre		= venta.venta_valor_tasa
	,		ParidadCosto		= 0.0
	,		MontoPesos			= venta.venta_capital
	,		Operador			= Anticipo.operador			--> his.operador
	,		MontoDolares		= His.compra_capital
	,		ResultadoMesa		= Anticipo.Monto
	,		Fecha				= Anticipo.FechaAnticipo --> his.fecha_cierre
	,		Relacionado			= '--'
	,		FolioRelacionado	= 0
	,		FechaEmision		= Anticipo.FechaAnticipo
	,		FechaVcto			= Anticipo.FechaAnticipo
	from	BacSwapSuda.dbo.CarteraHis His	with(nolock)
			inner join (	select	numero_operacion, numero_flujo, tipo_flujo, venta_capital, venta_valor_tasa, venta_moneda
							from	BacSwapSuda.dbo.CarteraHis	with(nolock)
							where ( rut_cliente	 = @nRut or @nRut = 0)
						)	Venta	On	Venta.numero_operacion = His.numero_operacion
									and	Venta.numero_flujo     = His.numero_flujo
									and	Venta.tipo_flujo       = 2

			inner join (	select		Contrato		= Numero_Operacion
							,			Flujo			= Min( Numero_Flujo ) - 1
							,			Tipo			= Tipo_Flujo
							,			Monto			= Min( Devengo_Recibido_Mda_Val )
							,			operador		= Min( operador )
							,			FechaAnticipo	= FechaAnticipo
							from		BacSwapSuda.dbo.Cartera_Unwind	with(nolock)
							where		FechaAnticipo	BETWEEN @FechaDesde AND @Fechahasta
							and			Tipo_Flujo		= 1
							and		(	rut_cliente		= @nRut or @nRut = 0)
							group by	Numero_Operacion, Tipo_Flujo, FechaAnticipo
						)	Anticipo	On	Anticipo.Contrato	= His.Numero_Operacion
										and	Anticipo.Flujo		= His.Numero_Flujo
										and	Anticipo.Tipo		= His.Tipo_Flujo

			inner join	(	select Producto		=	Case	when codigo_producto = 'ST' then 1
															when codigo_producto = 'SM' then 2
															when codigo_producto = 'FR' then 3
															when codigo_producto = 'SP' then 4
													end
							,		Glosa		=	Descripcion
							from	BacParamSuda.dbo.Producto	with(nolock)
							where	Id_Sistema	= 'PCS'
						)	Prod	On Prod.Producto = His.tipo_swap

			inner join  (	select	Rut			= clrut
								,	Codigo		= clcodigo
								,	Dv			= cldv
								,	Nombre		= clnombre
							from	BacParamSuda.dbo.Cliente	with(nolock)
						)	Clie	On 	Clie.Rut = His.Rut_Cliente and Clie.codigo = His.Codigo_Cliente

			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 ON mon1.mncodmon = his.compra_moneda
			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 ON mon2.mncodmon = Venta.venta_moneda

	where	His.Tipo_Flujo			= 1
	and		His.Estado				<> ''


	-->	   Anticipos Swap Parte 2
	---------------------------------
	INSERT INTO #RESULTADOS_MESA
	select	Modulo				= 'PCS'
	,		Producto			= 'ANT ' + Prod.Glosa
	,		Numero_Operacion	= his.numero_operacion
	,		Documento			= 0
	,		Correlativo			= 0
	,		Serie				= ''
	,		RutCliente			= clie.Rut
	,		CodCliente			= clie.Codigo
	,		DvCliente			= clie.Dv
	,		NombreCliente		= clie.Nombre
	,		TipoOperacion		= 'C'
	,		Monto				= his.compra_capital
	,		MonTransada			= mon1.mnnemo
	,		MonConversion		= mon2.mnnemo
	,		TCCierre			= his.compra_valor_tasa
	,		TCCosto				= 0.0
	,		ParidadCierre		= venta.venta_valor_tasa
	,		ParidadCosto		= 0.0
	,		MontoPesos			= venta.venta_capital
	,		Operador			= Anticipo.operador			--> his.operador
	,		MontoDolares		= His.compra_capital
	,		ResultadoMesa		= Anticipo.Monto
	,		Fecha				= Anticipo.FechaAnticipo --> his.fecha_cierre
	,		Relacionado			= '--'
	,		FolioRelacionado	= 0
	,		FechaEmision		= Anticipo.FechaAnticipo
	,		FechaVcto			= Anticipo.FechaAnticipo
	from	BacSwapSuda.dbo.Cartera His	with(nolock)
			inner join (	select	numero_operacion, numero_flujo, tipo_flujo, venta_capital, venta_valor_tasa, venta_moneda
							from	BacSwapSuda.dbo.Cartera	with(nolock)
							where (	rut_cliente	= @nRut or @nRut = 0)
						)	Venta	On	Venta.numero_operacion = His.numero_operacion
									and	Venta.numero_flujo     = His.numero_flujo
									and	Venta.tipo_flujo       = 2

			inner join (	select		Contrato		= Numero_Operacion
							,			Flujo			= Min( Numero_Flujo ) - 1
							,			Tipo			= Tipo_Flujo
							,			Monto			= Min( Devengo_Recibido_Mda_Val )
							,			operador		= Min( operador )
							,			FechaAnticipo	= FechaAnticipo
							from		BacSwapSuda.dbo.Cartera_Unwind	with(nolock)
							where		FechaAnticipo	BETWEEN @FechaDesde AND @Fechahasta
							and			Tipo_Flujo		= 1
							and		(	rut_cliente		= @nRut or @nRut = 0)
							group by	Numero_Operacion, Tipo_Flujo, FechaAnticipo
						)	Anticipo	On	Anticipo.Contrato	= His.Numero_Operacion
										and	Anticipo.Flujo		= His.Numero_Flujo
										and	Anticipo.Tipo		= His.Tipo_Flujo

			inner join	(	select Producto		=	Case	when codigo_producto = 'ST' then 1
															when codigo_producto = 'SM' then 2
															when codigo_producto = 'FR' then 3
															when codigo_producto = 'SP' then 4
													end
							,		Glosa		=	Descripcion
							from	BacParamSuda.dbo.Producto	with(nolock)
							where	Id_Sistema	= 'PCS'
						)	Prod	On Prod.Producto = His.tipo_swap

			inner join  (	select	Rut			= clrut
								,	Codigo		= clcodigo
								,	Dv			= cldv
								,	Nombre		= clnombre
							from	BacParamSuda.dbo.Cliente	with(nolock)
						)	Clie	On 	Clie.Rut = His.Rut_Cliente and Clie.codigo = His.Codigo_Cliente

			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 ON mon1.mncodmon = his.compra_moneda
			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 ON mon2.mncodmon = Venta.venta_moneda

			inner join	(	select	Usuario = tbglosa 
							from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
							where	tbcateg	= case	when @MedaDistibucion = 1 then 9000 
													when @MedaDistibucion = 2 then 9001
													else 9000 
												end
						)	Filtro	On Filtro.Usuario = Anticipo.operador

	where	His.Tipo_Flujo			= 1
	and		His.Estado				= 'N'



	-->	   Opciones y Anticipos de Opciones 
	---------------------------------------
	INSERT INTO #RESULTADOS_MESA
	select  Modulo				= 'OPT'
	,		Producto			= CASE	WHEN Opciones.moTipoTransaccion = 'ANTICIPA' THEN 'Anticipo Opcion' --> 'Antic. ' + Estr.OpcEstDsc
										WHEN Opciones.MoRelacionaPAE	= 1 THEN 'PAE BONIFICADO' 
										ELSE Estr.OpcEstDsc
									END	-->  Opciones.MoCallPut
	,		Numero_Operacion	= LTRIM(RTRIM( Opciones.MoNumContrato ))
	,		Documento			= 0
	,		Correlativo			= 0
	,		Serie				= ''
	,		RutCliente			= LTRIM(RTRIM(CONVERT(CHAR(10),clie.Clrut)))
	,		CodCliente			= Opciones.MoCodigo
	,		DvCliente			= LTRIM(RTRIM(clie.Cldv))
	,		NombreCliente		= LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))
	,		TipoOperacion		= Opciones.MoCVOpc -->CASE WHEN Opciones.MoVinculacion ='Individual' THEN Opciones.MoCVOpc ELSE '' END
	,		Monto				= Opciones.MoMontoMon1
	,		MonTransada			= Opciones.MonTransada
	,		MonConversion		= Opciones.MonConversion
	,		TCCierre			= Opciones.MoStrike
	,		TCCosto				= 0.0
	,		ParidadCierre		= 0.0
	,		ParidadCosto		= 0.0
	,		MontoPesos			= Opciones.MoMontoMon2
	,		Operador			= Opciones.mooperador
	,		MontoDolares		= Opciones.MoMontoMon1
	,		ResultadoMesa		= ISNULL( Opciones.MoResultadoVentasML, 0)
	,		Fecha				= CASE	WHEN Opciones.moTipoTransaccion = 'ANTICIPA' THEN	CONVERT(CHAR(8), Opciones.MoFechaUnwind, 112)
										ELSE												CONVERT(CHAR(8), Opciones.MoFechaContrato, 112)
									END
	,		Relacionado			= '--'
	,		FolioRelacionado	= 0
	,		FechaEmision		= Opciones.MoFechaUnwind
	,		FechaVcto			= Opciones.MoFechaUnwind
	from	(	select	monumcontrato		= mvto.monumcontrato
					,	monumfolio			= mvto.monumfolio
					,	mooperador			= mvto.mooperador
					,	moresultadoventasml	= mvto.moresultadoventasml
					,	mofechacontrato		= mvto.mofechacontrato
					,	morutcliente		= mvto.morutcliente
					,	mocodigo			= mvto.mocodigo
					,	morelacionapae		= mvto.morelacionapae
					,	mocodestructura		= mvto.mocodestructura
					,	motipotransaccion	= mvto.motipotransaccion

					,	monumestructura		= Deta.monumestructura
					,	mocallput			= Deta.mocallput
					,	mostrike			= Deta.mostrike
					,	movinculacion		= Deta.movinculacion
					,	mocvopc				= Deta.mocvopc
					,	momontomon1			= Deta.momontomon1
					,	momontomon2			= Deta.momontomon2

					,	MonTransada			= Mon1.mnnemo
					,	MonConversion		= Mon2.mnnemo
					,	MoFechaUnwind		= mvto.mofechaunwind
				from	LNKOPC.CbMdbOpc.dbo.MoEncContrato mvto	with(nolock)
						inner join	(	select	monumfolio
											,	monumestructura
											,	mocallput
											,	mostrike
											,	movinculacion
											,	mocvopc
											,	momontomon1
											,	momontomon2
											,	mocodmon1
											,	mocodmon2
										from	LNKOPC.CbMdbOpc.dbo.MoDetContrato det	with(nolock)
										where	MoNumEstructura	= 1
									)	Deta	On	Deta.monumfolio	=	mvto.monumfolio

						inner join (	select	mncodmon, mnnemo 
										from	BacParamSuda.dbo.Moneda with(nolock) 
									)	Mon1	On	Mon1.mncodmon	=	Deta.mocodmon1

						inner join (	select	mncodmon, mnnemo 
										from	BacParamSuda.dbo.Moneda with(nolock) 
									)	Mon2	On	Mon2.mncodmon	=	Deta.mocodmon2
				where	(	mvto.morutcliente	= @nRut or @nRut = 0)
--				where	mvto.MoResultadoVentasML	<> 0

				union

				select	monumcontrato		= mvto.monumcontrato
					,	monumfolio			= mvto.monumfolio
					,	mooperador			= mvto.mooperador
					,	moresultadoventasml	= mvto.moresultadoventasml
					,	mofechacontrato		= mvto.mofechacontrato
					,	morutcliente		= mvto.morutcliente
					,	mocodigo			= mvto.mocodigo
					,	morelacionapae		= mvto.morelacionapae
					,	mocodestructura		= mvto.mocodestructura
					,	motipotransaccion	= mvto.motipotransaccion

					,	monumestructura		= Deta.monumestructura
					,	mocallput			= Deta.mocallput
					,	mostrike			= Deta.mostrike
					,	movinculacion		= Deta.movinculacion
					,	mocvopc				= Deta.mocvopc
					,	momontomon1			= Deta.momontomon1
					,	momontomon2			= Deta.momontomon2

					,	MonTransada			= Mon1.mnnemo
					,	MonConversion		= Mon2.mnnemo
					,	MoFechaUnwind		= mvto.mofechaunwind
				from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato mvto	with(nolock)
						inner join	(	select	monumfolio
											,	monumestructura
											,	mocallput
											,	mostrike
											,	movinculacion
											,	mocvopc
											,	momontomon1
											,	momontomon2
											,	mocodmon1
											,	mocodmon2
										from	LNKOPC.CbMdbOpc.dbo.MoHisDetContrato det	with(nolock)
										where	MoNumEstructura	= 1
									)	Deta	On	Deta.monumfolio	=	mvto.monumfolio

						inner join (	select	mncodmon, mnnemo 
										from	BacParamSuda.dbo.Moneda with(nolock) 
									)	Mon1	On	Mon1.mncodmon	=	Deta.mocodmon1

						inner join (	select	mncodmon, mnnemo 
										from	BacParamSuda.dbo.Moneda with(nolock) 
									)	Mon2	On	Mon2.mncodmon	=	Deta.mocodmon2
				where	(	mvto.morutcliente	= @nRut or @nRut = 0)
--				where	mvto.MoResultadoVentasML	<> 0
			)	Opciones

			inner join (	select	monumcontrato			= Grp.monumcontrato
							,		monumfolio				= MAX( Grp.MoNumFolio )
							from	LNKOPC.CbMdbOpc.dbo.MoEncContrato	Grp	with(nolock)
							where	Grp.mofechacontrato		BETWEEN @FechaDesde and @FechaHasta
							and		Grp.moestado			<> 'C'
							group 
							by		Grp.monumcontrato

									UNION 
							select	monumcontrato			= Grp.monumcontrato
							,		monumfolio				= MAX( Grp.MoNumFolio )
							from	LNKOPC.CbMdbOpc.dbo.MoEncContrato	Grp	with(nolock)
							where	Grp.MoFechaUnwind		BETWEEN @FechaDesde and @FechaHasta
							and		Grp.moestado			<> 'C'
							group 
							by		Grp.monumcontrato

									UNION
							select	monumcontrato			= Grp.monumcontrato
							,		monumfolio				= MAX( Grp.MoNumFolio )
							from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato	Grp	with(nolock)
							where	Grp.mofechacontrato		BETWEEN @FechaDesde and @FechaHasta
							and		Grp.moestado			<> 'C'
							group 
							by		Grp.monumcontrato

									UNION
							select	monumcontrato			= Grp.monumcontrato
							,		monumfolio				= MAX( Grp.MoNumFolio )
							from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato	Grp	with(nolock)
							where	Grp.MoFechaUnwind		BETWEEN @FechaDesde and @FechaHasta
							and		Grp.moestado			<> 'C'
							group 
							by		Grp.monumcontrato
						)	Grp		On	Grp.monumcontrato	=	Opciones.monumcontrato
									and	Grp.monumfolio		=	Opciones.monumfolio

			left  join (	select	OpcEstCod,	OpcEstDsc
							from	LNKOPC.CbMdbOpc.dbo.OpcionEstructura	with(nolock)
						)	Estr	ON Estr.OpcEstCod		=	Opciones.mocodestructura

			inner join (	select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
							from	BacParamSuda.dbo.cliente	with(nolock)
						)	Clie	On	Clie.clrut			=	Opciones.MoRutCliente
									and Clie.clcodigo		=	Opciones.MoCodigo

	where Opciones.motipotransaccion	NOT IN('ANULA' , 'EJERCE' )


	-->	   Anticipos Forward
	---------------------------------------
	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BFW'        
	,		Producto            = 'ANT ' + Prod.descripcion
	,		Numero_Operacion    = unwind.canumoper
	,		Numero_Documento    = 0
	,		Numero_Correlativo  = 0
	,		Serie               = ''
	,		RutCliente          = Clie.clrut
	,		CodCliente          = Clie.clcodigo
	,		DvCliente           = Clie.cldv
	,		NombreCliente       = Clie.clnombre
	,		TipoOperacion       = unwind.catipoper
	,		Monto               = unwind.camtomon1
	,		MonTransada         = Mon1.mnnemo
	,		MonConversion       = Mon2.mnnemo
	,		TCCierre            = CASE WHEN unwind.cacodpos1 = 2  THEN unwind.capremon1   ELSE unwind.precio_spot  + unwind.caantptosfwd       END
	,		TCCosto             = CASE WHEN unwind.cacodpos1 = 2  THEN unwind.capremon2    ELSE unwind.capreant     + unwind.caantptoscos       END
	,		ParidadCierre       = CASE WHEN unwind.cacodpos1 = 2  THEN unwind.precio_spot  +    unwind.caantptosfwd / Mon1.mnfactor  ELSE 1.0 END
	,		ParidadCosto        = CASE WHEN unwind.cacodpos1 = 2  THEN unwind.capreant     +    unwind.caantptoscos / Mon1.mnfactor  ELSE 1.0 END
	,		MontoPesos          = unwind.caequmon1
	,		Operador            = unwind.caoperador
	,		MontoDolares        = CASE WHEN unwind.cacodpos1 = 2 and unwind.camtomon1 <> 13 THEN unwind.camtomon2 ELSE unwind.caequusd1 END
	,		ResultadoMesa       = unwind.caspread
	,		Fecha				= unwind.cafecvcto
	,		Relacionado         = '--'
	,		FolioRelacionado    = 0
	,		FechaEmision		= unwind.cafecvcto
	,		FechaVcto			= unwind.cafecvcto
	FROM	(	select	canumoper,	 cacodpos1,		catipoper, camtomon1, camtomon2, caequusd1, caequmon1, capremon1, capremon2, capreant
				,		precio_spot, caantptosfwd,	caantptoscos
				,		caspread,	 cafecvcto,		caoperador, cacodigo, cacodcli, cacodmon1, cacodmon2
				from	BacFwdsuda.dbo.MFCA   with(nolock)
				where	cafecvcto BETWEEN @FechaDesde and @Fechahasta
				and		caantici   = 'A'
				and		caestado  <> 'A'
				and	(	cacodigo	= @nRut or @nRut = 0)
				union

				select	canumoper,	 cacodpos1,		catipoper, camtomon1, camtomon2, caequusd1, caequmon1, capremon1, capremon2, capreant
				,		precio_spot, caantptosfwd = 0.0, caantptoscos = 0.0
				,		caspread,	 cafecvcto,		caoperador, cacodigo, cacodcli, cacodmon1, cacodmon2
				from	BacFwdsuda.dbo.MFCAH  with(nolock)
				where	cafecvcto BETWEEN @FechaDesde and @Fechahasta
				and		caantici   = 'A'
				and		caestado  <> 'A'
				and	(	cacodigo	= @nRut or @nRut = 0)
			)	unwind

			inner join ( select clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
						 from	BacParamSuda.dbo.cliente with(nolock)
						) Clie	On	Clie.clrut		= unwind.cacodigo
								and Clie.clcodigo	= unwind.cacodcli

			left  join	( select codigo_producto, descripcion from BacParamSuda.dbo.Producto with(nolock)
						   where Id_Sistema = 'BFW'
						) Prod On Prod.codigo_producto = unwind.cacodpos1

			Left  Join	(	select mncodmon, mnnemo, mnfactor from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 ON mon1.mncodmon = unwind.cacodmon1
			Left  Join	(	select mncodmon, mnnemo, mnfactor from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 ON mon2.mncodmon = unwind.cacodmon2

if @Pivotal = 0
begin
	update	#RESULTADOS_MESA
	set		Monto		 = Monto			- Anticipo.nMonto
	,		MontoPesos	 = MontoPesos		- Anticipo.nPesos
	,		MontoDolares = MontoDolares		- Anticipo.nDolares
	from	( select	Contrato	= Numero_Operacion
					,	nMonto		= Monto
					,	nPesos		= MontoPesos
					,	nDolares	= MontoDolares
				from	#RESULTADOS_MESA  
				where	Modulo		= 'BFW' 
				and		Producto	like 'Ant%'
			)	Anticipo
	where	Modulo				= 'BFW'
	and		Producto			not like 'Ant%'
	and		Numero_Operacion	= Anticipo.Contrato
end

	-->	   Spot Web
	---------------------------------------
	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BCC'
	,		Producto            = 'SPOT WEB'
	,		Numero_Operacion    = opx.FolioContrato
	,		Numero_Documento    = 0
	,		Numero_Correlativo  = 0
	,		Serie               = ''
	,		RutCliente          = opx.RutCliente
	,		CodCliente          = 0
	,		DvCliente           = BacParamSuda.dbo.Fn_GeneraDvRut(opx.RutCliente)	--> cli.xdig
	,		NombreCliente       = CASE	WHEN xRut IS NULL THEN	'**** CLIENTE NO ESTA CREADO EN BAC ****'
										ELSE					opx.NombreCliente
									END 
	,		TipoOperacion       = opx.TipoTransaccion
	,		Monto               = opx.MtoDolares
	,		MonTransada         = 'USD'
	,		MonConversion       = 'CLP'
	,		TCCierre            = opx.TipoCambio
	,		TCCosto             = CASE	WHEN opx.TipoTransaccion = 'C' THEN (opx.TipoCambio + opx.SpreadComercial)
										ELSE								(opx.TipoCambio - opx.SpreadComercial)
									END
	,		ParidadCierre       = 1.0
	,		ParidadCosto        = 1.0
	,		MontoPesos          = opx.MtoPesos
	,		Operador          = 'E-Bank'
	,		MontoDolares        = opx.MtoDolares
	,		ResultadoMesa       = ROUND(opx.SpreadComercial * opx.MtoDolares, 0)
	,		Fecha               = opx.Fecha
	,		Relacionado         = '--'
	,		FolioRelacionado    = 0
	,		FechaEmision		= opx.Fecha
	,		FechaVcto			= opx.Fecha
	FROM	BacCamSuda.dbo.TBL_OPERACIONES_OMA_EXTERNAS opx with(nolock)
			left join 
			(	select	xRut = clrut, xDig = MIN( cldv )
				from	BacParamSuda.dbo.cliente with(nolock)
				group 
				by		clrut
			)	cli		on cli.xRut	= opx.RutCliente

	WHERE	opx.Fecha	      BETWEEN @FechaDesde AND @Fechahasta
	and		opx.Origen		= 'TEFUSDWEB'
	and	(	opx.RutCliente	= @nRut or @nRut = 0)

	-->	   Spot New York
	---------------------------------------
	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BCC'
	,		Producto            = 'US$ NEW YORK'
	,		Numero_Operacion    = opx.FolioContrato
	,		Numero_Documento    = 0
	,		Numero_Correlativo  = 0
	,		Serie               = ''
	,		RutCliente			= opx.RutCliente
	,		CodCliente          = 0
	,		DvCliente           = BacParamSuda.dbo.Fn_GeneraDvRut( opx.RutCliente )
	,		NombreCliente       = opx.NombreCliente
	,		TipoOperacion       = opx.TipoTransaccion
	,		Monto               = opx.MtoDolares
	,		MonTransada         = 'USD'
	,		MonConversion       = 'CLP'
	,		TCCierre            = opx.TipoCambio
	,		TCCosto             = CASE	WHEN opx.TipoTransaccion = 'C' THEN (opx.TipoCambio + opx.SpreadComercial)
										ELSE								(opx.TipoCambio - opx.SpreadComercial)
									END
	,		ParidadCierre       = 1.0
	,		ParidadCosto        = 1.0
	,		MontoPesos          = opx.MtoPesos
	,		Operador            = 'E-Bank'
	,		MontoDolares        = opx.MtoDolares
	,		ResultadoMesa       = ROUND(opx.SpreadComercial * opx.MtoDolares, 0)
	,		Fecha               = opx.Fecha
	,		Relacionado         = '--'
	,		FolioRelacionado    = 0
	,		FechaEmision		= opx.Fecha
	,		FechaVcto			= opx.Fecha
	FROM	BacCamSuda.dbo.TBL_OPERACIONES_OMA_EXTERNAS opx with(nolock)
	WHERE	opx.Fecha			BETWEEN @FechaDesde AND @Fechahasta
	and		opx.Origen			= 'TEFCBNY'
	and	(	opx.RutCliente	= @nRut or @nRut = 0)


	-->		Se agrego para Alimentar el Pivotal
	if @Pivotal = 1
	begin
		INSERT INTO dbo.TBL_RESULTADOS_MESA_PIVOTAL
		SELECT	Modulo
			,	Producto
			,   Numero_Operacion
			,   Documento
			,   Correlativo
			,   Serie
			,   RutCliente
			,   CodCliente
			,   DvCliente
			,   NombreCliente
			,   TipoOperacion
			,   Monto
			,   MonTransada
			,   MonConversion
			,   isnull(TCCierre, 0.0)
			,   isnull(TCCosto, 0.0)
			,   isnull(ParidadCierre, 0.0)
			,   isnull(ParidadCosto, 0.0)
			,   MontoPesos
			,   Operador
			,   MontoDolares
			,   ResultadoMesa
			,   Fecha
			,   Relacionado
			,   FolioRelacionado
			,	FechaEmision
			,	FechaVcto
		FROM	#RESULTADOS_MESA	Result
				inner join (	select	Usuario = tbglosa 
								from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
								where	tbcateg	= case	when @MedaDistibucion = 1 then 9000 
														when @MedaDistibucion = 2 then 9001
														else 9000 end
							)	Filtro	On Filtro.Usuario = Result.operador
		WHERE  Result.Modulo		<> 'OPT'
			UNION
		SELECT	Modulo
			,	Producto
			,   Numero_Operacion
			,   Documento
			,   Correlativo
			,   Serie
			,   RutCliente
			,   CodCliente
			,   DvCliente
			,   NombreCliente
			,   TipoOperacion
			,   Monto
			,   MonTransada
			,   MonConversion
			,   isnull(TCCierre, 0.0)
			,   isnull(TCCosto, 0.0)
			,   isnull(ParidadCierre, 0.0)
			,   isnull(ParidadCosto, 0.0)
			,   MontoPesos
			,   Operador
			,   MontoDolares
			,   ResultadoMesa
			,   Fecha
			,   Relacionado
			,   FolioRelacionado
			,	FechaEmision
			,	FechaVcto
		FROM	#RESULTADOS_MESA	Result --Modificado 20140113 P.A.
				inner join (	select	Usuario = tbglosa 
								from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
								where	tbcateg	= case	when @MedaDistibucion = 1 then 9000 
														when @MedaDistibucion = 2 then 9001
														else 9000 end
							)	Filtro	On Filtro.Usuario = Result.operador
		WHERE	Result.Modulo		= 'OPT'
		AND		@MedaDistibucion	= 1

		RETURN
	END
	-->		Se agrego para Alimentar el Pivotal


	-->	   Retorno Final
	---------------------------------------
	SELECT	Modulo				= RetornoFinal.Modulo
		,   Producto			= RetornoFinal.Producto
		,   Numero_Operacion	= RetornoFinal.Numero_Operacion
		,   Relacionado			= RetornoFinal.Relacionado
		,   FolioRef			= RetornoFinal.FolioRef
		,   Serie				= RetornoFinal.Serie
		,   RutCliente			= RetornoFinal.RutCliente
		,   CodCliente			= RetornoFinal.CodCliente
		,   DvCliente			= RetornoFinal.DvCliente
		,   NombreCliente		= RetornoFinal.NombreCliente
		,   TipoOperacion		= RetornoFinal.TipoOperacion
		,   Monto				= RetornoFinal.Monto
		,   MonTransada			= RetornoFinal.MonTransada
		,   MonConversion		= RetornoFinal.MonConversion
		,   TCCierre			= RetornoFinal.TCCierre
		,	TCCosto				= RetornoFinal.TCCosto
		,   ParidadCierre		= RetornoFinal.ParidadCierre
		,   ParidadCosto		= RetornoFinal.ParidadCosto
		,   MontoPesos			= RetornoFinal.MontoPesos
		,   Operador			= ltrim(rtrim( RetornoFinal.Operador ))
		,   MontoDolares		= RetornoFinal.MontoDolares
		,   ResultadoMesa		= RetornoFinal.ResultadoMesa
		,   Fecha				= RetornoFinal.Fecha
		,	FechaEmision		= RetornoFinal.FechaEmision
		,	FechaVcto			= RetornoFinal.FechaVcto
	FROM	(	SELECT	Modulo				= Result.Modulo
					,   Producto			= Result.Producto
					,   Numero_Operacion	= Result.Numero_Operacion
					,   Relacionado			= Result.Relacionado
					,   FolioRef			= Result.Correlativo
					,   Serie				= Result.Serie
					,   RutCliente			= Result.RutCliente
					,   CodCliente			= Result.CodCliente
					,   DvCliente			= Result.DvCliente
					,   NombreCliente		= Result.NombreCliente
					,   TipoOperacion		= Result.TipoOperacion
					,   Monto				= Result.Monto
					,   MonTransada			= Result.MonTransada
					,   MonConversion		= Result.MonConversion
					,   TCCierre			= Result.TCCierre
					,   TCCosto				= Result.TCCosto
					,   ParidadCierre		= Result.ParidadCierre
					,   ParidadCosto		= Result.ParidadCosto
					,   MontoPesos			= Result.MontoPesos
					,   Operador			= Result.Operador
					,   MontoDolares		= Result.MontoDolares
					,   ResultadoMesa		= Result.ResultadoMesa
					,   Fecha				= Result.Fecha
					,   Documento			= Result.Documento
					,   Correlativo			= Result.Correlativo
					,	FechaEmision		= Result.FechaEmision
					,	FechaVcto			= Result.FechaVcto
				FROM	#RESULTADOS_MESA	Result
						inner join (	select	Usuario = tbglosa 
										from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
										where	tbcateg	= case	when @MedaDistibucion = 1 then 9000 
																when @MedaDistibucion = 2 then 9001
																else 9000 end
									)	Filtro	On Filtro.Usuario = Result.operador
				WHERE  Result.Modulo		<> 'OPT'

				UNION

				SELECT	Modulo				= Result.Modulo
					,   Producto			= Result.Producto
					,   Numero_Operacion	= Result.Numero_Operacion
					,   Relacionado			= Result.Relacionado
					,   FolioRef			= Result.Correlativo
					,   Serie				= Result.Serie
					,   RutCliente			= Result.RutCliente
					,   CodCliente			= Result.CodCliente
					,   DvCliente			= Result.DvCliente
					,   NombreCliente		= Result.NombreCliente
					,   TipoOperacion		= Result.TipoOperacion
					,   Monto				= Result.Monto
					,   MonTransada			= Result.MonTransada
					,   MonConversion		= Result.MonConversion
					,   TCCierre			= Result.TCCierre
					,   TCCosto				= Result.TCCosto
					,   ParidadCierre		= Result.ParidadCierre
					,   ParidadCosto		= Result.ParidadCosto
					,   MontoPesos			= Result.MontoPesos
					,   Operador			= Result.Operador
					,   MontoDolares		= Result.MontoDolares
					,   ResultadoMesa		= Result.ResultadoMesa
					,   Fecha				= Result.Fecha
					,   Documento			= Result.Documento
					,   Correlativo			= Result.Correlativo
					,	FechaEmision		= Result.FechaEmision
					,	FechaVcto			= Result.FechaVcto
				FROM	#RESULTADOS_MESA	Result --Modificado 20140113 P.A.
						inner join (	select	Usuario = tbglosa 
										from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
										where	tbcateg	= case	when @MedaDistibucion = 1 then 9000 
																when @MedaDistibucion = 2 then 9001
																else 9000 end
									)	Filtro	On Filtro.Usuario = Result.operador
				WHERE	Result.Modulo		= 'OPT'
				AND		@MedaDistibucion	= 1
			)	RetornoFinal
		ORDER BY	RetornoFinal.fecha
			,		RetornoFinal.Modulo
			,		RetornoFinal.Producto
			,		RetornoFinal.RutCliente
			,		RetornoFinal.CodCliente
			,		RetornoFinal.Numero_Operacion
			,		RetornoFinal.Documento
			,		RetornoFinal.Correlativo
			,		RetornoFinal.FechaEmision
			,		RetornoFinal.FechaVcto
END

GO
