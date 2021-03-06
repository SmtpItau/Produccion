USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CLIENTES_ART84]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_CLIENTES_ART84]
AS
BEGIN

	SELECT	 Rut_Cliente
		,Codigo_Cliente
		,Porcentaje
		,Endeudamiento
		,Garantia
		,Utilizado    
		,a.clnombre
		,a.cldv
		,'ENTIDAD' = ISNULL( (SELECT rcnombre FROM entidad ) , 'SIN ENTIDAD' )
	FROM	 cliente_art84
		,cliente a
	WHERE	 Rut_Cliente 	= a.clrut	AND
		 Codigo_Cliente = a.clcodigo

END

-- sp_autoriza_ejecutar 'bacuser'
-- SELECT * FROM ENTIDAD
GO
