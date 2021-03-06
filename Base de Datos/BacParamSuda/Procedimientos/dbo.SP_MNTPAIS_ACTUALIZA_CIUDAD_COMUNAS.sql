USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTPAIS_ACTUALIZA_CIUDAD_COMUNAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNTPAIS_ACTUALIZA_CIUDAD_COMUNAS]
AS
BEGIN
 SET NOCOUNT ON
 DELETE ciudad_comuna
 INSERT INTO ciudad_comuna
 select codigo_pais,ciudad.codigo_ciudad,codigo_comuna,comuna.nombre
 FROM ciudad,
  comuna,
  region
 WHERE region.codigo_region = ciudad.codigo_region
 AND ciudad.codigo_ciudad = comuna.codigo_ciudad
 SET NOCOUNT OFF
END
--sp_mntpais_actualiza_ciudad_Comunas

GO
