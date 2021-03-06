USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_ACTULIZA_TOTAL_SECURITIES_TRADING_VP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ALCO_ACTULIZA_TOTAL_SECURITIES_TRADING_VP] 
(		
	@TOTAL_SECURITIES_TRADING FLOAT 
)
AS BEGIN

	DECLARE @DISPONIBLE  FLOAT,
		@OUTSTANDING FLOAT

SET NOCOUNT ON

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/
	/******************************/

		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET outstanding = outstanding - @TOTAL_SECURITIES_TRADING
		WHERE CODIGO_LIMITE = 4


		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET outstanding = 0
		WHERE CODIGO_LIMITE = 4 AND outstanding < 1


		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET Disponible = Monto_Limite - (outstanding+outstanding_Filial)
		WHERE CODIGO_LIMITE = 4
	/******************************/


SET NOCOUNT OFF

	SELECT outstanding , Disponible FROM view_TOTAL_PORTFOLIO_TRADING_SWAP WHERE CODIGO_LIMITE = 4
END

GO
