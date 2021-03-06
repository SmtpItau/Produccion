USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_RELACION_CURVA]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_RELACION_CURVA](@iSistema            CHAR(3),
                                      @iCodigo_Producto    CHAR(5),
                                      @iTipo_Operacion     CHAR(1),
                                      @iCodigo_Instrumento NUMERIC(5),
                                      @iCodigo_Moneda1     NUMERIC(3),
                                      @iCodigo_Moneda2     NUMERIC(3),
                                      @iRut_Emisor         NUMERIC(9),
                                      @iCodigo_Emisor      NUMERIC(5)  
 				     )  
AS
BEGIN

        SET NOCOUNT ON
        SET DATEFORMAT dmy
        
        DELETE RELACION_CURVA
        WHERE  Id_Sistema         = @iSistema
        AND    Codigo_Producto    = @iCodigo_Producto
        AND    Tipo_Operacion     = @iTipo_Operacion
        AND    Codigo_Instrumento = @iCodigo_Instrumento
        AND    Codigo_Moneda1     = @iCodigo_Moneda1
        AND    Codigo_Moneda2     = @iCodigo_Moneda2
        AND    Rut_Emisor         = @iRut_Emisor
        AND    Codigo_Emisor      = @iCodigo_Emisor                

END




GO
