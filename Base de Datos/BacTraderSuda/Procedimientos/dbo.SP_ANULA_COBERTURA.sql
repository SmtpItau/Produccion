USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULA_COBERTURA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ANULA_COBERTURA]
   (   @cModulo     CHAR(3)
   ,   @nDerivado   NUMERIC(9)
   ,   @nCorrela    NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @MiCobertura   NUMERIC(9)

   SELECT  @MiCobertura = 0.0
   SELECT  @MiCobertura = ISNULL(nCobertura,0)
   FROM    BacTraderSuda..COBERTURAS WITH (NoLock)
   WHERE   cModulo      = @cModulo 
   AND     nDerivado    = @nDerivado 
   AND     nCorrela     = @nCorrela


   IF @MiCobertura > 0.0
      EXECUTE BacTraderSuda..SP_ELIMINAR_COBERTURA @MiCobertura

   SELECT @MiCobertura

END




GO
