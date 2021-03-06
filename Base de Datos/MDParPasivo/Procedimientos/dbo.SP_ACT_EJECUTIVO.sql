USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_EJECUTIVO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_EJECUTIVO](@iRut_Entidad     NUMERIC(10),		
                                 @iCodigo_Entidad  NUMERIC(10),		
                                 @iRut_Ejecutivo   NUMERIC(10),
                                 @iCodigo_Ejecutivo NUMERIC(10),
                                 @iNombre_Ejecutivo CHAR(40),
                                 @Area_Ejecutivo    CHAR(5))	
AS
BEGIN

        SET DATEFORMAT dmy
	
	DECLARE @descripcion_antigua CHAR(40)


	SET NOCOUNT ON	
	
	IF EXISTS(SELECT  Nombre_Ejecutivo
		  FROM EJECUTIVO
		  WHERE Rut_ejecutivo = @irut_ejecutivo
                  AND   codigo_ejecutivo = @icodigo_ejecutivo   )
	
	BEGIN	


            SELECT @descripcion_antigua= Nombre_Ejecutivo
	    FROM EJECUTIVO
	    WHERE Rut_ejecutivo = @irut_ejecutivo
            AND   codigo_ejecutivo = @icodigo_ejecutivo 	

         IF @descripcion_antigua <> @iNombre_Ejecutivo BEGIN		

		   UPDATE EJECUTIVO
		   SET nombre_ejecutivo = @inombre_ejecutivo
                   WHERE Rut_ejecutivo = @irut_ejecutivo
                   AND   codigo_ejecutivo = @icodigo_ejecutivo 	
		
		   SELECT "MOD"
	
          END ELSE BEGIN

		   SELECT "NO"		

      	  END		          
	
	END ELSE BEGIN
	  	
		   INSERT INTO EJECUTIVO   ( Rut_Entidad    ,		
                                             Codigo_Entidad ,		
                                             Rut_Ejecutivo  ,
                                             Codigo_Ejecutivo ,
                                             Nombre_Ejecutivo ,
                                             Area_Ejecutivo    )
			       VALUES	    (@iRut_Entidad    ,		
                                             @iCodigo_Entidad ,		
                                             @iRut_Ejecutivo  ,
                                             @iCodigo_Ejecutivo ,
                                             @iNombre_Ejecutivo ,
                                             @Area_Ejecutivo    ) 	

	   	   SELECT "SI"	

	END
	   

END

GO
