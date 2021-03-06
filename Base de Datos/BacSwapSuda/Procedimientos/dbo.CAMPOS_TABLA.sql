USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[CAMPOS_TABLA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create  PROCEDURE [dbo].[CAMPOS_TABLA]  @TABLA AS VARCHAR(20)
AS
BEGIN 

SET NOCOUNT ON
	SELECT '	,	' 
		+ B.NAME 
		+ '		' 
		+  C.name 
		+  CASE WHEN C.name =  'NUMERIC'
				THEN '(' + LTRIM(RTRIM(CONVERT(CHAR,B.xprec))) + ',' + LTRIM(RTRIM(CONVERT(CHAR,B.xscale))) +  ')'
			WHEN C.name = 'CHAR' OR C.name = 'VARCHAR'
				THEN '(' + LTRIM(RTRIM(CONVERT(CHAR,B.length))) +  ')'
				ELSE ''
		   END

	FROM	SYSOBJECTS	A
	,	SYSCOLUMNS	B
	,	SYSTYPES	C 
	WHERE	A.ID	= B.ID 
	AND	A.NAME	= @tabla
	AND	B.xtype = C.xtype
	ORDER 
	BY	colid
END
GO
