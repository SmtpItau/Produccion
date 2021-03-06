USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CreaPasoInterfazSerie]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_CreaPasoInterfazSerie]
               ( @Terminal   CHAR(20)   
               , @CREA       CHAR(1)    )

AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


   IF @CREA = 'N' BEGIN

      IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = 'CARTA_INTERFAZ_SERIE' ) BEGIN

         DELETE FROM CARGA_INTERFAZ_SERIE WHERE @Terminal = @Terminal

         IF NOT EXISTS (SELECT 1 FROM CARGA_INTERFAZ_SERIE ) BEGIN

            DROP TABLE CARGA_INTERFAZ_SERIE 

         END 

      END

      RETURN

   END


   IF @CREA = 'S' AND EXISTS ( SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = 'CARGA_INTERFAZ_SERIE' ) BEGIN

      DELETE FROM CARGA_INTERFAZ_SERIE WHERE Terminal = @Terminal

   END

   IF NOT EXISTS ( SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = 'CARGA_INTERFAZ_SERIE' ) BEGIN


      CREATE TABLE CARGA_INTERFAZ_SERIE
      (   Serie           CHAR(12)   
      ,   emisor          NUMERIC(9)      NOT NULL DEFAULT(0)
      ,   fecha_emision   DATETIME        NOT NULL DEFAULT('')
      ,   tasa_emision    NUMERIC(10,4)   NOT NULL DEFAULT('')
      ,   tasa_real       NUMERIC(10,4)   NOT NULL DEFAULT('')
      ,   UM              CHAR(10)        NOT NULL DEFAULT('')
      ,   BASE            NUMERIC(5)      NOT NULL DEFAULT('')
      ,   Numero_Cupones  NUMERIC(5)      NOT NULL DEFAULT('')
      ,   Perido_Pago     NUMERIC(5)      NOT NULL DEFAULT('')
      ,   Estado          CHAR(10)        NOT NULL DEFAULT('')
      ,   Terminal        CHAR(20)        NOT NULL DEFAULT('')
      )



   END

   SET NOCOUNT OFF

END





GO
