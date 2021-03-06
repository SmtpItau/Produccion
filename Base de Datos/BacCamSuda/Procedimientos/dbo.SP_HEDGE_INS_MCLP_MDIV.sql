USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_INS_MCLP_MDIV]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_INS_MCLP_MDIV]
 @dFechaProceso DATETIME
,@nTipoReporte	INTEGER
,@cCuenta 	CHAR(12) 
,@cDescripcion  CHAR(50)
,@cMoneda 	CHAR(3)
,@nDebe 	NUMERIC(21,4)
,@nHaber 	NUMERIC(21,4)
,@nSaldo_Debe 	NUMERIC(21,4)
,@nSaldo_Haber 	NUMERIC(21,4)
,@saldo_pesos	NUMERIC(21,0) =0
,@debe_haber	CHAR(1)	      =0
AS

IF @nTipoReporte = 1 
BEGIN
	---DELETE FROM TBL_HEDGE_MCLP WHERE fecha_proceso=@dFechaProceso
	---CUENTAS DEL MAYOR
	INSERT TBL_HEDGE_MCLP
	VALUES ( @dFechaProceso 
		,@cCuenta 
		,@cDescripcion
		,@cMoneda
		,@nDebe
		,@nHaber
		,@nSaldo_Debe
		,@nSaldo_Haber)
	IF @@ERROR>0
	BEGIN
		SELECT -1,'Error: al insertar datos desde Interfaz Hedge'
		RETURN -1
	END
END
ELSE
BEGIN
	---MAYOR DIVISAS
	INSERT TBL_HEDGE_MDIV
	VALUES ( @dFechaProceso 
		,@cCuenta 
		,@cDescripcion
		,@cMoneda
		,@nDebe
		,@nHaber
		,@nSaldo_Debe
		,@nSaldo_Haber
		,@saldo_pesos
		,@debe_haber)
	
	IF @@ERROR>0
	BEGIN
		SELECT -1,'Error: al insertar datos desde Interfaz Hedge'
		RETURN -1
	END
END

GO
