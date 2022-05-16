USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[Funciones]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Funciones]
	(	@CADENA VARCHAR (50) = ''	)
AS
BEGIN

	DECLARE @SELECT		VARCHAR(500)
	SELECT	@SELECT		='	SELECT	NAME 
							FROM	SYSOBJECTS 
							WHERE	TYPE = ''FN'' 
							AND		STATUS > -1 
							AND	(	NAME LIKE ''%''' + @CADENA + '''%'' OR ''' + @CADENA + ''' = '''')
							AND		NAME <> ''PROCEDIMIENTO''
							ORDER 
							BY		NAME'

	EXEC (@SELECT)


END
GO
