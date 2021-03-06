USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Limites_Chequear]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Limites_Chequear] (
      @cSistema CHAR (03) ,
      @nNumoper NUMERIC (10,0) ,
      @Tipo  Char(1)  ,
      @UsuarArpob Char(15) ,
      @cMensAprob VARCHAR(255) OUTPUT
     )
AS
BEGIN
-- ESTE PROCEDIMEITO SE MANDA A EJECUTAR DESDE 2 PANTALLA, en el SP_LINEAS_GRBOPERACIO en el chequeo de la operacion con @Tipo ='S'
-- y en el SP_LINEA_AUTORIZA en el montiro de operaciones con @Tipo ='N', esto es para centralizar el cheque de la matriz
-- en el mismo procedimiento
-- MQUILO

 SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
 SET NOCOUNT ON
        SET DATEFORMAT dmy

 DECLARE @dFecPro  DATETIME ,
  @cProducto CHAR (05) ,
  @nCodInst NUMERIC (05,0) ,
  @nMonto  NUMERIC (19,4) ,
  @dFecvctop DATETIME ,
  @cUsuario CHAR (15) ,
  @cCheckLimOp CHAR (1) ,
  @cCheckLimInst CHAR (1) ,
  @nCorrLinea Integer  ,
  @cCodigo_Grupo CHAR(10) ,
  @cTipoUsuario CHAR (15) ,
  @nMoneda NUMERIC (05,0) ,
  @iFound  Integer  ,
  /*control*/
  @Moneda1 NUMERIC (05) ,
  @Moneda2 NUMERIC (05) ,
  @MontoMX2 NUMERIC (19,4) ,
  @cTipoper CHAR(01) ,
  @cTipo_Moneda   CHAR(1)  ,
  @nMontoUSD NUMERIC (19,4) ,
  @cFuerte        CHAR(1)  ,
         @nParidad       FLOAT  ,
         @cNemo          CHAR(8)



 DECLARE @nCorrDet Integer,
  @cMensaje VARCHAR(255),
  @cError  VARCHAR(1),
  @cTipInst CHAR(15)


 DECLARE @nMontLimIni NUMERIC(19,04),
  @nMontLimVen NUMERIC(19,04),
  @nExceso NUMERIC(19,04),
  @cCod_Excepcion CHAR(02)


 SET @cCodigo_Grupo=''
 SET   @cMensAprob = ''
 SET  @cCod_Excepcion ='MA'


 IF @Tipo ='S'
  DELETE LIMITE_TRANSACCION_ERROR WITH (ROWLOCK)
  WHERE NumeroOperacion        = @nNumoper
  AND Id_Sistema        = @cSistema
         AND     RTRIM(tipo_Control)    = ''

 

 DECLARE Cursor_Lim SCROLL CURSOR FOR
 SELECT FechaOperacion,
  Codigo_Producto,
  InCodigo,
  SUM(MontoTransaccion),
  MAX(FechaVencimiento),
  Operador,
  Check_Operacion,
  Check_Instrumento,
  Moneda
  /*,
  Moneda1 ,
  Moneda2 ,
  sum(montoMX2),
  cTipoper,
  sum(nMontoUsd)
  */

        FROM LIMITE_TRANSACCION WITH (NOLOCK INDEX=IX_LIMITE_TRANSACCION)
 WHERE NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 GROUP BY
  FechaOperacion,
  Codigo_Producto,
  InCodigo,
  Operador,
  Check_Operacion,
  Check_Instrumento,
  Moneda
  /*,
  Moneda1 ,
  Moneda2 ,
  cTipoper
  */


 OPEN Cursor_Lim


 SELECT @nCorrLinea=0

 WHILE (1=1)
 BEGIN

  FETCH NEXT FROM cursor_Lim
  INTO @dFecPro ,
   @cProducto ,
   @nCodInst ,
   @nMonto  ,
   @dFecvctop ,
   @cUsuario ,
   @cCheckLimOp ,
   @cCheckLimInst ,
   @nMoneda/* ,
   @Moneda1 ,
   @Moneda2 ,
   @montoMX2 ,
   @cTipoper ,
   @nMontoUsd
   */

  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END

  IF @Tipo = 'N'
   SELECT @cUsuario = @UsuarArpob

  SELECT @cTipoUsuario = tipo_usuario FROM usuario WITH (NOLOCK) WHERE usuario = @cUsuario

  --*************************************
  --*************** INICIO LIMITES OP.***

--select @cCheckLimOp ,  @cCheckLimInst 
  IF @cCheckLimOp = 'S'
  BEGIN
   SELECT @cMensaje = ''
   

   /*********************control***************************/
   /*
   IF @cSistema = 'BFW' AND (@cProducto in (1,2,8))
   BEGIN
    SET @nMoneda=0
    IF(@cTipoper='C')  --COMPRA
     SET @nMoneda = @Moneda1
    ELSE
     SET @nMoneda = @Moneda2
  
    SELECT @cTipo_Moneda= mnextranj, @cFuerte= mnrrda, @cNemo=mnnemo
    FROM MONEDA WHERE mncodmon=@nMoneda
  
    IF @cTipo_Moneda=0 AND @nMoneda=13
    BEGIN
     SET @nMonto = @nMontoUsd --MONTO_USD
    END ELSE BEGIN 
     IF @cTipo_Moneda = 0 AND @nMoneda <> 13 BEGIN
      SET @nMonto = @montoMX2 
     END
    END
   END

   */


--select @cTipoUsuario, @cSistema, @cProducto, @nMoneda

   IF EXISTS( SELECT 1
     FROM MATRIZ_ATRIBUCION WITH (NOLOCK)
     WHERE Tipo_Usuario = @cTipoUsuario
     AND Id_Sistema   = @cSistema
     AND Codigo_Producto  = @cProducto
     AND Moneda = @nMoneda
     )
   BEGIN

    SET @nMontLimIni = 0
    SET @nMontLimVen = 0
    SET @iFound  = 0



    SELECT @nMontLimIni = MontoInicio,
     @nMontLimVen = MontoFinal,
     @iFound  = 1
    FROM MATRIZ_ATRIBUCION WITH (NOLOCK INDEX=PK_MATRIZ_ATRIBUCION)
    WHERE Tipo_Usuario = @cTipoUsuario
    AND Id_Sistema    = @cSistema
    AND Codigo_Producto = @cProducto
    AND (DATEDIFF(day, @dFecPro, @dFecvctop) >= Plazo_Desde OR @cSistema = 'BCC')
    AND (DATEDIFF(day, @dFecPro, @dFecvctop) < Plazo_Hasta OR @cSistema = 'BCC')
    AND Moneda   = @nMoneda

    IF @nMontLimIni > @nMonto AND @iFound = 1
        BEGIN
     SET  @cMensaje   = RTRIM(LTRIM(@cUsuario)) + ': Monto No Alcanza a cubrir Minimo de Operación en '
     SET  @cMensAprob = ': Monto No Alcanza a cubrir Minimo de Operación '
     SET  @nExceso    = @nMontLimIni - @nMonto
        END
    IF @nMontLimVen < @nMonto  AND @iFound = 1
        BEGIN
     SET  @cMensaje   = RTRIM(LTRIM(@cUsuario)) + ': Monto Sobrepasa Maximo de Operación en '
     SET  @cMensAprob = ': Monto Sobrepasa Maximo de Operación '
     SET  @nExceso    = @nMonto - @nMontLimVen
        END

    IF @iFound = 0
        BEGIN
     SET  @cMensaje   = RTRIM(LTRIM(@cUsuario)) + ': Operacion Fuera de Rango de Plazos '
     SET  @cMensAprob = ': Operacion Fuera de Rango de Plazos '
     SET  @nExceso    = 0
        END


   END ELSE
   BEGIN

    SET  @cMensaje   = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene Privilegios para esta Operación '
    SET  @cMensAprob = ': Usuario no tiene Privilegios para esta Operación '
    SET  @nExceso    = 0       

   END


   IF @cMensaje <> '' AND @Tipo ='S'
   BEGIN

    SET @nCorrLinea=@nCorrLinea+1


    INSERT INTO LIMITE_TRANSACCION_ERROR  WITH (ROWLOCK)
    VALUES( @dFecPro ,
     @nNumoper ,
     @cSistema ,
     @cProducto ,
     @cCodigo_Grupo ,
     @nExceso ,
     @cMensaje       ,
                                        @nCorrLinea ,
                                        ''  ,
     @cCod_Excepcion )


   END

  END

  --*************************************
  --*************** FIN LIMITES OP.******




  --*************************************
  --********** INICIO LIMITES OP.INST ***

  IF @cCheckLimInst = 'S'
  BEGIN
   SET @cMensaje = ''
   SET @cTipInst = ''

-- SELECT * FROM INSTRUMENTO
   IF @cSistema='BTR'
    SELECT @cTipInst = inserie
    FROM INSTRUMENTO WITH (NOLOCK)
    WHERE incodigo = @nCodInst

   IF @cSistema='INV'
    SELECT @cTipInst = Nom_Familia
    FROM VIEW_INSTRUMENTO_INVERSION_EXTERIOR
    WHERE Cod_familia = @nCodInst

  
--select @cUsuario, @cProducto, @nCodInst
-- SELECT * FROM MATRIZ_ATRIBUCION WHERE Id_Sistema = 'inv'
-- SELECT * FROM VIEW_INSTRUMENTO_INVERSION_EXTERIOR
-- SP_hELP INSTRUMENTO
-- SP_hELP MATRIZ_ATRIBUCION
   IF EXISTS( SELECT Tipo_Usuario
     FROM MATRIZ_ATRIBUCION WITH (NOLOCK INDEX=PK_MATRIZ_ATRIBUCION)
     WHERE Tipo_Usuario = @cTipoUsuario
     AND Codigo_Producto  = @cProducto
     AND Incodigo = @nCodInst
    )
   BEGIN


    SET @nMontLimIni = 0
    SET @nMontLimVen = 0
    SET @iFound      = 0



    SELECT @nMontLimIni = MontoInicio,
     @nMontLimVen = MontoFinal,
     @iFound      = 1
    FROM MATRIZ_ATRIBUCION WITH (NOLOCK INDEX=PK_MATRIZ_ATRIBUCION)
    WHERE Tipo_Usuario  = @cTipoUsuario
    AND Id_Sistema    = @cSistema
    AND Codigo_Producto = @cProducto
    AND Incodigo = @nCodInst
    AND (DATEDIFF(day, @dFecPro, @dFecvctop) >= Plazo_Desde OR @cSistema = 'BCC')
    AND (DATEDIFF(day, @dFecPro, @dFecvctop) < Plazo_Hasta OR @cSistema = 'BCC')


      
    IF @nMontLimIni > @nMonto  AND @iFound = 1
        BEGIN
     SET @cMensaje   = RTRIM(LTRIM(@cUsuario)) + ': Monto No Alcanza a cubrir Minimo de Instrumento ' + RTRIM(LTRIM(@cTipInst)) +' en'
     SET @cMensAprob = ': Monto No Alcanza a cubrir Minimo de Instrumento ' + RTRIM(LTRIM(@cTipInst))
     SET @nExceso    = @nMontLimIni - @nMonto
        END

    IF @nMontLimVen < @nMonto AND @iFound = 1
        BEGIN
     SET @cMensaje   = RTRIM(LTRIM(@cUsuario)) + ': Monto Sobrepasa Maximo de Instrumento ' + RTRIM(LTRIM(@cTipInst)) +' en'
     SET @cMensAprob = ': Monto Sobrepasa Maximo de Instrumento ' + RTRIM(LTRIM(@cTipInst))
     SET @nExceso    = @nMonto - @nMontLimVen
        END

    IF @iFound = 0
        BEGIN
     SET @cMensaje   = RTRIM(LTRIM(@cUsuario)) + ': Instrumento Fuera de Rango de Plazos '
     SET @cMensAprob = ': Instrumento Fuera de Rango de Plazos '
     SET @nExceso    = 0
        END

      END 
   ELSE
   BEGIN

    SET @cMensaje   = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene Privilegios para Instrumento ' + @cTipInst 
    SET @cMensAprob = ': Usuario no tiene Privilegios para Instrumento ' + @cTipInst 
    SET @nExceso    = 0

   END


   IF @cMensaje <> ''  AND @Tipo ='S'
   BEGIN

    SET @nCorrLinea=@nCorrLinea+1

    INSERT INTO LIMITE_TRANSACCION_ERROR WITH (ROWLOCK)
    VALUES ( @dFecPro ,
       @nNumoper ,
       @cSistema ,
       @cProducto ,
       @cCodigo_Grupo ,
       @nExceso ,
       @cMensaje       ,
                                          @nCorrLinea     ,
                     ''  ,
       @cCod_Excepcion )
   END

  END

  --*************************************
  --********** FIN LIMITES OP.INST ******


 END

 CLOSE Cursor_Lim
 DEALLOCATE Cursor_Lim


END

GO
