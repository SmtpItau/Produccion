USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[TABLAS]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[TABLAS] (@CADENA VARCHAR (50) = '')
AS
BEGIN
	DECLARE @SELECT VARCHAR(500)

	SELECT @SELECT =	'SELECT	NAME 
				FROM 	SYSOBJECTS 
				WHERE	TYPE = "U"
				AND	STATUS > -1
				AND	(NAME LIKE "%' + @CADENA + '%" OR "' + @CADENA + '" = "")
				AND	NAME <> "TABLAS"
				ORDER	
				BY	NAME'

	EXEC (@SELECT)

END


GO
