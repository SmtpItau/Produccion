USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA_DETALLE_COBERTURAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LIMPIA_DETALLE_COBERTURAS]
   (   @nCobertura      NUMERIC(9)   )
AS
BEGIN

   SET NOCOUNT ON

   DELETE BacTraderSuda..DETALLE_COBERTURAS
   WHERE nCobertura      = @nCobertura
   AND  (nMontoCubrir    = 0.0
    or   nMontoDerivado  = 0.0)

END



GO
