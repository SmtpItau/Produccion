USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CHEQUEARGRABAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_LINEAS_CHEQUEARGRABAR]
    (
    @dFecPro 		DATETIME ,
    @cSistema 		CHAR (03) ,
    @cProducto 		CHAR (05) ,
    @nNumoper 		NUMERIC(10) ,
    @nNumdocu 		NUMERIC (10,0) ,
    @nCorrela 		NUMERIC (10,0) ,
    @nRutcli 		NUMERIC (09,0) ,
    @nCodigo 		NUMERIC (09,0) ,
    @nMonto  		NUMERIC (19,4) ,
    @fTipcambio 	NUMERIC (08,4) ,
    @dFecvctop 		DATETIME ,
    @cUsuario 		CHAR (15) ,
    @nRut_emisor 	NUMERIC(9) ,
    @nMonedaEmision 	NUMERIC(3) ,
    @dFecvctoInst 	DATETIME ,
    @nInCodigo 		NUMERIC(05) ,
    @cSeriado 		CHAR(1)  ,
    @nMonedaOp 		NUMERIC(05) ,
    @cTipo_Riesgo 	CHAR (1) ,
    @nCodigo_pais 	NUMERIC(05) ,
    @cPagoCheque 	CHAR (1) ,
    @nRutCheque 	NUMERIC (09,0) ,
    @dFecvctoCehque 	DATETIME ,
    @nFactorVenta 	NUMERIC (19,8) ,
    @nCodEmi 		NUMERIC (09,0)
    )
AS
BEGIN

SET NOCOUNT ON

DECLARE @fecha 	       DATETIME
SELECT  @fecha = ( select acfecproc from text_arc_ctl_dri)

DECLARE @vmvalor       NUMERIC (19,4)

IF @nMonedaEmision <> 13
begin
   	select @vmvalor = (select vmptacmp from view_valor_moneda where vmcodigo = @nMonedaEmision and vmfecha = @fecha)
	select @nMonto = (@nMonto *  @vmvalor)
end
	

 	INSERT INTO VIEW_LINEA_CHEQUEAR
		(
  			FechaOperacion  ,
			NumeroOperacion  ,
			Numerodocumento  ,
  			NumeroCorrelativo ,
  			Rut_Cliente  ,
  			Codigo_Cliente  ,
  			Id_Sistema  ,
  			Codigo_Producto  ,
  			MontoTransaccion ,
  			TipoCambio  ,
  			FechaVencimiento ,
  			Operador  ,
  			Rut_Emisor  ,
  			Moneda_Emision  ,
  			FechaVctoInst  ,
  			InCodigo  ,
  			Seriado   ,
  			MonedaOperacion  ,
  			Tipo_Riesgo  ,
  			codigo_pais  ,
  			Pago_Cheque  ,
  			Rut_Cheque  ,
  			FechaVctoCheque  ,
  			FactorVenta  ,
  			Cod_Emisor  
		)
 	SELECT  
			@dFecPro  ,
			@nNumoper  ,
  			@nNumdocu  ,
  			@nCorrela  ,
  			@nRutcli  ,
  			@nCodigo  ,
  			@cSistema  ,
  			@cProducto  ,
  			@nMonto   ,
  			@fTipcambio  ,
  			@dFecvctop  ,
  			@cUsuario  ,
  			@nRut_emisor  ,
  			@nMonedaEmision  ,
  			@dFecvctoInst  ,
  			@nInCodigo  ,
  			@cSeriado  ,
  			@nMonedaOp  ,
  			@cTipo_Riesgo  ,
  			@nCodigo_pais  ,
  			@cPagoCheque  ,
  			@nRutCheque  ,
  			@dFecvctoCehque  ,
  			@nFactorVenta  ,
  			@nCodEmi


SET NOCOUNT OFF
END

-- sp_helptext Sp_Lineas_ChequearGrabar
-- select * from VIEW_LINEA_CHEQUEAR
-- delete from VIEW_LINEA_CHEQUEAR where NumeroOperacion = 89

GO
