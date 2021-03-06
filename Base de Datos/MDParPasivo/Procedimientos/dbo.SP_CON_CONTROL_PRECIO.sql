USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CONTROL_PRECIO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_CONTROL_PRECIO]
                                            @cId_Sistema            CHAR(03)
                                        ,   @cCodigo_Producto       CHAR(05)
                                        ,   @cCodigo_Subproducto    CHAR(15)
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

        SELECT   spread_minimo
            ,    spread_maximo
            FROM CONTROL_PRECIO
            WHERE id_sistema         = @cId_Sistema
              AND codigo_producto    = @cCodigo_Producto
              AND codigo_subproducto = @cCodigo_SubProducto

END
GO
