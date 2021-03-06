USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_RELACION_CURVA]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_RELACION_CURVA](
	@iSistema CHAR(3),
	@idProducto CHAR(4)

)
AS
BEGIN
SET 	


        SET NOCOUNT ON
        SET DATEFORMAT dmy
                
        SELECT Id_Sistema,
               Codigo_Producto,
               Tipo_Operacion,
               Codigo_Instrumento,
               Codigo_Moneda1,
               Codigo_Moneda2,
               Rut_Emisor,
               Codigo_Emisor,
               ISNULL(emnombre,''), 
               Codigo_Curva,
               plazo_desde,
               plazo_hasta,
	       Evento,
	       Defecto,
               Rango_por,
               Area
        FROM RELACION_CURVA,EMISOR
        WHERE rut_emisor 	*= emrut 
        AND   codigo_emisor 	*= emcodigo 
        AND   id_sistema 	=  @isistema
	and   Codigo_Producto 	=  @idProducto
        ORDER BY Id_Sistema,
                 Codigo_Producto,
                 Tipo_Operacion,
                 Codigo_Instrumento,
                 Codigo_Moneda1,
                 Codigo_Moneda2,
                 Rut_Emisor,
                 Codigo_Emisor,
                 Evento,    
                 area

END











GO
