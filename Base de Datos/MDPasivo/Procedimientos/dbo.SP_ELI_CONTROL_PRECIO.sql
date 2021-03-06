USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_CONTROL_PRECIO]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELI_CONTROL_PRECIO]
                                            @cId_Sistema            CHAR(03)
                                        ,   @cCodigo_Producto       CHAR(05)
                                        ,   @cCodigo_Subproducto    CHAR(15)
AS
BEGIN

   SET DATEFORMAT dmy

        DELETE FROM CONTROL_PRECIO WHERE id_sistema         = @cId_Sistema
                                     AND codigo_producto    = @cCodigo_Producto
                                     AND codigo_subproducto = @cCodigo_Subproducto

END

GO
