USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_RENTABILIDAD_15MIN]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GENERA_RENTABILIDAD_15MIN]
AS
BEGIN

   DECLARE @FinDia   INTEGER
   ,       @MaxHora  DATETIME

   SELECT  @FinDia   = SUBSTRING(aclogdig,9,1) 
   FROM    MEAC

   IF NOT EXISTS(SELECT 1 FROM RENTABILIDAD_DINAMICA , MEAC WHERE Fecha = acfecpro)
   BEGIN
      INSERT INTO RENTABILIDAD_DINAMICA
      SELECT 'Fecha'            = CONVERT(CHAR(10),acfecpro,112)
      ,      'Hora'             = GETDATE()
      ,      'DescalceInicio'   = (achedgeactualfuturo + achedgeactualspot) + (achedgevctofuturo)
      ,      'HnfInicio'        = M.achedgeinicialfuturo
      ,      'DescalceCierre'   = CASE WHEN @FinDia = 1 THEN (achedgeactualfuturo + achedgeactualspot) + (achedgevctofuturo)
                                       ELSE                   0.0000 
                                  END
      ,      'HnfCierre'        = CASE WHEN @FinDia = 1 THEN M.achedgeinicialfuturo
                                       ELSE                  0.0000 
                                  END
      ,      'TcInicio'         = M.acpreini
      ,      'TcCierre'         = M.acprecie
      ,      'UtilidadTrading'  = M.acacumdia
      ,      'UtilidadDescalce' = M.achedgeutilidad
      ,      'Hnf'              = M.achedgeactualfuturo
      FROM    MEAC                    M
              LEFT JOIN RENTABILIDAD  R  ON R.fecha = M.acfecant

   END ELSE
   BEGIN

      SELECT  @MaxHora  = dateadd(minute,15,hora)
      FROM    RENTABILIDAD_DINAMICA
      ,       MEAC
      WHERE   Fecha     = acfecpro

      IF substring(convert(char(10),@MaxHora,108),1,5) <= substring(convert(char(10),getdate(),108),1,5)
      BEGIN
         INSERT INTO RENTABILIDAD_DINAMICA
         SELECT 'Fecha'            = CONVERT(CHAR(10),acfecpro,112)
         ,      'Hora'             = GETDATE()
         ,      'DescalceInicio'   = (achedgeactualfuturo + achedgeactualspot) + (achedgevctofuturo)
         ,      'HnfInicio'        = M.achedgeinicialfuturo
         ,      'DescalceCierre'   = CASE WHEN @FinDia = 1 THEN (achedgeactualfuturo + achedgeactualspot) + (achedgevctofuturo)
                                          ELSE                   0.0000 
                                     END
         ,      'HnfCierre'        = CASE WHEN @FinDia = 1 THEN M.achedgeinicialfuturo
                                          ELSE                  0.0000 
                                     END
         ,      'TcInicio'         = M.acpreini
         ,      'TcCierre'         = M.acprecie
         ,      'UtilidadTrading'  = M.acacumdia
         ,      'UtilidadDescalce' = M.achedgeutilidad
         ,      'Hnf'              = M.achedgeactualfuturo
         FROM    MEAC                    M
                 LEFT JOIN RENTABILIDAD  R  ON R.fecha = M.acfecant
      END
   END

END

GO
