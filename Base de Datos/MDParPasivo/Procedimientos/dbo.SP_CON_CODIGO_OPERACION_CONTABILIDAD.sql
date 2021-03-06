USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CODIGO_OPERACION_CONTABILIDAD]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_CODIGO_OPERACION_CONTABILIDAD](
                                                             @codigo_operacion    CHAR(03) = ' '
                                                            ,@id_sistema          CHAR(03) = ' '
                                                            ,@codigo_producto     CHAR(05) = ' '
                                                          )
AS
BEGIN

        SET NOCOUNT ON
        SET DATEFORMAT dmy

        SELECT       codigo_operacion
                ,    tipo_cuenta
                ,    id_sistema
                ,    codigo_producto
                ,    moneda1
                ,    moneda2
                ,    instrumento
                ,    descripcion
                ,    glosa_corta
                ,    evento
                ,    Relacion_bcch
                ,    Reversa
                ,    mercado
            FROM CODIGO_OPERACION_CONTABLE
            WHERE          (codigo_operacion = @codigo_operacion OR @codigo_operacion = ' ')
                    AND    (id_sistema       = @id_sistema       OR @id_sistema       = ' ')
                    AND    (codigo_producto  = @codigo_producto  OR @codigo_producto  = ' ')
            ORDER BY descripcion

        SET NOCOUNT OFF

END







GO
