USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEEJECUTIVOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAEEJECUTIVOS]
AS
BEGIN

   SET NOCOUNT ON

   SELECT Nombre, Codigo
   FROM   Bacparamsuda.dbo.TBL_EJECUTIVOS
   ORDER BY Nombre

END
GO
