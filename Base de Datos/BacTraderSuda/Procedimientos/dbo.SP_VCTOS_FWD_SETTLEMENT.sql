USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VCTOS_FWD_SETTLEMENT]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VCTOS_FWD_SETTLEMENT]
                                        ( @Rut_Cliente  NUMERIC(10)  ,
                                          @Codigo_Rut   NUMERIC(5)   ,
                                          @Dia3         FLOAT OUTPUT ,
                                          @Dia4         FLOAT OUTPUT )
AS
BEGIN  
DECLARE @Fec_Prox    DATETIME ,
        @Fec_Prox10  DATETIME
SELECT @Dia3 = 0.0
SELECT @Dia4 = 0.0
SELECT @Fec_Prox = ACFECPROX FROM VIEW_MFAC
SELECT @Dia3 = ISNULL(SUM(CASE WHEN CACODPOS1 = 2 THEN CAMTOMON2 ELSE CAEQUUSD1 END),0.0)
  FROM VIEW_MFCA
 WHERE CACODIGO  = @Rut_Cliente
   AND CACODCLI  = @Codigo_Rut
   AND CAFECVCTO = @Fec_Prox
SELECT @Fec_Prox10 = DATEADD(day, 10, @Fec_Prox)
SELECT @Dia4 = ISNULL(SUM(CASE WHEN CACODPOS1 = 2 THEN CAMTOMON2 ELSE CAEQUUSD1 END),0.0)
  FROM VIEW_MFCA
 WHERE CACODIGO   = @Rut_Cliente
   AND CACODCLI   = @Codigo_Rut
   AND CAFECVCTO  > @Fec_Prox
   AND CAFECVCTO <= @Fec_Prox10
END

GO
