USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borrar_Codigo_Comercio]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Borrar_Codigo_Comercio]
        (
	      @comercio CHAR(6)
           ,  @borrar   CHAR(1) = 'N'
	)
AS

BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

      IF EXISTS (SELECT 1 FROM   VIEW_PLANILLA_AUTOMATICA  WHERE  codigo_comercio = @comercio)
      BEGIN   
           IF @borrar <> 'S'
           BEGIN
                SELECT -1, 'No es posible eliminar, El código de comercio esta relacionado'
                SET NOCOUNT OFF 
                RETURN
           END
      END

      IF EXISTS (SELECT 1 FROM CONFIGURACION_DE_VALORES WHERE nombre_original_campo = 'codigo_comercio' 
                                                          AND valor_caracter = @comercio
                )


      BEGIN
      
           IF @borrar <> 'S'
           BEGIN
                SELECT -1, 'No es posible eliminar, El código de comercio esta relacionado'
                SET NOCOUNT OFF 
                RETURN
           END

      END



BEGIN TRANSACTION

      IF EXISTS (SELECT 1 FROM   CODIGO_COMERCIO   WHERE  @comercio = comercio) 
      BEGIN

              DELETE FROM CODIGO_COMERCIO
              WHERE @comercio = comercio 


              IF @@ERROR<>0
	      BEGIN
                   ROLLBACK TRANSACTION
	           SELECT -2, 'Error: No puede ser Eliminado'
		   SET NOCOUNT OFF
                   RETURN
              END


      END ELSE
      BEGIN
          ROLLBACK TRANSACTION
          SELECT -3, 'Error: No Existen Códigos'
          SET NOCOUNT OFF
          RETURN
      END

   COMMIT TRANSACTION

   SELECT 0, 'OK'

SET NOCOUNT OFF

END





GO
