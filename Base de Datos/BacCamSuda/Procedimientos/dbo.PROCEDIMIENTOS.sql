USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[PROCEDIMIENTOS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROCEDIMIENTOS] (@CADENA VARCHAR (50) = '')
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

--  REQ.7619 CASS 28-01-2011
--	SELECT @SELECT =	'SELECT	NAME 
--				FROM 	SYSOBJECTS 
--				WHERE	TYPE = "P"
--				AND	STATUS > -1
--				AND	(NAME LIKE "%' + @CADENA + '%" OR "' + @CADENA + '" = "")
--				AND	NAME <> "PROCEDIMIENTO"
--				ORDER	
--				BY	NAME'

	EXEC (@SELECT)


END
-- PROCEDIMIENTOS 'FIN'
GO
