USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_AREA_NEGOCIO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_AREA_NEGOCIO]
AS
BEGIN
--Area de Negocio
	select 	tbglosa,
		tbcodigo1
	from VIEW_TABLA_GENERAL_DETALLE 
	where tbcateg=1553
END


GO
