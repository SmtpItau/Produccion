USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_CODIGO_TRANSACCION_SWIFT]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ELI_CODIGO_TRANSACCION_SWIFT](
                                                    @id_sistema         CHAR(3)
                                                   ,@codigo_producto    CHAR(5)
                                                )
AS
BEGIN

    DELETE CODIGO_TRANSACCION_SWIFT
    WHERE    Id_Sistema         = @id_sistema        AND
             codigo_producto    = @codigo_producto


END



GO
