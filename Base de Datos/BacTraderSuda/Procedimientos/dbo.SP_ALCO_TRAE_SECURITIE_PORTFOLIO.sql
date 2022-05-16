USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_TRAE_SECURITIE_PORTFOLIO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create PROC [dbo].[SP_ALCO_TRAE_SECURITIE_PORTFOLIO]
AS 
BEGIN
/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/


	SELECT Disponible,*
	FROM view_TOTAL_PORTFOLIO_TRADING_SWAP
	WHERE Codigo_Limite = 2
END

GO
