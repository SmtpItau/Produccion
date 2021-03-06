USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CODIGO_OPERACION_CONTABLE]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_CODIGO_OPERACION_CONTABLE]( 
                                                 @id_sistema            char    (3)
                                                ,@producto              char    (5)
                                                ,@evento                char    (3)                                                
                                                ,@codigo_operacion      char	(3)
                                                ,@descripcion	        char	(50)
                                            )
AS
BEGIN --- INICIO SP

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    /* VALIDACIONES
    --------------- */
    IF NOT EXISTS( SELECT 1 FROM SISTEMA WHERE id_sistema = @id_sistema)
    BEGIN
        SELECT -1 , 'no existe sistema : ' + @id_sistema
        RETURN
    END

    IF NOT EXISTS( SELECT 1 FROM PRODUCTO WHERE Codigo_Producto = @producto
                                            AND id_sistema = @id_sistema
                  )
    BEGIN
        SELECT -1 , 'no existe producto : ' + @producto +
                    'sistema : ' + @id_sistema
        RETURN
    END

    IF NOT EXISTS( SELECT 1 FROM EVENTO_CONTABLE WHERE Codigo_evento = @evento )
    BEGIN
        SELECT -1 , 'no existe evento contable : ' + @evento
        RETURN
    END

    IF NOT EXISTS( SELECT * FROM CODIGO_OPERACION_CONTABLE
                           WHERE   codigo_operacion  = @codigo_operacion
                           AND     id_sistema        = @id_sistema
                           AND     codigo_producto   = @producto

                 ) BEGIN

        INSERT CODIGO_OPERACION_CONTABLE(
                                                 id_sistema            
                                                ,codigo_producto
                                                ,evento                
                                                ,codigo_operacion      
                                                ,descripcion	      
                                        )
        VALUES(
                                                 @id_sistema            
                                                ,@producto              
                                                ,@evento                
                                                ,@codigo_operacion      
                                                ,@descripcion	        
              )
        
    END

    SELECT 0 , 'OK'

END ------FIN SP
GO
