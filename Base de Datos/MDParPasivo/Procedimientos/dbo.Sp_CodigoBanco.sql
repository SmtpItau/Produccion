USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CodigoBanco]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_CodigoBanco]
		(@moneda	NUMERIC(10)
		 
		)
		 
AS 
BEGIN

        SET DATEFORMAT dmy
	SET NOCOUNT ON
	SELECT mncodbanco
	FROM MONEDA
	WHERE mncodmon=@moneda
               AND ESTADO<>'A'
	SET NOCOUNT OFF
END





GO
