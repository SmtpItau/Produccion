USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_TODOS_EJECUTIVO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_TODOS_EJECUTIVO]
AS BEGIN
SET NOCOUNT ON
 SELECT  Codigo  ,
   Nombre  ,
  Sucursal ,
  Monto_Linea
 FROM EJECUTIVO
SET NoCount OFF
END

GO
