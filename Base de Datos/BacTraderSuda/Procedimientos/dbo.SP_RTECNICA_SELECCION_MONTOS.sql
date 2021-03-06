USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_SELECCION_MONTOS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_SELECCION_MONTOS]
AS
BEGIN
 SET NOCOUNT ON
 SELECT  'rtecnica'  = CONVERT( NUMERIC(19), ( SELECT SUM(monto) FROM tbtr_pra_rsv_tcn WHERE tipo = 1 GROUP by tipo )
      - ( SELECT SUM(monto) FROM tbtr_pra_rsv_tcn WHERE tipo = 2 GROUP by tipo ) ),
  'ooperaciones' = CONVERT( NUMERIC(19), ( SELECT SUM(monto_ocupado) FROM tbtr_mnl_me ) ),
  'diferencia' = CONVERT( NUMERIC(19), ( ( ( SELECT SUM(monto) FROM tbtr_pra_rsv_tcn WHERE tipo = 1 GROUP by tipo )
           - ( SELECT SUM(monto) FROM tbtr_pra_rsv_tcn WHERE tipo = 2 GROUP by tipo ) )
       - ( SELECT SUM(monto_ocupado) FROM tbtr_mnl_me ) ) )
 INTO #TEMPORAL
 SELECT * FROM #TEMPORAL
 SET NOCOUNT OFF
END

GO
