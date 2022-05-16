USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[PROCEDIMIENTOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PROCEDIMIENTOS] (@CADENA VARCHAR (50) = '')
AS
BEGIN
	DECLARE @SELECT VARCHAR(500)

	SELECT @SELECT =	'SELECT	NAME 
				FROM 	SYSOBJECTS 
				WHERE	TYPE = ''P''
				AND	STATUS > -1
				AND	(NAME LIKE ''%' + @CADENA + '%'' OR ''' + @CADENA + ''' = '''')
				AND	NAME <> ''PROCEDIMIENTO''
				ORDER	
				BY	NAME'

	EXEC (@SELECT)


END

GO
