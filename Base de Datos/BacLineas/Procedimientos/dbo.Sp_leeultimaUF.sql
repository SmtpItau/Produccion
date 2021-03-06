USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_leeultimaUF]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_leeultimaUF] (@ultFechaUF DATETIME,
				 @ultFechaIV DATETIME
				)

AS
BEGIN

	SET NOCOUNT ON
	DECLARE @nValorUF  	FLOAT 
	DECLARE @cFechaUF  	CHAR(10)
	DECLARE @nValorIPC 	FLOAT
	DECLARE @nValorIPC_a 	FLOAT
	DECLARE @cFechaIPC 	CHAR(10)
	DECLARE @Fecha_Proceso 	DATETIME

	SELECT @Fecha_Proceso = acfecproc FROM  view_mdac		
	SET ROWCOUNT 1  

	-- Ultima UF Conocida
	SELECT 	@nValorUF   = vmvalor
	FROM 	Valor_moneda
	WHERE 	vmcodigo = 998  
		AND vmfecha  = @ultFechaUF
	ORDER BY vmfecha DESC


	-- IPC Publicado en el Mes Anterior
	SELECT 	@nValorIPC = vmvalor
	FROM  	Valor_moneda
	WHERE 	vmcodigo = 500  
		AND vmfecha  = @ultFechaIV
	ORDER BY vmfecha DESC

	SELECT @cFechaUF   = CONVERT(CHAR(10),@ultFechaUF,103) 
	SELECT @cFechaIPC = CONVERT(CHAR(10),@ultFechaIV,103)

	SELECT	'ValorUf'  	= ISNULL(@nValorUF , 0.00)	, 
		'FechaUF'  	= ISNULL(@cFechaUF ,   "")	, 
		'ValorIPC' 	= ISNULL(@nValorIPC, 0.00)	, 
		'FechaIPC' 	= ISNULL(@cFechaIPC,   "")


    SET ROWCOUNT 0 
    RETURN

END


-- sp_leeultimaUF '20020109', '20011201','20020101'
-- sp_leeultimaUF '20020109', '20011201'








GO
