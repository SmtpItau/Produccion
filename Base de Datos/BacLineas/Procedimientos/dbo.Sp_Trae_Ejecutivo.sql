USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Ejecutivo]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Trae_Ejecutivo]
 (
 @Codigo  NUMERIC(2)    --,
-- @Nombre  CHAR(30) ,
-- @Sucursal  NUMERIC(2) ,
-- @Monto_Linea NUMERIC(19)
 )
AS
BEGIN
SET NOCOUNT ON
 SELECT  Codigo  ,
   Nombre  ,
  Sucursal ,
  Monto_Linea
 FROM EJECUTIVO
 WHERE Codigo = @Codigo
SET NoCount OFF
END






GO
