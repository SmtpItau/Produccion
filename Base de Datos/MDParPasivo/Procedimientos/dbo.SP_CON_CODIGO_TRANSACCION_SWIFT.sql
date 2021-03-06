USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CODIGO_TRANSACCION_SWIFT]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CON_CODIGO_TRANSACCION_SWIFT](
                                                    @id_sistema         CHAR(3)
                                                   ,@codigo_producto    CHAR(5)
                                                )
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

    SELECT   
             Id_Sistema 
            ,codigo_producto 
            ,codigo_transaccion 
            ,glosa_transaccion 
    FROM CODIGO_TRANSACCION_SWIFT
    WHERE   Id_Sistema      = @id_sistema        AND
            codigo_producto = @codigo_producto

END
GO
