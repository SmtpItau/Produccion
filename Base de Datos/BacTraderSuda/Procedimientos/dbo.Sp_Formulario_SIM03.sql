USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Formulario_SIM03]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Sp_Formulario_SIM03 '20200730'
CREATE procedure [dbo].[Sp_Formulario_SIM03]
	(	@dFechaInforme	datetime	)
as  
BEGIN
 
SET NOCOUNT ON   

--DECLARE @dFechaInforme	datetime	
--SET @dFechaInforme='20211123'

declare @tipo_sal	varchar(1)-- 0:select ; 1:coma csv ; 2:blanco texto plano 
declare @separador	varchar(1)

set @tipo_sal=1



if @tipo_sal=1 set @separador=','
if @tipo_sal=2 set @separador=''
	


CREATE TABLE #TAB_CONTABLES(
	[codigo] [numeric](12, 0) NOT NULL,
	[descrip_cartera] [varchar](200) NULL)

INSERT INTO #TAB_CONTABLES
SELECT '112000101','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Instrumentos financieros de deuda del Banco Central de Chile.				  ' UNION
SELECT '112000102','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Bonos y pagarés de la Tesorería General de la República.                      ' UNION
SELECT '112000109','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Otros instrumentos financieros de deuda fiscales.                             ' UNION
SELECT '112000201','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Instrumentos financieros de deuda de otros bancos del ' UNION
SELECT '112000202','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Bonos y efectos de comercio de empresas del país.     ' UNION
SELECT '112000209','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Otros instrumentos financieros de deuda emitidos en e ' UNION
SELECT '115250101','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Instrumentos financieros de deuda del Banco Central de Chile.                 ' UNION
SELECT '115250102','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Bonos y pagarés de la Tesorería General de la República.                      ' UNION
SELECT '115250109','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Otros instrumentos financieros de deuda fiscales.                             ' UNION
SELECT '115250201','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Instrumentos financieros de deuda de otros bancos del ' UNION
SELECT '115250202','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Bonos y efectos de comercio de empresas del país.     ' UNION
SELECT '115250209','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Otros instrumentos financieros de deuda emitidos en e ' UNION
SELECT '118250101','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Instrumentos financieros de deuda del Banco Central de Chile.                 ' UNION
SELECT '118250102','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Bonos y pagarés de la Tesorería General de la República.                      ' UNION
SELECT '118250109','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Otros instrumentos financieros de deuda fiscales.                             ' UNION
SELECT '118250201','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Instrumentos financieros de deuda de otros bancos del ' UNION
SELECT '118250202','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Bonos y efectos de comercio de empresas del país.     ' UNION
SELECT '118250209','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Otros instrumentos financieros de deuda emitidos en e ' UNION
SELECT '122000101','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Instrumentos financieros de deuda del Banco Central de Chile.                 ' UNION
SELECT '122000102','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Bonos y pagarés de la Tesorería General de la República.                      ' UNION
SELECT '122000109','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Otros instrumentos financieros de deuda fiscales.                             ' UNION
SELECT '122000201','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Instrumentos financieros de deuda de otros bancos del ' UNION
SELECT '122000202','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Bonos y efectos de comercio de empresas del país.     ' UNION
SELECT '122000209','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Otros instrumentos financieros de deuda emitidos en e ' UNION
SELECT '141000101','Derechos por pactos de retroventa y préstamos de valores. Operaciones con bancos del país. Contratos de retroventa con otros bancos.                  ' UNION
SELECT '141000102','Derechos por pactos de retroventa y préstamos de valores. Operaciones con bancos del país. Contratos de retroventa con Banco Central de Chile.        ' UNION
SELECT '141000103','Derechos por pactos de retroventa y préstamos de valores. Operaciones con bancos del país. Derechos por préstamos de valores.                         ' UNION
SELECT '141000201','Derechos por pactos de retroventa y préstamos de valores. Operaciones con bancos del exterior. Contratos de retroventa con otros bancos.              ' UNION
SELECT '141000202','Derechos por pactos de retroventa y préstamos de valores. Operaciones con bancos del exterior. Contratos de retroventa con Bancos Centrales del exter ' UNION
SELECT '141000203','Derechos por pactos de retroventa y préstamos de valores. Operaciones con bancos del exterior. Derechos por préstamos de valores.                     ' UNION
SELECT '141000301','Derechos por pactos de retroventa y préstamos de valores. Operaciones con otras entidades en el país. Contratos de retroventa.                        ' UNION
SELECT '141000302','Derechos por pactos de retroventa y préstamos de valores. Operaciones con otras entidades en el país. Derechos por préstamos de valores.              ' UNION
SELECT '141000401','Derechos por pactos de retroventa y préstamos de valores. Operaciones con otras entidades en el exterior. Contratos de retroventa.                    ' UNION
SELECT '141000402','Derechos por pactos de retroventa y préstamos de valores. Operaciones con otras entidades en el exterior. Derechos por préstamos de valores.          ' UNION
SELECT '141000901','Derechos por pactos de retroventa y préstamos de valores. Deterioro de valor acumulado de activos financieros a costo amortizado. Activos financieros ' UNION
SELECT '141000902','Derechos por pactos de retroventa y préstamos de valores. Deterioro de valor acumulado de activos financieros a costo amortizado. Activos financieros ' UNION
SELECT '141000903','Derechos por pactos de retroventa y préstamos de valores. Deterioro de valor acumulado de activos financieros a costo amortizado. Activos financieros ' UNION
SELECT '141500101','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Instrumentos financieros de deuda del Banco Central de Chile.                 ' UNION
SELECT '141500102','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Bonos y pagarés de la Tesorería General de la República.                      ' UNION
SELECT '141500109','Instrumentos financieros de deuda. Del Estado y Banco Central de Chile. Otros instrumentos financieros de deuda fiscales.                             ' UNION
SELECT '141500201','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Instrumentos financieros de deuda de otros bancos del ' UNION
SELECT '141500202','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Bonos y efectos de comercio de empresas del país.     ' UNION
SELECT '141500209','Instrumentos financieros de deuda. Otros instrumentos financieros de deuda emitidos en el país. Otros instrumentos financieros de deuda emitidos en e ' UNION
SELECT '243000101','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con bancos del país. Contratos de retrocompra con otros bancos.            ' UNION
SELECT '243000102','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con bancos del país. Contratos de retrocompra con Banco Central de Chile.  ' UNION
SELECT '243000103','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con bancos del país. Obligaciones por préstamos de valores.                ' UNION
SELECT '243000201','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con bancos del exterior. Contratos de retrocompra con otros bancos.        ' UNION
SELECT '243000202','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con bancos del exterior. Contratos de retrocompra con Bancos Centrales del ' UNION
SELECT '243000203','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con bancos del exterior. Obligaciones por préstamos de valores.            ' UNION
SELECT '243000301','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con otras entidades del país. Contratos de retrocompra.                    ' UNION
SELECT '243000302','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con otras entidades del país. Obligaciones por préstamos de valores.       ' UNION
SELECT '243000401','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con otras entidades en el exterior. Contratos de retrocompra.              ' UNION
SELECT '243000402','Obligaciones por pactos de retrocompra y préstamos de valores. Operaciones con otras entidades en el exterior. Obligaciones por préstamos de valores. ' 


CREATE TABLE #TAB_INSTRUMENTOS (
	[codigo]  [numeric](4, 0) NOT NULL,
	[cod_bac] [numeric](4, 0) NOT NULL,
	[instser] [varchar](10) NULL,
	[descrip_instrumentos] [varchar](80) NULL
)

INSERT INTO #TAB_INSTRUMENTOS
SELECT 1, 6, 	'PDBC', 'PDBC Pagarés descontables del Banco Central de Chile'					  	UNION
SELECT 2, 7, 	'PRBC', 'PRBC Pagarés reajustables del Banco Central de Chile'                   	UNION
SELECT 3, 4, 	'PRC', 	'PRC Pagarés reajustables del Banco Central de Chile con pago en cupones' 	UNION
SELECT 4, 300, 	'CERO', 'CERO Cupones de emisión reajustables opcionales en UF'                		UNION
SELECT 5, 33, 	'BCP', 	'BCP Bonos del Banco Central de Chile en pesos'                          	UNION
SELECT 6, 32, 	'BCU', 	'BCU Bonos del Banco Central de Chile en UF'                             	UNION
SELECT 7, 34, 	'BCD', 	'BCD Bonos del Banco Central de Chile expresados en US$'                 	UNION
SELECT 8, 39, 	'BCX', 	'BCX Bonos del Banco Central de Chile en US$'                            	UNION
SELECT 9, 40, 	'BTP', 	'BTP Bonos o pagarés de la Tesorería Gral. República en pesos'           	UNION
SELECT 10, 36, 	'BTU', 	'BTU Bonos o pagarés de la Tesorería Gral. República en UF'             	UNION
SELECT 11, 15,  'BB', 	'BB Bonos de bancos e instituciones financieras'                        	UNION
SELECT 12, 888, 'BH', 	'BH Bonos hipotecarios'                                                 	UNION
SELECT 13, 888,	'BE', 	'BE Bonos de empresas'                                                   	UNION
SELECT 14, 16, 	'EC', 	'EC Efectos de comercio'                                                 	UNION
SELECT 15, 20, 	'LH', 	'LH Letras hipotecarias'                                                 	UNION
SELECT 16, 9, 	'DP', 	'DP Depósitos a plazo'                                                    	UNION
SELECT 16, 11, 	'DPR', 	'DP Depósitos a plazo UF'                                               	UNION
SELECT 99, 0, 	'OIIF', 'OIIF Otros instrumentos e inversiones financieras'                     

------------------


		CREATE TABLE #SALIDA (
			codigo_ctb		numeric(9,0)
		,	codigo_inst		numeric(5,0)
		,	codigo_mon		numeric(5,0)
		,	monto			numeric(19,2)
		)

--SELECT * FROM BacParamSuda..Tab_Instrumentos
--SELECT * FROM BacParamSuda..MONEDA
declare @dFechaproc	datetime
declare @dFechaant	datetime
declare @dFechaprox	datetime

	select	@dFechaant=acfecante
	,		@dFechaproc=acfecproc
	,		@dFechaprox=acfecprox 
	from bactradersuda..mdac

--SET @dFechaant	='20211123'
--SET @dFechaproc	='20211124'

--OTROS INSTRUMENTOS
			insert into #SALIDA
			SELECT 
				contable =	'112000202'
			,	case when Cltipcli = 1 then tab.codigo else 13 end
			,	moneda=	case	when moneda_emision=999 then 01 
								when moneda_emision=998 then 02
								when moneda_emision in (500,502,997) then 03
								when moneda_emision in (994,13) then 04
						else 99 end
			,	cpmonto		= case when r.codigo_carterasuper = 'A' then valor_presente else valor_mercado end
			FROM bactradersuda.dbo.MDRS r
			inner join bactradersuda.dbo.VALORIZACION_MERCADO v on v.rmnumdocu = r.rsnumdocu and v.rmnumoper= r.rsnumoper and v.rmcorrela = r.rscorrela and v.id_sistema='BTR'
			inner join bactradersuda.dbo.VIEW_EMISOR e on e.emrut = v.rut_emisor 
			inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo= v.rmcodigo  
			inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon= v.moneda_emision  
			inner join BacParamSuda.dbo.Cliente with(nolock) On clrut = rut_emisor --and clcodigo=1
			inner join #Tab_Instrumentos tab on cod_bac=rmcodigo
			WHERE r.rsfecha=@dFechaant
			and r.rstipoper='DEV'
			AND v.fecha_valorizacion=r.rsfecha
			AND r.rscartera Not In (115) 
			and Cltipcli=7

--instrumentos Banco Central
			insert into #SALIDA
			SELECT 
				contable =	'122000101'
			,	case when Cltipcli = 1 then tab.codigo else 13 end
			,	moneda=	case	when moneda_emision=999 then 01 
								when moneda_emision=998 then 02
								when moneda_emision in (500,502,997) then 03
								when moneda_emision in (994,13) then 04
						else 99 end
			,	cpmonto		= valor_mercado 
			from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
			inner join BacParamSuda.dbo.Instrumento with(nolock) On Incodigo = rmcodigo
			inner join BacParamSuda.dbo.EMISOR with(nolock) On emrut = rut_emisor 
			inner join BacParamSuda.dbo.Cliente with(nolock) On clrut = rut_emisor and clcodigo=1
			inner join #Tab_Instrumentos tab on cod_bac=rmcodigo
			where	fecha_valorizacion	= @dFechaant
			AND		rmcodigo			IN(4,6,7,8,32,33,34,36,39,40,300)
			and		rminstser			not in( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9907)
			and Clrut=97029000--banco central


--instrumentos Tesoreria General Republica
			insert into #SALIDA
			SELECT 
				contable =	'122000102'
			,	tab.codigo
			,	moneda=	case	when moneda_emision=999 then 01 
								when moneda_emision=998 then 02
								when moneda_emision in (500,502,997) then 03
								when moneda_emision in (994,13) then 04
						else 99 end
			,	cpmonto		= valor_mercado 
			from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
			inner join BacParamSuda.dbo.Instrumento with(nolock) On Incodigo = rmcodigo
			inner join BacParamSuda.dbo.EMISOR with(nolock) On emrut = rut_emisor 
			inner join BacParamSuda.dbo.Cliente with(nolock) On clrut = rut_emisor and clcodigo=1
			inner join #Tab_Instrumentos tab on cod_bac=rmcodigo
			where	fecha_valorizacion	= @dFechaant
			AND		rmcodigo			IN(4,6,7,8,32,33,34,36,39,40,300)
			and		rminstser			not in( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9907)
			and Clrut=60805000--tesoreria



--instrumentos Bancos del Pais
			insert into #SALIDA
			SELECT 
				contable =	'122000201'
			,	tab.codigo
			,	moneda=	case	when moneda_emision=999 then 01 
								when moneda_emision=998 then 02
								when moneda_emision in (500,502,997) then 03
								when moneda_emision in (994,13) then 04
						else 99 end
			,	cpmonto		= valor_mercado 
			from	BacTraderSuda.dbo.valorizacion_mercado with(nolock)
			inner join BacParamSuda.dbo.Instrumento with(nolock) On Incodigo = rmcodigo
			inner join BacParamSuda.dbo.EMISOR with(nolock) On emrut = rut_emisor 
			inner join BacParamSuda.dbo.Cliente with(nolock) On clrut = rut_emisor and clcodigo=1
			inner join #Tab_Instrumentos tab on cod_bac=rmcodigo
			where	fecha_valorizacion	= @dFechaant
			and Clrut NOT IN (97029000,60805000)
			AND CLTIPCLI<>7


--COMPRAS CON PACTO
			insert into #SALIDA
			SELECT 
				contable =	'141000301'
			,	case when Cltipcli = 7 then 13 else tab.codigo end
			,	moneda=	case	when tab.codigo IN (1,5,9,11,12,13,14,15,16) then 01
								when tab.codigo IN (2,3,4,6,10)  then 02
								when tab.codigo IN (7,8) then 04
						else 99 end
			,	cimonto		= rsvppresen
			FROM bactradersuda.dbo.MDRS r
			inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo= r.rscodigo  
			inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon= r.rsmonpact
			inner join BacParamSuda.dbo.Cliente with(nolock) On clrut = r.rsrutemis --and clcodigo=1
			inner join #Tab_Instrumentos tab on cod_bac=rscodigo
			WHERE r.rsfecha=@dFechaproc
			and r.rstipoper='DEV'
			AND r.rscartera  In (112) --OR (r.rstipoper='dvp') 

--VENTAS CON PACTO
			insert into #SALIDA
			SELECT 
				contable = case when r.rsrutcli=97029000 then 243000102 else 243000301 end
			,	tab.codigo
			,	moneda=	case	when rsmonemi= 999 then 01 
								when rsmonemi= 998 then 02
								when rsmonemi in (500,502,997) then 03
								when rsmonemi in (994,13) then 04
						else 99 end

			,	cpmonto		=	(rsvalinip 
							+ 	ROUND( rsvalinip * (rstaspact/100.0) / 360.0 * DATEDIFF(DAY,rsfecinip, rsfecctb), 2) )*-1
			FROM bactradersuda.dbo.MDRS r
			inner join bactradersuda.dbo.VIEW_EMISOR e on e.emrut = r.rsrutemis
			inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo= r.rscodigo  
			inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon= r.rsmonemi
			inner join BacParamSuda.dbo.Cliente with(nolock) On clrut = r.rsrutemis --and clcodigo=1
			inner join #Tab_Instrumentos tab on cod_bac=rscodigo
			WHERE r.rsfecha=@dFechaproc
			and r.rstipoper='DEV'
			AND r.rscartera  In (115) --OR (r.rstipoper='dvp') 



--BONOS INVERSION AL EXTERIOR
			insert into #SALIDA
			SELECT 
				contable =	'122000109'
			,	99
			,	moneda=	case	when rsmonemi=999 then 01 
								when rsmonemi=998 then 02
								when rsmonemi in (500,502,997) then 03
								when rsmonemi in (994,13) then 04
						else 99 end
			,	cpmonto		= round((case when codigo_carterasuper = 'A' then rsvppresen else rsvalmerc end) ,0)
			from	BacBonosExtSuda.dbo.Text_Rsu with(nolock)
			left join BacParamSuda.dbo.Valor_Moneda_Contable tc with(nolock) On tc.Fecha = rsfecpro and codigo_moneda = 994
			left join BacParamSuda.dbo.Cliente cl with(nolock) On cl.clrut = rsrutemis --and cl.clpais=6
			where	rsfecpro	= @dFechaant
			and		rstipoper	= 'DEV'
			and		cod_nemo	not in( SELECT tbglosa FROM	BacParamSuda.dbo.Tabla_General_Detalle with(nolock) WHERE tbcateg = 9907)
			and     cl.clpais=6

			select 
					codigo_ctb,codigo_inst,codigo_mon,sum(monto) as monto
			into #paso
			from #SALIDA
			group by codigo_ctb,codigo_inst,codigo_mon


			insert into #paso
			select codigo,0,0,0 
			from #TAB_CONTABLES
			where codigo not in (select codigo_ctb from #paso)	



		if @tipo_sal = 0
		begin
			select	codigo_ctb
			,		codigo_inst
			,		codigo_mon
--			,		convert(numeric(19,2),round(monto/1000000,0))
			,		monto
			from #paso order by codigo_ctb,codigo_inst,codigo_mon 
		end
		else
		begin
			if @tipo_sal = 1 or @tipo_sal= 2
			begin
				select '0039'
				+		@separador			
				+		'SIM03'
				+		@separador			
				+		convert(varchar(8),@dFechaant,112)
				+		'             '
--				+		'..............'
				UNION
				select	
						right(replicate('0',9)+convert(varchar(9),codigo_ctb),9)
				+		@separador			
				+		right(replicate('0',2)+convert(varchar(2),codigo_inst),2)
				+		@separador			
				+		right(replicate('0',2)+convert(varchar(2),codigo_mon),2)
				+		@separador			
	--			,		convert(numeric(19,2),round(monto/1000000,0))
				+		case when monto >= 0 then '+' else '-' end
				+		right(replicate('0',15)+convert(varchar(15),convert(numeric(19),abs(monto))),15)
				from #paso --order by codigo_ctb,codigo_inst,codigo_mon 
			end
		end



drop table #TAB_INSTRUMENTOS 
drop table #SALIDA 
drop table #paso
drop table #TAB_CONTABLES

END
GO
