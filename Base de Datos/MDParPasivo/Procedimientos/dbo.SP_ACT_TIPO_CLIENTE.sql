USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_TIPO_CLIENTE]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ACT_TIPO_CLIENTE](@icodigo_tipo_cliente 	NUMERIC(5)	,
			  	    @idescripcion	        CHAR(40) 	,
				    @codigo_clasificacion_SBIF  numeric(2) = 0  ,
				    @descripcion_SBIF		char(40) = ' '	)
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @descripcion_antigua CHAR(40),
                @codigo_sbif   NUMERIC(2),
                @des_sbif      CHAR(40)    
	
	IF EXISTS(SELECT codigo_tipo_cliente
		  FROM TIPO_CLIENTE
		  WHERE codigo_tipo_cliente = @icodigo_tipo_cliente)
	
	BEGIN	

          SELECT @descripcion_antigua= descripcion,
                @codigo_sbif   = Codigo_Cliente_SBIF,
                @des_sbif      =descripcion_cliente_sbif
	  FROM TIPO_CLIENTE
	  WHERE codigo_tipo_cliente = @icodigo_tipo_cliente

          IF @descripcion_antigua <> @idescripcion OR @codigo_sbif <> @codigo_clasificacion_SBIF OR @des_sbif <> @descripcion_SBIF BEGIN	
	
	       UPDATE TIPO_CLIENTE
    	       SET  descripcion              = @idescripcion 
		   ,Codigo_Cliente_SBIF      = @codigo_clasificacion_SBIF
   		   ,Descripcion_Cliente_SBIF = @descripcion_SBIF
        

    	       WHERE codigo_tipo_cliente = @icodigo_tipo_cliente

               SELECT 'MOD'
	
          END ELSE BEGIN
    
  	       SELECT 'NO'		

          END	
	END ELSE BEGIN
	  	
	   INSERT INTO TIPO_CLIENTE (codigo_tipo_cliente
 		  	            ,Descripcion
				    ,Codigo_Cliente_SBIF
				    ,Descripcion_Cliente_SBIF)
		       VALUES	    (@icodigo_tipo_cliente
 				    ,@idescripcion
				    ,@codigo_clasificacion_SBIF
				    ,@descripcion_SBIF) 	
            SELECT 'SI' 	
	END
	   

END
GO
