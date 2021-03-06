USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_INTERFAZ_LCR_Interno_Inversiones]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [SP_FUSION_INTERFAZ_LCR_Interno_Inversiones] '20200713','s'
CREATE PROCEDURE [dbo].[SP_FUSION_INTERFAZ_LCR_Interno_Inversiones]
	(	@fecCont		DATETIME
	,	@Formateada		VARCHAR(1) = 'S'
)
AS
BEGIN
    -- SP_FUSION_INTERFAZ_LCR_Interno_Inversiones '20160331' ,'N'

	SET NOCOUNT ON

	declare @dFechaMTM		datetime
		set @dFechaMTM		=	(	select	Fecha = case	when month(acfecproc) <> month(acfecprox) then dateadd(day, -1, acfecprox)
															else acfecproc
														end
									from	BacTraderSuda.dbo.mdac with(nolock)
								)

    -- Activa / Desactiva Inversiones en el Exterior
	declare @IncluyeInvex Varchar(2) = 'NO'


	/*********************************************************
	PRECONDICION	: ejecutar recálculo Lineas solo de renta fija al cierre
	IMPORTANTE		: leer token IMPORTANTE más abajo	                                                                
	***********************************************************/                                                               

	    CREATE TABLE #INT_SALIDA 
	(	  LINEA				VARCHAR(465)  -- El largo definitivo y el formato será manejado por el SP
   ,      ORDEN        INT
   ,      CANTIDAD     Numeric(10)
   ,      Moneda       Numeric(5)
   ,      Rut_Cliente  Numeric(13)
   ,      Codigo_Cliente Numeric(5)
    )
	/*********
	1	CONTRAT0
	2	RUT
	3	DIGV
	4	FACILITY
	5	DTCONTR
	6	DTVENC
	7	MOEDAR
	8	VLCONTR
	9	VLPRIN
	10	Signo-1
	11	VALMTM
	12	Signo-2
	13	VALRCP
	14	NOMPRO
	15	Signo-3
	16	SALDES
	17	AMOOPE
	18	AINDOP
	19	APOROP
	20	Signo-4
	21	ATASOP
	22	PMOOPE
	23	PINDOP
	24	PPOROP
	25	Signo-5
	26	PTASOP
	27	ACUCOM

	**********/

	-- Conceptos solicitados en la interfaz
	-- se documenta el valor a colocar 
	-- que se rescatará en la instruccion
	-- siguiente.
	-- No se agruparan los pactos por
	-- incluir instrumentos con diversa
	-- mitigación enredando el query..
	-- por ultimo sumamos al final.
	CREATE TABLE #Salida 
			(
			    /*01*/  [AGENCIA]      varchar(4)
			,	/*02*/	[CGI]	       varchar(13)  -- Rut alineado a la derecha
            ,   /*03*/  [FILLER_01]    varchar(1)   -- DV
			,	/*04*/	[FILLER_02]	   varchar(11)  -- solo blancos
			,	/*05*/	[TIPOREG] 	   Varchar(2)   -- Poner en duro '02' -- POR HACER: parametrizar
			,	/*06*/	[FILLER_03]    VARCHAR(6)   -- solo blancos
			,	/*07*/	[OPER]	       Varchar(5)   -- Si es CP:
			                                        --       InCodigo: 9,11,14 then 97728 else 97732.
													--       Emisor es: (97029000,60805000) -- BCCH o TESORERIA 
													--                  0 Incodigo: 20 then 97732 else 97732 end ... dejar igual!! 
			                                        -- Si es CI:
													--       Colocación interbancaria: 97728 else 97733 

			,	/*08*/	[CONTRATO]     varchar(13)  -- N° de Operación de CP o Pacto
			,	/*09*/	[DTATU]        varchar(6)   -- Fecha actual, poner fecha de proceso del sistema
			,	/*10*/	[HRATU]		   varchar(6)   -- Hora generación, sacar la del sistema
			,   /*11*/  [FILLER_04]    varchar(7)   -- Solo Blancos
			,   /*12*/  [OPER_02]      Varchar(5)   -- -- Si es CP:
			                                        --       InCodigo: 9,11,14 then 97728 else 97732.
													--       Emisor es: (97029000,60805000) -- BCCH o TESORERIA 
													--                  0 Incodigo: 20 then 97732 else 97732 end ... dejar igual!! 
			                                        -- Si es CI:
													--       Colocación interbancaria: 97728 else 97733 

			,   /*13*/  [CONTRATO_02]  varchar(13)  -- cpnumdocu o ciNumdocu
			,   /*14*/  [DTCONTR]      varchar(6)   -- cpfeccomp, cifeccomp
			,   /*15*/  [DTVENC]       varchar(7)   -- CP:  difecSal CI: cifecvenp
		    ,   /*16*/  [MOEDAR]       varchar(4)   -- CP:
			                                        --  WHEN dimoneda in(999,998) THEN '0715' 
													--  WHEN dimoneda in(13,994,995) THEN '0220'  
													--  ELSE 0220 -- para no dejar NULL
													-- CI:
													--  WHEN ci.cimonpact in(999,998) THEN '0715' 
													--  WHEN ci.cimonpact in(13,994,995) THEN '0220'
													--  ELSE '2020' -- para no dejar null  

													  -- Valor del activo en moneda de emisión al inicio
			,   /*17*/  [VLCONTR]      varchar(13)    -- numeric(13,2)  -- CP:  WHEN dimoneda in (994,995) THEN Round(cpvalcomp/@nValDo,2) ELSE cpvalcomp END
			                                          -- CI:  WHEN ci.cimonpact in (994,995) THEN Round(ci.civalinip/@nValDo,2) ELSE ci.civalinip END
			,   /*18*/  [CODEMPI]      varchar(2)     -- '00'
			,   /*19*/  [FILLER_05]    varchar(2)     -- '  '
			,   /*20*/  [VLPRIN]       varchar(13)    -- numeric(13,2)  -- CP: WHEN dimoneda in (994,995) THEN Round(cpvalcomp/@nValDo,2) ELSE cpvalcomp END
			                                          -- CI: baclineas.dbo.linea_transaccion.MontoOriginal debería ser por instrumento 
													  --     dejar expresado en la moneda del pacto.
			,   /*21*/  [VLENC]        varchar(13)    -- numeric(13,2)  -- CP:  WHEN dimoneda in (994,995) THEN Round(cpinteresc/@nValDo,2) ELSE cpinteresc END
			                                          -- CI: CASE WHEN ci.cimonpact in (994,995) THEN Round(ci.ciinteresci/@nValDo,2) ELSE ci.ciinteresci END
			,   /*22*/  [DTPPARC]      varchar(6)     --  '000000'
			,   /*23*/  [VLRVCDO]      varchar(13)    -- numeric(13,2)  -- CP: '0000000000000'  -- se copia del SP de BIC
			,   /*24*/  [FILLER_06]    varchar(31)    -- 31 blancos.
			,   /*25*/  [NOMENC]       varchar(30)    -- CP: LEFT(emnombre,30) 
			                                          -- CI: LEFT(clnombre,30) -- Nombre del cliente contraparte del pacto.
			,   /*26*/  [CGIVEI]       varchar(13)    -- "0000000000000"
			,   /*27*/  [FILLER_07]    varchar(1)     -- 1 blanco
			,   /*28*/  [CODSIST]      varchar(2)     -- "QC" -- POR HACER: parametrizar.
			,   /*29*/  [Valor de MTM] varchar(17)    -- numeric(17,4)  -- CP: ISNULL(valor_mercado,0) CI: Idem
			,   /*30*/  [Valor de RCP] varchar(17) -- numeric(17,4)  -- CP: 0 Ci: 0
			,   /*31*/  [Nome do produto] varchar(50) -- CP: 'COMPRA PROPIA   '
			                                          -- CI: WHEN  ci.ciinstser = 'ICOL' THEN 'ICOL' ELSE 'COMPRA CON PACTO'
			,   /*32*/  [Saldo_Credito]   varchar(17) -- numeric(17,4) -- CP: 0 CI: 0
			,   /*33*/  [AMOOPE]          varchar(4)    -- CP: dinemmon CI: '    '
			,   /*34*/  [AINDOP]          varchar(30)   -- CP y CI: 30 blancos
			,   /*35*/  [APOROP]          varchar(5)    -- numeric(5,2)  -- '00000'
			,   /*36*/  [ATASOP]          varchar(14)   -- numeric(14,8) -- CP: cptircomp CI: citaspact
			,   /*37*/  [PMOOPE]          varchar(4)    -- 4 blancos
			,   /*38*/  [PINDOP]          varchar(30)   -- 30 blancos
			,   /*39*/  [PPOROP]          varchar(5)    -- numeric(5,2)  -- 5 ceros
			,   /*40*/  [PTASOP]          varchar(13)   -- numeric(14,8) -- 13 ceros segun Itau
			,           Corr numeric(10)
			,           Rut_Cliente numeric(13)
			,           Codigo_Cliente numeric(10)
			)

    
	 CREATE  TABLE #CodigoAS400Mda ( MdaBAC Varchar(3), MdaNemo Varchar(3) /* Findur*/ ,  MdaAS Varchar(4) /*AS400*/ ) 
	 Insert into #CodigoAS400Mda select  'AUD','AUD', 'AU.D'
	 Insert into #CodigoAS400Mda select  'SEK','SEK', 'SWKR'
	 Insert into #CodigoAS400Mda select  'NZD','NZD', 'NZ.D'  
	 Insert into #CodigoAS400Mda select  'NOK','NOK', 'NKR'
	 Insert into #CodigoAS400Mda select  'BRL','BRL', 'BRL'
	 Insert into #CodigoAS400Mda select  'DKK','DKK', 'DKR'
	 Insert into #CodigoAS400Mda select  'CAD','CAD', 'CA.D'
	 Insert into #CodigoAS400Mda select  'CHF','CHF', 'SFCS'
	 Insert into #CodigoAS400Mda select  'CLP','CLP', 'CHEZ'
	 Insert into #CodigoAS400Mda select  'USD','USD', 'US.D'
	 Insert into #CodigoAS400Mda select  'UF','CLF', 'UF'
	 Insert into #CodigoAS400Mda select  'GBP','GBP', 'LSTG'
	 Insert into #CodigoAS400Mda select  'EUR','EUR', 'EUR'
	 Insert into #CodigoAS400Mda select  'JPY','JPY', 'YEN'

/*
	 select * into #TMPInvex from BacBonosExtSuda.dbo.TEXT_RSU where rsfecpro = @fecCont 
	  union
	 Select * from BacBonosExtNY.dbo.TEXT_RSU ResInvex where rsfecpro = @fecCont
*/
	select	[CGI]						= Operaciones.[CGI]
		,	[FILLER_01]					= Operaciones.[FILLER_01]
		,	[OPER]						= Operaciones.[OPER]
		,	[CONTRATO]					= Operaciones.[CONTRATO]
		,	[OPER_02]					= Operaciones.[OPER_02]
		,	[CONTRATO_02]				= Operaciones.[CONTRATO_02]
		,	[DTCONTR]					= Operaciones.[DTCONTR]
		,	[DTVenc]					= Operaciones.[DTVenc]
		,	[MOEDAR]					= Operaciones.[MOEDAR]
		,	[VLCONTR]					= Operaciones.[VLCONTR]
		,	[VLPRIN]					= Operaciones.[VLPRIN]
		,	[VLENC]						= Operaciones.[VLENC]
		,	[NOMENC]					= Operaciones.[NOMENC]
		,	[Valor de MTM]				= Operaciones.[Valor de MTM]
		,	[Nome do Producto]			= Operaciones.[Nome do Producto]
		,	[AMOOPE]					= Operaciones.[AMOOPE]
		,	[ATASOP]					= Operaciones.[ATASOP]
		,	codigo_Producto_BAC			= Operaciones.codigo_Producto_BAC
		,	Moneda_Emision_BAC			= Operaciones.Moneda_Emision_BAC
		,	Moneda_MontoOriginal_BAC	= Operaciones.Moneda_MontoOriginal_BAC
		,	NumeroDocumento_BAC			= Operaciones.NumeroDocumento_BAC
		,	Correla_BAC					= Operaciones.Correla_BAC
		,	Rut_Cliente					= Operaciones.Rut_Cliente
		,	Codigo_Cliente				= Operaciones.Codigo_Cliente
		,	corr						= row_number() over (order by Operaciones.NumeroDocumento_BAC, Operaciones.Correla_BAC )
	into	#TMP001
	from	
		(	select	[CGI]					= cp.RutEmisor
				,	[FILLER_01]				= cl.cldv
				,	[OPER]					= case	when cp.cpcodigo in(9, 11, 14)	then '97728' else '97732' end
				,	[CONTRATO]				= cp.cpnumdocu
				,	[OPER_02]				= case	when cp.cpcodigo in(9, 11, 14)	then '97728' else '97732' end
				,	[CONTRATO_02]			= cp.cpnumdocu
				,	[DTCONTR]				= cp.cpfeccomp
				,	[DTVenc]				= cp.cpfecven
				,	[MOEDAR]				= case	when cp.dimoneda in(999,998)	then '0715'
													when cp.dimoneda in(13,994,995)	then '0220'
													else '0000'
													  end
				,	[VLCONTR]				= cp.cpvalcomp
				,	[VLPRIN]				= cp.cpvptirc
				,	[VLENC]					= cp.cpinteresc
				,	[NOMENC]				= ltrim(rtrim( left( cl.clnombre, 30)))
				,	[Valor de MTM]			= cp.ValorMercado
				,	[Nome do Producto]		= 'COMPRA PROPIA'
				,	[AMOOPE]				= cp.dinemmon
				,	[ATASOP]				= cp.cptircomp
				,	codigo_Producto_BAC		= 'CP'
				,	Moneda_Emision_BAC		= cp.dimoneda
				,	Moneda_MontoOriginal_BAC= 999
				,	NumeroDocumento_BAC		= cp.cpnumdocu
				,	Correla_BAC				= cp.cpcorrela
				,	Rut_Cliente				= cl.clrut
				,	Codigo_Cliente			= cl.clcodigo
			from
				(	select	cpnumdocu		= cp.cpnumdocu
						,	cpcorrela		= cp.cpcorrela
						,	cpcodigo		= cp.cpcodigo
						,	cpfeccomp		= cp.cpfeccomp
						,	cpvalcomp		= cp.cpvalcomp
						,	cpinteresc		= cp.cpinteresc
						,	cptircomp		= cp.cptircomp
						,	dimoneda		= di.dimoneda
						,	dinemmon		= di.dinemmon
						,	digenemi		= di.digenemi
						,	cpfecven		= cp.cpfecven
						,	ValorMercado	= mr.valor_mercado
						,	cpvptirc		= cp.cpvptirc
						,	RutEmisor		= case when cp.cpseriado = 'S' then di.dirutemi else ns.nsrutemi	end
						,	CodEmisor		= case when cp.cpseriado = 'S' then di.dicodemi	else 1				end
					from	
						(	select	cpnumdocu, cpcorrela, cpcodigo, cpfeccomp, cpvalcomp, cpinteresc, cptircomp, cpseriado, cpfecven, cpvptirc
							from	BacTraderSuda.dbo.mdcp with(nolock)
							where	cpnominal	> 0
						)	cp
							inner join 
							(	select	dinumdocu, dicorrela, dimoneda, dinemmon, digenemi
									,	dirutemi = em.emrut
									,	dicodemi = 1 --> em.emcodigo
								from	BacTraderSuda.dbo.Mddi with(nolock) 
										left join 
										(	select	emgeneric, emrut, emcodigo
											from	BacParamSuda.dbo.Emisor with(nolock)
										)	em		on em.emgeneric	= digenemi
								where	digenemi	not in('bcch')
							)	di		On	di.dinumdocu	= cp.cpnumdocu
										and	di.dicorrela	= cp.cpcorrela
							inner join
							(	select	rmnumdocu, rmcorrela
									,	valor_mercado
								from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
								where	Fecha_Valorizacion	= @dFechaMTM
								and		Tipo_operacion		= 'CP'
							)	mr		On	mr.rmnumdocu	= cp.cpnumdocu
										and	mr.rmcorrela	= cp.cpcorrela
							left join 
							(	select  nsnumdocu, nscorrela, nsrutemi
								from	BacParamSuda.dbo.NoSerie with(nolock)
										left join 
										(	select	emrut, emcodigo, emnombre
											from	BacParamSuda.dbo.Emisor	with(nolock)
										)	em		On em.emrut = nsrutemi
							)	ns		On	ns.nsnumdocu	= cp.cpnumdocu
										and	ns.nscorrela	= cp.cpcorrela
				)	CP
					left join
					(	select	clrut, cldv, clcodigo, clnombre
						from	BacParamSuda.dbo.cliente with(nolock)
					)	cl		on	cl.clrut	= cp.RutEmisor
								and	cl.clcodigo	= cp.CodEmisor

					union all

			select	[CGI]					= cl.clrut
				,	[FILLER_01]				= cl.cldv
				,	[OPER]					= case	when ci.ciinstser = 'ICOL' then '97728' else '97733' end
				,	[CONTRATO]				= ci.cinumdocu
				,	[OPER_02]				= case	when ci.ciinstser = 'ICOL' then '97728' else '97733' end
				,	[CONTRATO_02]			= ci.cinumdocu
				,	[DTCONTR]				= ci.cifeccomp
				,	[DTVenc]				= ci.cifecven
				,	[MOEDAR]				= case	when ci.cimonpact	in(999,998)		then	'0715'
													when ci.cimonpact	in(13,994,995)	then	'0220'
													else										'0000' 
													  end
				,	[VLCONTR]				= ci.civalinip
				,	[VLPRIN]				= ci.civptirc
				,	[VLENC]					= ci.ciinteresci
				,	[NOMENC]				= ltrim(rtrim( left( cl.clnombre, 30) ))
				,	[Valor de MTM]			= 0.0
				,	[Nome do Producto]		= case	when ci.ciinstser = 'ICOL' then 'COLOCACION IBCO' else 'COMPRA CON PACTO' end
				,	[AMOOPE]				= '    '	-->	mn.mnnemo
				,	[ATASOP]				= ci.citaspact
				,	codigo_Producto_BAC		= case	when ci.ciinstser = 'ICOL' then 'ICOL' else 'CI' end
				,	Moneda_Emision_BAC		= ci.cimonemi
			,     Moneda_MontoOriginal_BAC          = 999  
				,	NumeroDocumento_BAC		= ci.cinumdocu
				,	Correla_BAC				= ci.cicorrela
				,	Rut_Cliente				= cl.clrut
				,	Codigo_Cliente			= cl.clcodigo
	      from       
					(	select	cinumdocu, cicorrela, ciinstser, cifeccomp, cimonpact, civalinip, ciinteresci, citaspact, cimonemi, cifecven, civptirc
							,	cirutcli, cicodcli
						from	BacTraderSuda.dbo.mdci with(nolock)
						where	not (ciinstser	= 'icap')
					)	ci
					left join
					(	select	clrut, cldv, clcodigo, clnombre
						from	BacParamSuda.dbo.cliente with(nolock)
					)	cl		on	cl.clrut	= ci.cirutcli
								and	cl.clcodigo	= ci.cicodcli
					left join
					(	select	mncodmon, mnnemo
						from	BacParamSuda.dbo.Moneda with(nolock)
					)	mn		On mn.mncodmon	= ci.cimonemi
											
					union all
                        
			select	[CGI]					= cl.clrut
				,	[FILLER_01]				= cl.cldv
				,	[OPER]					= '97732'
				,	[CONTRATO]				= cp.rsnumdocu
				,	[OPER_02]				= '97732'
				,	[CONTRATO_02]			= cp.rsnumdocu
				,	[DTCONTR]				= cp.rsfeccomp
				,	[DTVenc]				= cp.rsfecvcto
				,	[MOEDAR]				= isnull( CampoMOEDAR.Moedar , '0220' )
				,	[VLCONTR]				= cp.rsvalcomu
				,	[VLPRIN]				= cp.rsvppresenx -- isnull(li.Monto, (cp.rsvppresenx * vm.vmvalor))
				,	[VLENC]					= cp.rsvppresenx - cp.rsvalcomu -- cp.rsinteres_acum
				,	[NOMENC]				= ltrim(rtrim( left( cl.clnombre, 30) ))
				,	[Valor de MTM]			= cp.rsValMerc * isnull( vm.vmvalor, 1.0 )
				,	[Nome do Producto]		= 'COMPRA PROPIA EXT'
				,	[AMOOPE]				= mn.mnnemo
				,	[ATASOP]				= cp.rstir
				,	codigo_Producto_BAC		= 'CPX'
				,	Moneda_Emision_BAC		= cp.rsmonemi
				,	Moneda_MontoOriginal_BAC= 999
				,	NumeroDocumento_BAC		= cp.rsnumdocu
				,	Correla_BAC				= 1
				,	Rut_Cliente				= cl.clrut
				,	Codigo_Cliente			= cl.clcodigo

			from	(	select  rsfecpro,  rsnumdocu, rsnumoper, rscorrelativo, rsfeccomp, rsvalcomu, rsinteres_acum, rsValMerc, rstir, rsmonemi
							,	rsrutemis, rscodemi, rsfecvcto,  rsvppresenx
						from	BacBonosExtSuda.dbo.TEXT_RSU with(nolock) 
						where	rsfecpro	= @fecCont and  rstipOper = 'DEV' and @IncluyeInvex = 'SI'
						--	union
						--select  rsfecpro,  rsnumdocu, rsnumoper, rscorrelativo, rsfeccomp, rsvalcomu, rsinteres_acum, rsValMerc, rstir, rsmonemi
						--	,	rsrutemis, rscodemi, rsfecvcto,	 rsvppresenx
						--from	BacBonosExtNY.dbo.TEXT_RSU with(nolock)
						--where	rsfecpro	= @fecCont and rstipOper = 'DEV'  and @IncluyeInvex = 'SI'
					)	cp
					left join
					(	select	clrut, cldv, clcodigo, clnombre
						from	BacParamSuda.dbo.cliente with(nolock)
					)	cl		on	cl.clrut	= cp.rsrutemis
								and	cl.clcodigo	= cp.rscodemi
					left join
					(	select	vmfecha			= fecha
							,	vmvalor			= tipo_cambio
							,	vmcodigo		= codigo_moneda
						from	bacparamsuda.dbo.valor_moneda_contable with(nolock)
						where	fecha		    = @fecCont
						and		/*codigo_moneda	= 994 and */ tipo_cambio > 0
					)	vm		On vm.vmcodigo	= cp.rsmonemi
					left join
					(	select	mncodmon, mnnemo
						from	BacParamSuda.dbo.Moneda with(nolock)
					)	mn		On mn.mncodmon	= cp.rsmonemi

					left join
					(	select	numdocu		= NumeroDocumento
							,	correla		= NumeroCorrelativo
							,	Monto		= MontoOriginal
						from	BacLineas.dbo.LINEA_TRANSACCION with(nolock)
						where	Id_Sistema		= 'BEX'
					)	li		On	li.numdocu	= cp.rsnumdocu
								and	li.correla	= cp.rscorrelativo
					-- Parametrizacion Campo MOEDAR
					left join
					(   select MoEdar = Nemo
					         , MoCodBAC = TbCodigo1
							 from BacParamSuda.dbo.TABLA_GENERAL_DETALLE 
							  where tbcateg = 230
					)    CampoMOEDAR on CampoMOEDAR.MoCodBAC = cp.rsmonemi
		)	Operaciones

         
     update #TMP001 
	set		VLCONTR		= VLCONTR		+ vivalcomp
		,	VLPRIN		= VLPRIN		+ vivalcomp
		,	VLENC		= VLENC			+ viinteresv
	from	(	select	vitipoper, vinumdocu, vicorrela, vivalcomp = sum(vivalcomp), viinteresv = sum(viinteresv)
				from	mdvi with(nolock)
				group 
				by		vitipoper, vinumdocu, vicorrela
			)	mdvi
	where	#TMP001.codigo_Producto_BAC not in ('icol', 'cpx')
	and		mdvi.vitipoper				= #TMP001.[codigo_Producto_BAC]
	and		mdvi.vinumdocu				= #TMP001.NumeroDocumento_BAC
	and		mdvi.vicorrela				= #TMP001.Correla_BAC

/*	
	  update #TMP001 
	set		VLCONTR		= VLCONTR		+ isnull((	select	sum( vivalcomp ) 
													from	MDVI VI 
													where	#TMP001.[codigo_Producto_BAC]	= VI.vitipoper
		                          and #TMP001.NumeroDocumento_BAC = VI.ViNumDocu
			                       and #TMP001.Correla_BAC = VI.ViCorrela  ), 0)
		                   
	,		VLPRIN		= VLPRIN		+ isnull((	select	sum( ViValComp)	
													from	MDVI VI  
													where	#TMP001.[codigo_Producto_BAC]	= VI.vitipoper
		                             and #TMP001.NumeroDocumento_BAC = VI.ViNumDocu
			                         and #TMP001.Correla_BAC = VI.ViCorrela  ) , 0 )
			
	,		VLENC		= VLENC			+  isnull((	select	sum( viinteresv) 
													from	MDVI VI
													where	#TMP001.[codigo_Producto_BAC]	= VI.vitipoper
		                             and #TMP001.NumeroDocumento_BAC = VI.ViNumDocu
			                         and #TMP001.correla_BAC = VI.ViCorrela  )  , 0 )
									 
	-->	Se desconecta la sumatoria para las compras con pacto, Este producto no valoriza a Mercado
	,	[Valor de MTM]	= [Valor de MTM] + 0.0	/*isnull((	select	sum( valor_Mercado ) 
			                                        from	VALORIZACION_MERCADO VMer 
													where	#TMP001.NumeroDocumento_BAC		= VMer.rmnumdocu  
													      AND #TMP001.correla_BAC = VMer.rmcorrela  
			                                        and		VMer.Tipo_operacion				= 'CI'
													and		VMer.Fecha_Valorizacion			= @dFechaMTM),	0)*/
		where  #TMP001.codigo_Producto_BAC not in ( 'ICOL', 'CPX'  )
*/
		   
	  update #TMP001  
            set VLCONTR = VLCONTR / isnull( VMValor, 1 )
              , VLPRIN  = VLPRIN / isnull( VMValor, 1 )
			  , VLENC   = VLENC / isnull( VMValor, 1 )
			 from BacParamSuda.dbo.valor_moneda VM 
	where	VM.vmfecha					= @fecCont 
	and		VM.VMCodigo					= #TMP001.Moneda_Emision_BAC
	and    #TMP001.codigo_Producto_BAC  <> 'CPX'
			 and #TMP001.Moneda_Emision_BAC not in ( 999, 998 ) -- Monedas locales en Chile 

	 -- Redondeo a los decimales requeridos
     update #TMP001
	     set VLCONTR = round( VLCONTR, 2 )
		   , VLPRIN  = round( VLPRIN, 2 )
		   , VLENC   = round( VLENC, 2 )
		   , [Valor de MTM] = round( [Valor de MTM],4)
		   , ATASOP = round( ATASOP, 8 )

      -- **************************************************************	  
	  -- IMPORTANTE: estas operaciones no pueden ser trasmitidas
	  -- **************************************************************
	DELETE	#TMP001	WHERE DTCONTR is null
    DELETE	#TMP001	WHERE VLPRIN > 99999999999.99 or VLCONTR > 99999999999.99 or [Valor de MTM] > 999999999999999.99


--select 'fre2',VLENC,[VLCONTR],[VLPRIN],* from  #TMP001 
--return
      -- Seccion para llevar a char todo que no es char	
      insert into #Salida
      select  [AGENCIA] = replicate(' ', 4)
            , [CGI]     = replicate( '0' , 13 - len( [CGI] ) ) 
			            +  convert( varchar(13), [CGI])  
            , [FILLER]  = [FILLER_01]
            , [FILLER_02] = replicate(' ', 11 )
            , [TIPOREG]   = '02'
            , [FILLER_03] = replicate(' ', 6 )
            , [OPER]      
            , [CONTRATO]  = replicate( '0' , 13 - len( [CONTRATO] ) ) 
			            +  convert( varchar(13), [CONTRATO])  
	        , [DTATU]     = convert( varchar(6), @fecCont, 12 )
			, [HRATU]     = replace( convert( varchar(8), GETDATE(), 8), ':', ''  )
			, [FILLER_04] = replicate(' ',7)
			, [OPER_02]  			 
			, [CONTRATO_02]  = replicate( '0' , 13 - len( [CONTRATO_02] ) ) 
			            +  convert( varchar(13), [CONTRATO_02])								
            , [DTCONTR]      = convert( varchar(6), [DTCONTR] , 12)
			, [DTVENC]       = dbo.fx_FormatoDDMM2AA([DTVENC]) 
            , [MOEDAR] 
--fmo 20200714
			, [VLCONTR]      =  case when len(floor(abs([VLCONTR])))>13 then replicate('9',13) else right(replicate('0',13) + convert(varchar(13),convert(numeric(19),abs([VLCONTR])))+'00',13) end --'0000000000000'--replicate( '0' , 13 - len(convert(numeric(13), [VLCONTR] * 100 ) ) ) 			            +      convert( varchar(13), convert(numeric(13), [VLCONTR] * 100 ) ) 
--fmo 20200714
            , [CODEMPI]      = '00'
			, [FILLER_05]    = replicate(' ',2)

			, [VLPRIN]       = case when len(floor(abs([VLPRIN])))>13 then replicate('9',13) else right(replicate('0',13) + convert(varchar(13),convert(numeric(19),abs([VLPRIN])))+'00',13) end
--			replicate( '0' , 13 - len(convert(numeric(13), [VLPRIN] * 100 ) ) ) + convert( varchar(13), convert(numeric(13), [VLPRIN] * 100 ) ) 	--FREDDY
					
--fmo 20200331
            , [VLENC]        = case when len(floor(abs([VLENC])))>13 then replicate('9',13) else right(replicate('0',13) + convert(varchar(13),convert(numeric(19),abs([VLENC])))+'00',13) end
--fmo 20200331
            , [DTPPARC]      = replicate( '0', 6 )
			, [VLRVCDO]      = replicate('0', 13)
			, [FILLER_06]    = replicate(' ',31)
			, [NOMENC]       = rtrim([NOMENC]) + replicate( ' ', 30-len(rtrim([NOMENC])) ) 			
			, [CGIVEI]       = replicate('0',13)
            , [FILLER_07]    = replicate(' ',1)			
			, [CODSIST]      = 'QC'
			, [Valor de MTM] = replicate( '0' , 17 - len(convert(numeric(17), [Valor de MTM]  * 10000 ) ) ) 
			            +      convert( varchar(17), convert(numeric(17), [Valor de MTM]  * 10000 ) ) 
			, [Valor de RCP] = replicate('0',17)
			
			,  [Nome do Produto]  = rtrim( [Nome do Producto]) + replicate( ' ', 50 - len([Nome do Producto]) )
			,  [Saldo_Credito]    = replicate('0',17)			
			,  [AMOOPE]           = Rtrim([AMOOPE] ) + replicate( ' ', 4 -len(rtrim([AMOOPE] )) )   
			,  [AINDOP]           = replicate(' ',30) 
			,  [APOROP]           = replicate('0', 5) 		
			,  [ATASOP]           = case when [ATASOP] >= 0 then
			                         replicate( '0' , 14 - len(convert(numeric(14), [ATASOP]  * 100000000 ) ) ) 
			          +      convert( varchar(14), convert(numeric(14), [ATASOP]  * 100000000 ) )						
						            else 
									  '-' +   -- Signo negativo al comienzo del campo
                                    replicate( '0' , 13 - len(convert(numeric(13), abs([ATASOP])  * 100000000 ) ) ) 
			            +      convert( varchar(13), convert(numeric(13), abs([ATASOP])  * 100000000 ) )										
									end					
									
			,  [PMOOPE]           = replicate(' ',4)  
			,  [PINDOP]           = replicate(' ',30) 
			,  [PPOROP]           = replicate('0',5) 
			,  [PTASOP]           = replicate('0',13) 
			,  Corr
			,  Rut_Cliente
			,  Codigo_Cliente			
	from #TMP001


--select top 3 'fre3',* from  #TMP001 
--RIGHT( REPLICATE('0',13)+CONVERT(VARCHA R(13),CONVERT(NUMERIC(19),CONVERT(FLOAT,VLENC)))+'00' ,13)

	insert into #INT_SALIDA
	select	convert( varchar(464),
			    /*01*/  [AGENCIA] 
			+   /*02*/  [CGI]	   
			+   /*03*/  [FILLER_01]  
			+   /*04*/  [FILLER_02]
			+   /*05*/  [TIPOREG]
			+   /*06*/  [FILLER_03]
			+   /*07*/  [OPER]
			+   /*08*/  [CONTRATO] 
			+   /*09*/  [DTATU] 
			+   /*10*/  [HRATU]	
			+   /*11*/  [FILLER_04] 
			+   /*12*/  [OPER_02] )
			+   /*13*/  [CONTRATO_02] 
			+   /*14*/  [DTCONTR]
			+   /*15*/  [DTVENC] 
		    +   /*16*/  [MOEDAR] 
			+   /*17*/  [VLCONTR] 
			+   /*18*/  [CODEMPI]
			+   /*19*/  [FILLER_05] 
			+   /*20*/  [VLPRIN]
			+   /*21*/  [VLENC] 
			+   /*22*/  [DTPPARC] 
			+   /*23*/  [VLRVCDO]
			+   /*24*/  [FILLER_06]
			+   /*25*/   [NOMENC]  
			+   /*26*/  [CGIVEI] 
			+   /*27*/  [FILLER_07] 
			+   /*28*/  [CODSIST]  
			+   /*29*/  [Valor de MTM]
			+   /*30*/  [Valor de RCP] 
			+   /*31*/  [Nome do produto] 
			+   /*32*/  [Saldo_Credito] 
			+   /*33*/  [AMOOPE]          
			+   /*34*/  [AINDOP]         
			+   /*35*/  [APOROP]         
			+   /*36*/  [ATASOP]         
			+   /*37*/  [PMOOPE]         
			+   /*38*/  [PINDOP]         
			+   /*39*/  [PPOROP]        
			+   /*40*/  [PTASOP]  --) 			 	  
        , ORDEN = Corr
        , CANTIDAD = 0 
        , Moneda = 0
        , Rut_Cliente  
        , Codigo_Cliente 
	   from #Salida 

		if exists( select (1) from #INT_SALIDA )
		   BEGIN
				If @Formateada = 'S'
				Begin
					declare @Cnt_Registros numeric(10)
					select  @Cnt_Registros = count(1) from #INT_SALIDA where linea = linea -- ojo que hay valores con NULL
					update #INT_SALIDA set cantidad = @Cnt_Registros

					if exists( select (1) from #INT_SALIDA where #INT_SALIDA.LINEA like '%ADVERTENCIA: moneda no definida:%' )
					   select Linea = convert( CHAR(464) , substring(  #INT_SALIDA.LINEA ,  1, 464) ), Cnt = @Cnt_Registros, orden, rut_Cliente
							  from #INT_SALIDA  where linea = linea
							  order by  ORDEN
					else
					  begin
						  SELECT convert( CHAR(464) , substring(  #INT_SALIDA.LINEA ,  1, 464 ) ), Cnt = @Cnt_Registros, orden, rut_Cliente 
						      FROM #INT_SALIDA   where linea = linea				  
						   order by  #INT_SALIDA.ORDEN
					  end 
				End 
				else select * from #Salida
		   END
		else
		 select  Linea = convert( CHAR(300) , 'NO HAY INFORMACION PARA INTERFAZ!!!!' )
			   , Cnt = 0  , orden = 0, rut_Cliente = 0
    FIN:
	     drop table #Salida
		 drop table #TMP001
		 drop table #INT_SALIDA
		 drop table #CodigoAS400Mda
		 -- drop table #TMPInvex
END


GO
