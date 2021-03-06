USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_FORMAPAGO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_FORMAPAGO] ( @codigo     NUMERIC (3)  ,
                                       @glosa      CHAR    (30) ,
                                       @perfil     CHAR    (9)  ,
                                       @codgen     NUMERIC (3)  ,
                                       @glosa2     CHAR    (8)  ,
                                       @cc2756     CHAR    (1)  ,
                                       @afectacorr CHAR    (1)  ,
                                       @diasvalor  NUMERIC (3)  ,
                                       @numcheque  CHAR    (1)  ,
                                       @ctacte     CHAR    (1)  )
AS
BEGIN
     IF EXISTS (SELECT codigo FROM FORMA_DE_PAGO WHERE codigo = @codigo )
     BEGIN
          UPDATE Forma_de_Pago
             SET codigo     = @codigo     ,
                 glosa      = @glosa      ,
                 perfil     = @perfil     ,
                 codgen     = @codgen     ,
                 glosa2     = @glosa2     ,
                 cc2756     = @cc2756     ,
                 afectacorr = @afectacorr ,
                 diasvalor  = @diasvalor  ,
                 numcheque  = @numcheque  ,
                 ctacte     = @ctacte
           WHERE codigo = @codigo
          IF @@ERROR <> 0  BEGIN
             SELECT -1, 'Error : No pudo actualizar la Tabla Formas de Pago'
             RETURN 1
          END
     END ELSE BEGIN
          INSERT FORMA_DE_PAGO ( codigo     ,
                        glosa      ,
                        perfil     ,
                        codgen     ,
                        glosa2     ,
                        cc2756     ,
                        afectacorr ,
                        diasvalor  ,
                        numcheque  ,
                        ctacte     )
               VALUES( @codigo     ,
                       @glosa      ,
                       @perfil     ,
                       @codgen     ,
                       @glosa2     ,
                       @cc2756     ,
                       @afectacorr ,
                       @diasvalor  ,
                       @numcheque  ,
                       @ctacte     )
          IF @@ERROR <> 0  BEGIN
             SELECT -1, 'Error : No pudo Insertar la Tabla Formas de Pago'
             RETURN 1
          END
     END
END  -- PROCEDURE
GO
