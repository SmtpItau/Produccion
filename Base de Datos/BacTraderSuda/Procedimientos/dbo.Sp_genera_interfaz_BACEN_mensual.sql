USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_genera_interfaz_BACEN_mensual]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[Sp_genera_interfaz_BACEN_mensual] 
AS 

BEGIN

	SET NOCOUNT ON
	
	DECLARE @fechaProceso DATETIME

	SELECT @fechaProceso = acfecproc 
	FROM mdac (NOLOCK)

	SELECT 0			--Nr controle dado instituição financeira
			,CASE WHEN CNPJ = '' THEN Clrut ELSE ISNULL(CNPJ,Clrut) END --Devedor (CNPJ)
			,@fechaProceso	--Data estoque
			,CASE WHEN vimonpact = 998 THEN mnsimbol ELSE mnnemo END  --Moeda do estoque
			,SUM(vivalinip)	--Valor do estoque
	FROM mdvi (NOLOCK)
		INNER JOIN BacParamSuda..CLIENTE cli ON
			cli.Clrut = virutcli 
			AND cli.Clcodigo = vicodcli		
		INNER JOIN BacParamSuda..MONEDA mo ON
			mo.mncodmon = vimonpact	
	GROUP BY vinumoper, vimonpact,mnsimbol,mnnemo,CNPJ, Clrut


	
END

GO
