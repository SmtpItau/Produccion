USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ADENDUM_ObtenerModificacionesSWAP_Cliente]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--ADENDUM_ObtenerModificacionesSWAP 2569
--ADENDUM_ObtenerModificacionesSWAP_Cliente 94686000, 1, '2010/01/01', '2013/01/31'



CREATE PROCEDURE [dbo].[ADENDUM_ObtenerModificacionesSWAP_Cliente]
(
	--@nContrato NUMERIC(9)
	  @nRutCli AS NUMERIC(10) 
	, @CodCli as varchar(2)
	, @FechaDesde datetime --varchar(10)
	, @FechaHasta datetime --varchar(10)
)

AS 
BEGIN
SET NOCOUNT ON



--IF EXISTS (SELECT 1 FROM baclineas..DETALLE_APROBACIONES WHERE NUMERO_OPERACION = @nContrato AND ID_SISTEMA = 'PCS' AND ESTADO = 'A')
--	BEGIN

	--declare @nContrato	numeric(9)
	--	set @nContrato	= 2569 
	--	set @nContrato	= 6491
	--	set @nContrato	= 2569
		--set @nContrato	= 6048
--		set @nContrato	= 2271

	select	Contrato				= Swap.Folio1
		,	Estado					= Swap.Estado
		,   Fecha_Contrato			= convert(char(10),Swap.Fecha_Contrato,105)
		,	Fecha_Modificacion		= convert(char(10),Swap.Fecha,105)
		,	Hora_Modificacion		= Swap.Hora
		,	Adendum					= Swap.Adendum
		,	Orden					= ROW_NUMBER () OVER (ORDER BY Swap.Fecha)
		,	id
		,	Folio					
	from	(	select	Folio1		= Modif.numero_operacion
					,	Flujo		= Min( Modif.numero_flujo )
					,	Fecha_Contrato = Modif.fecha_cierre
					,	Fecha		= Modif.fecha_modifica
					,	Estado		= 'Modificada'
					,	Hora		= '00:00:00'
					,	Adendum		= 'Si'
					,	id			= 1
					,	Folio		= '---'
				from	BacSwapSuda.dbo.CarteraLog Modif with(nolock)
				where	--Modif.numero_operacion	= @nContrato
				Modif.Rut_Cliente = @nRutCli
				and    Modif.Codigo_Cliente = @CodCli
				and		Modif.Tipo_Flujo		= 1
				and		Modif.Estado			<> 'C'
				and		Modif.Fecha_modifica	between @FechaDesde and @FechaHasta
				group
				by		Modif.numero_operacion
					,   Modif.fecha_cierre
					,	Modif.fecha_modifica

					
				union

				select	Folio1		= Antic.numero_operacion
					,	Flujo		= Min( Antic.numero_flujo )
					,	Fecha_Contrato = Antic.fecha_cierre
					,	Fecha		= Antic.FechaAnticipo
					,	Estado		= 'Anticipo'
					,	Hora		= '00:00:00'
					,	Adendum		= 'Si'
					,	id			= 2
					,	Folio					= '---'
				from	BacSwapSuda.dbo.CARTERA_UNWIND Antic with(nolock)
				where	--Antic.numero_operacion	= @nContrato
				Antic.Rut_Cliente = @nRutCli
				and Antic.codigo_cliente	= @CodCli
				and		Antic.Tipo_Flujo		= 1
				and		Antic.Estado			<> 'C'
				and		Antic.FechaAnticipo between  @FechaDesde and @FechaHasta
				group
				by		Antic.numero_operacion
					,   Antic.fecha_cierre
					,	Antic.FechaAnticipo
					,	Antic.Estado
			)	Swap
	order
	--by		Swap.Fecha
	by		Swap.Folio1

--END ELSE
--BEGIN
--					select	TOP 0			
--					'Contrato'						=	''
--			,		'Estado'						=	''
--			,		'Fecha_Modificacion'			=	''
--			,		'Hora_Modificacion'							=	''
--			,		'Adendum'						=	''
--			,		'Orden'							=	''
--			,		'id'							=	''
--			,		'Folio'							=	''


--END
END
GO
