USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Selecciona_Ejecutivo]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Selecciona_Ejecutivo]
AS
BEGIN
set nocount on
  SELECT codigo,
   nombre
  FROM EJECUTIVO
  ORDER BY codigo
 
       RETURN
set nocount off
END






GO
