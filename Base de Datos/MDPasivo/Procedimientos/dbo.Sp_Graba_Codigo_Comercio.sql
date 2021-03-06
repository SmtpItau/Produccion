USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Codigo_Comercio]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Graba_Codigo_Comercio]
         (
	    	@COMERCIO  	    CHAR(6)
	   ,	@GLOSA     	    VARCHAR( 60)
           ,    @TIPO_DOCUMENTO     NUMERIC(3)
           ,    @CODIGO_OMA         NUMERIC(3)
           ,    @TIP_REGISTRO       CHAR(3)
           ,    @COD_VALIDACION     VARCHAR(100)
         )
AS
BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy

   BEGIN TRANSACTION

   IF NOT EXISTS ( SELECT comercio
                   FROM   CODIGO_COMERCIO 
		   WHERE  comercio    = @COMERCIO 
                  )
   BEGIN

	  PRINT '<< INSERTANDO ... >>'

   	  INSERT CODIGO_COMERCIO
                  (
                     codigo_oma
                  ,  comercio
                  ,  tipo_documento
                  ,  tipo_registro
                  ,  codigo_validacion

                  )  
         VALUES
                  (
                     @CODIGO_OMA
                  ,  @COMERCIO
                  ,  @TIPO_DOCUMENTO
                  ,  @TIP_REGISTRO
                  ,  @COD_VALIDACION

                  )

          IF @@error<>0
          BEGIN
            ROLLBACK TRANSACTION
            SELECT 'NO INSERT'
            RETURN
          END

   END


  PRINT '<< ACTUALIZANDO ...>>'

  UPDATE CODIGO_COMERCIO
  SET    glosa              = (CASE WHEN @GLOSA = '' THEN glosa
                                    ELSE @GLOSA           
                               END)
  ,      tipo_documento     = (CASE WHEN @TIPO_DOCUMENTO  =  0 THEN tipo_documento
                                    ELSE @TIPO_DOCUMENTO  
                               END)
  ,      codigo_OMA         = (CASE WHEN @CODIGO_OMA      =  0 THEN codigo_OMA
                                    ELSE @CODIGO_OMA      
                               END)
  ,     tipo_registro       =  @TIP_REGISTRO
  ,     codigo_validacion   =  @COD_VALIDACION
  WHERE comercio            =  @comercio

         IF @@error<>0
         BEGIN
             ROLLBACK TRANSACTION
             SELECT 'NO UPDATE'
             RETURN
         END

   COMMIT TRANSACTION
   SELECT 'OK'

SET NOCOUNT OFF
END




GO
