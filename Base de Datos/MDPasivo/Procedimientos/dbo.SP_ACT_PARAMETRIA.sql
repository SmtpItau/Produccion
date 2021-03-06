USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_PARAMETRIA]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_PARAMETRIA]( 
                                     @codigo_operacion	char	(3)
                                    ,@concepto_programa	char	(5)
                                    ,@numero_secuencia	int	
                                    ,@tipo_monto	char	(1)
                                    ,@moneda	        int	
                                    ,@centro_origen	char	(4)
                                    ,@centro_destino	char	(4)
                                    ,@concepto_contable	char	(5)
                                    ,@Primero		char	(1)
                                )
AS
BEGIN --- INICIO SP

	SET DATEFORMAT DMY
	SET NOCOUNT ON



    /* VALIDACIONES
    --------------- */
/*
    IF NOT EXISTS( SELECT 1 FROM CODIGO_OPERACION_CONTABLE 
                            WHERE       CODIGO_OPERACION = @codigo_operacion 
                                    AND ID_SISTEMA       = @id_sistema
                                    AND CODIGO_PRODUCTO  = @codigo_producto
                 )
    BEGIN
        SELECT -1 , ' no existe codigo de operacion :' + @codigo_operacion + 
                    ' sistema : ' + @id_sistema +
                    ' codigo de producto : ' + @codigo_producto
        RETURN 
    END
*/

/*
    IF NOT EXISTS( SELECT 1 FROM CONCEPTO_PROGRAMA_CONTABLE
                            WHERE       CONCEPTO_PROGRAMA = @concepto_programa 
                                    AND ID_SISTEMA        = @id_sistema
                                    AND CODIGO_PRODUCTO   = @codigo_producto
                 )
    BEGIN
        SELECT -1 , ' no existe concepto programa :' + @concepto_programa + 
                    ' sistema : ' + @id_sistema +
                    ' codigo de producto : ' + @codigo_producto
        RETURN 
    END

    IF NOT EXISTS( SELECT 1 FROM  CONCEPTO_CONTABLE
                            WHERE CONCEPTO_CONTABLE = @concepto_contable
                 )
    BEGIN
        SELECT -1 , ' no existe concepto contable :' + @concepto_contable 
        RETURN 
    END
*/


    IF @Primero = 'S'
    BEGIN

	DELETE PARAMETRIA_CONTABLE WHERE codigo_operacion <> 'INV'

    END


    IF EXISTS( SELECT 1 FROM PARAMETRIA_CONTABLE WHERE  
                                                        @codigo_operacion  = codigo_operacion    AND
                                                        @concepto_programa = concepto_programa   AND
                                                        @numero_secuencia  = numero_secuencia
             ) BEGIN

        UPDATE PARAMETRIA_CONTABLE
        SET    concepto_programa    = @concepto_programa   
              ,numero_secuencia     = @numero_secuencia    
              ,tipo_monto	    = @tipo_monto	    
              ,moneda	            = @moneda	            
              ,centro_origen	    = @centro_origen	    
              ,centro_destino	    = @centro_destino	    
              ,concepto_contable    = @concepto_contable
        WHERE 
               @codigo_operacion    = codigo_operacion    AND
               @concepto_programa   = concepto_programa   AND
               @numero_secuencia    = numero_secuencia

    END ELSE BEGIN        
        
        INSERT PARAMETRIA_CONTABLE(
                                     codigo_operacion	
                                    ,concepto_programa	
                                    ,numero_secuencia	
                                    ,tipo_monto	        
                                    ,moneda	        
                                    ,centro_origen	
                                    ,centro_destino	
                                    ,concepto_contable	
                                  )        
        VALUES(
                                     @codigo_operacion	
                                    ,@concepto_programa	
                                    ,@numero_secuencia	
                                    ,@tipo_monto	        
                                    ,@moneda	        
                                    ,@centro_origen	
                                    ,@centro_destino	
                                    ,@concepto_contable	
                )        
        
    END

    SELECT 0 , 'OK'

END ------FIN SP

GO
