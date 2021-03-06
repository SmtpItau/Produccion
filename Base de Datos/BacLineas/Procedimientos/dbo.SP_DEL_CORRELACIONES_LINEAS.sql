USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_CORRELACIONES_LINEAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DEL_CORRELACIONES_LINEAS]   (   @CodMon1   NUMERIC(5,0)   = -9999
                                              ,   @PlazoIni1 FLOAT          = -9999
                                              ,   @PlazoFin1 FLOAT          = -9999
                                              ,   @CodMon2   NUMERIC(5,0)   = -9999
                                              ,   @PlazoIni2 FLOAT          = -9999
                                              ,   @PlazoFin2 FLOAT          = -9999
                                              )
AS BEGIN 

   SET NOCOUNT ON 
   
   DELETE  TBL_CORRELACIONES_LINEAS
   WHERE   (CorMoneda1   = @CodMon1    OR @CodMon1   = -9999)
   AND     (CorPlazoIni1 = @PlazoIni1  OR @PlazoIni1 = -9999)
   AND     (CorPlazoFin1 = @PlazoFin1  OR @PlazoFin1 = -9999) 
   AND     (CorMoneda2   = @CodMon2    OR @CodMon2   = -9999)
   AND     (CorPlazoIni2 = @PlazoIni2  OR @PlazoIni2 = -9999)
   AND     (CorPlazoFin2 = @PlazoFin2  OR @PlazoFin2 = -9999)

   SET NOCOUNT OFF

END
GO
