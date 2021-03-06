USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_Margen_Inv_Inst]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Grabar_Margen_Inv_Inst]
         (
             @cartera         NUMERIC(9)
         ,   @sistema         CHAR(3)
         ,   @instrumento     CHAR(10)   
         ,   @codigo_moneda   CHAR(5)
         ,   @emisor          CHAR(10)
         ,   @por_asignado    NUMERIC(8,4)
         ,   @por_adicional   NUMERIC(8,4)
         ,   @por_utilizado   NUMERIC(8,4)
         ,   @totalasignado   NUMERIC(19,4)
         ,   @totaladicional  NUMERIC(19,4)
         ,   @totalocupado    NUMERIC(19,4)
         ,   @totaldisponible NUMERIC(19,4)
         ,   @totalexeso      NUMERIC(19,4)

         )

AS

SET DATEFORMAT DMY

DECLARE 
         @instrum NUMERIC(3)
        ,@mon     NUMERIC(5)
        ,@emi     NUMERIC(10)

BEGIN 
        SELECT
         @instrum = (SELECT incodigo  FROM INSTRUMENTO WHERE inserie   = @instrumento  )
       , @mon     = (SELECT mncodmon  FROM MONEDA      WHERE mnsimbol  = @codigo_moneda)
       , @emi     = (SELECT emrut     FROM EMISOR      WHERE emgeneric = @emisor )


  SET NOCOUNT ON

   IF EXISTS (SELECT instrumento FROM MARGEN_INVERSION_INSTRUMENTO WHERE instrumento  =  @instrum
                                                                  AND rut_cartera     =  @cartera
                                                                  AND id_sistema      =  @sistema )                             
   BEGIN                                                                     


   UPDATE MARGEN_INVERSION_INSTRUMENTO
    SET 
             rut_cartera          = @cartera
         ,   id_sistema           = @sistema
         ,   instrumento          = @instrum
         ,   codigo_moneda        = @mon
         ,   rut_emisor           = @emi
         ,   porcentaje_asignado  = @por_asignado
         ,   porcentaje_adicional = @por_adicional
         ,   porcentaje_utilizado = @por_utilizado
         ,   totalasignado        = @totalasignado
         ,   totaladicional       = @totaladicional
         ,   totalocupado         = @totalocupado
         ,   totaldisponible      = @totaldisponible 
         ,   totalexceso          = @totalexeso

   FROM  MARGEN_INVERSION_INSTRUMENTO
   WHERE instrumento = @instrum 
   AND   rut_cartera = @cartera
   AND   id_sistema =@sistema

   END ELSE
   BEGIN

   INSERT  MARGEN_INVERSION_INSTRUMENTO
         (
             rut_cartera
         ,   id_sistema   
         ,   instrumento
         ,   codigo_moneda
         ,   rut_emisor
         ,   porcentaje_asignado
         ,   porcentaje_adicional
         ,   porcentaje_utilizado
         ,   totalasignado
         ,   totaladicional
         ,   totalocupado
         ,   totaldisponible
         ,   totalexceso 
         )           

   VALUES
         (
             @cartera       
         ,   @sistema       
         ,   @instrum   
         ,   @mon   
         ,   @emi          
         ,   @por_asignado    
         ,   @por_adicional   
         ,   @por_utilizado    
         ,   @totalasignado   
         ,   @totaladicional
         ,   @totalocupado    
         ,   @totaldisponible 
         ,   @totalexeso
         )
END
SET NOCOUNT OFF
END

--sp_help margen_inversion_instrumento
--select * from margen_inversion_instrumento
--select * from instrumento
--delete margen_inversion_instrumento where instrumento=0










GO
