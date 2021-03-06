USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_CAMPO_CONTABILIDAD]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELI_CAMPO_CONTABILIDAD]
                                                 @codigo_concepto        CHAR(05)
                                            ,    @id_sistema             CHAR(03)
                                            ,    @codigo_producto        CHAR(05)
AS
BEGIN

   SET DATEFORMAT dmy

    IF NOT EXISTS(SELECT 1 FROM PERFIL_CONTABILIDAD WHERE codigo_concepto = @codigo_concepto 
                                                      AND id_sistema      = @id_sistema 
                                                      AND codigo_producto = @codigo_producto)
            DELETE CAMPO_CONTABILIDAD
                   WHERE codigo_concepto = @codigo_concepto
                     AND id_sistema      = @id_sistema
                     AND codigo_producto = @codigo_producto
    ELSE
        SELECT -1,'Registro esta relacionado'



END

GO
