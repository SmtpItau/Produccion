USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CODIGO_TRANSACCION_SWIFT]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_CODIGO_TRANSACCION_SWIFT](
                                                 @Id_Sistema                 CHAR(3)
                                                ,@codigo_producto            CHAR(5)
                                                ,@codigo_transaccion         NUMERIC(3)
                                                ,@glosa_transaccion          CHAR(40)
                                                )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    IF EXISTS( SELECT * FROM CODIGO_TRANSACCION_SWIFT WHERE @Id_Sistema = Id_Sistema AND @codigo_producto = codigo_producto ) BEGIN

        /* ACTUALIZAO */
        UPDATE CODIGO_TRANSACCION_SWIFT
        SET  codigo_transaccion = @codigo_transaccion
            ,glosa_transaccion  = @glosa_transaccion
        WHERE @Id_Sistema = Id_Sistema AND @codigo_producto = codigo_producto
        
    END ELSE BEGIN

        /* INSERTO */
        INSERT CODIGO_TRANSACCION_SWIFT(
                                              Id_Sistema                 
                                             ,codigo_producto   
                                             ,codigo_transaccion
                                             ,glosa_transaccion
                                            )
        VALUES                              (    
                                              @Id_Sistema                 
                                             ,@codigo_producto            
                                             ,@codigo_transaccion         
                                             ,@glosa_transaccion
                                            )
        
    END

END

GO
