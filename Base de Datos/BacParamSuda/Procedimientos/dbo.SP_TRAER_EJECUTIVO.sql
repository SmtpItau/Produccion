USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAER_EJECUTIVO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_TRAER_EJECUTIVO]
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
