USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_mntpais_actualiza_ciudad_Comunas]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







Create PROCEDURE [dbo].[Sp_mntpais_actualiza_ciudad_Comunas]
AS
BEGIN


	SET NOCOUNT ON
	DELETE ciudad_comuna

	INSERT INTO ciudad_comuna
	select codigo_pais,ciudad.codigo_ciudad,codigo_comuna,comuna.nombre
	FROM	ciudad,
		comuna,
		region
	WHERE	region.codigo_region = ciudad.codigo_region
	AND	ciudad.codigo_ciudad = comuna.codigo_ciudad

	SET NOCOUNT OFF
END

--sp_mntpais_actualiza_ciudad_Comunas






GO
