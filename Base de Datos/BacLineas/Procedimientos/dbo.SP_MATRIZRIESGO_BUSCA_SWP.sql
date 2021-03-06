USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_BUSCA_SWP]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_BUSCA_SWP]
	(
	 @Codpro char(5)	,
	 @Moneda char(5)
        )
AS 
BEGIN

 SET NOCOUNT ON

	 SELECT Codigo_Producto,
	        moneda  	,
	        DiasDesde 	,
	        DiasHasta 	,
	        Porcentaje
	   FROM MATRIZ_RIESGO_SWAP
	  WHERE	codigo_producto = @codpro 
	    AND	moneda          = @moneda
	  ORDER BY diasdesde

 SET NOCOUNT OFF

END
GO
