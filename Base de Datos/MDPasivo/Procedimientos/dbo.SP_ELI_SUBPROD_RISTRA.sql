USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_SUBPROD_RISTRA]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELI_SUBPROD_RISTRA]
                                            @isistema           CHAR(03)
                                          , @icodigo_producto   CHAR(05)
                                          , @inumero_condicion  NUMERIC(05)
AS

    DELETE CONDICION_SUBPRODUCTO WHERE id_sistema      = @isistema
                                   AND codigo_producto = @icodigo_producto
                                   AND numero_condicion= @inumero_condicion


GO
