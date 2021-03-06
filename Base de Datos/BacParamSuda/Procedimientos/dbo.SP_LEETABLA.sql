USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEETABLA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEETABLA]
   (   @ctcateg   NUMERIC(04)   )
                  
AS
BEGIN

   SET NOCOUNT ON


   IF @ctcateg = 2700 
   BEGIN

	SELECT	a.tbcodigo1
	,	a.tbtasa   
	,	CONVERT(CHAR(10),tbfecha,103)
	,	a.tbvalor  
	,	a.tbglosa  
	,	a.nemo
	,	ctdescrip
	FROM	TABLA_GENERAL_DETALLE a
	,	TABLA_GENERAL_GLOBAL
	WHERE	tbcateg = @ctcateg
	AND	ctcateg = tbcateg
	ORDER BY tbcateg
	,	 convert(float, tbcodigo1)
	,	 tbtasa
	,	 tbfecha
	return
   END

   IF @ctcateg = 2740
   BEGIN

	SELECT	a.tbcodigo1
	,	a.tbtasa   
	,	CONVERT(CHAR(10),tbfecha,103)
	,	a.tbvalor  
	,	a.tbglosa  
	,	a.nemo
	,	ctdescrip
	FROM	TABLA_GENERAL_DETALLE a
	,	TABLA_GENERAL_GLOBAL
	WHERE	tbcateg = @ctcateg
	AND	ctcateg = tbcateg
	ORDER BY a.tbglosa
	return
   END	


   IF @ctcateg = 1042
   BEGIN
	SELECT  a.tbcodigo1
	,	a.tbtasa   
	,	convert(char(10),tbfecha,103)
	,	a.tbvalor  
	,	a.tbglosa
	,	CASE WHEN @ctcateg = 1042 AND tbcodigo1 <> 13 THEN CASE WHEN a.nemo = 'S' THEN 'SI' ELSE 'NO' END
                     WHEN @ctcateg = 1042 AND tbcodigo1  = 13 THEN '--'
                     ELSE                                          a.nemo
                END
	,	ctdescrip
	FROM	TABLA_GENERAL_DETALLE a
	,	TABLA_GENERAL_GLOBAL 
	WHERE	tbcateg = @ctcateg
	AND	ctcateg = @ctcateg
	ORDER BY tbcateg
	,	 CONVERT(NUMERIC(9),tbcodigo1)
	,	 tbtasa
	,	 tbfecha
   
      RETURN
   END

   IF @ctcateg  NOT IN(1111)
   BEGIN
	SELECT  a.tbcodigo1
	,	a.tbtasa   
	,	convert(char(10),tbfecha,103)
	,	a.tbvalor  
	,	a.tbglosa
	,	CASE WHEN @ctcateg = 1042 AND tbcodigo1 <> 13 THEN CASE WHEN a.nemo = 'S' THEN 'SI' ELSE 'NO' END
                     WHEN @ctcateg = 1042 AND tbcodigo1  = 13 THEN '--'
                     ELSE                                          a.nemo
                END
	,	ctdescrip
	FROM	TABLA_GENERAL_DETALLE a
	,	TABLA_GENERAL_GLOBAL 
	WHERE	tbcateg = @ctcateg
	AND	ctcateg = @ctcateg
	ORDER BY tbcateg
	,	 tbcodigo1
	,	 tbtasa
	,	 tbfecha

   END ELSE
   BEGIN
	SELECT	a.tbcodigo1
	,	a.tbtasa   
	,	CONVERT(CHAR(10),tbfecha,103)
	,	a.tbvalor  
	,	a.tbglosa  
	,	a.nemo
	,	ctdescrip
	FROM	TABLA_GENERAL_DETALLE a
	,	TABLA_GENERAL_GLOBAL
	WHERE	tbcateg = @ctcateg
	AND	ctcateg = tbcateg
	ORDER BY tbcateg
	,	 tbcodigo1
	,	 tbtasa
	,	 tbfecha
   END

END
GO
