USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECCIONA_PAIS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SELECCIONA_PAIS]
AS
BEGIN
set nocount on
  SELECT codigo_pais,
   nombre
  FROM PAIS
  ORDER BY nombre
 
       RETURN
set nocount off
END
GO
