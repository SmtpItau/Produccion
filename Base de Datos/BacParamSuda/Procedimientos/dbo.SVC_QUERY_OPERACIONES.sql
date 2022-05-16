USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_QUERY_OPERACIONES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_QUERY_OPERACIONES]
   (   @dFecha      DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT numero_operacion
      ,   numero_flujo
      ,   tipo_flujo

      ,   *
     FROM BacSwapsuda.dbo.CARTERA
    WHERE fecha_vence_flujo = @dFecha

END
GO
