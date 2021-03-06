USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CODIGO_OPERACION_CONTABILIDAD]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACT_CODIGO_OPERACION_CONTABILIDAD]
                                                             @codigo_operacion       CHAR(03)
                                                        ,    @tipo_cuenta            CHAR(01)
                                                        ,    @id_sistema             CHAR(03)
                                                        ,    @codigo_producto        CHAR(05)
                                                        ,    @moneda1                NUMERIC(03)
                                                        ,    @moneda2                NUMERIC(03)
                                                        ,    @instrumento            NUMERIC(05)
                                                        ,    @descripcion            CHAR(80)
                                                        ,    @glosa_corta            CHAR(15)
                                                        ,    @evento                 CHAR(3)
                                                        ,    @relacion_bcch          NUMERIC(1)
                                                        ,    @reversa                NUMERIC(1)
                                                        ,    @mercado                NUMERIC(1)
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

   
        IF EXISTS(SELECT 1 FROM CODIGO_OPERACION_CONTABLE
                                WHERE          codigo_operacion = @codigo_operacion
                                        AND    id_sistema       = @id_sistema
                                        AND    codigo_producto  = @codigo_producto
                 )
                    
                    UPDATE CODIGO_OPERACION_CONTABLE SET 
                                                                 tipo_cuenta     = @tipo_cuenta
                                                            ,    id_sistema      = @id_sistema
                                                            ,    codigo_producto = @codigo_producto
                                                            ,    moneda1         = @moneda1
                                                            ,    moneda2         = @moneda2
                                                            ,    instrumento     = @instrumento
                                                            ,    descripcion     = @descripcion
                                                            ,    glosa_corta     = @glosa_corta
                                                            ,    evento          = @evento
                                                            ,    relacion_bcch   = @relacion_bcch
                                                            ,    reversa         = @reversa
                                                            ,    mercado         = @mercado
                                WHERE          codigo_operacion = @codigo_operacion
                                        AND    id_sistema       = @id_sistema
                                        AND    codigo_producto  = @codigo_producto

        ELSE
                    INSERT CODIGO_OPERACION_CONTABLE(
                                                                 codigo_operacion
                                                        ,        tipo_cuenta
                                                        ,        id_sistema
                                                        ,        codigo_producto
                                                        ,        moneda1
                                                        ,        moneda2
                                                        ,        instrumento
                                                        ,        descripcion
                                                        ,        glosa_corta
                                                        ,        evento
                                                        ,        relacion_bcch
                                                        ,        reversa            
                                                        ,        mercado
                                                        )
                                                VALUES  (
                                                                 @codigo_operacion
                                                        ,        @tipo_cuenta
                                                        ,        @id_sistema
                                                        ,        @codigo_producto
                                                        ,        @moneda1
                                                        ,        @moneda2
                                                        ,        @instrumento
                                                        ,        @descripcion
                                                        ,        @glosa_corta
                                                        ,        @evento
                                                        ,        @relacion_bcch
                                                        ,        @reversa
                                                        ,        @mercado
                                                        )
END




GO
