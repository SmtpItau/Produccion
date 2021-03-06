USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTERELA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CLIENTERELA]
	(	@rut_padre	NUMERIC(10),
		@codigo_padre	NUMERIC(10)
	)
AS 
	BEGIN

	SET NOCOUNT ON
	SELECT  RutPadre			= a.clrut_padre
		,	CodPadre			= a.clcodigo_padre
		,	RutHijo				= a.clrut_hijo
		,	CodHijo				= a.clcodigo_hijo
		,	PorHijo				= a.clporcentaje
		,	NomHijo				= b.clnombre
		,	AfectaLin			= a.Afecta_Lineas_Hijo
		,	NomPadre			= Padre.clnombre
	FROM 	CLIENTE_RELACIONADO	a
			INNER JOIN VIEW_CLIENTE		b ON b.clrut	 = a.clrut_hijo  AND b.clcodigo		= a.clcodigo_hijo
			INNER JOIN VIEW_CLIENTE	Padre ON Padre.clrut = a.clrut_padre AND Padre.clcodigo = a.clcodigo_padre
	WHERE 	a.clrut_padre		= @rut_padre 
	AND		a.clcodigo_padre	= @codigo_padre

END
GO
