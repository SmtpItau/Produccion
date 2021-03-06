USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_TCRC]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_LEE_TCRC]
   (   @dFechaProceso   DATETIME
   ,   @dFechaAnterior  DATETIME
   ,   @nMoneda         INT
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @dFechaProceso = @dFechaAnterior
      SET @dFechaAnterior = (SELECT acfecante FROM BacFwdSuda..MFAC)

   IF @nMoneda = 13
      SET @nMoneda = 994

   DECLARE @nValorMoneda   FLOAT
       SET @nValorMoneda   = ISNULL((SELECT ISNULL(Tipo_Cambio,0.0) FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @dFechaProceso AND Codigo_Moneda = @nMoneda),0.0)

   IF @nValorMoneda = 0.0 OR @nValorMoneda IS NULL
       SET @nValorMoneda   = ISNULL((SELECT ISNULL(Tipo_Cambio,0.0) FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @dFechaAnterior AND Codigo_Moneda = @nMoneda),0.0)   

   SELECT @nValorMoneda

END

GO
