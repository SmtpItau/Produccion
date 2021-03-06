USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SEGURO_INFLACION_MV]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_SEGURO_INFLACION_MV]	
( @nNumOper NUMERIC(10)	)
AS
BEGIN

	DECLARE @dFecha          DATETIME
	,       @dFechaProceso   DATETIME

	SET NOCOUNT ON

	SELECT  @dFechaProceso   = acfecproc
	FROM    MFAC

	SELECT  @dFecha          = fecharecepcion
	FROM    MFCA 
	WHERE   canumoper        = @nnumoper 


	IF EXISTS(SELECT 1 FROM MFCA WHERE canumoper = @nnumoper)
	BEGIN 
--	IF @dFecha = @dFechaProceso BEGIN 

		SELECT	Ctf_Numero_OPeracion	
		,		cacodigo	-- RUT CLIENTE
		,		cacodcli	-- CODIGO CLIENTE
		,		catipoper
		,		cafecha
		,		Ctf_Numero_Credito
		,		Ctf_Correlativo
		,		Ctf_Numero_Dividendo
		,		Ctf_Plazo
		,		Ctf_Fecha_Vencimiento
		,		Ctf_Fecha_Fijacion
		,		Ctf_Monto_Principal
		,		Ctf_Precio_Contrato
		,		Ctf_Precio_Costo
		,		Ctf_Spread
		,		Ctf_Tasa_Moneda_Principal
		,		Ctf_Tasa_Moneda_Secundaria
		,		Ctf_Precio_Proyectado
		,		Ctf_Monto_Secundario
		,		caoperador
		,		CONVERT(CHAR(10),@dFechaProceso,103)	as Fecha_Proc
		,		CONVERT(CHAR(10), GETDATE(),108)		as Hora
		FROM	BacFwdSuda.dbo.MFCA
				INNER  JOIN BacFwdSuda.dbo.TBL_CARTERA_FLUJOS ON Ctf_Numero_OPeracion = canumoper
		WHERE	canumoper				= @nnumoper 
		ORDER BY ctf_numero_operacion, ctf_correlativo
		
	END
END
GO
