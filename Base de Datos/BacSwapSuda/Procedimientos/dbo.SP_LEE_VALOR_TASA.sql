USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_VALOR_TASA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEE_VALOR_TASA]
   (   @iCodMoneda   INTEGER
   ,   @iCodTasa     INTEGER
   ,   @dFecha       DATETIME
   )
AS
BEGIN

   SET NOCOUNT ON
   
   SELECT ISNULL(tasa,0.0)
   FROM   BacParamSuda..MONEDA_TASA
   WHERE  sistema = 'PCS'
   AND    periodo = 1 -- 4
   AND    codmon  = @iCodMoneda
   AND    codtasa = @iCodTasa
   AND    fecha   = @dFecha
   
END
GO
