USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERTIPOOPSOMA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERTIPOOPSOMA]
AS
BEGIN
   SET NOCOUNT ON
	select tbcateg
	,      tbcodigo1
	,      tbtasa
	,      tbfecha
	,      tbvalor
	,      tbglosa
	,      nemo       
	from tabla_general_detalle
	where tbcateg =860  
   SET NOCOUNT OFF
END

GO
