USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_BASE]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_TIPO_BASE]	(@icodigo_base	       NUMERIC(5),		
					 @idescripcion	       CHAR(40) ,
					 @ibase		       CHAR(3)  ,
					 @isistema	       CHAR(3))	
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @descripcion_antigua CHAR(40)

	IF EXISTS(SELECT codigo_base
		  FROM TIPO_BASE
		  WHERE Codigo_base = @icodigo_base
		  AND	id_sistema  = @isistema )
	
	BEGIN	

	           UPDATE TIPO_BASE
        	   SET descripcion = @idescripcion 
	               ,base	   = @ibase	
        	   WHERE Codigo_base = @icodigo_base
	           AND	 id_sistema  = @isistema

                   SELECT 'MOD'

	
	END 
	ELSE 
	BEGIN
	  	
	   INSERT INTO TIPO_BASE 	 ( Codigo_base 
			  	          ,Descripcion
					  ,base
					  ,id_sistema)

		       VALUES		 ( @icodigo_base
					  ,@idescripcion
					  ,@ibase	
					  ,@isistema	) 	
            SELECT 'SI' 
	
	END
	   

END

GO
