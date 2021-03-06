USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CORRELACIONES_LINEAS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACT_CORRELACIONES_LINEAS]   (   @CodMon1   CHAR(08)
                                                    ,   @PlazoIni1 FLOAT
                                                    ,   @PlazoFin1 FLOAT
                                                    ,   @CodMon2   CHAR(08)
                                                    ,   @PlazoIni2 FLOAT
                                                    ,   @PlazoFin2 FLOAT
                                                    ,   @Valor     FLOAT
                                                    )
AS BEGIN 

   SET NOCOUNT ON 
   
      DECLARE @Moneda1   FLOAT
      ,       @Moneda2   FLOAT


      IF @CodMon1 = 'MX/ML' 
         SET @Moneda1   =  999999 
      ELSE IF @CodMon1 = 'MX' 
         SET @Moneda1   = 13 
      ELSE 
         SET @Moneda1   =  (SELECT mncodmon FROM BACPARAMSUDA.dbo.MONEDA WHERE MnNemo = @CodMon1) 


      IF @CodMon2 = 'MX/ML' 
         SET @Moneda2   =  999999 
      ELSE IF @CodMon2 = 'MX' 
         SET @Moneda2   = 13 
      ELSE 
         SET @Moneda2   =  (SELECT mncodmon FROM BACPARAMSUDA.dbo.MONEDA WHERE MnNemo = @CodMon2) 


      INSERT INTO TBL_CORRELACIONES_LINEAS
      (   CorMoneda1
      ,   CorPlazoIni1
      ,   CorPlazoFin1
      ,   CorMoneda2
      ,   CorPlazoIni2
      ,   CorPlazoFin2
      ,   CorValor
      )
      SELECT   @Moneda1
      ,        (CASE WHEN @CodMon1 = 'MX/ML' THEN 999999 ELSE @PlazoIni1 END)
      ,        (CASE WHEN @CodMon1 = 'MX/ML' THEN 999999 ELSE @PlazoFin1 END)
      ,        @Moneda2
      ,        (CASE WHEN @CodMon2 = 'MX/ML' THEN 999999 ELSE @PlazoIni2 END)
      ,        (CASE WHEN @CodMon2 = 'MX/ML' THEN 999999 ELSE @PlazoFin2 END)
      ,        @Valor
      

   SET NOCOUNT OFF

END
GO
