USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_ACTULIZA_TOTAL_SECURITIES_TRADING]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ALCO_ACTULIZA_TOTAL_SECURITIES_TRADING] 
( 
	@TOTAL_SECURITIES_TRADING FLOAT 
)
AS BEGIN
/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/


SET NOCOUNT ON

		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET outstanding = outstanding + @TOTAL_SECURITIES_TRADING
		WHERE CODIGO_LIMITE = 4

		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET Disponible = Monto_Limite - (Outstanding+Outstanding_Filial)
		WHERE CODIGO_LIMITE = 4


SET NOCOUNT OFF

	SELECT outstanding , Disponible FROM view_TOTAL_PORTFOLIO_TRADING_SWAP WHERE CODIGO_LIMITE = 4
END

GO
