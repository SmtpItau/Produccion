USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_FORMAPAGO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_FORMAPAGO]
   (   @codigo        NUMERIC(3)
   ,   @glosa         CHAR(30)
   ,   @perfil        CHAR(9)
   ,   @codgen        NUMERIC(3)
   ,   @glosa2        CHAR(8)
   ,   @cc2756        CHAR(1)
   ,   @afectacorr    CHAR(1)
   ,   @diasvalor     NUMERIC(3)
   ,   @numcheque     CHAR(1)
   ,   @ctacte        CHAR(1)
   ,   @DiasLineas    INTEGER
   ,   @CodigoBolsa   int
   )
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS(SELECT 1 FROM FORMA_DE_PAGO WHERE codigo = @codigo)
   BEGIN
      UPDATE FORMA_DE_PAGO
      SET    glosa         = @glosa
      ,      perfil        = @perfil
      ,      codgen        = @codgen
      ,      glosa2        = @glosa2
      ,      cc2756        = @cc2756
      ,      afectacorr    = @afectacorr
      ,      diasvalor     = @diasvalor
      ,      numcheque     = @numcheque
      ,      ctacte        = @ctacte
      ,      DiasLineas    = @DiasLineas
      ,      CodigoBolsa   = @CodigoBolsa
      WHERE  codigo        = @codigo

      IF @@ERROR <> 0
      BEGIN
         SELECT -1, 'Error : No pudo actualizar la Tabla Formas de Pago'
         RETURN 1
      END

   END ELSE 
   BEGIN
      
      INSERT INTO FORMA_DE_PAGO
      (   codigo        ,   glosa       ,   perfil     ,   codgen     ,   glosa2   
      ,   cc2756        ,   afectacorr  ,   diasvalor  ,   numcheque  ,   ctacte
      ,   DiasLineas    ,   CodigoBolsa 
      )
      VALUES
      (   @codigo       ,   @glosa      ,   @perfil    ,   @codgen    ,   @glosa2
      ,   @cc2756       ,   @afectacorr ,   @diasvalor ,   @numcheque ,   @ctacte
      ,   @DiasLineas   ,   @CodigoBolsa
      )

      IF @@ERROR <> 0  
      BEGIN
         SELECT -1, 'Error : No pudo Insertar la Tabla Formas de Pago'
         RETURN 1
      END

   END

   SELECT 0 , 'Proceso de actualización de medios de pagos ha finalizado correctamente.'

END
GO
