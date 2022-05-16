USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_USU_CART_FINANCIERA]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE VIEW [dbo].[VIEW_USU_CART_FINANCIERA]
AS
	SELECT	
		Ucf_Usuario
     	,	Ucf_Sistema
	,	Ucf_Producto
	,	Ucf_Codigo_Cart
	,	Ucf_Default 
   FROM  BACPARAMSUDA..TBL_REL_USU_CART_FINANCIERA


GO
