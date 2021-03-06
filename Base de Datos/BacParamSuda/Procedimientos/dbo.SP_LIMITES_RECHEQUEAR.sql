USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_RECHEQUEAR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_RECHEQUEAR] (
    @cSistema CHAR (03) ,
    @nNumoper NUMERIC (10,0) ,
    @cUsuario CHAR (15)
    )
AS
BEGIN
 DECLARE @dFecPro  DATETIME ,
  @cProducto CHAR (05) ,
  @nCodInst NUMERIC (05,0) ,
  @nMonto  NUMERIC (19,4) ,
  @dFecvctop DATETIME ,
  @cCheckLimOp CHAR (1) ,
  @cCheckLimInst CHAR (1) ,
  @Sw_Error CHAR (1)
 SET NOCOUNT ON
 DECLARE @nCorrDet Integer,
  @cMensaje VARCHAR(255),
  @cError  VARCHAR(1),
  @cTipInst CHAR(6)
 DECLARE @nMontLimIni NUMERIC(19,04),
  @nMontLimVen NUMERIC(19,04),
  @nExceso NUMERIC(19,04)
 SELECT @Sw_Error = 'N'
 DECLARE Cursor_Lim SCROLL CURSOR FOR
 SELECT FechaOperacion,
  Codigo_Producto,
  InCodigo,
  SUM(MontoTransaccion),
  MAX(FechaVencimiento),
  Check_Operacion,
  Check_Instrumento 
 FROM LIMITE_TRANSACCION
 WHERE NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 GROUP BY
  FechaOperacion,
  Codigo_Producto,
  InCodigo,
  Check_Operacion,
  Check_Instrumento
 OPEN Cursor_Lim
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_Lim
  INTO @dFecPro ,
   @cProducto ,
   @nCodInst ,
   @nMonto  ,
   @dFecvctop ,
   @cCheckLimOp ,
   @cCheckLimInst
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  --*************************************
  --*************** INICIO LIMITES OP.***
  IF @cCheckLimOp = 'S'
  BEGIN
   SELECT @cMensaje = ''
   IF EXISTS(SELECT * FROM MATRIZ_ATRIBUCION WHERE Usuario = @cUsuario AND Codigo_Producto  = @cProducto)
   BEGIN
    SELECT @nMontLimIni = 0,
     @nMontLimVen = 0
    SELECT @nMontLimIni = MontoInicio,
     @nMontLimVen = MontoFinal
    FROM MATRIZ_ATRIBUCION
    WHERE Usuario  = @cUsuario
    AND Codigo_Producto = @cProducto
    AND Plazo_Desde    <= DATEDIFF(day, @dFecPro, @dFecvctop)
    AND Plazo_Hasta    >= DATEDIFF(day, @dFecPro, @dFecvctop)
    IF @nMontLimIni > @nMonto
     SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto No Alcanza a cubrir Minimo de Operación en',
      @nExceso  = @nMontLimIni - @nMonto
    IF @nMontLimVen < @nMonto
     SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto Sobrepasa Maximo de Operación en ',
      @nExceso  = @nMonto - @nMontLimVen
   END ELSE
   BEGIN
    SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene Privilegios para esta Operación ' ,
     @nExceso  = 0       
   END
   IF @cMensaje <> ''
   BEGIN
    SELECT @Sw_Error = 'S'
    INSERT INTO LIMITE_TRANSACCION_ERROR
    SELECT @nNumoper ,
     @cSistema ,
     @nExceso ,
     @cMensaje
   END
  END
  --*************************************
  --*************** FIN LIMITES OP.******
  --*************************************
  --********** INICIO LIMITES OP.INST ***
  IF @cCheckLimInst = 'S'
  BEGIN
   SELECT  @cMensaje = ''
   SELECT @cTipInst = inserie
   FROM INSTRUMENTO
   WHERE incodigo = @nCodInst
  
   IF EXISTS(SELECT * FROM MATRIZ_ATRIBUCION_INSTRUMENTO WHERE Usuario = @cUsuario AND Codigo_Producto  = @cProducto AND Incodigo = @nCodInst)
   BEGIN
    SELECT @nMontLimIni = 0,
     @nMontLimVen = 0
    SELECT @nMontLimIni = MontoInicio,
     @nMontLimVen = MontoFinal
    FROM MATRIZ_ATRIBUCION_INSTRUMENTO
    WHERE Usuario  = @cUsuario
    AND Codigo_Producto = @cProducto
    AND Incodigo = @nCodInst
    AND Plazo_Desde    <= DATEDIFF(day, @dFecPro, @dFecvctop)
    AND Plazo_Hasta    >= DATEDIFF(day, @dFecPro, @dFecvctop)
    IF @nMontLimIni > @nMonto
     SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto No Alcanza a cubrir Minimo de Instrumento ' + RTRIM(LTRIM(@cTipInst)) +' en',
      @nExceso  = @nMontLimIni - @nMonto
    IF @nMontLimVen < @nMonto
     SELECT  @cMensaje = 'Monto Sobrepasa Maximo de Instrumento ' + RTRIM(LTRIM(@cTipInst)) +' en',
      @nExceso  = @nMonto - @nMontLimVen
  END ELSE
   BEGIN
    SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene Privilegios para Instrumento ' + @cTipInst ,
     @nExceso  = 0
   END
   IF @cMensaje <> ''
BEGIN
    SELECT @Sw_Error = 'S'
    INSERT INTO LIMITE_TRANSACCION_ERROR
    SELECT @nNumoper ,
     @cSistema ,
     @nExceso ,
     @cMensaje
   END
  END
  --*************************************
  --********** FIN LIMITES OP.INST ******
 END
 CLOSE Cursor_Lim
 DEALLOCATE Cursor_Lim
 IF @Sw_Error = 'S'
  SELECT 'NO', 'Usuario No Tiene Privilegios Suficientes Sobre Operación'
 ELSE
  SELECT 'OK'
  
 SET NOCOUNT OFF
END
-- select * from CONTROL_FINANCIERO
-- select * from LINEA_TRANSACCION
-- select * from MATRIZ_ATRIBUCION
-- select * from MATRIZ_ATRIBUCION_INSTRUMENTO
-- select * from LIMITE_TRANSACCION
-- select * from LIMITE_TRANSACCION_ERROR
-- EXECUTE Sp_Limites_ReChequear 'BTR', 36530, 'ADMINISTRA'
-- SELECT MOSTATREG FROM BACTRADERSUDA..MDMO


GO
