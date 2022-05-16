USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_SERIE_FONDOS_MUTUOS]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_SERIE_FONDOS_MUTUOS]
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

       SELECT	Serie,
		ClNombre,
		clCodigo,
		mnglosa
       FROM	FMUTUO_SERIE,
		CLIENTE,
		MONEDA
       WHERE	clrut		= rut_cliente 		AND
		clCodigo	= Codigo_cliente 	AND 
		mncodmon	= codigo_moneda		


       RETURN
SET NOCOUNT OFF
END






GO
