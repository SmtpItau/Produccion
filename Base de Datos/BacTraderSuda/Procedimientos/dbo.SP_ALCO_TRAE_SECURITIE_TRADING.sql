USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_TRAE_SECURITIE_TRADING]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ALCO_TRAE_SECURITIE_TRADING]
(		
		@PLAZO_PAPEL NUMERIC(10) 
)
AS BEGIN
/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/


	DECLARE @CODIGO_GRUPO NUMERIC(10)

	SELECT @CODIGO_GRUPO = Codigo_Grupo
	FROM view_GRUPO_TRADING_SWAP
	WHERE Codigo_limite = 3 AND @PLAZO_PAPEL BETWEEN Tramo_Desde AND Tramo_Hasta


	SELECT Disponible , Codigo_Grupo
	FROM view_LIMITE_TRADING_SWAP
	WHERE Codigo_limite = 3 AND Codigo_Grupo = @CODIGO_GRUPO
	
END

GO
