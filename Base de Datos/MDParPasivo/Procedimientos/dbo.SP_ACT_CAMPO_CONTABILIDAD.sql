USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CAMPO_CONTABILIDAD]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACT_CAMPO_CONTABILIDAD]
                                                 @codigo_concepto        CHAR(05)
                                            ,    @id_sistema             CHAR(03)
                                            ,    @codigo_producto        CHAR(05)
                                            ,    @descripcion            CHAR(50)
                                            ,    @nombre_campo           CHAR(50)
                                            ,    @negativo               CHAR(01)
AS
BEGIN


	SET DATEFORMAT DMY
	SET NOCOUNT ON


    IF EXISTS(SELECT 1 FROM CONCEPTO_PROGRAMA_CONTABLE WHERE concepto_programa = @codigo_concepto
                                                        AND  id_sistema      = @id_sistema
                                                        AND  codigo_producto = @codigo_producto)
            UPDATE CONCEPTO_PROGRAMA_CONTABLE SET descripcion = @descripcion
                                                , negativo    = @negativo
                                                , nombre_campo= @nombre_campo
                                            WHERE concepto_programa   = @codigo_concepto
                                              AND id_sistema          = @id_sistema
                                              AND codigo_producto     = @codigo_producto
    ELSE
            INSERT CONCEPTO_PROGRAMA_CONTABLE(
                                                 id_sistema
                                            ,    codigo_producto
                                            ,    concepto_programa
                                            ,    descripcion
                                            ,    negativo
                                            ,    nombre_campo
                                          )
                                   VALUES(
                                                 @id_sistema
                                            ,    @codigo_producto
                                            ,    @codigo_concepto
                                            ,    @descripcion
                                            ,    @negativo
                                            ,    @nombre_campo
                                         )
END




GO
