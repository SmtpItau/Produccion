USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_P40_BANCO_IBS_rch]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_INTERFAZ_P40_BANCO_IBS_rch]
	(	@Fecha_Interfaz		DATETIME	)    
AS    
BEGIN     

	SET NOCOUNT ON    

	/*
	DECLARE	@dFechaOrigen		DATETIME;	SET	@dFechaOrigen	= @Fecha_Interfaz
	DECLARE @dFechaProxima		DATETIME;	SET @dFechaProxima	= @Fecha_Interfaz

	EXECUTE SP_BUSCA_FECHA_HABIL @dFechaProxima, 1, @dFechaProxima OUTPUT

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
	*/
	
	declare @dFechaMercado	datetime	--	'Fecha mercado (T0)'
	declare @dFechacartera	datetime	--	'Fecha cartera (+1)'
	declare @dFechaProxima	datetime

	if exists( select 1 from BacTraderSuda.dbo.Fechas_Proceso where acfecproc = @Fecha_Interfaz )
	begin
		select	@dFechaMercado			= case	when month(acfecproc) <> month(acfecprox) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(acfecproc)*-1),acfecproc))))
												else acfecproc
	      									end
			,	@dFechacartera			= case	when month(acfecproc) <> month(acfecprox) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(acfecproc)*-1),acfecproc))))
												else acfecprox
	      									end
		from	BacTraderSuda.dbo.Fechas_Proceso 
		where	acfecproc	= @Fecha_Interfaz

	end else
	begin

		SET		@dFechaProxima	= @Fecha_Interfaz
		EXECUTE SP_BUSCA_FECHA_HABIL @dFechaProxima, 1, @dFechaProxima OUTPUT
		
		select	@dFechaMercado			= case	when month(@Fecha_Interfaz) <> month(@dFechaProxima) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(@Fecha_Interfaz)*-1),@Fecha_Interfaz))))
												else @Fecha_Interfaz
	      									end
			,	@dFechacartera			= case	when month(@Fecha_Interfaz) <> month(@dFechaProxima) then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(@Fecha_Interfaz)*-1),@Fecha_Interfaz))))
												else @dFechaProxima
	      									end
	end


select	Tipo_Registro			=	convert(char(2),		Ret.Tipo_Registro			)
	,	Codigo_Tenedor			=	convert(char(12),		Ret.Codigo_Tenedor			)
	,	Fecha_Proceso			=	convert(char(8),		Ret.Fecha_Proceso			)
	,	Fecha_Compra			=	convert(char(10),		Ret.Fecha_Compra			)
	,	Tipo_Cartera			=	convert(numeric(5),		Ret.Tipo_Cartera			)
	,	Emisor					=	convert(varchar(11),	Ret.Emisor					)
	,	Pais_Emisor				=	convert(int,			Ret.Pais_Emisor				)
	,	Familia_Instrumento		=	convert(char(2),		Ret.Familia_Instrumento		)
	,	Nemotecnico				=	convert(char(20),		Ret.Nemotecnico				)
	,	Tipo_Rendimiento		=	convert(int,			Ret.Tipo_Rendimiento		)
	,	Periodicidad_Cupon		=	convert(decimal(5),		Ret.Periodicidad_Cupon		)
	,	Fecha_Ultimo_Cupon		=	convert(char(8),		Ret.Fecha_Ultimo_Cupon		)
	,	Fecha_Proximo_Cupon		=	convert(char(8),		Ret.Fecha_Proximo_Cupon		)
	,	Fecha_Vcto_Instr		=	convert(char(8),		Ret.Fecha_Vcto_Instr		)
	,	Derivado_Incrust_Opc	=	convert(char(2),		Ret.Derivado_Incrust_Opc	)
	,	Nominal_Inicial			=	convert(numeric(19,4),	Ret.Nominal_Inicial			)
	,	Nominal_Actual			=	convert(numeric(19,4),	Ret.Nominal_Actual			)
	,	Moneda_Emision			=	convert(numeric(3),		Ret.Moneda_Emision			)
	,	Moneda_Reajuste			=	convert(varchar(4),		Ret.Moneda_Reajuste			)
	,	Tipo_Tasa_Emision		=	convert(varchar(7),		Ret.Tipo_Tasa_Emision		)
	,	Tasa_Emision			=	convert(numeric(9,4),	Ret.Tasa_Emision			)
	,	Tera					=	convert(numeric(8,4),	Ret.Tera					)
	,	Valor_Par				=	convert(numeric(18,4),	Ret.Valor_Par				)
	,	Tipo_Tasa_Compra		=	convert(char(7),		Ret.Tipo_Tasa_Compra		)
	,	Tasa_Compra				=	convert(numeric(9,4),	Ret.Tasa_Compra				)
	,	Costo_Adquisicion		=	convert(numeric(19,4),	Ret.Costo_Adquisicion		)
	,	Costo_Amortizado		=	convert(numeric(14,0),	Ret.Costo_Amortizado		)
	,	Valor_Razonable			=	convert(numeric(19,4),	Ret.Valor_Razonable			)
	,	Tipo_Tasa_Valoriza		=	convert(varchar(7),		Ret.Tipo_Tasa_Valoriza		)
	
	,	Tasa_Valorizacion		=	convert(numeric(19,4),	Ret.Tasa_Valorizacion		)
	
	,	Tipo_valorizacion		=	convert(int,			Ret.Tipo_valorizacion		)
	,	Precio_Instrumento		=	convert(numeric(6,2),	Ret.Precio_Instrumento		)
	,	Duracion_Modificada		=	convert(numeric(24,8),	Ret.Duracion_Modificada		)
	,	Convexidad				=	convert(numeric(24,8),	Ret.Convexidad				)
	,	Valor_Deterioro			=	convert(numeric(14,0),	Ret.Valor_Deterioro			)
	,	Condicion_Instrumento	=	convert(int,			Ret.Condicion_Instrumento	)
	,	Fecha_Inicio_Cond		=	convert(char(8),		Ret.Fecha_Inicio_Cond		)
	,	Fecha_Final_Cond		=	convert(char(8),		Ret.Fecha_Final_Cond		)
	,	iCantidad				=	dbo.Fx_ReplicaId(Ret.iCantidad, ROW_NUMBER() over( order by Ret.iCantidad desc ))
	,	signoTCmp				=	Ret.signoTCmp
	,	signoTVal				=	Ret.signoTVal
from	(
	select	Tipo_Registro				= TmpP40.Tipo_Registro
		,	Codigo_Tenedor				= TmpP40.Codigo_Tenedor
		,	Fecha_Proceso				= TmpP40.Fecha_Proceso
		,	Fecha_Compra				= TmpP40.Fecha_Compra
		,	Tipo_Cartera				= TmpP40.Tipo_Cartera
		,	Emisor						= TmpP40.Emisor
		,	Pais_Emisor					= TmpP40.Pais_Emisor
		,	Familia_Instrumento			= TmpP40.Familia_Instrumento
		,	Nemotecnico					= TmpP40.Nemotecnico
		,	Tipo_Rendimiento			= TmpP40.Tipo_Rendimiento

		,	Periodicidad_Cupon			= case	when TmpP40.Tipo_Rendimiento = 1 then 0
												else TmpP40.xPeriodicidad
											end

		,	Fecha_Ultimo_Cupon			= case	when TmpP40.Tipo_Rendimiento = 1 then '00000000'
												else TmpP40.Fecha_Ultimo_Cupon
											end
		,	Fecha_Proximo_Cupon			= case	when TmpP40.Tipo_Rendimiento = 1 then '00000000' 
												else TmpP40.Fecha_Proximo_Cupon
											end

		,	Fecha_Vcto_Instr			= TmpP40.Fecha_Vcto_Instr
		,	Derivado_Incrust_Opc		= TmpP40.Derivado_Incrust_Opc
		,	Nominal_Inicial				= TmpP40.Nominal_Inicial
		,	Nominal_Actual				= TmpP40.Nominal_Actual
		,	Moneda_Emision				= TmpP40.Moneda_Emision
		,	Moneda_Reajuste				= TmpP40.Moneda_Reajuste
		,	Tipo_Tasa_Emision			= TmpP40.Tipo_Tasa_Emision
		,	Tasa_Emision				= abs( TmpP40.Tasa_Emision )
		,	Tera						= abs( TmpP40.Tera )
		,	Valor_Par					= TmpP40.Valor_Par
		,	Tipo_Tasa_Compra			= TmpP40.Tipo_Tasa_Compra
		,	Tasa_Compra					= abs( TmpP40.Tasa_Compra )
		,	Costo_Adquisicion			= TmpP40.Costo_Adquisicion
		,	Costo_Amortizado			= TmpP40.Costo_Amortizado
		,	Valor_Razonable				= TmpP40.Valor_Razonable
		,	Tipo_Tasa_Valoriza			= TmpP40.Tipo_Tasa_Valoriza
		,	Tasa_Valorizacion			= case	when abs(TmpP40.Tasa_Valorizacion) > 100 then abs(TmpP40.Tasa_Valorizacion) - abs((100 - abs(TmpP40.Tasa_Valorizacion))-1)
												else abs(TmpP40.Tasa_Valorizacion)
											end
		,	Tipo_valorizacion			= TmpP40.Tipo_valorizacion
		,	Precio_Instrumento			= abs( TmpP40.Precio_Instrumento )
		,	Duracion_Modificada			= TmpP40.Duracion_Modificada
		,	Convexidad					= TmpP40.Convexidad
		,	Valor_Deterioro				= TmpP40.Valor_Deterioro
		,	Condicion_Instrumento		= TmpP40.Condicion_Instrumento
		,	Fecha_Inicio_Cond			= TmpP40.Fecha_Inicio_Cond
		,	Fecha_Final_Cond			= TmpP40.Fecha_Final_Cond
		,	Filler						= TmpP40.Filler
		,	numero_Documento			= TmpP40.numero_Documento
		,	Correlativo					= TmpP40.Correlativo
		,	Numero_Operacion			= TmpP40.Numero_Operacion
		,	Seriado						= TmpP40.Seriado
		,	Codigo						= TmpP40.Codigo
		,	Serie						= TmpP40.Serie
		,	FecCupVen					= TmpP40.FecCupVen
		,	FechaEmision				= TmpP40.FechaEmision
		,	NomOriginal					= TmpP40.NomOriginal
		,	rutcart						= TmpP40.rutcart
		,   signoTCmp					= CASE WHEN TmpP40.Tasa_Compra       >= 0 THEN '+' ELSE '-' END                                                        -- 35. Signo Tasa Compra    
        ,   signoTVal					= CASE WHEN TmpP40.Tasa_Valorizacion >= 0 THEN '+' ELSE '-' END                     -- 36. Signo Tasa Valorizacion    
		,	iCantidad					= TmpP40.iCantidad
	from	(

		SELECT	'Tipo_Registro'				= '01'
		,		'Codigo_Tenedor'			= '039' --20200514.RCHS AJUSTES P40 '027'
		,		'Fecha_Proceso'				= CONVERT(CHAR(8),	@Fecha_Interfaz,	112)
		,		'Fecha_Compra'				= CONVERT(CHAR(10), MDRS.rsfeccomp,		112)
		,		'Tipo_Cartera'				= CASE	WHEN MDRS.codigo_carterasuper = 'A' THEN 3
													WHEN MDRS.codigo_carterasuper = 'P' THEN 2
													WHEN MDRS.codigo_carterasuper = 'T' THEN 1
													WHEN MDRS.codigo_carterasuper = 'R' THEN 1
													ELSE                                     2
												END
		,		'Emisor'					= CONVERT(VARCHAR(11),	REPLICATE('0',(9 -LEN(LTRIM(RTRIM(STR( ltrim(rtrim( MDRS.rsrutemis )) )))))) 
																+	LTRIM(RTRIM(STR( ltrim(rtrim( MDRS.rsrutemis )) ))) 
																+	ltrim(rtrim( Emisor.emdv ))	)
		,		'Pais_Emisor'				= 160
		,		'Familia_Instrumento'		= CASE	WHEN Emisor.emrut	= 97029000					THEN '01'
													WHEN Emisor.emrut	= 60805000					THEN '01'
													WHEN Emisor.emrut	= 61533000					THEN '03'
													WHEN MDRS.rscodigo	= 20						THEN '04'
													WHEN MDRS.rscodigo	IN (9,11)					THEN '10'
													WHEN MDRS.rscodigo	= 15 AND Emisor.emtipo = 1	THEN '06'
													WHEN MDRS.rscodigo	= 15 AND Emisor.emtipo = 2	THEN '08'
													WHEN MDRS.rscodigo	= 15 AND Emisor.emtipo = 4	THEN '52'
													ELSE												 '00'
												END
		,		'Nemotecnico'				= CASE	WHEN MDRS.rscodigo = 9	THEN NEMOTECNICO.nsnemo
													WHEN MDRS.rscodigo = 11 THEN NEMOTECNICO.nsnemo
													ELSE						 Convert(Char(20), MDRS.rsinstser )
												END

		,		'Tipo_Rendimiento'			= CASE	WHEN INST.inmdse		= 'N'	THEN 1
													WHEN SERIE.secupones	<= 1    THEN 1
													WHEN SERIE.senumamort	= 1		THEN 2
													WHEN INST.incodigo		= 20	THEN 3
													ELSE								 9    
												END

		,		'Periodicidad_Cupon'		= CASE	WHEN INST.inmdse = 'N' THEN 0     
													ELSE SERIE.SePeriodicidad
												END

		,		'Fecha_Ultimo_Cupon'		= CONVERT(CHAR(08), dbo.Fx_P40_Fecha( MDRS.rscodigo, MDRS.rsinstser, MDRS.rsfecha, MDRS.rsnominal, MDRS.rsfecemis), 112)

		,		'Fecha_Proximo_Cupon'		= CONVERT(CHAR(08), MDRS.rsfecpcup, 112)
		,		'Fecha_Vcto_Instr'			= CONVERT(CHAR(08), MDRS.rsfecvcto, 112)
		,		'Derivado_Incrust_Opc'		= CASE WHEN MDRS.rscodigo = 20 THEN '02' ELSE '01' END

		,		'Nominal_Inicial'			= CONVERT(NUMERIC(19,4), MDRS.rsnominal)
		,		'Nominal_Actual'			= case	when INST.inmdse = 'S' then dbo.Fx_P40_Nominal ( rscodigo, rsinstser, rsfecucup, rsnominal, rsfecemis )
													else convert(numeric(19,4), MDRS.rsnominal )
												end

		,		'Moneda_Emision'			= case	when INST.inmdse = 'N' then NOSERIE.nsmonemi
													else case when MDRS.rscodigo = 20 then 998 else INST.inmonemi end
												end

		,		'Moneda_Reajuste'			= CASE	WHEN MDRS.rscodigo	= 20  THEN 998 ELSE INST.inmonemi END

		,		'Tipo_Tasa_Emision'			= case	when INST.inmdse = 'N' then '1' + NOSERIE.SeIndN
																			  + '9' + NOSERIE.NsIndC + '000'
													else case	when Datediff(Day, SERIE.sefecemi, SERIE.sefecven) > 365 then	'12'
																else															'11'	
															end + SERIE.SeIndPc + '000'
												end

		,		'Tasa_Emision'				= CASE	WHEN MDRS.rscodigo = 888									THEN 4.0	--> BR
													WHEN MDRS.rscodigo = 37										THEN 0.0	--> XERO
													WHEN MDRS.rscodigo = 300									THEN 0.0	--> CERO
													WHEN MDRS.rscodigo = 301									THEN 0.0	--> ZERO
													WHEN MDRS.rscodigo IN(3,9,11,12,13,14, 18,19, 50,51,52, 54) THEN 0.0	--> DP%
													WHEN INST.inmdse = 'S' and SERIE.setasemi	=	0			THEN MDRS.rstir	
													WHEN INST.inmdse = 'S' and SERIE.setasemi	<>	0			THEN SERIE.setasemi

													WHEN INST.inmdse = 'N' and NOSERIE.nstasemi	=	0			THEN MDRS.rstir
													WHEN INST.inmdse = 'N' and NOSERIE.nstasemi	<>	0			THEN NOSERIE.nstasemi
													ELSE MDRS.rstasemi
												END

		,		'Tera'						= case	when INST.inmdse = 'S' and SERIE.setera		=	0	then MDRS.rstir
													when INST.inmdse = 'S' and SERIE.setera		<>	0	then SERIE.setera
													
													when INST.inmdse = 'N' and NOSERIE.nstasemi	=	0	then MDRS.rstir
													when INST.inmdse = 'N' and NOSERIE.nstasemi	<>	0	then NOSERIE.nstasemi
												END


		,		'Valor_Par'					= CASE	WHEN MDRS.valor_tasa_emision = 0 THEN MDRS.rsvppresen 
													ELSE MDRS.valor_tasa_emision 
												END
											/ isnull(VMONEDA.vmvalor, 1.0)

		,		'Tipo_Tasa_Compra'			= case	when INST.inmdse = 'N' then '1' + NOSERIE.SeIndN + '9' + NOSERIE.NsIndC + '000'
													else case	when Datediff(Day, SERIE.sefecemi, SERIE.sefecven) > 365 then '12'
																else '11'	end + SERIE.SeIndPc + '000'
												end

		,		'Tasa_Compra'				= MDRS.rstir
		,		'Costo_Adquisicion'			= MDRS.rsvalcomp
		,		'Costo_Amortizado'			= CASE	WHEN MDRS.codigo_carterasuper = 'A' THEN MDRS.rsvalcomp ELSE 0 END
		,		'Valor_Razonable'			= ISNULL(VMERC.valor_mercado, 0.0)

		,		'Tipo_Tasa_Valoriza'		= case	when INST.inmdse = 'N' then '1' + NOSERIE.SeIndN + '9' + NOSERIE.NsIndC + '000'
													else case	when Datediff(Day, SERIE.sefecemi, SERIE.sefecven) > 365 then '12'
																else '11'	
															end + SERIE.SeIndPc + '000'
												end

		,		'Tasa_Valorizacion'			= ISNULL( VMERC.tasa_mercado, 0.0)
		,		'Tipo_valorizacion'			= CASE	WHEN VMERC.OrigenCurva = 'MC' THEN 3 ELSE 2 END

		,		'Precio_Instrumento'		= CASE	WHEN MDRS.rscodigo	= 888	THEN	ROUND(MDRS.rsvpcomp, 2)  
													WHEN MDRS.valor_par = 0		THEN	ROUND(MDRS.rstir, 2)
													ELSE							ROUND(MDRS.valor_par, 2)
												END
		,		'Duracion_Modificada'		= CASE	WHEN CONVERT(NUMERIC(24,2),ISNULL(VMERC.Duration_Mod, 0)) = 0 THEN 0.01
													ELSE CONVERT(NUMERIC(24,2),ISNULL(VMERC.Duration_Mod, 0)) 
												END

		,		'Convexidad'				= convert(numeric(24,8), CASE	WHEN isnull(VMERC.Convexidad, 0.0) = 0.0 THEN 0.01
																			ELSE isnull(VMERC.Convexidad, 0.0)
																		END )

		,		'Valor_Deterioro'			= CONVERT(NUMERIC(14),0)
		,		'Condicion_Instrumento'		= CASE	WHEN MDRS.rscartera = '111' THEN 1 
													WHEN MDRS.rscartera = '114' THEN 2 
													WHEN MDRS.rscartera = '159' THEN 3  --20200430.RCHS. AJUSTES P40 CASE	WHEN MDRS.rscartera = '111' THEN 1 ELSE 2 END
													else 0 END  

		,		'Fecha_Inicio_Cond'			= case	when MDVI.viEstado	= 1	then convert(char(08), MDVI.vifecinip, 112)
													when GTIA.viEstado	= 2 then convert(char(08), GTIA.vifecinip, 112)
													else case	when MDRS.rscartera = '114' then convert(char(08), MDRS.rsfecinip, 112)
																else '00000000'
															end
												end
		,		'Fecha_Final_Cond'			= case	when MDVI.viEstado	= 1	then convert(char(08), MDVI.vifecvenp, 112)
													when GTIA.viEstado	= 2 then convert(char(08), GTIA.vifecvenp, 112) 	
													else case	when MDRS.rscartera = '114' then convert(char(08), MDRS.rsfecvtop, 112)
																else '00000000'
															end
												end

		,		'Filler'					= ' '
		,		'Numero_Documento'			= MDRS.rsnumdocu    
		,		'Correlativo'				= MDRS.rscorrela    
		,		'Numero_Operacion'			= CASE WHEN MDRS.rscartera ='111' THEN MDRS.rsnumdocu ELSE MDRS.rsnumoper END
		-->>>> Agregado para su uso mas adelante <<<<--    
		,		'Seriado'					= INST.inmdse
		,		'Codigo'					= INST.incodigo
		,		'Serie'						= MDRS.rsinstser
		,		'FecCupVen'					= MDRS.rsfecucup
		,		'FechaEmision'				= MDRS.rsfecemis
		,		'NomOriginal'				= MDRS.rsnominal
		,		'Rutcart'					= MDRS.rsrutcart
		-->>>> Agregado para su uso mas adelante <<<<--    
		,		'xPeriodicidad'				= case when INST.inmdse = 'S' then SERIE.SePeriodo else NOSERIE.NsPeriodo end
		,		'iCantidad'					= ROW_NUMBER() over( order by MDRS.rsnumoper, MDRS.rsnumdocu, MDRS.rscorrela)
	   FROM		(	select	rsfecha,	rstipoper, rscartera, rsnominal, rstir,		rsvppresen
						,	rsnumoper,	rsnumdocu, rscorrela, rsfecucup, rsfecpcup, rstasemi
						,	rsfecinip,	rsfecvtop, rsfecemis, rscodigo,  rsrutemis, rsrutcart
						,	rsvalcomp,	rsinstser, rsrutcli,  rscodcli,  rsfeccomp, rsfecvcto
						,	codigo_carterasuper, valor_tasa_emision, valor_par, rsvpcomp
					from	BacTraderSuda.dbo.Mdrs	with(nolock)
					where	rsfecha					= @dFechacartera
													/*	case	when @dFechaProxima > @dFechaCierreMes then @dFechaCierreMes
																else @Fecha_Interfaz
													  		end
													*/
					and		MDRS.rsfecvcto		   >= MDRS.rsfecha
					and		MDRS.rstipoper			= 'DEV'
					and		MDRS.rscartera			IN(111, 114, 159)--20200430.RCHS.AJUSTES P40 (INCLUSIÓN GTIAS.) IN(111, 114)
					and		MDRS.rsnominal			> 0
					and		MDRS.rscodigo		   <> 98
					AND not(MDRS.rscodigo			= 20 
						AND MDRS.rsrutemis			= (select acrutprop from BacTraderSuda.dbo.Mdac with(nolock) )
							)
				)	MDRS

				--20200514.RCHS.AJUSTES P40 (MAY 4 DV) left Join ( select	emrut, emdv, emtipo, emrutdv = ltrim(rtrim( emrut )) + ltrim(rtrim( emdv ))
				left Join ( select	emrut, UPPER(emdv) emdv, emtipo, emrutdv = ltrim(rtrim( emrut )) + ltrim(rtrim( emdv ))
								
							from	BacParamSuda.dbo.Emisor with(nolock) 
							) Emisor			On	Emisor.emrut = MDRS.rsrutemis

				left Join ( Select	incodigo, inmdse, inmonemi
								/*,	BaseP40	= case	when BaseP40 = 1 then '9' --> 'ACT/ACT' ???
													when BaseP40 = 2 then '1' --> 'ACT/360'
													when BaseP40 = 3 then '2' --> 'ACT/366'
													when BaseP40 = 4 then '3' --> '30/360'
													when BaseP40 = 4 then '9' --> '30/365'  ????
													else				  '9'	
												end*/
							from	BacParamSuda.dbo.Instrumento with(nolock)
							)		INST		On	INST.incodigo = rscodigo

				Left Join (	Select	secodigo, seserie, secupones, senumamort, sepervcup, sefecemi, sefecven, setera, setasemi
								,	SeIndPc			= case	when sepervcup	= 1		then '1'
															when sepervcup	= 3		then '2'
															when sepervcup	= 4		then '3'
															when sepervcup	= 6		then '4'
															when sepervcup	= 12	then '5' else '9' end
														--> Base del Instrumento (Nueva Definicion Carlos)	
													+ case	when sebasemi	= 360	then '1'
															when sebasemi	= 365	then '2'
															when sebasemi	= 30	then '3' else '9' end
--													+ case	when sebasemi	= 360	then '4' else '9' end

								,	SePeriodicidad	= case	when sepervcup	= 1		then 1
															when sepervcup	= 3		then 2
															when sepervcup	= 4		then 3
															when sepervcup	= 6		then 4
															when sepervcup	= 12	then 5 else 6 end

								,	SePeriodo		= case	when sepervcup	= 1		then '1'
															when sepervcup	= 3		then '2'
															when sepervcup	= 4		then '3'
															when sepervcup	= 6		then '4'
															when sepervcup	= 12	then '5' else '9' end
							from	BacParamSuda.dbo.Serie with(nolock)
							)		SERIE		On	SERIE.secodigo	= MDRS.rscodigo
												AND SERIE.seserie	= CASE WHEN MDRS.rscodigo = 20 THEN SUBSTRING(MDRS.rsinstser,1,6) ELSE MDRS.rsinstser END

				Left Join ( Select	nsnumdocu, nscorrela, nsrutcart, nstasemi, nsmonemi
								,	NsIndC		=/*	case	when nsbasemi	= 360	then '1'
															when nsbasemi	= 365	then '2'
															when nsbasemi	= 30	then '3' else '9' end*/

													case	when nsbasemi	= 360	then '4' else '9' end

								,	SeIndN		=	case	when DateDiff( Day, nsfecemi, nsfecven ) > 365 then '2'
															else '1' end
								,	NsPeriodo	=	'9'
							from	BacparamSuda.dbo.NoSerie with(nolock)
							)		NOSERIE		On	NOSERIE.nsnumdocu	= MDRS.rsnumdocu
												AND NOSERIE.nscorrela	= MDRS.rscorrela
												AND	NOSERIE.nsrutcart	= MDRS.rsrutcart

				Left Join (	Select  clrut, clcodigo
							from	BacParamSuda.dbo.Cliente with(nolock)
							)		CLIEN		On	CLIEN.clrut		= MDRS.rsrutcli
												AND	CLIEN.clcodigo	= MDRS.rscodcli

				inner Join (Select	fecha_valorizacion, rmnumoper, tipo_operacion, id_sistema, rmnumdocu, rmcorrela
								,	valor_mercado, tasa_mercado, OrigenCurva, Duration_Mod
								,	Convexidad
							From	BacTraderSuda.dbo.Valorizacion_Mercado with(nolock)
							)		VMERC		On	VMERC.fecha_valorizacion = @dFechaMercado
																			/*	CASE	WHEN MONTH( @dFechaProxima ) > MONTH( @Fecha_Interfaz ) THEN @dFechaCierreMes
																						ELSE														 @Fecha_Interfaz
																				END	*/
												AND VMERC.id_sistema			= 'BTR'    
												AND VMERC.rmnumdocu			= MDRS.rsnumdocu 
												AND VMERC.rmcorrela			= MDRS.rscorrela 
												AND VMERC.rmnumoper			= MDRS.rsnumoper
												AND VMERC.tipo_operacion	= CASE WHEN MDRS.rscartera = '111' THEN 'CP' WHEN MDRS.rscartera = '114' THEN 'VI' ELSE 'CG' END    --20200514.RCHS.AJUSTES P40 (INCLUSIÓN OPERACIONES CG) AND VMERC.tipo_operacion	= CASE WHEN MDRS.rscartera = '111' THEN 'CP' ELSE  THEN 'VI' END    

				left Join ( Select	nscodigo, nsnumdocu, nscorrela, nsrutemi
								,	nsnemo	= case	when nscodigo = 9	and nsmonemi  = 999 then 'PAGARE NR'
													when nscodigo = 9	and nsmonemi <> 999 then 'PAGARE R'
													when nscodigo = 11	and nsmonemi  = 999 then 'PAGARE NR'
													when nscodigo = 11	and nsmonemi <> 999 then 'PAGARE R'
													else nsserie
												end
							from	BacParamSuda.dbo.NOSERIE with(nolock)
									LEFT JOIN BacParamSuda.dbo.SINACOFI with(nolock) On clrut = nsrutemi
							)		NEMOTECNICO	On	NEMOTECNICO.nsnumdocu	= MDRS.rsnumdocu
												AND	NEMOTECNICO.nscorrela	= MDRS.rscorrela

				Left Join (	Select	vinumoper, vifecinip, vifecvenp, vinumdocu, vicorrela, viEstado = 1
							from	BacTraderSuda.dbo.MDVI with(nolock)
							
							
							)		MDVI		On	MDVI.vinumoper	= CASE WHEN MDRS.rscartera = '111' THEN MDRS.rsnumdocu ELSE MDRS.rsnumoper END
												AND MDVI.vinumdocu	= MDRS.rsnumdocu
												AND MDVI.vicorrela	= MDRS.rscorrela
				--GARANTIAS												
				left join (	
							select 	D.NUMEROOPERACIONINSTRUMENTO vinumoper,C.FECHAINGRESOGARANTIA vifecinip,
									C.FECHAVENCIMIENTOGARANTIA vifecvenp,D.NUMEROOPERACIONINSTRUMENTO vinumdocu,
									D.CORRELATIVOINSTRUMENTO vicorrela, viEstado = 2
							from BDBOMESA.garantia.TBL_DetalleCarteraGarantia D with(nolock),
								 BDBOMESA.garantia.TBL_CarteraGarantia C with(nolock)	
						    where  C.numerogarantia=D.numerogarantia AND instrumento !='EFECTIVO'
						    group by 
								D.NUMEROOPERACIONINSTRUMENTO ,C.FECHAINGRESOGARANTIA ,
																C.FECHAVENCIMIENTOGARANTIA ,D.NUMEROOPERACIONINSTRUMENTO ,
																D.CORRELATIVOINSTRUMENTO 	
						   ) GTIA		On	GTIA.vinumoper	= CASE WHEN MDRS.rscartera = '159' THEN MDRS.rsnumdocu ELSE MDRS.rsnumoper END
												AND GTIA.vinumdocu	= MDRS.rsnumdocu
												AND GTIA.vicorrela	= MDRS.rscorrela
												and GTIA.vifecvenp	>= MDRS.rsfecha
				--FIN						
				left Join (	Select	vmcodigo, vmvalor
							from	BacTraderSuda.dbo.MDAC with(nolock)
									inner join BacParamSuda.dbo.VALOR_MONEDA with(nolock) On vmfecha = acfecproc
								union
							Select	999, 1.0 
								union
							select  13,  vmvalor
							from	BacTraderSuda.dbo.MDAC with(nolock)
									inner join BacParamSuda.dbo.VALOR_MONEDA with(nolock) On vmfecha = acfecproc
							where	vmcodigo = 994
							)		VMONEDA		On	VMONEDA.vmcodigo =	case	when INST.inmdse = 'N' then NOSERIE.nsmonemi
																				else case when MDRS.rscodigo = 20 then 998 else INST.inmonemi end
																			end
		)	TmpP40
	)	Ret
	order 
	by		Ret.Nemotecnico
		,	Ret.numero_Documento
		,	Ret.Correlativo
		,	Ret.Numero_Operacion

END

GO
