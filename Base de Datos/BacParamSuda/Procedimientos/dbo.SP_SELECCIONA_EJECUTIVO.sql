USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECCIONA_EJECUTIVO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SELECCIONA_EJECUTIVO]
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
