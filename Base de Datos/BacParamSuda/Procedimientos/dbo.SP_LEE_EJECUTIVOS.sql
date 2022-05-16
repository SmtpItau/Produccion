USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_EJECUTIVOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_EJECUTIVOS]
AS
BEGIN

   SET NOCOUNT ON

   SELECT Codigo
      ,   Nombre 
     FROM BacParamSuda.dbo.TBL_EJECUTIVOS with(nolock)
    WHERE Estado = 'VIGENTE'

END
GO
