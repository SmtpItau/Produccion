USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_OMA]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Graba_OMA]
      (       
            @codigo      NUMERIC(10)
       ,    @glosa       CHAR(50)
       ,    @tipope      CHAR(10)
      )

AS
BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy

   IF NOT EXISTS ( SELECT  codigo_numerico 
                   FROM    CODIGO_OMA
                   WHERE   codigo_numerico = @codigo 
                 ) 
   BEGIN

	 INSERT INTO CODIGO_OMA
            ( 
               codigo_numerico
            ,  codigo_caracter
            ,  glosa
            )
         VALUES            
            (         
               @codigo
            ,  @tipope
            ,  @glosa
            )

	 SELECT 'OK'
 	 RETURN

   END ELSE 
   BEGIN
   
         UPDATE CODIGO_OMA
         SET    codigo_numerico = @codigo
         ,      codigo_caracter = @tipope
         ,      glosa           = @glosa
         WHERE  codigo_numerico = @codigo   

   END

   SELECT 'OK'

SET NOCOUNT OFF

END






GO
