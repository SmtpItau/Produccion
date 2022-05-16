USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_NOMBRE_CAMPO_CONTABILIDAD]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_NOMBRE_CAMPO_CONTABILIDAD]
                                                        @id_sistema        CHAR(03) = ' '
                                                     ,  @codigo_producto   CHAR(05) = ' '
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

        SELECT descripcion
            ,  nombre_campo
            FROM NOMBRE_CAMPO_CONTABLE
            WHERE (id_sistema      = @id_sistema      OR @id_sistema      = ' ')
              AND (codigo_producto = @codigo_producto OR @codigo_producto = ' ')


END


GO
