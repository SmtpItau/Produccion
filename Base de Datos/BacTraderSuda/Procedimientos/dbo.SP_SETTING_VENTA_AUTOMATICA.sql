USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SETTING_VENTA_AUTOMATICA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SETTING_VENTA_AUTOMATICA]
AS
BEGIN

	SET NOCOUNT ON

	-->	    Se define el Rut final para las operaciones de venta automaticas 
	DECLARE @iRutCliente	NUMERIC(9)
	DECLARE @iCodCliente	NUMERIC(9)
	SELECT  @iRutCliente	= tbvalor
		,	@iCodCliente	= tbcodigo1
	FROM	BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 9900

	-->	    Se define la Forma de Pago para las operaciones de venta automaticas 
	DECLARE @iFPago			INT
	SELECT	@iFPago			= tbvalor
	FROM	BacParamSuda.dbo.TABLA_GENERAL_DETALLE
	WHERE	tbcateg			= 9901

	SELECT rut = @iRutCliente, Codigo = @iCodCliente, FPAgo = @iFPago

END
GO
