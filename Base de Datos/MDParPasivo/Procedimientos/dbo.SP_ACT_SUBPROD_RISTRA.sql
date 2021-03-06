USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_SUBPROD_RISTRA]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACT_SUBPROD_RISTRA]
                                            @isistema                CHAR(03)
                                          , @icodigo_producto        CHAR(05)
                                          , @inumero_condicion       NUMERIC(05)
                                          , @icodigo_campo           CHAR(05)
                                          , @iorden_campo            NUMERIC(05)
                                          , @valor_campo             VARCHAR(255)
                                          , @campo_atributo          CHAR(20)
                                          , @codigo_utilizacion      VARCHAR(15)
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


        IF EXISTS(SELECT 1 FROM CONDICION_SUBPRODUCTO WHERE id_sistema      = @isistema 
                                                        AND codigo_producto = @icodigo_producto
                                                        AND numero_condicion= @inumero_condicion
                                                        AND codigo_campo    = @icodigo_campo)

                UPDATE CONDICION_SUBPRODUCTO SET orden_campo        = @iorden_campo
                                            ,    valor_campo        = @valor_campo
                                            ,    codigo_utilizacion = @codigo_utilizacion
                                            ,    campo_atributo     = @campo_atributo
                                        WHERE id_sistema      = @isistema 
                                          AND codigo_producto = @icodigo_producto
                                          AND numero_condicion= @inumero_condicion
                                          AND codigo_campo    = @icodigo_campo
        ELSE

                INSERT CONDICION_SUBPRODUCTO(
                                                 id_sistema
                                            ,    codigo_producto
                                            ,    numero_condicion
                                            ,    codigo_campo
                                            ,    orden_campo
                                            ,    valor_campo
                                            ,    campo_atributo
                                            ,    codigo_utilizacion
                                            )
                                VALUES      (    
                                                 @isistema
                                            ,    @icodigo_producto
                                            ,    @inumero_condicion
                                            ,    @icodigo_campo
                                            ,    @iorden_campo
                                            ,    @valor_campo
                                            ,    @campo_atributo
                                            ,    @codigo_utilizacion
                                            )

END
GO
