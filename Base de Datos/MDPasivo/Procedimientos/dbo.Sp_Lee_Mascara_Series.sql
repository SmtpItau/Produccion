USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lee_Mascara_Series]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Lee_Mascara_Series]
		(@Incodigo NUMERIC(3))
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
	SELECT secodigo,semascara FROM SERIE WHERE secodigo = @Incodigo
SET NOCOUNT OFF
END

GO
