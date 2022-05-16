USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoGeneral_Elimina]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_LineaCreditoGeneral_Elimina]
	@RUTCLIENTE NUMERIC(9),
	@CODCLIENTE NUMERIC(9)
AS BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy

	DELETE
		FROM LINEA_GENERAL
			WHERE rut_cliente=@RUTCLIENTE 
				AND codigo_cliente=@CODCLIENTE

SET NOCOUNT OFF

END


GO
