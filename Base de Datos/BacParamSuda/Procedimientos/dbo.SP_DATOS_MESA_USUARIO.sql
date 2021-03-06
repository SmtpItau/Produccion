USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOS_MESA_USUARIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DATOS_MESA_USUARIO]
---
--- Autor: Jorge Bravo H. 16-Octubre-2009
--- Objetivo: Obtener Nombre y Código de la mesa según el usuario
---
@recUsuario char(15)
AS
SELECT a.codigomesa AS CodMesa, b.tbglosa AS NomMesa
FROM usuario a,
tabla_general_detalle b
WHERE a.usuario = @recUsuario
AND a.codigomesa = b.tbcodigo1
AND b.tbcateg = 245
GO
