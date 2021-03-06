USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CONVERTIR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_CONVERTIR]
	(	@dFecPro  	DATETIME 	,
		@cMonedaPre 	NUMERIC(03,00) 	,
		@cMonedaNew 	NUMERIC(03,00) 	,
		@xLineaAsig	NUMERIC(19,04) 	,
		@xLineaOcup	NUMERIC(19,04) 	,
		@xLineaDisp	NUMERIC(19,04) 	,
		@xLineaExce	NUMERIC(19,04) 	
	)
AS
BEGIN

DECLARE 	@fTipcambio 	NUMERIC(08,4) 	
DECLARE 	@nParidadPre 	NUMERIC(08,4) 	
DECLARE 	@nParidadNew 	NUMERIC(08,4) 	
DECLARE 	@nMtoLinAsig   	NUMERIC(19,04)
DECLARE 	@nMtoLinOcup  	NUMERIC(19,04)
DECLARE 	@nMtoLinDisp   	NUMERIC(19,04)
DECLARE 	@nMtoLinExce  	NUMERIC(19,04)



SET NOCOUNT ON


IF @cMonedaPre = @cMonedaNew BEGIN
	SELECT 	@xLineaAsig, @xLineaOcup, @xLineaDisp, @xLineaExce
	RETURN	
END


IF @cMonedaPre = 13 
	SELECT @cMonedaPre = 994
IF @cMonedaNew = 13 
	SELECT @cMonedaNew = 994
	

SELECT @fTipcambio = (	Select 	vmvalor 
			from 	view_valor_moneda 
			where 	vmcodigo 	= 994 		and 
				vmfecha 	= @dFecPro	)

IF NOT EXISTS(SELECT 1 FROM view_valor_moneda where vmcodigo = 994 and vmfecha = @dFecPro) or @fTipcambio = 0
BEGIN
	SELECT 'ERROR', 'VALOR DE MONEDA DOLAR OBSERVADO NO EXISTE PARA FECHA DE PROCESO'
	RETURN
END

IF @cMonedaPre <> 999 
BEGIN 

	SELECT  @nParidadPre = ISNULL(( 
				SELECT 	vmptacmp
			 	FROM 	bacparamsuda.dbo.VALOR_MONEDA
				WHERE	vmfecha  = @dFecPro 	AND
					vmcodigo = (    SELECT 	mncodmon
							FROM 	VIEW_MONEDA 
							WHERE mncodmon = @cMonedaPre ) ) ,1)



	IF ( SELECT mnrrda FROM VIEW_MONEDA WHERE mncodmon = @cMonedaPre ) = 'D'
		BEGIN
		SELECT  @nParidadPre = @nParidadPre / @fTipcambio
		END 
	ELSE 
		BEGIN
		SELECT  @nParidadPre = @nParidadPre * @fTipcambio
		END

	SELECT @nMtoLinAsig = @xLineaAsig * @nParidadPre
	SELECT @nMtoLinOcup = @xLineaOcup * @nParidadPre
	SELECT @nMtoLinDisp = @xLineaDisp * @nParidadPre
	SELECT @nMtoLinExce = @xLineaExce * @nParidadPre


END
ELSE  BEGIN

SELECT @nMtoLinAsig = @xLineaAsig 
SELECT @nMtoLinOcup = @xLineaOcup 
SELECT @nMtoLinDisp = @xLineaDisp 
SELECT @nMtoLinExce = @xLineaExce 


END



IF NOT EXISTS(SELECT 1 FROM bacparamsuda.dbo.valor_moneda
		       WHERE	vmfecha  = @dFecPro 	AND
				vmcodigo = ( SELECT 	mncodmon
				FROM 	VIEW_MONEDA 
				WHERE mncodmon = @cMonedaNew ) ) AND @cMonedaNew <> 999 
BEGIN
	SELECT 'ERROR', 'VALOR DE MONEDA ' + ISNULL(RTRIM(LTRIM((SELECT mnglosa FROM bacparamsuda.dbo.MONEDA WHERE mncodmon = @cMonedaNew))),'') + ' NO EXISTE PARA FECHA DE PROCESO'
	RETURN
END	


IF @cMonedaNew NOT IN (999,13) 
BEGIN 
	SELECT  @nParidadNew = ISNULL(( SELECT 	vmptacmp
			 	FROM 	bacparamsuda.dbo.valor_moneda
				WHERE	vmfecha  = @dFecPro 	AND
					vmcodigo = (    SELECT 	mncodmon
							FROM 	VIEW_MONEDA 
							WHERE mncodmon = @cMonedaNew ) ) ,1)

/*
IF @nParidadNew = 0 BEGIN
	SELECT 'ERROR', 'PARIDAD DE ' + ISNULL(RTRIM(LTRIM((SELECT mnglosa FROM bacparamsuda.dbo.MONEDA WHERE mncodmon = @cMonedaNew))),'') + ' NO EXISTE PARA FECHA DE PROCESO'
	RETURN
END	
*/

IF @nParidadNew = 0 BEGIN
	select @nParidadNew = 1
END	


IF ( SELECT mnrrda FROM VIEW_MONEDA WHERE mncodmon = @cMonedaNew ) = 'D'
	BEGIN

	SELECT  @nParidadNew = @nParidadNew / @fTipcambio
	END 
ELSE 
	BEGIN
	SELECT  @nParidadNew = @nParidadNew * @fTipcambio
	END



SELECT @nMtoLinAsig = CASE WHEN @nMtoLinAsig <> 0 THEN @nMtoLinAsig / @nParidadNew ELSE 0 END
SELECT @nMtoLinOcup = CASE WHEN @nMtoLinOcup <> 0 THEN @nMtoLinOcup / @nParidadNew ELSE 0 END
SELECT @nMtoLinDisp = CASE WHEN @nMtoLinDisp <> 0 THEN @nMtoLinDisp / @nParidadNew ELSE 0 END
SELECT @nMtoLinExce = CASE WHEN @nMtoLinExce <> 0 THEN @nMtoLinExce / @nParidadNew ELSE 0 END

END


SELECT @nMtoLinAsig, @nMtoLinOcup, @nMtoLinDisp, @nMtoLinExce 


SET NOCOUNT OFF

END
GO
