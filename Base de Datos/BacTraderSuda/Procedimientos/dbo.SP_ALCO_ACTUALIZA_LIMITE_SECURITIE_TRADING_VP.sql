USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_ACTUALIZA_LIMITE_SECURITIE_TRADING_VP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ALCO_ACTUALIZA_LIMITE_SECURITIE_TRADING_VP] 
( 
		  @PLAZO NUMERIC(10) 
		, @VALOR_PAPEL FLOAT  
)
AS BEGIN
/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/

	DECLARE @CODIGO_GRUPO 	NUMERIC(10)	
SET NOCOUNT ON

	SELECT @CODIGO_GRUPO = Codigo_Grupo
	FROM view_GRUPO_TRADING_SWAP
	WHERE ( @PLAZO BETWEEN Tramo_Desde AND Tramo_Hasta )
		AND Codigo_Limite = 3

--select * from view_LIMITE_TRADING_SWAP 	WHERE Codigo_Limite = 3 AND Codigo_Grupo = 2

	UPDATE view_LIMITE_TRADING_SWAP
	SET	outstanding = outstanding - @VALOR_PAPEL
	WHERE Codigo_Limite = 3 AND Codigo_Grupo = @CODIGO_GRUPO

	-- Esto limpia el campo outstanding para que no wqueden valores negativos cuando se vede toda la posiion Trading
	UPDATE view_LIMITE_TRADING_SWAP
	SET	outstanding = 0
	WHERE Codigo_Limite = 3 AND Codigo_Grupo = @CODIGO_GRUPO and outstanding < 1


	UPDATE view_LIMITE_TRADING_SWAP
	SET	DISPONIBLE = Monto_Limite - Outstanding
	WHERE Codigo_Limite = 3 AND Codigo_Grupo = @CODIGO_GRUPO

SET NOCOUNT OFF

	SELECT Codigo_Grupo , outstanding , disponible FROM view_LIMITE_TRADING_SWAP WHERE Codigo_Limite = 3 AND Codigo_Grupo = @CODIGO_GRUPO
END

GO
