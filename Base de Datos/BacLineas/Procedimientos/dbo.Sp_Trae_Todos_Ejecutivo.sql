USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Todos_Ejecutivo]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Trae_Todos_Ejecutivo]
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
