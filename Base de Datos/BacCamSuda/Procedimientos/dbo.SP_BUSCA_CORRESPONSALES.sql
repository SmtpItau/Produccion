USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_CORRESPONSALES]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create Procedure [dbo].[SP_BUSCA_CORRESPONSALES]
As
Begin

	SELECT codigo_contable,nombre 
	FROM   bacparamsuda..corresponsal 
	WHERE  rut_cliente     =  97023000 
	  AND  codigo_contable <> 0
	Order By 2


end





GO
