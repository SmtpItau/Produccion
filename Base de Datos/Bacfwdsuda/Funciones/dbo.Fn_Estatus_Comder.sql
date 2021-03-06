USE [Bacfwdsuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fn_Estatus_Comder]    Script Date: 13-05-2022 9:09:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fn_Estatus_Comder]
	(	@Modulo		char(5)
	,	@Folio		numeric(9)
	)	returns		int
as
begin

	DECLARE @iEstado	INT
		SET @iEstado	= isnull(	(	SELECT TOP 1 1 FROM BdBomesa.dbo.ComDer_RelacionMarcaComder WITH(NOLOCK) 
										WHERE	cReSistema	= upper(@Modulo)
										AND		nReNumOper	= @Folio
									), -1)

	return @iEstado

END
GO
