USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEERVALORES_DEFECTO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEERVALORES_DEFECTO]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	Origen		 = vd.Origen
	,		GlosaOrigen	 = me.Descripcion
	,		Mercado		 = vd.Mercado
	,		GlosaMercado = pe.Producto
	FROM	BacParamSuda.dbo.SADP_VALORDEFAULT						vd
			INNER JOIN BacParamSuda.dbo.SADP_MODULOS_EXTERNOS		me ON me.Nemo = vd.Origen
			LEFT  JOIN BacParamSuda.dbo.SADP_PRODUCTO_MODULOEXTERNO pe ON me.Nemo = pe.Modulo AND vd.Mercado = pe.Producto
	ORDER BY vd.Origen, vd.Mercado, vd.Moneda, vd.Forma_Pago
	
END 
GO
