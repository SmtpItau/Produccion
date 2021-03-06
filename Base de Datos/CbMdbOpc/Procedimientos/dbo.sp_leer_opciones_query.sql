USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[sp_leer_opciones_query]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_leer_opciones_query]
as
begin
	set nocount on
	select	Folio			= enc.Folio
		,	Contrato		= enc.Contrato
		,	Rut				= cli.RutDv
		,	Nombre			= cli.Nombre
		,	Producto		= pro.Descripcion
		,	Id				= det.Estructura
		,	Tipo			= Det.Tipo
		,	FechaInicio		= det.FechaInicio
		,	Fijacion		= det.Fijacion
		,	FechaTermino	= det.Vencimiento
	from 
	(select Contrato= CaNumContrato
	,Estructura= CaNumEstructura
	,Tipo= case when CaTipoOpc = 'C' then 'Compra' else 'Venta' end + ' ' + CaCallPut
	,FechaInicio= CaFechaInicioOpc
	,Fijacion= CaFechaFijacion
	,Vencimiento= CaFechaVcto
	from CaDetContrato with(nolock) 
	where CaFechaVcto >= (select OpcionesGeneral.fechaproc from OpcionesGeneral with(nolock))
	) Det
inner join
(select	Folio= CaNumFolio
,Contrato= CaNumContrato
,Creacion= CaFechaContrato
,Rut= CaRutCliente
,Codigo= CaCodigo
,Estructura= CaCodEstructura
from CaEncContrato with(nolock)
) Enc On Enc.Contrato = Det.Contrato 

left join
(	select	Producto	= OpcEstCod
		,	Descripcion	= OpcEstDsc
	from	OpcionEstructura with(nolock)
)	pro		on pro.Producto	= enc.Estructura  
left join
(	select	Rut		= clrut
		,	Codigo	= Clcodigo
		,	Nombre	= Clnombre
		,	RutDv	= ltrim(rtrim( clrut )) + '-' + ltrim(rtrim( cldv ))
	from	BacparamSuda.dbo.cliente with(nolock)
)	cli		On cli.Rut	= Enc.Rut and cli.Codigo = enc.Codigo
end
GO
