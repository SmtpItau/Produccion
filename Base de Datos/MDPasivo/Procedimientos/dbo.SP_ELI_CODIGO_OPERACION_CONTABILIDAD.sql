USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_CODIGO_OPERACION_CONTABILIDAD]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ELI_CODIGO_OPERACION_CONTABILIDAD]
                                                            @codigo_operacion    CHAR(03)
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    IF NOT EXISTS(SELECT 1 FROM PERFIL_CONTABILIDAD WHERE codigo_operacion = @codigo_operacion)
        DELETE CODIGO_OPERACION_CONTABILIDAD
                        WHERE codigo_operacion = @codigo_operacion
    ELSE
        SELECT -1,'Registro esta relacionado'


END
GO
