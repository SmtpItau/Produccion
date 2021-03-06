USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tributarios_LeeCriterios]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Tributarios_LeeCriterios]
AS
BEGIN

	SET NOCOUNT ON

	SELECT	Id				=	 Criterio.oId
		,	Origen			=	 Criterio.oOrigen
		,	Producto		=	 Criterio.oProducto
		,	TipoOperacion   =	 Criterio.oTipOperacion
		,	Moneda			=	 Criterio.oMoneda
		,	GlProducto		=	 Producto.descripcion 
							+	 CASE	WHEN Criterio.oCartera = 'C' THEN ' DE COBERTURA'
										ELSE ''
									END
		,	GlTipoOperacion =	 CASE WHEN Criterio.oTipOperacion = 'C' THEN 'COMPRA' 
									  WHEN Criterio.oTipOperacion = 'V' THEN 'VENTA' 
									  ELSE ''
								 END
		,	GlMoneda		=	 Criterio.oMoneda
	FROM	BacParamSuda.dbo.TBL_TRIBUTARIOS_CRITERIOS Criterio with(nolock)
			inner join ( select  Id_Sistema, codigo_producto = case		when codigo_producto = 'ST' then 1
																		when codigo_producto = 'SM' then 2
																		when codigo_producto = 'FR' then 3
																		when codigo_producto = 'SP' then 4 end ,	descripcion
						   from  BacParamSuda.dbo.Producto with(nolock)
						  where  Id_Sistema = 'pcs'
								 union
						 select  Id_Sistema, codigo_producto, descripcion
						   from  BacParamSuda.dbo.Producto with(nolock)
						  where  Id_Sistema = 'bfw'
								 union
						 select  'BFW', 15, 'FORWARD ASIATICO' union
						 select	 Id_Sistema, codigo_producto = case	when codigo_producto = 'ST' then 1
																	when codigo_producto = 'SM' then 2
																	when codigo_producto = 'FR' then 3
																	when codigo_producto = 'SP' then 4 end,	descripcion
						   from	 BacParamSuda.dbo.Producto with(nolock)
						  where	 Id_Sistema = 'pcs'
								 union

						  select  'OPT' ,	1 ,	'COMPRA CALL'		union 
						  select  'OPT' ,	2 ,	'VENTA  CALL'		union 
						  select  'OPT' ,	3 ,	'COMPRA PUT'		union 
						  select  'OPT' ,	4 ,	'VENTA  PUT'		union
						  select  'OPT' ,	15,	'FORMARD AMERICANO' union
						  select  'OPT' ,	17,	'FORMARD ASIATICOS' union
						  select  'OPT' ,	13,	'FORMARD ASIATICOS E/S'
						  ) Producto ON Producto.Id_Sistema		= Criterio.oOrigen 
									and Producto.codigo_producto = Criterio.oProducto
	ORDER BY	Criterio.oOrigen
			,	Criterio.oProducto
			,	Criterio.oMoneda
			,	Criterio.oTipOperacion

END
GO
