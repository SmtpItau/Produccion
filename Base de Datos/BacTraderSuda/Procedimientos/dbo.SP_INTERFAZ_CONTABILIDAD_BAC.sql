USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_CONTABILIDAD_BAC]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[SP_INTERFAZ_CONTABILIDAD_BAC] '2021-11-17'
CREATE PROCEDURE [dbo].[SP_INTERFAZ_CONTABILIDAD_BAC]
(
	@FECHA DATE = NULL
)
AS
BEGIN
SET NOCOUNT ON   
	declare @fecha_proc	datetime

	if @FECHA is null 
	begin
		select @fecha_proc=acfecproc from mdac
    end
	else
	begin
		set @fecha_proc=@FECHA
	end


--RENTA FIJA
	SELECT	Fecha_Ingreso
	,		Operacion
	,		det.Correlativo
	,		fpago
	,		plazo
	,		Monto													as Monto_loc
	,		case when moneda in (999,998)	then 0	else Monto end	as Monto_Div
	,		det.cuenta
	,		'BTR'					as id_sistema
	,		tipo_movimiento			=	CONVERT(VARCHAR(5),(select tipo_movimiento from bacparamsuda..MOVIMIENTO_CNT m where m.id_sistema='BTR' and m.tipo_operacion=vou.tipo_operacion))
	,		vou.Tipo_Operacion		as tipo_operacion
	,		codigo_producto			as codigo_instrumento
	,		moneda					as moneda_instrumento
	,		mnnemo					as moneda_des
	,		convert(numeric(9),0)	as folio_perfil		
	,		Tipo_Monto				as Tipo_Monto 
	,		space(6)				as tipo_voucher
	,		vou.Glosa				as glosa_perfil
	INTO #PASO
	FROM   BacTraderSuda..BAC_CNT_VOUCHER  vou WITH (NoLock)  
    INNER JOIN BacTraderSuda..BAC_CNT_DETALLE_VOUCHER det ON vou.numero_voucher = det.numero_voucher  
    INNER JOIN BacParamSuda..MONEDA mon ON mon.mncodmon = moneda  
	WHERE  vou.fecha_ingreso    = @fecha_proc--'20200519'--
	ORDER BY det.numero_voucher , det.correlativo  


--INVERSION EXTERIOR
	INSERT #PASO 
	select	Fecha_Ingreso
	,		v.Operacion
	,		v.Correlativo
	,		0
	,		0
	,		case when MonedaCuenta not in (999) then round(Monto*isnull(m2.vmvalor,0),0) else Monto end as Monto_loc
	,		case when MonedaCuenta in (999,998)	then 0	else Monto end	as Monto_Div
	,		cuenta
	,		'BEX'					as id_sistema
	,		tipo_movimiento =	(	select top 1 tipo_movimiento from bacparamsuda..MOVIMIENTO_CNT m where m.id_sistema='BEX' and m.tipo_operacion=v.tipo_operacion )
	,		v.Tipo_Operacion		as tipo_operacion
	,		''						as codigo_instrumento
	,		MonedaOperacion			as moneda_instrumento
	,		mnnemo					as moneda_des
	,		0						as folio_perfil		
	,		Tipo_Monto				as Tipo_Monto 
	,		space(6)				as tipo_voucher
	,		v.Glosa				as glosa_perfil
	FROM   BacBonosExtSuda..BAC_CNT_VOUCHER                   v WITH (NoLock)
    inner join BacBonosExtSuda..BAC_CNT_DETALLE_VOUCHER d ON v.numero_voucher = d.numero_voucher
	LEFT JOIN BacParamSuda..MONEDA                     m ON m.mncodmon       = convert(integer,d.MonedaCuenta)
	LEFT  JOIN BacParamSuda..VALOR_MONEDA m2 with(nolock) ON m2.vmcodigo = case when convert(integer,MonedaCuenta) = 13 then 994 else convert(integer,MonedaCuenta) end  and vmfecha=v.fecha_ingreso
	WHERE  v.fecha_ingreso    = @fecha_proc--'20210914'--
    ORDER BY d.numero_voucher , d.correlativo


--SWAP
	INSERT #PASO 
	select	Fecha_Ingreso
	,		v.Operacion
	,		1
	,		0
	,		0
	,		case when Moneda=998 then round(monto*m2.vmvalor,0) else monto end	as Monto_loc
	,		case when Moneda in (999,998)	then 0	else Monto end				as Monto_Div
	,		cuenta
	,		'PCS'					as id_sistema
	,		tipo_movimiento =	(	select top 1 tipo_movimiento from bacparamsuda..MOVIMIENTO_CNT m where m.id_sistema='PCS' and m.tipo_operacion=v.tipo_operacion )
	,		v.Tipo_Operacion		as tipo_operacion
	,		''						as codigo_instrumento
	,		Moneda					as moneda_instrumento
	,		mnnemo					as moneda_des
	,		Folio_Perfil			as folio_perfil		
	,		Tipo_Monto				as Tipo_Monto 
	,		space(6)				as tipo_voucher
	,		v.Glosa					as glosa_perfil
	FROM   BacSwapSuda..BAC_CNT_VOUCHER                    v with(nolock)  
	INNER JOIN BacSwapSuda..BAC_CNT_DETALLE_VOUCHER d with(nolock) ON v.numero_voucher = d.numero_voucher  
	LEFT  JOIN BacParamSuda..MONEDA                 m with(nolock) ON m.mncodmon       = convert(integer,d.moneda)  
	LEFT  JOIN BacParamSuda..VALOR_MONEDA m2 with(nolock) ON m2.vmcodigo = convert(integer,d.moneda)  and vmfecha=v.fecha_ingreso
	WHERE  v.fecha_ingreso    = @fecha_proc--'20190930'--
	ORDER BY d.numero_voucher , d.correlativo  


--PASIVO
	INSERT #PASO 
	select	v.Fecha_Ingreso
	,		v.numero_operacion
	,		v.correlativo
	,		0
	,		0
	,		Monto															as Monto_loc
	,		case when v.codigo_moneda1 in (999,998)	then 0	else Monto end	as Monto_Div
	,		cuenta
	,		id_sistema				as id_sistema
	,		codigo_evento
	,		v.codigo_producto		as tipo_operacion
	,		''						as codigo_instrumento
	,		v.codigo_moneda1		as moneda_instrumento
	,		mnnemo					as moneda_des
	,		0						as folio_perfil		
	,		Tipo_Monto				as Tipo_Monto 
	,		space(6)				as tipo_voucher
	,		v.Glosa					as glosa_perfil
	FROM MDPasivo..BAC_CNT_VOUCHER   v  
	INNER JOIN MDPasivo..BAC_CNT_VOUCHER_DETALLE d  ON d.numero_voucher=v.numero_voucher
    inner  JOIN BacParamSuda.dbo.MONEDA  m ON m.mncodmon       = v.codigo_moneda1
	where v.fecha_ingreso=@fecha_proc--'20191002'--


--SELECT * from #PASO p
--WHERE p.Folio_Perfil=0

update p
	set p.glosa_perfil = replace(replace(p.glosa_perfil,'ñ','n'),'ú','u')
from #PASO p

update p
	set p.folio_perfil = c.folio_perfil
from #PASO p
inner join bacparamsuda..PERFIL_CNT c on c.id_sistema=p.id_sistema and c.tipo_movimiento=p.tipo_movimiento and c.tipo_operacion=p.tipo_operacion and c.glosa_perfil=p.glosa_perfil
WHERE p.Folio_Perfil=0

/*
--revisar monedas Swap
update p
	set p.monto = round(p.monto * isnull(c.vmvalor,0),0)
from #PASO p
inner join bacparamsuda..VALOR_MONEDA c on c.vmfecha  = @fecha_proc and C.vmcodigo=p.moneda_instrumento
WHERE p.moneda_instrumento=998
*/

--SACAR CUENTAS DE RESPONSABILIDAD
--select *
--from #Paso p
--inner join BacParamSuda..PLAN_DE_CUENTA c on c.cuenta=p.cuenta and c.cuenta in ('990001018','990001041','990001089','990001111','990001158','990001243','990002041','990004054','990004062')

DELETE p
from #Paso p
inner join BacParamSuda..PLAN_DE_CUENTA c on c.cuenta=p.cuenta and c.cuenta in ('990001018','990001041','990001089','990001111','990001158','990001243','990002041','990004054','990004062')



	select 
		'0039'	
	+	'888'--'BAC'	
	+	convert(varchar(8),@fecha_proc,112)	
	+	convert(varchar(8),@fecha_proc,112)	
	+	space(6)
	+	'2230'
	+	'2230'
	+	'2230'
	--41
	+	case when Tipo_Monto='D' then '0000001' else '0000000' end
	+	case when Tipo_Monto='H' then '0000001' else '0000000' end
	--55
	+	case when Tipo_Monto='D' then right(replicate('0',15)+replace(convert(varchar(16),convert(numeric(15,2),monto_loc)),'.',''),15) else replicate('0',15) end
	+	case when Tipo_Monto='H' then right(replicate('0',15)+replace(convert(varchar(16),convert(numeric(15,2),monto_loc)),'.',''),15) else replicate('0',15) end
	+	case when Tipo_Monto='D' then right(replicate('0',15)+replace(convert(varchar(16),convert(numeric(15,2),monto_div)),'.',''),15) else replicate('0',15) end
	+	case when Tipo_Monto='H' then right(replicate('0',15)+replace(convert(varchar(16),convert(numeric(15,2),monto_div)),'.',''),15) else replicate('0',15) end
	--115
	+	space(1)				--INDICADOR DE CORRECCION  
	+	space(12)				--NUMERO DE CONTROL        
	+	replicate('0',3)		--CLAVE DE CONCEPTO        
	+	space(14)				--DESCRIPCION DE CONCEPTO  
	+	space(1)				--TIPODE CONCEPTO          
	--146
	+	left(substring(glosa_perfil,1,30)+space(30),30)			--OBSERVACIONES            
	--176
	+	'DEAL:'
	--181
	+   right(replicate('0',8)+convert(varchar(8),operacion),8)
	--189
	+   space(5)				--    CODIGO CUENTA CLIENTE
	--194
	+	'888'--'BAC'					--        APLICACION ORIGEN 
	--197
	+	space(3)				--        APLICACION DESTINO
	--200
	+	'COLIVI'				--        OBSERVACIONES3    
	+	case when moneda_des='UF' then 'CLP ' else left(moneda_des,4) end		--RESERVADO (Codigo y Tipo de Moneda)
	+	space(4)				--TRANSACC/PRG ORIGEN
	+	space(1)				--INDICADOR CAJA COMPENSAC
	+	'0'						--INDICADOR CUENTA ORDEN
	+	replicate('0',13)		--SATINTER
	+	space(17)				--SACCLVOP,SACCEGES,SACAPLCP,SACCDTGT,SAYUTILI,SACOPASC,SAFILLER

--datos fijos
--	+	left((rtrim(cuenta) + '0')+replicate(' ',13),13)
    +   left((rtrim(cuenta) + case when moneda_des in ('CLP','UF') then '0' else '2' end )+replicate(' ',13),13)
--	+	left(convert(varchar(10),cuenta)+space(10),10)
	+	space(2)--left(convert(varchar(4),id_sistema)+space(4),4)	
	+	space(4)--left(convert(varchar(4),isnull(tipo_movimiento,''))+space(4),4)	
	+	space(4)--left(convert(varchar(4),tipo_operacion)+space(4),4)	
	+	space(4)--left(convert(varchar(4),codigo_instrumento)+space(4),4)		
	+	space(3)--left(convert(varchar(3),moneda_instrumento)+space(3),3)
	+	space(1)--convert(varchar(1),Tipo_Monto)
	+	space(5)--left(convert(varchar(5),folio_perfil)+space(5),5)
	+	space(1)				--
--37
/*
	+	space(2)				--PRODUCTO          
	+	space(4)				--SUBPRODUCTO       
	+	space(3)				--GARANTIA          
	+	space(1)				--TIPO DE PLAZO     
	+	space(3)				--PLAZO             
	+	space(1)				--SUBSECTOR         
	+	space(2)				--SECTOR B.E.       
	+	space(5)				--DESTINO DE LOS FONDOS
	+	space(4)				--EMPRESA TUTELADA  
	+	space(2)				--AMBITO            
	+	space(1)				--MOROSIDAD / TIPO DE GARANTIA    
	+	space(1)				--INVERSION         
	+	space(3)				--OPERACION         
	+	space(5)				--CODIGO CONTABLE
*/
--37
	+	space(3)				--DIVISA            
	+	space(1)				--TIPO DE DIVISA    
	+	space(1)				--INDIC.PF TRANSFER.
	+	space(1)				--ESTADO DE LA CTA
	+	space(1)				--INDICADOR DE IVA
	+	space(1)				--INDICADOR COB/DEV
	+	space(8)				--EVENTO IMP A SELLOS
	+	space(1)				--TIPO SISTEMA
	+	space(3)				--CODIGO DE MERCADO ALTAMIRA
	+	space(15)				--ENTORNO
	+	space(1)				--código de Provincia
	+	space(28)				--FILLER          

--redefinir datos fijos
--	+	space(15)				--CONCEPTO
--	+	space(66)				--DISCRIMINADOR 1,DISCRIMINADOR 2,DISCRIMINADOR 3,DISCRIMINADOR 4,DISCRIMINADOR 5,DISCRIMINADOR 6
--	+	space(15)				--DATO ENTORNO
--	+	space(5)				--FILLER          

	+	space(12)				--VARIOS              
	+	space(3)				--CODIGO MERCADO
	+	space(30)				--REFERENCIA
--	+	'1'--OJO
	+	space(8)				--FECHA ANTIGÜEDAD
	+	space(50)				--FILLER
	FROM #PASO
--	FROM   BacTraderSuda..BAC_CNT_VOUCHER  v WITH (NoLock)  
--  INNER JOIN BacTraderSuda..BAC_CNT_DETALLE_VOUCHER d ON v.numero_voucher = d.numero_voucher  
--  LEFT  JOIN BacParamSuda..PLAN_DE_CUENTA     c ON c.cuenta         = d.cuenta  
--  LEFT  JOIN BacParamSuda..MONEDA                   m ON m.mncodmon       = convert(integer,d.moneda)  
--	WHERE  v.fecha_ingreso    = '20200730'--@fecha_proc
--	ORDER BY d.numero_voucher , d.correlativo  



	drop table #paso

/*
--FORWARD
	INSERT #PASO 
	select	Fecha_Ingreso
	,		Operacion
	,		Correlativo
	,		0
	,		0
	,		monto
	,		cuenta
	,		'BFW'					as id_sistema
	,		tipo_movimiento =	(	select top 1 tipo_movimiento from bacparamsuda..MOVIMIENTO_CNT m where m.id_sistema='BFW' and m.tipo_operacion=vou.tipo_operacion )
	,		vou.Tipo_Operacion		as tipo_operacion
	,		''						as codigo_instrumento
	,		moneda					as moneda_instrumento
	,		mnnemo					as moneda_des
	,		Folio_Perfil			as folio_perfil		
	,		Tipo_Monto				as Tipo_Monto 
	,		space(6)				as tipo_voucher
	,		vou.Glosa				as glosa_perfil
	FROM   bacfwdsuda..VOUCHER_CNT  vou WITH (NoLock)  
    INNER JOIN bacfwdsuda..DETALLE_VOUCHER_CNT det ON vou.numero_voucher = det.numero_voucher  
    INNER JOIN BacParamSuda..MONEDA mon ON mon.mncodmon = moneda  
	WHERE  vou.fecha_ingreso    = @fecha_proc--'20210310'--
	ORDER BY det.numero_voucher , det.correlativo  


--SPOT
	INSERT #PASO 
	select	Fecha_Ingreso
	,		v.Operacion
	,		v.Correlativo
	,		0
	,		0
	,		monto
	,		cuenta
	,		'BCC'					as id_sistema
	,		Mercado AS tipo_movimiento --=	(	select top 1 tipo_movimiento from bacparamsuda..MOVIMIENTO_CNT m where m.id_sistema='BCC' and m.tipo_operacion=vou.tipo_operacion and LEFT(glosa_operacion,20) LIKE LEFT(glosa,20))
	,		v.Tipo_Operacion		as tipo_operacion
	,		''						as codigo_instrumento
	,		Moneda_Operacion		as moneda_instrumento
	,		mnnemo					as moneda_des
	,		0						as folio_perfil		
	,		Tipo_Monto				as Tipo_Monto 
	,		space(6)				as tipo_voucher
	,		v.Glosa				as glosa_perfil
	from BacCamsuda..bac_cnt_voucher v
	inner join BacCamsuda..bac_cnt_detalle_voucher d on d.Numero_Voucher=v.Numero_Voucher
    INNER JOIN BacParamSuda..MONEDA mon ON mon.mncodmon = Moneda_Operacion  
	where v.Fecha_Ingreso = @fecha_proc--'20200519'--


--OPCIONES
	INSERT #PASO 
	select	Fecha_Ingreso
	,		v.Operacion
	,		1
	,		0
	,		0
	,		monto
	,		cuenta
	,		'OPT'					as id_sistema
	,		tipo_movimiento =	(	select top 1 tipo_movimiento from bacparamsuda..MOVIMIENTO_CNT m where m.id_sistema='OPT' and m.tipo_operacion=v.tipo_operacion )
	,		v.Tipo_Operacion		as tipo_operacion
	,		''						as codigo_instrumento
	,		Moneda					as moneda_instrumento
	,		mnnemo					as moneda_des
	,		Folio_Perfil			as folio_perfil		
	,		Tipo_Monto				as Tipo_Monto 
	,		space(6)				as tipo_voucher
	,		v.Glosa					as glosa_perfil
	FROM   CbMdbOpc..OpcVoucher                   v WITH (NoLock)
	INNER JOIN CbMdbOpc..OpcDetalleVOUCHER d ON v.numero_voucher = d.numero_voucher
    LEFT  JOIN BacParamSuda.dbo.MONEDA                 m ON m.mncodmon       = convert(integer,d.moneda)
	WHERE  v.fecha_ingreso    = @fecha_proc--'20190930'--

*/


END
GO
