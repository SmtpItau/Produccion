USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERENVIOMAIL]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERENVIOMAIL]  
		(   @ctcateg   NUMERIC(04)   )
AS  
BEGIN  
  
   SET NOCOUNT ON  
  

	SELECT	a.tbcodigo1
	,		a.tbtasa   
	,		CONVERT(CHAR(10),tbfecha,103)
	,		a.tbvalor  
	,		a.tbglosa  
	,		a.nemo
	,		ctdescrip
	FROM	TABLA_GENERAL_DETALLE a
	,		TABLA_GENERAL_GLOBAL
	WHERE	tbcateg = @ctcateg
	AND		ctcateg = tbcateg
	ORDER BY tbcateg
	,		tbcodigo1
	,		tbtasa
	,		tbfecha
  

END
GO
