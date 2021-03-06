USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARPARAMAC]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARPARAMAC]
   (   @cfecproc   CHAR(10)
   ,   @cfecprox   CHAR(10)
   )
AS
BEGIN

   SET NOCOUNT ON 

   UPDATE MDAC
   SET    acfecante   = acfecproc
   ,      acfecproc   = CONVERT(DATETIME,@cfecproc,101)
   ,      acfecprox   = CONVERT(DATETIME,@cfecprox,101)
   ,      acsw_pd     = '1'
   ,      acsw_cm     = '0'
   ,      acsw_fd     = '0'
   ,      acint_rcc   =  0

   IF EXISTS(SELECT 1 FROM fechas_proceso WHERE fecha = @cfecproc)
      UPDATE FECHAS_PROCESO
      SET    FECHAS_PROCESO.acfecante = MDAC.acfecante
      ,      FECHAS_PROCESO.acfecproc = MDAC.acfecproc
      ,      FECHAS_PROCESO.acfecprox = MDAC.acfecprox 
      FROM   MDAC
      WHERE  fecha = @cfecproc
   ELSE
      INSERT INTO FECHAS_PROCESO
      SELECT @cfecproc
      ,      acfecante
      ,      acfecproc
      ,      acfecprox
      FROM   MDAC

   UPDATE  BACLINEAS..matriz_atribucion_instrumento 
   SET	   Acumulado_Diario = 0
   WHERE   Id_Sistema       = 'BTR'

   SET NOCOUNT OFF
   SELECT 'OK'
   
END



GO
