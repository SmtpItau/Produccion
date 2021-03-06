USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTA_CLIENTES]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_LISTA_CLIENTES '20210609'
CREATE PROCEDURE [dbo].[SP_LISTA_CLIENTES]  
(
	@FECHA DATE = NULL
)
AS
BEGIN   

declare @acfecante	datetime
declare @acfecproc	datetime

SET NOCOUNT ON   

select @acfecante=acfecante,@acfecproc=acfecproc from mdac

select 
--		convert(varchar(9),rsrutcli) + '-' +cldv	as RutCli
		Clrut										as Rut_Cliente
,		Cldv										as DV_Cliente
,		rscodcli									as Codigo_Cliente
,		clnombre									as Nombre_Contraparte
,		case when clvigente ='S' then 'SI' else 'NO' end as Habilitado_Operar
,		'RENTA FIJA'								as Origen
,		case	when rstipopero ='IB' then 'INTERBANCARIOS'
				when rstipopero ='VI' then 'VENTAS CON PACTO'
				when rstipopero ='CI' then 'COMPRAS CON PACTO'
				when rstipopero ='CP' then 'COMPRAS CON PACTO'  end  as Producto
,		max(rsnumdocu)								as Folio_Operacion	
,		max(case when rsfeccomp>rsfecinip then rsfeccomp else rsfecinip end) as Fecha_Operacion
,		convert(varchar(15),'')						as usuario
into #paso_rf
from BacTraderSuda..mdrs
inner join bacparamsuda..cliente ON clrut=rsrutcli and clcodigo=rscodcli
where rsfecha=@acfecproc
group by clrut,cldv,rscodcli,cldv,clnombre,rstipopero,clvigente


update p
	set usuario = (select top 1 upper(rtrim(mousuario)) from BacTraderSuda..mdmh where mofecpro=p.Fecha_Operacion and morutcli=Rut_Cliente)
from #paso_rf p


select 
	Clrut										as Rut_Cliente
,	Cldv										as DV_Cliente
,	cacodcli									as Codigo_Cliente
,	clnombre									as Nombre_Contraparte
,   case when clvigente ='S' then 'SI' else 'NO' end as Habilitado_Operar
,	'FORWARD'									as Origen
,	p.descripcion								as Producto
,	max(canumoper)								as Folio_Operacion
,	max(cafecha)								as Fecha_Operacion
,	upper(max(caoperador))						as usuario
into #paso_fwd
from bacfwdsuda..mfca
inner join bacparamsuda..cliente ON clrut=cacodigo and clcodigo=cacodcli
inner join BACFWDSUDA..VIEW_PRODUCTO P	ON P.CODIGO_PRODUCTO= cacodpos1 AND P.ID_SISTEMA='BFW'
group by clrut,cldv,cacodcli,cldv,clnombre,p.descripcion,clvigente

select	
		Clrut										as Rut_Cliente
,		Cldv										as DV_Cliente
,		codigo_cliente								as Codigo_Cliente
,		clnombre									as Nombre_Contraparte
,       case when clvigente ='S' then 'SI' else 'NO' end as Habilitado_Operar
,		'SWAP'										as Origen
,		case	when tipo_swap = 1 THEN 'INTEREST RATE SWAP'
				when tipo_swap = 2 THEN 'CROSS CURRENCY SWAP'
				when tipo_swap = 4 THEN 'INDICE PROMEDIO CAMARA' end Producto
,		max(numero_operacion)						as Folio_Operacion
,		max(fecha_cierre)							as Fecha_Operacion
,		upper(max(operador))						as usuario
into #paso_swp
from bacswapsuda..cartera
inner join bacparamsuda..cliente ON clrut=rut_cliente and clcodigo=codigo_cliente
group by clrut,cldv,codigo_cliente,cldv,clnombre,tipo_swap,clvigente

select 
		Clrut											as Rut_Cliente
,		Cldv											as DV_Cliente
,		CaCodigo										as Codigo_Cliente
,		clnombre										as Nombre_Contraparte
,       case when clvigente ='S' then 'SI' else 'NO' end as Habilitado_Operar
,		'OPCIONES'										as Origen
,		UPPER(E.OPCESTDSC)								as Producto
,		max(D.CANUMCONTRATO)							as Folio_Operacion
,		MAX(CaFechaContrato)							as Fecha_Operacion
,		upper(max(CaOperador))							as usuario
into #paso_opc	
FROM  CBMDBOPC.DBO.CaEncContrato AS H WITH(NOLOCK)
INNER JOIN  CBMDBOPC.DBO.CaDetContrato AS D WITH(NOLOCK) ON H.CANUMCONTRATO = D.CANUMCONTRATO
inner join bacparamsuda..cliente ON clrut=CaRutCliente and clcodigo=CaCodigo
left join cbmdbopc..OPCIONESTRUCTURA  E			ON E.OPCESTCOD  = d.CaNumEstructura  -- AND E.OPCCONTABEXTERNA='N'
group by clrut,cldv,CaCodigo,cldv,clnombre,d.CaNumEstructura,E.OPCESTDSC,clvigente

select 
		Clrut											as Rut_Cliente
,		Cldv											as DV_Cliente
,		c.codigo_cliente								as Codigo_Cliente
,		clnombre										as Nombre_Contraparte
,       case when clvigente ='S' then 'SI' else 'NO' end as Habilitado_Operar
,		'PASIVO'										as Origen
,		'BONOS'											as Producto
,		max(c.numero_operacion)							as Folio_Operacion
,		max(c.fecha_colocacion)							as Fecha_Operacion
,		upper(max(operador))							as usuario
into #paso_pas
--From LNKMDPASIVO.MDPasivo.dbo.CARTERA_PASIVO c
from MDPasivo..CARTERA_PASIVO c
inner join MDPasivo..MOVIMIENTO_PASIVO m on m.codigo_instrumento=c.codigo_instrumento and m.numero_operacion=c.numero_operacion and m.numero_correlativo=c.numero_correlativo
inner join bacparamsuda..cliente ON clrut=c.rut_cliente and clcodigo=c.codigo_cliente
group by clrut,cldv,c.codigo_cliente,cldv,clnombre,clvigente


select 
		Clrut											as Rut_Cliente
,		Cldv											as DV_Cliente
,		rscodcli										as Codigo_Cliente
,		clnombre										as Nombre_Contraparte
,       case when clvigente ='S' then 'SI' else 'NO' end as Habilitado_Operar
,		'INVERSION AL EXTERIOR'							as Origen
,		'COMPRA BONOS EXT.'								as Producto
,		max(rsnumdocu)									as Folio_Operacion
,		max(rsfeccomp)									as Fecha_Operacion
,		upper(max(mousuario))							as usuario
into #paso_rfext
FROM	BacBonosExtSuda..TEXT_RSU
inner join BacBonosExtSuda..CARTERA_CUENTA on NumDocu=rsnumdocu and Correla=rscorrelativo and NumOper=rsnumoper --and  NumOper not IN (4108, 4109, 4114, 4115, 4117, 4118, 4119, 4120, 4121, 4122, 4123, 4124, 4125)
inner join BacBonosExtSuda..TEXT_MVT_DRI on monumoper=rsnumoper and monumdocu=rsnumdocu and mocorrelativo=rscorrelativo and mofecpro=(select MAX(p.mofecpro) from BacBonosExtSuda..TEXT_MVT_DRI p where p.monumoper=rsnumoper and p.monumdocu=rsnumdocu and p.mocorrelativo=rscorrelativo)
inner join bacparamsuda..cliente ON clrut=rsrutcli and clcodigo=rscodcli
WHERE	rsfecpro =@acfecante
group by clrut,cldv, rscodcli,cldv,clnombre,clvigente


select *
from #paso_rf p
--inner join bacparamsuda..cliente on clrut=rutcli and clcodigo=codcli
UNION
select *
from #paso_swp p
--inner join bacparamsuda..cliente on clrut=rutcli and clcodigo=codcli
UNION
select *
from #paso_fwd p
--inner join bacparamsuda..cliente on clrut=rutcli and clcodigo=codcli
UNION
select *
from #paso_rfext p
--inner join bacparamsuda..cliente on clrut=rutcli and clcodigo=codcli
UNION
select *
from #paso_opc	p
--inner join bacparamsuda..cliente on clrut=rutcli and clcodigo=codcli
UNION
select *
from #paso_pas p
--inner join bacparamsuda..cliente on clrut=rutcli and clcodigo=codcli

drop table #paso_rfext
drop table #paso_swp
drop table #paso_fwd
drop table #paso_rf
drop table #paso_pas
drop table #paso_opc	

--select * from bacparamsuda..cliente
--where clrut=96639280


END
GO
