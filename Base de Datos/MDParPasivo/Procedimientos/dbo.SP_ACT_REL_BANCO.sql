USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_REL_BANCO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_ACT_REL_BANCO](@icodigo_banco NUMERIC(2),		
	 		  	 @idescripcion  CHAR(40) )	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @descripcion_antigua CHAR(40)
	

	IF EXISTS(SELECT Codigo_Relacion_Banco
		  FROM RELACION_BANCO
		  WHERE Codigo_Relacion_Banco = @icodigo_banco)
	
	BEGIN	

              SELECT  @descripcion_antigua= descripcion
	      FROM RELACION_BANCO
              WHERE Codigo_Relacion_Banco = @icodigo_banco
    
              IF @descripcion_antigua <> @idescripcion BEGIN	
	
	           UPDATE RELACION_BANCO
        	   SET descripcion = @idescripcion 
                   WHERE Codigo_Relacion_Banco = @icodigo_banco

                   SELECT "MOD"
	
              END ELSE BEGIN
    
		   SELECT "NO"		

              END		  

	END ELSE BEGIN
	  	
	   INSERT INTO RELACION_BANCO (Codigo_Relacion_Banco 
		  	            ,Descripcion)
		       VALUES	    (@icodigo_banco
     				    ,@idescripcion) 	
           SELECT "SI" 	 
	END
	   

END

GO
