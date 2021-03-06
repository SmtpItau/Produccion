USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_INFORME_REEMPLAZO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GENERA_INFORME_REEMPLAZO]
	(	@dFecha				DATETIME	
	,	@dHasta				DATETIME
	,	@iFolioContrato		NUMERIC(9)
	,	@cUsuario			VARCHAR(15)
	,	@Modulo				VARCHAR(3)
	,	@bReemplazo			INT
	)
AS
BEGIN
   -- SP_GENERA_INFORME_REEMPLAZO '20150623', '20150623', 0, 'ADMINISTRA', '',  0 
	SET NOCOUNT ON

	DECLARE @dFechaProceso	CHAR(10)
		SET @dFechaProceso	= (SELECT CONVERT(CHAR(10), acfecproc , 103) from BacTraderSuda.dbo.MDAC)
	DECLARE @dFechaEmision	CHAR(10)
		SET @dFechaEmision	= CONVERT(CHAR(10),GETDATE(), 103)
	DECLARE @cHoraEmision	CHAR(10)
		SET @cHoraEmision	= CONVERT(CHAR(10),GETDATE(), 108)

	DECLARE @iFound			INT
		SET @iFound			= 0

	SELECT  @iFound			= 1
	FROM	TBL_MODIFICACIAONES
	WHERE	FechaModificacion	BETWEEN @dFecha AND @dHasta
	AND   ( Modulo				= @Modulo			OR @Modulo = '')
	AND   ( FolioContrato		= @iFolioContrato	OR @iFolioContrato = 0 ) 

	AND	  ( ( @bReemplazo		= 0 AND FolioContrato  = FolioCotizacion ) OR  ( @bReemplazo = 1 AND FolioContrato <> FolioCotizacion ) )
		

	IF @iFound = 1
	BEGIN
		SELECT	'Encabezado'		= CASE WHEN FolioContrato = FolioCotizacion THEN 'MODIFICACION DE OPERACION ' + CASE WHEN Modulo = 'BFW' THEN 'FORWARD FOLIO : ' + LTRIM(RTRIM( FolioContrato   )) 
																														 WHEN Modulo = 'PCS' THEN 'SWAP FOLIO : '	 + LTRIM(RTRIM( FolioContrato   )) 
																														 ELSE 'OPT FOLIO : '	 + LTRIM(RTRIM( FolioContrato   ))
																													END
										   ELSE    								     'REEMPLAZO DE OPERACION SWAP FOLIO : ' + LTRIM(RTRIM( FolioContrato   )) 
																				  + ' POR COTIZACION FOLIO : '		        + LTRIM(RTRIM( FolioCotizacion )) 
									  END
									+ ' AL '							+ CONVERT(CHAR(10), FechaModificacion, 103)
									+ CASE WHEN FolioContrato = FolioCotizacion THEN ' ' ELSE  ' - N° REEMPLAZO : '	+ LTRIM(RTRIM( FolioModificacion ))  END
		,		'Items'				= Items
		,		'DatosOriginales'	= DatosOriginales
		,		'DatosNuevos'		= DatosNuevos
		,		'dFechaProceso'		= @dFechaProceso
		,		'dFechaEmision'		= @dFechaEmision
		,		'cHoraEmision'		= @cHoraEmision
		,		'Usuario'			= @cUsuario
		,		'Operacion'			= FolioContrato
		,		'Modificacion'		= FolioModificacion
		FROM	TBL_MODIFICACIAONES
		WHERE	FechaModificacion	BETWEEN @dFecha AND @dHasta
		AND    ( Modulo				= @Modulo			OR @Modulo = '')
		AND    ( FolioContrato		= @iFolioContrato	OR @iFolioContrato = 0 ) 

		AND (  ( @bReemplazo		= 0 AND FolioContrato  = FolioCotizacion )
			OR ( @bReemplazo		= 1 AND FolioContrato <> FolioCotizacion )
			)

		ORDER BY FolioContrato
	END ELSE
	BEGIN
		SELECT	'Encabezado'		= 'NO EXISTE INFORMACION EN EL RANGO DE FECHAS SELECCIONADO '
		,		'Items'				= ''
		,		'DatosOriginales'	= ''
		,		'DatosNuevos'		= ''
		,		'dFechaProceso'		= @dFechaProceso
		,		'dFechaEmision'		= @dFechaEmision
		,		'cHoraEmision'		= @cHoraEmision
		,		'Usuario'			= @cUsuario
		,		'Operacion'			= 0
		,		'Modificacion'		= 0
	END
END
GO
