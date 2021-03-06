USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mensaje_139_Bcch]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_Mensaje_139_Bcch]
as  
begin   

	set nocount on  
  
	declare @acfecprox			datetime	declare @acfecproc			datetime
	declare @valor_pres			numeric(19,4)
	declare @valor_pres2		numeric(19,4)
	declare @Responsable		char(40)
	declare @Referencia			char(40)   

	select	@acfecproc			= acfecproc
		,	@acfecprox			= acfecprox
		,	@Responsable		= acnom_resoma
		,	@Referencia			= acnomprop
	from	BacTraderSuda.dbo.MDAC with(nolock)

	DECLARE @Fecha_Interfaz		DATETIME
		SET	@Fecha_Interfaz		= @acfecproc

	-->		Define la fecha del Informe a partir de la fecha de proceso 
	-->		Controla el Fin de Mes 
	DECLARE	@dFechaOrigen		DATETIME;	SET	@dFechaOrigen	= @Fecha_Interfaz
	DECLARE @dFechaProxima		DATETIME;	SET @dFechaProxima	= @Fecha_Interfaz

	EXECUTE SP_BUSCA_FECHA_HABIL @dFechaProxima, 1, @dFechaProxima OUTPUT

	-->		Identifica el Fin de Mes    
	DECLARE @dFechaCierreMes	DATETIME    
		SET @dFechaCierreMes	= DATEADD( DAY, DAY(DATEADD(MONTH, 1, @Fecha_Interfaz)) *-1, DATEADD(MONTH, 1, @Fecha_Interfaz) )

	IF @dFechaCierreMes <> @Fecha_Interfaz AND MONTH(@dFechaCierreMes) > MONTH(@dFechaProxima)
	BEGIN
		IF MONTH(@Fecha_Interfaz) <> MONTH(@dFechaProxima) AND DATEDIFF(DAY, @Fecha_Interfaz, @dFechaProxima) > 1
		BEGIN
			SET @Fecha_Interfaz = @dFechaCierreMes
			SET @dFechaProxima  = @dFechaCierreMes
		END
	END

	-->		Identifica el Fin de Mes    
	SET @Fecha_Interfaz = case	when month( @Fecha_Interfaz ) <> month( @dFechaProxima ) then @dFechaCierreMes
								else @Fecha_Interfaz
							end
	-->		Define la fecha del Informe a partir de la fecha de proceso 
	-->		Controla el Fin de Mes 


	select	Codigo				= convert(int,		inst.incodigo)
		,	instrumento			= convert(char(10),	inst.inserie)
		,	inglosa				= convert(char(50),	inst.inglosa)
		,	MontoInst			= convert(numeric(19,4), isnull((mdcp.cpmonto / 1000), 0.0))
		,	MontoInterm			= convert(numeric(19,4), isnull((mdvi.vimonto / 1000), 0.0))
		,	MontoCompra			= convert(numeric(19,4), isnull((mdci.cimonto / 1000), 0.0))
		,	MontoDeudores		= convert(numeric(19,4), 0.0)
		,	Linea01				= case	when inst.inserie = 'PDBC'	then 'AG2:'
										when inst.inserie = 'PRBC'	then 'AG7:'
										when inst.inserie = 'PRC'	then 'AGC:'
										when inst.inserie = 'CERO'	then 'AGH:'
										when inst.inserie = 'BCP'	then 'AGM:'
										when inst.inserie = 'BCU'	then 'AGR:'
										when inst.inserie = 'BCD'	then 'AGW:'
										when inst.inserie = 'BCX'	then 'AH1:'
										when inst.inserie = 'BTP'	then 'AH6:'
										when inst.inserie = 'BTU'	then 'AHB:'
										when inst.inserie = ''		then 'AHG:'
									end
		,	LineaIntermedia		= case	when inst.inserie = 'PDBC'	then 'PAGARES DESCONTABLES DEL BCCH'
										when inst.inserie = 'PRBC'	then 'PAGARES REAJUSTABLES DEL BCCH'
										when inst.inserie = 'PRC'	then 'PAGARES DESCONTABLES DEL BCCH CON PAGO DE CUPONES'
										when inst.inserie = 'CERO'	then 'CUPONES DE EMISION REAJUSTABLES OPCIONALES EN UF'
										when inst.inserie = 'BCP'	then 'BONOS DEL BANCO CENTRAL DE CHILE EN PESOS'
										when inst.inserie = 'BCU'	then 'BONOS DEL BANCO CENTRAL DE CHILE EN UF'
										when inst.inserie = 'BCD'	then 'BONOS DEL BANCO CENTRAL DE CHILE EXPRESADOS EN US$'
										when inst.inserie = 'BCX'	then 'BONOS DEL BANCO CENTRAL DE CHILE EN US$'
										when inst.inserie = 'BTP'	then 'BONOS DE LA TESORERIA GRAL REPUBLICA EN PESOS'
										when inst.inserie = 'BTU'	then 'BONOS DE LA TESORERIA GRAL REPUBLICA EN UF'
										when inst.inserie = ''		then 'OTROS INSTRUMENTOS EMITIDOS EN EL PAIS'
									end	 
		,	Linea02				= case	when inst.inserie = 'PDBC'	then 'AG3:' + '1150.1.01'
										when inst.inserie = 'PRBC'	then 'AG8:' + '1150.1.01'
										when inst.inserie = 'PRC'	then 'AGD:' + '1150.1.01'
										when inst.inserie = 'CERO'	then 'AGI:' + '1150.1.01'
										when inst.inserie = 'BCP'	then 'AGN:' + '1150.1.01'
										when inst.inserie = 'BCU'	then 'AGS:' + '1150.1.01'
										when inst.inserie = 'BCD'	then 'AGX:' + '1150.1.01'
										when inst.inserie = 'BCX'	then 'AH2:' + '1150.1.01'

										when inst.inserie = 'BTP'	then 'AH7:' + '1150.1.02'
										when inst.inserie = 'BTU'	then 'AHC:' + '1150.1.02'
										when inst.inserie = ''		then 'AHH:' + '1150.02'			--> 'AHH:' + '1150.1.02'
									end
		,	Linea03				= case	when inst.inserie = 'BTP'	then '+ 1350.1.02 + 1360.1.02 '
										when inst.inserie = 'BTU'	then '+ 1350.1.02 + 1360.1.02 '
										when inst.inserie = ''		then '+ 1350.02 + 1360.02 '		-->	'+ 1350.1.02 + 1360.1.02 '
										else							 '+ 1350.1.01 + 1360.1.01 '
									end
		,	Linea0301			= case	when inst.inserie = 'PDBC'	then 'Monto Pagares  ' + inst.inserie
										when inst.inserie = 'PRBC'	then 'Monto Pagares  ' + inst.inserie
										when inst.inserie = 'PRC'	then 'Monto Pagares  ' + inst.inserie
										when inst.inserie = 'CERO'	then 'Monto Pagares  ' + inst.inserie
										when inst.inserie = 'BCP'	then 'Monto Bonos	 ' + inst.inserie
										when inst.inserie = 'BCU'	then 'Monto Bonos	 ' + inst.inserie
										when inst.inserie = 'BCD'	then 'Monto Bonos	 ' + inst.inserie
										when inst.inserie = 'BCX'	then 'Monto Bonos	 ' + inst.inserie
										when inst.inserie = 'BTP'	then 'Monto Bonos	 ' + inst.inserie
										when inst.inserie = 'BTU'	then 'Monto Bonos	 ' + inst.inserie
										when inst.inserie = ''		then 'Monto Otros Instrumentos ' 
									end	 
		,	Linea04				= case	when inst.inserie = 'PDBC'	then 'AG4:'
										when inst.inserie = 'PRBC'	then 'AG9:'
										when inst.inserie = 'PRC'	then 'AGE:'
										when inst.inserie = 'CERO'	then 'AGJ:'
										when inst.inserie = 'BCP'	then 'AG0:'
										when inst.inserie = 'BCU'	then 'AGT:'
										when inst.inserie = 'BCD'	then 'AGY:'
										when inst.inserie = 'BCX'	then 'AH3:'
										when inst.inserie = 'BTP'	then 'AH8:'
										when inst.inserie = 'BTU'	then 'AHD:'
										when inst.inserie = ''		then 'AHI:'
									end	+ '2160.1'
		,	Linea05				= case	when inst.inserie = 'PDBC'	then 'AG5:'
										when inst.inserie = 'PRBC'	then 'AGA:'
										when inst.inserie = 'PRC'	then 'AGF:'
										when inst.inserie = 'CERO'	then 'AGK:'
										when inst.inserie = 'BCP'	then 'AGP:'
										when inst.inserie = 'BCU'	then 'AGU:'
										when inst.inserie = 'BCD'	then 'AGZ:'
										when inst.inserie = 'BCX'	then 'AH4:'
										when inst.inserie = 'BTP'	then 'AH9:'
										when inst.inserie = 'BTU'	then 'AHE:'
										when inst.inserie = ''		then 'AHJ:'
									end	+ '1160.1'
		,	Linea06				= case	when inst.inserie = 'PDBC'	then 'AG6:'
										when inst.inserie = 'PRBC'	then 'AGB:'
										when inst.inserie = 'PRC'	then 'AGG:'
										when inst.inserie = 'CERO'	then 'AGL:'
										when inst.inserie = 'BCP'	then 'AGQ:'
										when inst.inserie = 'BCU'	then 'AGV:'
										when inst.inserie = 'BCD'	then 'AH0:'
										when inst.inserie = 'BCX'	then 'AH5:'
										when inst.inserie = 'BTP'	then 'AHA:'
										when inst.inserie = 'BTU'	then 'AHF:'
										when inst.inserie = ''		then 'AHK:'
									end	+ '1160.2'
		,	Linea07				= 'E32'
		,	inorden				= case	when inst.inserie = 'PDBC'	then 1
										when inst.inserie = 'PRBC'	then 2
										when inst.inserie = 'PRC'	then 3
										when inst.inserie = 'CERO'	then 4
										when inst.inserie = 'BCP'	then 5
										when inst.inserie = 'BCU'	then 6
										when inst.inserie = 'BCD'	then 7
										when inst.inserie = 'BCX'	then 8
										when inst.inserie = 'BTP'	then 9
										when inst.inserie = 'BTU'	then 10
										when inst.inserie = ''		then 11
									end
		,	Linea0400			= case	when inst.inserie = ''		then 'Otros instrumentos intermediados'
										else							 ltrim(rtrim( inst.inserie )) + ' Intermediados'
									end
		,	Linea0401			= 'Compra ' +  case when inst.inserie = ''		then 'otros instrumentos'
													else							 ltrim(rtrim( inst.inserie )) + ' con pacto/retrocompra'
												end
		,	Lineas0402			= 'Deudores por préstamos de ' 
								+ case  when inst.inserie = '' then 'otros instrumentos'
										else						ltrim(rtrim( inst.inserie ))
									end
		,	Lin01				= '18 :NOMBRE Y CARGO RESPONS INFORM '
		,	Lin02				= '20 :NUESTRA REFERENCIA '
		,	Lin03				= '34 :FECHA VALIDEZ DATOS'
		,	Lin04				= 'E32:'
		,	Lin05				= 'AG0:REF. MB2'
		,	Lin06				= 'AG1:'
		,	Fecha				= @acfecproc
		,	Responsable			= @Responsable
		,	Referencia			= @Referencia
		
	from	(	SELECT	incodigo, inserie, inglosa 
				FROM	BacParamSuda.dbo.Instrumento
				WHERE	inserie	IN('PDBC', 'PRBC', 'PRC', 'CERO', 'BCP', 'BCU', 'BCD', 'BCX', 'BTP', 'BTU') -- ,'ZERO')

				UNION	

				SELECT	-1,	'',	'OTROS INSTRUMENTOS EMITIDOS EN EL PAIS'
			)	inst 

			left	join (	select	cpcodigo	= Item1.cpcodigo
								,	cpmonto		= sum( Item1.cpmonto )
							from	(	select	cpcodigo	= Cartera.cpcodigo
											,	inserie		= Cartera.inserie
											,	moneda		= Cartera.moneda
											,	cpmonto		= SUM( Cartera.cpmonto )
										from	(	select	cpcodigo	= case when rmcodigo IN(4,6,7,32,33,34,36,39,40,300) then rmcodigo else -1 end
														,	inserie		= inserie
														,	moneda		= moneda_emision
														,	cpmonto		= case when codigo_carterasuper = 'A' then valor_presente else valor_mercado end
													from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
															inner join BacParamSuda.dbo.Instrumento with(nolock) On Incodigo = rmcodigo
													where	fecha_valorizacion	= @Fecha_Interfaz
													AND		rmcodigo			IN(4,6,7,32,33,34,36,39,40,300)
													and		rminstser			not in( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9907)
												)	Cartera
										group 
										by		cpcodigo
											,	inserie
											,	moneda
											union
										select	cpcodigo	= Cartera.cpcodigo
											,	inserie		= Cartera.inserie
											,	moneda		= Cartera.moneda
											,	cpmonto		= SUM( Cartera.cpmonto )
										from	(	select	cpcodigo	= case when rmcodigo IN(4,6,7,32,33,34,36,39,40,300) then rmcodigo else -1 end
														,	inserie		= inserie
														,	moneda		= moneda_emision
														,	cpmonto		= case when codigo_carterasuper = 'A' then valor_presente else valor_mercado end
													from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
															inner join BacParamSuda.dbo.Instrumento with(nolock) On Incodigo = rmcodigo
													where	fecha_valorizacion	= @Fecha_Interfaz
													AND		rmcodigo			NOT IN(888)
													AND		rmcodigo			NOT IN(4,6,7,32,33,34,36,39,40,300)
													and		rminstser			not in( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9907)
												)	Cartera
										group 
										by		cpcodigo
											,	inserie
											,	moneda
											union
										select	cpcodigo	= Cartera.cpcodigo
											,	inserie		= Cartera.inserie
											,	Moneda		= Cartera.Moneda
											,	cpmonto		= SUM( Cartera.cpmonto	)
										from	(	select	cpCodigo	= -1
														,	Inserie		= 'BONOS'
														,	Moneda		= rsmonemi
														,	cpmonto		= round((case when codigo_carterasuper = 'A' then rsvppresen else rsvalmerc end) * tc.tipo_cambio,0)
														,	MontoMer	= ( rsvalmerc )
														,	MontoPre	= ( rsvppresen )
														,	DifMer		= ( rsDiferenciaMerc )
													from	BacBonosExtSuda.dbo.Text_Rsu with(nolock)
															left join BacParamSuda.dbo.Valor_Moneda_Contable tc with(nolock) On tc.Fecha = rsfecpro and codigo_moneda = 994
													where	rsfecpro	= @Fecha_Interfaz
													and		rstipoper	= 'DEV'
													and		cod_nemo	not in( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9907)
												)	Cartera
										group
										by		cpcodigo
											,	inserie
											,	moneda
									)	Item1
								
							group
							by		Item1.cpcodigo

						)	mdcp	On	mdcp.cpcodigo	= inst.incodigo



			left	join (	
							select	vicodigo	= case when rscodigo IN(4,6,7,32,33,34,36,39,40,300) then rscodigo else -1 end
								,	vimonto		= sum(rsvalinip
												+ ROUND( rsvalinip * (rstaspact/100.0) / 360.0 * DATEDIFF(DAY,rsfecinip, rsfecha), 2)
												+ ROUND(case	when rsmonpact /*rsmonemi*/ = 998 then (UfPro.vmvalor - UfInip.vmvalor) * rsnominal 
																else 0.0
															end, 2)
														)
							from	BacTraderSuda.dbo.mdrs
									inner join (	SELECT	incodigo
														,	inserie
													FROM	BacParamSuda.dbo.Instrumento with(nolock) 
													WHERE	inserie	NOT IN( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9908)
												)	inst	On inst.Incodigo = rscodigo
									left  join BacParamSuda.dbo.valor_moneda UfPro	On	UfPro.vmfecha	= rsfecha
																					and UfPro.vmcodigo	= 998
									left  join BacParamSuda.dbo.valor_moneda UfInip	On	UfInip.vmfecha	= rsfecinip
																					and UfInip.vmcodigo	= 998

									inner join (	select	clrut, clcodigo, cltipcli, clnombre
													from	BacParamSuda.dbo.Cliente cli with(nolock)
													where	cltipcli = 1
												)	cli		On	cli.clrut		= rsrutcli
															and cli.clcodigo	= rscodcli

							where	rsnominal	> 0
							and		rstipoper	= 'DEV'
							and		rsfecha		= @Fecha_Interfaz
							and		rscartera	IN(115)
					--		and		rscodigo	NOT IN(888)
							and		rsrutcli	<> 97029000
							and		rsinstser	not in( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9907)
							group
							by		case when rscodigo IN(4,6,7,32,33,34,36,39,40,300) then rscodigo else -1 end

						)	mdvi	On	mdvi.vicodigo = inst.incodigo


			left	join (	
							select	cicodigo	= case when rscodigo IN(4,6,7,32,33,34,36,39,40,300) then rscodigo else -1 end
								,	cimonto		= sum(rsvalinip
												+ ROUND( rsvalinip * (rstaspact/100.0) / 360.0 * DATEDIFF(DAY,rsfecinip, rsfecha), 2)
												+ ROUND(case	when rsmonpact /*inst.inmonemi*/ = 998 then (UfPro.vmvalor - UfInip.vmvalor) * rsnominal 
																else 0.0
															end, 2)
														)
							from	BacTraderSuda.dbo.mdrs
									inner join (	SELECT	incodigo
														,	inserie
														,	inmonemi
													FROM	BacParamSuda.dbo.Instrumento with(nolock) 
													WHERE	inserie	NOT IN( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9908)
												)	inst	On inst.Incodigo = rscodigo

									left  join BacParamSuda.dbo.valor_moneda UfPro	On	UfPro.vmfecha	= rsfecha
																					and UfPro.vmcodigo	= 998
									left  join BacParamSuda.dbo.valor_moneda UfInip	On	UfInip.vmfecha	= rsfecinip
																					and UfInip.vmcodigo	= 998

									inner join (	select	clrut, clcodigo, cltipcli, clnombre
													from	BacParamSuda.dbo.Cliente cli with(nolock)
													where	cltipcli = 1
												)	cli		On	cli.clrut		= rsrutcli
															and cli.clcodigo	= rscodcli
							where	rsnominal	> 0
							and		rstipoper	= 'DEV'
							and		rsfecha		= @Fecha_Interfaz
							and		rscartera	IN(112)
					--		and		rscodigo	NOT IN(888)
							and		rsrutcli	<> 97029000
							and		rsinstser	not in( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9907)
							group
							by		case when rscodigo IN(4,6,7,32,33,34,36,39,40,300) then rscodigo else -1 end

						)	mdci	On	mdci.cicodigo	= inst.incodigo

	order 
	by		case	when inst.inserie = 'PDBC'	then 1
					when inst.inserie = 'PRBC'	then 2
					when inst.inserie = 'PRC'	then 3
					when inst.inserie = 'CERO'	then 4
					when inst.inserie = 'BCP'	then 5
					when inst.inserie = 'BCU'	then 6
					when inst.inserie = 'BCD'	then 7
					when inst.inserie = 'BCX'	then 8
					when inst.inserie = 'BTP'	then 9
					when inst.inserie = 'BTU'	then 10
					when inst.inserie = ''		then 11
				end

end

GO
