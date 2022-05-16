USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CONSULTAROPERACION]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Stored Procedure dbo.Sp_Lineas_ConsultarOperacion    Script Date: 06-01-2011 16:41:32 ******/
CREATE PROCEDURE  [dbo].[SP_LINEAS_CONSULTAROPERACION]
    (
    @cSistema 		CHAR 	(03) ,
    @cProducto 		CHAR 	(05) ,
    @nNumPantalla 	NUMERIC	(10) ,
    @cTipoper  		Char	(01) ,
    @cValidaCheque 	Char	(01) ,
    @nMercadoLocal 	Char	(01) ,
    @mContraMoneda 	NUMERIC	(03) = 0
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @cCheckEmi  	CHAR 	(01) 	,
  	 @cCheckChq  	CHAR 	(01) 	,
  	 @cCheckCli  	CHAR 	(01)
 DECLARE @cCheckLimOPER CHAR	(01)	,
  	 @cCheckLimInst CHAR	(01)
 DECLARE @dFecPro  	DATETIME 	,
  	 @nRutcli  	NUMERIC (09,0) 	,
   	 @nCodigo  	NUMERIC (09,0) 	,
  	 @dFecvctop  	DATETIME 	,
  	 @cUsuario  	CHAR 	(15) 	,
  	 @nMonto   	NUMERIC (19,4) 	,
  	 @cTipo_Riesgo  CHAR 	(01) 	,
  	 @nNumdocu  	NUMERIC (10,0) 	,
  	 @nCorrela  	NUMERIC (10,0) 	,
  	 @dFeciniop  	DATETIME 	,
  	 @fTipcambio  	NUMERIC (19,4) 	,
  	 @nMonedaOp  	NUMERIC (05,00) ,
  	 @nInCodigo  	NUMERIC (05,0) 	,
  	 @nFactor  	NUMERIC (19,8)

 CREATE TABLE #Tmp_Error
  ( 	Tipo_Error 	CHAR(3)  	,
   	Correlativo 	NUMERIC(19) 	,
   	Mensaje_Error 	VARCHAR(255)  	,
    	MontoExceso 	NUMERIC(19,4) )
 
 --************************************************
 --************************************************
 --**********                     *****************
 --**********    CHEQUEA LINEAS   *****************
 --**********                     *****************
 --************************************************
 --************************************************
 SELECT @cCheckCli = 'S',
  @cCheckEmi = 'N',
  @cCheckChq = 'N'
 IF @cSistema = 'BTR' AND @cProducto = 'CP'
  SELECT @cCheckCli = 'N', @cCheckEmi = 'S',@cCheckChq = 'N'
 IF @cSistema = 'BTR' AND ( @cProducto = 'VI' OR @cProducto = 'VP' )
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'S'
 IF @cSistema = 'BTR' AND ( @cProducto = 'ICAP' )
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N', @cCheckChq = 'N'
 IF @cSistema = 'BTR' AND ( @cProducto = 'RCA' OR @cProducto = 'RVA' )
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N', @cCheckChq = 'N'
 IF @cSistema = 'BCC' 
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'
 IF @cSistema = 'BCC' AND ( @cProducto = 'PTAS' OR @cProducto = 'EMPR' ) AND @cTipoper = 'C'
  SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'
 IF @cSistema = 'BCC' AND ( @cProducto = 'EMPR' ) AND @cTipoper = 'C' AND @cValidaCheque = 'S'
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'S'
 IF @cSistema = 'BFW' 
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'
--select 'Entre1'
 IF @cSistema = 'BFW' AND ( @cProducto = '1' OR @cProducto = '2'  OR @cProducto = '3'  OR @cProducto = '7' ) AND @nMercadoLocal = 'S'
  SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'
--select 'Entre2'
 --************************************************
 --************************************************
 --**********                     *****************
 --**********   ACTUALIZA LINEAS  *****************
 --**********                     *****************
 --************************************************
 --************************************************
 --********** GRABAR LINEA EMISOR *****************
 IF @cCheckEmi = 'S'
 BEGIN
  DECLARE Cursor_LINEAS_EMISOR SCROLL CURSOR FOR
  SELECT FechaOperacion  	,
   	 Rut_Emisor  		,
   	 Cod_Emisor  		,
   	 NumeroDocumento  	,
   	 NumeroCorrelativo 	,
   	 SUM(MontoTransaccion) 	,
   	 TipoCambio  		,
   	 FechaVctoInst  	,
    	 Operador  		,
   	 MonedaOperacion  	,
   	 Tipo_Riesgo
    FROM LINEA_CHEQUEAR
--  FROM VIEW_LINEA_CHEQUEAR
  WHERE NumeroOperacion  = @nNumPantalla
  AND Id_Sistema  	 = @cSistema
  AND Rut_Emisor         <> 97029000
  AND Rut_Emisor         <> 97018000
  GROUP BY FechaOperacion  	,
   	Rut_Emisor  		,
   	Cod_Emisor  		,
   	NumeroDocumento  	,
   	NumeroCorrelativo 	,
   	TipoCambio  		,
   	FechaVctoInst  		,
   	Operador  		,
   	MonedaOperacion  	,
   	Tipo_Riesgo
  OPEN Cursor_LINEAS_EMISOR
  WHILE (1=1)
  BEGIN
   FETCH NEXT FROM Cursor_LINEAS_EMISOR
   INTO @dFecPro  	,
    	@nRutcli 	,
    	@nCodigo 	,
    	@nNumdocu 	,
    	@nCorrela 	,
    	@nMonto  	,
    	@fTipcambio 	,
    	@dFecvctop 	,
    	@cUsuario 	,
    	@nMonedaOp 	,
    	@cTipo_Riesgo 
    IF (@@fetch_status <> 0)
    BEGIN
     BREAK
    END
    EXECUTE Sp_Lineas_ConsultarOperacionDetalle @dFecPro, @cSistema, @cProducto, @nRutcli, @nCodigo, @dFecPro, @nMonto, @fTipcambio, @dFecvctop, @cUsuario, @nMonedaOp, @cTipo_Riesgo, @mContraMoneda
  END
  CLOSE Cursor_LINEAS_EMISOR
  DEALLOCATE Cursor_LINEAS_EMISOR
 END
 --********** GRABAR LINEA CLIENTE *****************
 IF @cCheckCli = 'S'
 BEGIN
  DECLARE Cursor_LINEAS_CLIENTE SCROLL CURSOR FOR
  SELECT FechaOperacion 	,
   	 Rut_Cliente  		,
   	 Codigo_Cliente  	,
   	 SUM(MontoTransaccion)	,
   	 TipoCambio  		,
   	 FechaVencimiento 	,
   	 Operador  		,
    	 MonedaOperacion  	,
   	 Tipo_Riesgo
  FROM LINEA_CHEQUEAR	
  --FROM VIEW_LINEA_CHEQUEAR
  WHERE NumeroOperacion  = @nNumPantalla
  AND Id_Sistema  = @cSistema
  GROUP BY 
	FechaOperacion  	,
   	Rut_Cliente  		,
   	Codigo_Cliente  	,
   	TipoCambio  		,
   	FechaVencimiento 	,
   	Operador  		,
   	MonedaOperacion  	,
   	Tipo_Riesgo
  OPEN Cursor_LINEAS_CLIENTE
  WHILE (1=1)
  BEGIN
   FETCH NEXT FROM Cursor_LINEAS_CLIENTE
   INTO @dFecPro  		,
    	@nRutcli 		,
    	@nCodigo 		,
    	@nMonto  		,
    	@fTipcambio 		,
    	@dFecvctop 		,
    	@cUsuario 		,
    	@nMonedaOp 		,
    	@cTipo_Riesgo 
    IF (@@fetch_status <> 0)
    BEGIN
     BREAK
    END
    EXECUTE Sp_Lineas_ConsultarOperacionDetalle @dFecPro, @cSistema, @cProducto, @nRutcli, @nCodigo, @dFecPro, @nMonto, @fTipcambio, @dFecvctop, @cUsuario, @nMonedaOp, @cTipo_Riesgo
  END
  CLOSE Cursor_LINEAS_CLIENTE
  DEALLOCATE Cursor_LINEAS_CLIENTE
 END
 --********** GRABAR LINEA CHEQUE *****************
 IF @cCheckChq = 'S'
 BEGIN
  DECLARE Cursor_LINEAS_CHEQUE SCROLL CURSOR FOR
  SELECT FechaOperacion  	 ,
   	 Rut_Cheque  		 ,
   	 SUM(MontoTransaccion)   ,
   	 TipoCambio  		 ,
   	 FechaVctoCheque  	 ,
    	 Operador  		 ,
   	 MonedaOperacion  	 ,
   	 Tipo_Riesgo
   FROM LINEA_CHEQUEAR	
--  FROM VIEW_LINEA_CHEQUEAR
  WHERE NumeroOperacion  = @nNumPantalla
  AND Id_Sistema   	 = @cSistema
  AND Pago_Cheque  	 = @cCheckChq
  GROUP BY 
	FechaOperacion  	,
   	Rut_Cheque  		,
   	TipoCambio  		,
   	FechaVctoCheque  	,
   	Operador  		,
   	MonedaOperacion  	,
   	Tipo_Riesgo
  OPEN Cursor_LINEAS_CHEQUE
  WHILE (1=1)
  BEGIN
   FETCH NEXT FROM Cursor_LINEAS_CHEQUE
   INTO @dFecPro 		,
    	@nRutcli 		,
    	@nMonto  		,
    	@fTipcambio 		,
    	@dFecvctop 		,
    	@cUsuario 		,
    	@nMonedaOp 		,
    	@cTipo_Riesgo
    IF (@@fetch_status <> 0)
    BEGIN
     BREAK
    END
    EXECUTE Sp_Lineas_ConsultarOperacionDetalle @dFecPro, @cSistema, @cProducto, @nRutcli, 0, @dFecPro, @nMonto, @fTipcambio, @dFecvctop, @cUsuario, @nMonedaOp, @cTipo_Riesgo
  END
  CLOSE Cursor_LINEAS_CHEQUE
  DEALLOCATE Cursor_LINEAS_CHEQUE
 END
 --************************************************
 --************************************************
 --**********                     *****************
 --********** LIMITES DE OPERADOR *****************
 --**********                     *****************
 --************************************************
 --************************************************
 CREATE TABLE #Temp_LIMITE_TRANSACCION(
  	FechaOperacion  	DATETIME    		  		,
  	NumeroOperacion  	NUMERIC(10) 	NOT NULL  		,
  	Id_Sistema  		CHAR   (03)  	NOT NULL  		,
  	Codigo_Producto  	CHAR   (05)  	NOT NULL  		,
  	InCodigo  		NUMERIC(05) 	NOT NULL  		,
  	MontoTransaccion 	NUMERIC(19,4) 	NOT NULL DEFAULT(0) 	,
  	FechaVencimiento 	DATETIME    				,
	Operador  		CHAR   (15) 	NOT NULL  		,
  	Check_Operacion  	VARCHAR(01) 	NOT NULL DEFAULT('') 	,
  	Check_Instrumento 	VARCHAR(01) 	NOT NULL DEFAULT('') )
 SELECT @cCheckLimOPER = 'S',
  @cCheckLimInst = 'N'
 IF @cSistema = 'BTR' AND @cProducto = 'CP'
  SELECT @cCheckLimInst = 'S'
 IF @cSistema='BTR' AND (@cProducto='ICOL' OR @cProducto='ICAP')
  SELECT @cCheckLimInst = 'S'
 --********** GRABAR LIMITE POR OPERACION *****************
 IF @cCheckLimOPER = 'S'
 BEGIN
  DECLARE Cursor_LIMITES_OPERACION SCROLL CURSOR FOR
  SELECT FechaOperacion  	,
   	 SUM(MontoTransaccion) 	,
   	 FechaVencimiento 	,
   	 Operador
   FROM LINEA_CHEQUEAR	

--  FROM VIEW_LINEA_CHEQUEAR
  WHERE NumeroOperacion  = @nNumPantalla
  AND Id_Sistema  = @cSistema
  GROUP BY FechaOperacion  	,
   	   FechaVencimiento 	,
   	   Operador
  OPEN Cursor_LIMITES_OPERACION
  WHILE (1=1)
  BEGIN
   FETCH NEXT FROM Cursor_LIMITES_OPERACION
   INTO @dFecPro	,
    	@nMonto		,
    	@dFecvctop	,
    	@cUsuario
    IF (@@fetch_status <> 0)
    BEGIN
     BREAK
    END
    INSERT INTO #Temp_LIMITE_TRANSACCION
    SELECT @dFecPro  	,
     	   @nNumPantalla,
     	   @cSistema 	,
           @cProducto 	,
      	   0  		,
     	   @nMonto  	,
     	   @dFecvctop 	,
     	   @cUsuario 	,
     	   @cCheckLimOPER ,
     	   'N' 
  END
  CLOSE Cursor_LIMITES_OPERACION
  DEALLOCATE Cursor_LIMITES_OPERACION
 END
 --********** GRABAR LIMITE POR OPERACION e INSTRUMENTO *****************
 IF @cCheckLimInst = 'S'
 BEGIN
  DECLARE Cursor_LIMITES_OPERACION_INSTRUMENTO SCROLL CURSOR FOR
  SELECT FechaOperacion  	,
         InCodigo  	 	,
   	 SUM(MontoTransaccion) 	,
   	 FechaVencimiento 	,
   	 Operador
   FROM  LINEA_CHEQUEAR	
--  FROM VIEW_LINEA_CHEQUEAR
  WHERE  NumeroOperacion  = @nNumPantalla
    AND	 Id_Sistema  	 = @cSistema
  GROUP BY FechaOperacion  	,
     	 InCodigo  		,
     	 FechaVencimiento 	,
     	 Operador
  OPEN Cursor_LIMITES_OPERACION_INSTRUMENTO
  WHILE (1=1)
  BEGIN
   FETCH NEXT FROM Cursor_LIMITES_OPERACION_INSTRUMENTO
   INTO  @dFecPro	,
    	 @nInCodigo	,
    	 @nMonto	,
    	 @dFecvctop	,
    	 @cUsuario
    IF (@@fetch_status <> 0)
    BEGIN
     BREAK
    END
    INSERT INTO #Temp_LIMITE_TRANSACCION
    SELECT @dFecPro  	,
     	   @nNumPantalla,
     	   @cSistema 	,
     	   @cProducto 	,
     	   @nInCodigo 	,
     	   @nMonto  	,
     	   @dFecvctop 	,
     	   @cUsuario 	,
     	   'N'  	,
     	   @cCheckLimInst
  END
  CLOSE Cursor_LIMITES_OPERACION_INSTRUMENTO
  DEALLOCATE Cursor_LIMITES_OPERACION_INSTRUMENTO
 END
 
 --********** GRABAR LIMITE DE OPERADOR *****************
 EXECUTE Sp_Limites_ConsultaOperacion
 SELECT * FROM #Tmp_Error
 SET NOCOUNT OFF
END

GO
