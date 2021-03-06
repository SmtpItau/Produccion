USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ListadoMdasProductos]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE PROCEDURE [dbo].[Sp_ListadoMdasProductos]
AS
BEGIN

     SET NOCOUNT ON

	SELECT	'producto' 	= mpproducto									,
		'nombre'	= descripcion									,
		'codigoC'	= ISNULL( (SELECT mnnemo FROM MONEDA WHERE mpcodigo = mncodmon ) , "N/E" )	,	
		'codigoL'	= ISNULL( (SELECT mnglosa FROM MONEDA WHERE mpcodigo = mncodmon) , "N/E" )	,
		'estado'	= mpestado									,  
		'sistema'	= mpsistema									,	
		'hora'		= CONVERT(varchar(10), GETDATE(), 108),
                'nombreentidad' = (SELECT rcnombre FROM entidad)           
       	FROM 	PRODUCTO_MONEDA	,
		PRODUCTO
	WHERE 	mpproducto <> 0		AND
		codigo_producto = mpproducto
	ORDER BY producto,sistema

END




-- SELECT * FROM PRODUCTO_MONEDA where mpproducto = 30 and mpsistema = 'BFW'
-- SELECT * FROM PRODUCTO
-- DELETE PRODUCTO_MONEDA where mpproducto = 30 and mpsistema = 'BFW'











GO
