USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAMESAS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CARGAMESAS] 
AS
	SELECT	tbcodigo1	as codigo 
		,tbglosa  	as descripcion
	FROM	tabla_general_detalle  
	WHERE	tbcateg	= 245
	ORDER BY convert(int, tbcodigo1);
GO
