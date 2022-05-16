USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ADENDUM_ObtieneModificacionesOpciones_Cliente]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--ADENDUM_ObtieneModificacionesOpciones_Cliente 8072982, 1, '2010/01/01', '2013/12/31'

CREATE PROCEDURE [dbo].[ADENDUM_ObtieneModificacionesOpciones_Cliente]
(
	--@nContrato numeric(10)
		  @nRutCli AS NUMERIC(10) 
	, @CodCli as varchar(2)
	, @FechaDesde datetime --varchar(10)
	, @FechaHasta datetime --varchar(10)
)

AS
BEGIN
SET NOCOUNT ON

--DECLARE @nContrato numeric(9)
--set @nContrato = 344

	--IF EXISTS (SELECT 1 FROM baclineas..DETALLE_APROBACIONES WHERE NUMERO_OPERACION = @nContrato AND ID_SISTEMA = 'OPT' AND ESTADO = 'A')
	--	BEGIN
		select	'Contrato'				=	monumcontrato --@nContrato

		,		'Estado'				=	MoTipoTransaccion
		,		'Fecha_Contrato'		=	CONVERT(CHAR(10),MoFechaContrato,105)
		,		'Fecha_Modificacion'	=	convert(char(10),MofecValorizacion,105)
		,		'Hora_Modificacion'		=	convert(char(10),MoFechaCreacionRegistro,108)
		,		'Adendum'				=	case when MoTipoTransaccion = 'MODIFICA' OR MoTipoTransaccion = 'ANTICIPA' THEn 'Si'
												else 'No' end
		,		Orden					= ROW_NUMBER () OVER (ORDER BY MoFechaCreacionRegistro)
		,		'id'					=	'---'
		,		'Folio'					=	monumfolio
		
		 from CbMdbOpc.DBO.MoHisEncContrato 
		 where --monumcontrato = @nContrato
		morutcliente = @nRutCli
		and mocodigo = @CodCli
		 and MoTipoTransaccion in ('MODIFICA', 'ANTICIPA')
		 and MofecValorizacion between @FechaDesde and @FechaHasta
	
	--END ELSE
	--	BEGIN
	--				select			TOP 0 'Contrato'				=	''
	--						,		'Estado'				=	''
	--						,		'Fecha_Modificacion'	=	''
	--						,		'Hora_Modificacion'		=	''
	--						,		'Adendum'				=	''									
	--						,		Orden					= ''
	--						,		'id'					=	''
	--						,		'Folio'					=	''
		
		
	--END
END
GO
