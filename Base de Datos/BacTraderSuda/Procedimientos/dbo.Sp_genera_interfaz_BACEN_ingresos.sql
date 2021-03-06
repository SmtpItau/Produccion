USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_genera_interfaz_BACEN_ingresos]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[Sp_genera_interfaz_BACEN_ingresos] 
AS 
BEGIN

	SET NOCOUNT ON
	
	DECLARE @fechaProceso DATETIME

	SELECT @fechaProceso = acfecproc 
	FROM mdac (NOLOCK)

	SELECT 0			--Nr controle dado instituição financeira
			,'I'		--Tipo Operação
			,vinumoper	--Identificador Captação	
			,vifecinip	--Data da captação	
			,CASE WHEN CNPJ = '' THEN Clrut ELSE ISNULL(CNPJ,Clrut) END --Devedor (CNPJ)	
			,ISNULL(cod_swift,'')	--Pais do Devedor	
			,'S'--Credor	
			,CASE WHEN cli.clcod_contra = 3 THEN 'S' ELSE 'N' END--Indicador de operação intraconglomerado	
			,CASE WHEN cli.clcod_contra = 3 THEN 'S' ELSE 'N' END--Indicador de operação intragrupo financeiro	
			,CASE WHEN vimonpact = 998 THEN mnsimbol ELSE mnnemo END  --Moeda	
			,SUM(vivalinip)	--Valor da captação	
			,'S'		--Indicador de Captação sem vencimento de principal	
			,vifecvenp	--Data de vencimento prevista da parcela principal	
			,0			--valor previsto para parcela de principal	
			,'PRE'		--Tipo de Juros	
			,999		--Código da taxa pós fixada	
			,0			--Spread da taxa pós-fixada	
			,SUM(vivalvenp)	--Custo total na data da captação	Modalidadede origem	
			,999		--Destinação	
			,0			--Conta Cosif	
			,''			--Observações
	FROM mdvi (NOLOCK)		
		INNER JOIN BacParamSuda..CLIENTE cli ON
			cli.Clrut = virutcli 
			AND cli.Clcodigo = vicodcli
		INNER JOIN BacParamSuda..PAIS pa ON
			pa.codigo_pais = cli.Clpais
		INNER JOIN BacParamSuda..MONEDA mo ON
			mo.mncodmon = vimonpact	
	WHERE vifecinip = @fechaProceso
	GROUP BY vinumoper,vifecinip,vifecvenp,cod_swift,vimonpact,mnsimbol,mnnemo,Clrut,CNPJ,cli.clcod_contra
	
END

GO
