USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_mntcliente_leer_ciudades]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







Create PROCEDURE [dbo].[Sp_mntcliente_leer_ciudades]
AS
BEGIN

	SET NOCOUNT ON

	SELECT codigo_ciudad, nombre FROM ciudad

	SET NOCOUNT OFF

END







GO
