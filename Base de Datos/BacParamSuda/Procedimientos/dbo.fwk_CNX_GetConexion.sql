USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_CNX_GetConexion]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_CNX_GetConexion] 
(@IdAplicacion NVARCHAR(30) ,@IdConexion NVARCHAR(40))
--WITH ENCRYPTION
AS
	/*
Recupera la informacion de conexion

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_CNX_GetConexion 'FFMM', 'F8B52C1908A3159B7E8253C012B530C56074C6F1'

*/


BEGIN
	SELECT id_aplicacion
	      ,id_conexion
	      ,connection
	      ,provider
	      ,time_out
	FROM   FWK_CONEXIONES
	WHERE  id_aplicacion = @IdAplicacion
	       AND id_conexion = @IdConexion
END
GO
