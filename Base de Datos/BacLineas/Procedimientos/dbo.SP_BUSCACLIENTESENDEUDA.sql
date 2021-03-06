USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCACLIENTESENDEUDA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCACLIENTESENDEUDA]
AS
BEGIN

	SELECT	 Rut_Cliente
		,Codigo_Cliente
		,Porcentaje
		,Endeudamiento
		,Garantia
		,Utilizado    
		,a.clnombre
		,a.cltipcli
		,porcentajetres
	FROM	 cliente_endeudamiento
		,view_cliente a
	WHERE	 Rut_Cliente 	= a.clrut	AND
		 Codigo_Cliente = a.clcodigo
	ORDER BY a.clnombre

END
GO
