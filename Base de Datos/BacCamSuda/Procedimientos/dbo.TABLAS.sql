USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[TABLAS]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[TABLAS] (@CADENA VARCHAR (50) = '')
AS
BEGIN
	DECLARE @SELECT VARCHAR(500)
/*  REQ.7619
	SELECT @SELECT =	'SELECT	NAME 
				FROM 	SYSOBJECTS 
				WHERE	TYPE = "U"
				AND	STATUS > -1
				AND	(NAME LIKE "%' + @CADENA + '%" OR "' + @CADENA + '" = "")
				AND	NAME <> "TABLAS"
				ORDER	
				BY	NAME'
*/

	SELECT @SELECT =	'SELECT	NAME 
				FROM 	SYSOBJECTS 
				WHERE	TYPE = ''U''
				AND	STATUS > -1 
				AND	(NAME LIKE ''%'+ @CADENA + '%''  OR ''' + @CADENA + ''' = '''' )
				AND	NAME <> '''' + ''TABLAS''
				ORDER	
				BY	NAME'

	EXEC (@SELECT)

END


GO
