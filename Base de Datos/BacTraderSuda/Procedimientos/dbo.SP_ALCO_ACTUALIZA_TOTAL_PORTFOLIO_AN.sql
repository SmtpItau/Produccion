USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_ACTUALIZA_TOTAL_PORTFOLIO_AN]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ALCO_ACTUALIZA_TOTAL_PORTFOLIO_AN] 
( 		@MONTO_OPERACION   	FLOAT 		,
		@PRODUCTO		CHAR(5) 	
)	

AS BEGIN
/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/
SET NOCOUNT ON

	IF @PRODUCTO = 'CP'
	BEGIN
		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET  Outstanding = Outstanding - @MONTO_OPERACION
		WHERE CODIGO_LIMITE = 2	

		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET  disponible = Monto_Limite - (Outstanding+Outstanding_Filial)
		WHERE CODIGO_LIMITE = 2	

	END

	IF @PRODUCTO = 'VP'
	BEGIN
		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET  Outstanding = Outstanding + @MONTO_OPERACION
		WHERE CODIGO_LIMITE = 2	

		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET  disponible = Monto_Limite - (Outstanding+Outstanding_Filial)
		WHERE CODIGO_LIMITE = 2	
	END

		
SET NOCOUNT OFF

	SELECT outstanding , Disponible FROM view_TOTAL_PORTFOLIO_TRADING_SWAP WHERE CODIGO_LIMITE = 2	
END

GO
