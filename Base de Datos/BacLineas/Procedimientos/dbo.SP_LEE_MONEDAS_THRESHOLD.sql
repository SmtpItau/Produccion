USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_MONEDAS_THRESHOLD]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_MONEDAS_THRESHOLD]
AS
BEGIN

	--> Proposito : Llenar el Objeto "Combo Box" de la pantalla de asignación y creacion de líneas de crédito.
	-->				Controlando un valor por defecto desde SQL, por si este cambia en el tiempo o en la certificación

	SET NOCOUNT ON

	DECLARE @iCodMonDefecto	SMALLINT
		SET @iCodMonDefecto	= 13

	-->     Selecciona las Moneda definidas como Divisa
	SELECT	Codigo	= mncodmon
		,	Nemo	= mnnemo
		,	Defecto = CASE WHEN mncodmon = @iCodMonDefecto THEN 1 ELSE 0 END    
	  FROM	BacParamSuda.dbo.MONEDA 
	 WHERE	mntipmon = 2

	UNION
	
	-->     Agrega a la Seleccion el Pesos ($) y la Unidad de Fomento (UF)
	SELECT	Codigo	= mncodmon
		,	Nemo	= mnnemo
		,	Defecto = CASE WHEN mncodmon = @iCodMonDefecto THEN 1 ELSE 0 END  
	FROM	BacParamSuda.dbo.MONEDA 
	WHERE	mncodmon IN(999,998)
	ORDER BY Defecto DESC
	
END
GO
