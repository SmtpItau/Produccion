USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_PRODUCTOS_DERIVADOS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_PRODUCTOS_DERIVADOS]
	(	@Id_Sistema			VARCHAR(3)
	
	)	
AS
BEGIN
	SET NOCOUNT ON
		SELECT CASE WHEN Codigo_Producto ='ST'THEN '1'
					WHEN Codigo_Producto ='SM'THEN '2'
					WHEN Codigo_Producto ='FR'THEN '3'
					WHEN Codigo_Producto ='SP'THEN '4' ELSE RTRIM(LTRIM(Codigo_Producto))
				END AS Producto
		,		Descripcion
		,		Id_Sistema
		FROM BacParamSuda..PRODUCTO
		WHERE	LTRIM(RTRIM((ID_SISTEMA))) = LTRIM(RTRIM(@Id_Sistema))
		AND		ESTADO = 1 

		
END
SET NOCOUNT OFF
--SP_RIEFIN_PRODUCTOS_DERIVADOS 'pcs'
GO
