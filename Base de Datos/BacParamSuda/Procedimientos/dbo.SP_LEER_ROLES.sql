USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_ROLES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_ROLES]
AS
BEGIN

   SET NOCOUNT ON

   SELECT codigo  = tbcodigo1
      ,   glosa   = tbglosa
   FROM   BacparamSuda.dbo.TABLA_GENERAL_DETALLE
   WHERE  tbcateg = 8500

   SET NOCOUNT OFF

END
GO
