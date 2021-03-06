USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CORRELACIONES_LINEAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_CORRELACIONES_LINEAS]   (   @Moneda1   CHAR(08) = ''
                                              ,   @PlazoIni1 FLOAT    = -9999
                                              ,   @PlazoFin1 FLOAT    = -9999
                                              ,   @Moneda2   CHAR(08) = ''
                                              ,   @PlazoIni2 FLOAT    = -9999
                                              ,   @PlazoFin2 FLOAT    = -9999
                                              )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @CodMon1 NUMERIC(6,0)
   ,       @CodMon2 NUMERIC(6,0)

   SELECT @CodMon1 = CASE @Moneda1 WHEN 'MX/ML' 
                                                THEN 999999 
                                              WHEN 'MX' 
                                                THEN 13 
                                              WHEN '' 
                                                THEN -9999
                                              ELSE CONVERT(NUMERIC(6,0),(SELECT mncodmon FROM BACPARAMSUDA..MONEDA WHERE mnnemo = @Moneda1))
                     END
   ,      @CodMon2 = CASE @Moneda2 WHEN 'MX/ML' 
                                                THEN 999999 
                                              WHEN 'MX' 
                                                THEN 13 
                                              WHEN '' 
                                                THEN -9999
                                              ELSE CONVERT(NUMERIC(6,0),(SELECT mncodmon FROM BACPARAMSUDA..MONEDA WHERE mnnemo = @Moneda2))
                     END


   SELECT CorMoneda1
   ,      CorPlazoIni1
   ,      CorPlazoFin1
   ,      CorMoneda2
   ,      CorPlazoIni2
   ,      CorPlazoFin2
   ,      CorValor
   ,      (CASE CorMoneda1 WHEN 999999 THEN 'MX/ML' WHEN 13 THEN 'MX' ELSE (SELECT mnnemo FROM BACPARAMSUDA..MONEDA WHERE mncodmon = CorMoneda1) END) as NemoMon1
   ,      (CASE CorMoneda2 WHEN 999999 THEN 'MX/ML' WHEN 13 THEN 'MX' ELSE (SELECT mnnemo FROM BACPARAMSUDA..MONEDA WHERE mncodmon = CorMoneda2) END) as NemoMon2
   FROM   TBL_CORRELACIONES_LINEAS
   WHERE  (CorMoneda1     = @CodMon1   OR @CodMon1   = -9999)
   AND    (CorPlazoIni1   = @PlazoIni1 OR @PlazoIni1 = -9999)
   AND    (CorPlazoFin1   = @PlazoFin1 OR @PlazoFin1 = -9999)
   AND    (CorMoneda2     = @CodMon2   OR @CodMon1   = -9999)
   AND    (CorPlazoIni2   = @PlazoIni2 OR @PlazoIni2 = -9999)
   AND    (CorPlazoFin2   = @PlazoFin2 OR @PlazoFin2 = -9999)
   ORDER
   BY     CorMoneda1   DESC
   ,      CorPlazoIni1 ASC
   ,      CorPlazoFin1 ASC
   ,      CorMoneda2   DESC
   ,      CorPlazoIni2 ASC
   ,      CorPlazoFin2 ASC


   SET NOCOUNT OFF

END

GO
