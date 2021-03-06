USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_LOG_AUDITORIA]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAR_LOG_AUDITORIA]
       (
        @ENTIDAD               CHAR(2),
        @FECHA_PROCESO         DATETIME,
        @TERMINAL              CHAR(15),
        @USUARIO               CHAR(15),
        @ID_SISTEMA            CHAR(3),
        @CODIGO_MENU           VARCHAR(12),
        @CODIGO_EVENTO         VARCHAR(2),
        @DETALLE_TRANSAC       VARCHAR(250),
        @TABLAINVOLUCRADA      VARCHAR(50),
        @VALOR_ANTIGUO         VARCHAR(250),
        @VALOR_NUEVO           VARCHAR(250)
       )                 
AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET NOCOUNT ON

   IF NOT EXISTS( SELECT * FROM USUARIO WITH (NOLOCK) WHERE usuario = @USUARIO )
   BEGIN
      SELECT 'NO'
      RETURN

   END

   INSERT INTO LOG_AUDITORIA WITH (ROWLOCK) (   
                              entidad,
                              fechaproceso,
                              fechasistema,
                              horaproceso,
                              terminal,
                              usuario,
                              id_sistema,
                              codigomenu,
                              codigo_evento,
                              detalletransac,
                              tablainvolucrada,
                              valorantiguo,
                              valornuevo
                             )
          VALUES             (
                              @ENTIDAD,
                              @FECHA_PROCESO,
                              GETDATE(),                                    -------- FECHA SISTMA
                              CONVERT( VARCHAR(10), GETDATE(), 108 ),       -------- HORA
                              @TERMINAL,
                              @USUARIO,
                              @ID_SISTEMA,
                              @CODIGO_MENU,
                              @Codigo_EVENTO,
                              @DETALLE_TRANSAC,
                              @TABLAINVOLUCRADA,
                              @VALOR_ANTIGUO,
                              @VALOR_NUEVO
                             )

   IF @@error <> 0
   BEGIN
      SELECT 'NO'
      RETURN

   END

   SELECT 'SI'

END



GO
