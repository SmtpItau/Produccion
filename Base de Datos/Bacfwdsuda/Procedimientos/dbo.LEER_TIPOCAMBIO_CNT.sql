USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[LEER_TIPOCAMBIO_CNT]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[LEER_TIPOCAMBIO_CNT]
   (   @iMoneda   INT   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso    DATETIME
   DECLARE @dFechaanterior   DATETIME

    SELECT @dFechaProceso    = acfecproc
       ,   @dFechaanterior   = acfecante
      FROM BacFwdsuda..MFAC  with (nolock)

   DECLARE @iTipoCambio      FLOAT
       SET @iTipoCambio      = ISNULL( (SELECT tipo_cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock) 
                                                          WHERE Fecha = @dFechaProceso  AND Codigo_Moneda = @iMoneda), 0.0)

   IF @iTipoCambio = 0.0
       SET @iTipoCambio      = ISNULL( (SELECT tipo_cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock) 
                                                          WHERE Fecha = @dFechaanterior AND Codigo_Moneda = @iMoneda), 0.0)
   SELECT 'iTipoCambio' = @iTipoCambio

END

GO
