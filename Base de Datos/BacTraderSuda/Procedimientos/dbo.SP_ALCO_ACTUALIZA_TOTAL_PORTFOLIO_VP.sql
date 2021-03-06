USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_ACTUALIZA_TOTAL_PORTFOLIO_VP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ALCO_ACTUALIZA_TOTAL_PORTFOLIO_VP] 
( 
		@MONTO_OPERACION   FLOAT 
)
AS BEGIN
/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/

	DECLARE @DISPONIBLE  	FLOAT	,
		@OUTSTANDING 	FLOAT


SET NOCOUNT ON
		
		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET outstanding = outstanding - @MONTO_OPERACION
		WHERE CODIGO_LIMITE = 2

		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET outstanding = 0
		WHERE CODIGO_LIMITE = 2 AND outstanding < 1

		UPDATE view_TOTAL_PORTFOLIO_TRADING_SWAP
		SET Disponible = Monto_Limite - (Outstanding+Outstanding_Filial)
		WHERE CODIGO_LIMITE = 2	

		
SET NOCOUNT OFF

	SELECT outstanding , Disponible FROM view_TOTAL_PORTFOLIO_TRADING_SWAP WHERE CODIGO_LIMITE = 2	
END

GO
