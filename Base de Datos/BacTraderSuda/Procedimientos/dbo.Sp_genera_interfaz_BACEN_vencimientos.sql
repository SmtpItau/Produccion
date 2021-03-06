USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_genera_interfaz_BACEN_vencimientos]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[Sp_genera_interfaz_BACEN_vencimientos] 
AS 

BEGIN

	SET NOCOUNT ON
	
	DECLARE @fechaProceso DATETIME

	SELECT @fechaProceso = acfecproc 
	FROM mdac (NOLOCK)

	SELECT 0			--Nr controle dado instituição financeira
			,monumoper	--Identificador Captação	
			,mofecpro	--Data do Pagamento
			,movalvenp	--Parcela de Principal sendo paga
			,mofecpro	--Data principal recebendo pagamento
			,movalvenp	--Valor sendo pago para a parcela
	FROM MDMO (NOLOCK)		
	WHERE mofecpro = @fechaProceso
		AND motipoper = 'RC'
		AND motipopero = 'CP'
	
END

GO
