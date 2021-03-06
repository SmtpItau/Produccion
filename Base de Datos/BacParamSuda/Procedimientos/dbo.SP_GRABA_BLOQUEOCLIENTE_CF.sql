USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_BLOQUEOCLIENTE_CF]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_BLOQUEOCLIENTE_CF]  
(  
 @codSistema  CHAR(3),  
 @codProducto  CHAR(5),  
 @NumOp   NUMERIC(10),  
 @tipoOp   CHAR(1),  
 @Motivo   VARCHAR(70)  
)  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @RutCliente  NUMERIC(9, 0)  
  , @CodCliente  NUMERIC(9, 0)  
  , @MontoOp  NUMERIC(21, 4)  
  , @codProdSwap NUMERIC(1, 0)  
  , @correlInterno INTEGER  
  , @fechaInicio DATETIME  
  , @fechaVcto  DATETIME  
  , @TipoCambio  NUMERIC(9, 4)  
  , @Operador  VARCHAR(15)  
  , @NumDocu  NUMERIC(10, 0)  
  
 SELECT  @correlInterno = 0  
  
 SELECT @NumDocu = @NumOp  
  
 SELECT @correlInterno = ISNULL(MAX(NumeroCorre_Detalle),0)  
 FROM BacLineas..LINEA_TRANSACCION_DETALLE  
 WHERE NumeroOperacion = @NumOp  
 AND Id_Sistema = @codSistema  
 AND NumeroCorrelativo = 1  
  
 SELECT @correlInterno = @correlInterno + 1  
  
 IF @codSistema = 'BCC'  
 BEGIN  
  IF NOT EXISTS(SELECT MONUMOPE  
    FROM BacCamSuda..MEMO  
    WHERE MOTIPMER = @codProducto  
    AND MONUMOPE = @NumOp  
    AND MOTIPOPE = @tipoOp)  
   SELECT 'Error','No se encontró el movimiento en tabla MEMO'  
  ELSE   
  BEGIN  
   UPDATE BacCamSuda..MEMO  
   SET MOESTATUS = 'P'  
   WHERE MOTIPMER = @codProducto  
   AND MONUMOPE = @NumOp  
   AND MOTIPOPE = @tipoOp  
   AND MOESTATUS <> 'P'  
     
   /*  
   IF @@ROWCOUNT = 0  
   BEGIN  
    SELECT 'Error','No se pudo actualizar en tabla MEMO'  
    RETURN 0  
   END  
   */  
        
   IF @tipoOp = 'C' ---Compra  
   BEGIN  
    SELECT  @RutCliente = MORUTCLI,  
    @CodCliente = MOCODCLI,  
    @MontoOp    = MOMONMO,  
    @fechaInicio= MOFECH,  
    @fechaVcto  = MOVALUTA2,  
    @TipoCambio = MOTICAM,  
    @Operador   = MOOPER  
    FROM BacCamSuda..MEMO  
    WHERE MOTIPMER = @codProducto  
    AND MONUMOPE = @NumOp  
    AND MOTIPOPE = @tipoOp  
   END  
   ELSE --- Venta  
   BEGIN  
    SELECT  @RutCliente = MORUTCLI,  
    @CodCliente = MOCODCLI,  
    @MontoOp    = MOMONMO,  
    @fechaInicio= MOFECH,  
    @fechaVcto  = MOVALUTA1,  
    @TipoCambio = MOTICAM,  
    @Operador   = MOOPER  
    FROM BacCamSuda..MEMO  
    WHERE MOTIPMER = @codProducto  
    AND MONUMOPE = @NumOp  
    AND MOTIPOPE = @tipoOp  
   END      
  
  
   /* Primero, insertar en tabla LINEA_TRANSACCION */  
   IF NOT EXISTS(SELECT NumeroOperacion FROM BacLineas..LINEA_TRANSACCION  
      WHERE Id_Sistema = @codSistema  
      AND NumeroOperacion = @NumOp  
      AND Rut_Cliente = @RutCliente  
      AND Codigo_Cliente = @CodCliente)  
   BEGIN  
    INSERT INTO BacLineas..LINEA_TRANSACCION (  
       NumeroOperacion  
      ,NumeroDocumento  
      ,NumeroCorrelativo  
      ,Rut_Cliente  
      ,Codigo_Cliente  
      ,Id_Sistema  
      ,Codigo_Producto  
      ,Tipo_Operacion  
      ,Tipo_Riesgo  
      ,FechaInicio  
      ,FechaVencimiento  
      ,MontoOriginal  
      ,TipoCambio  
      ,MatrizRiesgo  
      ,MontoTransaccion  
      ,Operador  
      ,Activo  
      )  
     VALUES( @NumOp,  
      @NumDocu,  
      2,  
      @RutCliente,  
      @CodCliente,  
      @codSistema,  
      @codProducto,  
      '',  
      'C',  
      @fechaInicio,  
      @fechaVcto,  
      @MontoOp,  
      @TipoCambio,  
      0,  
      0,  
      @Operador,  
      'S'  
      )  
  
    IF @@ROWCOUNT = 0  
    BEGIN  
     SELECT 'Error','No se pudo insertar en tabla LINEA_TRANSACCION'  
     RETURN 0  
    END     
   END  
     
   /* Segundo, insertar en tabla LINEA_TRANSACCION_DETALLE */    
   INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE (  
      NumeroOperacion  
     ,NumeroDocumento  
     ,NumeroCorrelativo  
     ,NumeroCorre_Detalle  
     ,Rut_Cliente  
     ,Codigo_Cliente  
     ,Id_Sistema  
     ,Codigo_Producto  
     ,Tipo_Detalle  
     ,Tipo_Movimiento  
     ,Linea_Transsaccion  
     ,MontoTransaccion  
     ,MontoExceso  
     ,PlazoDesde  
     ,PlazoHasta  
     ,Actualizo_Linea  
     ,Error  
     ,Mensaje_Error  
     ,moneda  
     ,forma_pago  
     ,Grupo_Emisor  
     ,instrumento  
     )  
    VALUES( @NumOp,  
     @NumDocu,  
     2,  
     @correlInterno,  
     @RutCliente,  
     @CodCliente,  
     @codSistema,  
     @codProducto,  
     'L',  
     'S',  
     'BLQCLI',  
     @MontoOp,  
     0,  
     0,  
     0,  
     'N',  
     'S',  
     @Motivo,  
     0,  
     0,  
     '',  
     0 )  
   IF @@ROWCOUNT = 0  
   BEGIN  
    SELECT 'Error','No se pudo insertar en tabla LINEA_TRANSACCION_DETALLE'  
    RETURN 0  
   END       
     
   SELECT 'OK','OK'  
  END  
 END --- @codSistema = 'BCC'  
 IF @codSistema = 'BTR'  --- Aplicar solo para Pactos (CI, VI)  
 BEGIN  
  IF @codProducto NOT IN ('CI','VI')  
   SELECT 'Error','La operación no corresponde'  
  ELSE  
  BEGIN  
   IF NOT EXISTS(SELECT monumoper  
     FROM BacTraderSuda..mdmo  
     WHERE monumoper = @NumOp  
     AND motipoper = @codProducto)  
    SELECT 'Error','No se encontró el movimiento en tabla mdmo'  
   ELSE   
   BEGIN  
    UPDATE BacTraderSuda..mdmo  
    SET mostatreg = 'P'  
    WHERE monumoper = @NumOp  
    AND motipoper = @codProducto  
    AND mostatreg <> 'P'  
      
    /*  
    IF @@ROWCOUNT = 0  
    BEGIN  
     SELECT 'Error','No se pudo actualizar en tabla mdmo'  
     RETURN 0  
    END  
    */  
      
    IF @codProducto IN ( 'CI','VI' )  
     SELECT  @RutCliente = morutcli,  
     @CodCliente = mocodcli,  
     @MontoOp    = movpresen,  
     @fechaInicio= mofecemi,  
     @fechaVcto  = mofecven,  
     @TipoCambio = 0.0,  
     @Operador   = mousuario  
     FROM BacTraderSuda..mdmo  
     WHERE monumoper = @NumOp  
     AND motipoper = @codProducto  
  
    /* Primero, insertar en tabla LINEA_TRANSACCION */  
    IF NOT EXISTS(SELECT NumeroOperacion FROM BacLineas..LINEA_TRANSACCION  
      WHERE Id_Sistema = @codSistema  
      AND NumeroOperacion = @NumOp  
      AND Rut_Cliente = @RutCliente  
      AND Codigo_Cliente = @CodCliente)  
    BEGIN  
     INSERT INTO BacLineas..LINEA_TRANSACCION (  
        NumeroOperacion  
       ,NumeroDocumento  
       ,NumeroCorrelativo  
       ,Rut_Cliente  
       ,Codigo_Cliente  
       ,Id_Sistema  
       ,Codigo_Producto  
       ,Tipo_Operacion  
       ,Tipo_Riesgo  
       ,FechaInicio  
       ,FechaVencimiento  
       ,MontoOriginal  
       ,TipoCambio  
       ,MatrizRiesgo  
       ,MontoTransaccion  
       ,Operador  
       ,Activo  
       )  
      VALUES( @NumOp,  
       @NumDocu,  
       2,  
       @RutCliente,  
       @CodCliente,  
       @codSistema,  
       @codProducto,  
       SUBSTRING(@codProducto, 1, 1),  
       'C',  
       @fechaInicio,  
       @fechaVcto,  
       @MontoOp,  
       @TipoCambio,  
       0,  
       0,  
       @Operador,  
       'S'  
       )  
         
     IF @@ROWCOUNT = 0  
     BEGIN  
      SELECT 'Error','No se pudo insertar en tabla LINEA_TRANSACCION'  
      RETURN 0  
     END  
    END  
      
    INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE(  
       NumeroOperacion  
      ,NumeroDocumento  
      ,NumeroCorrelativo  
      ,NumeroCorre_Detalle  
      ,Rut_Cliente  
      ,Codigo_Cliente  
      ,Id_Sistema  
      ,Codigo_Producto  
      ,Tipo_Detalle  
      ,Tipo_Movimiento  
      ,Linea_Transsaccion  
      ,MontoTransaccion  
      ,MontoExceso  
      ,PlazoDesde  
      ,PlazoHasta  
      ,Actualizo_Linea  
      ,Error  
      ,Mensaje_Error  
      ,moneda  
      ,forma_pago  
      ,Grupo_Emisor  
      ,instrumento  
      )  
     VALUES( @NumOp,  
      @NumDocu,  
      2,  
      @correlInterno,  
      @RutCliente,  
      @CodCliente,  
      @codSistema,  
      @codProducto,  
      'L',  
      'S',  
      'BLQCLI',  
      @MontoOp,  
      0,  
      0,  
      0,  
      'N',  
      'S',  
      @Motivo,  
      0,  
      0,  
      '',  
      0 )  
    IF @@ROWCOUNT = 0  
    BEGIN  
     SELECT 'Error','No se pudo insertar en tabla LINEA_TRANSACCION_DETALLE'  
     RETURN 0  
    END  
    SELECT 'OK','OK'  
   END  
  END  
 END --- @codSistema = 'BTR'  
 IF @codSistema = 'BFW'  
 BEGIN  
  IF NOT EXISTS(SELECT monumoper  
    FROM BacFwdSuda..mfmo ---WITH(nolock)  
    WHERE monumoper = @NumOp  
    AND mocodpos1 = CONVERT(NUMERIC(2,0), @codProducto)  
    AND motipoper = @tipoOp)  
   SELECT 'Error','No se encontró el movimiento en tabla mfmo'  
  ELSE   
  BEGIN  
   UPDATE BacFwdSuda..mfmo  
   SET moestado = 'P'  
   WHERE monumoper = @NumOp  
   AND mocodpos1 = CONVERT(NUMERIC(2,0), @codProducto)  
   AND motipoper = @tipoOp  
   AND moestado <> 'P'  
     
   SELECT  @RutCliente = mocodigo,  
    @CodCliente = mocodcli,  
    @MontoOp    = momtomon1,  
    @fechaInicio= mofecha,  
    @fechaVcto  = mofecvcto,  
    @TipoCambio = motipcam,  
    @Operador   = mooperador  
    FROM BacFwdSuda..mfmo ---WITH(nolock)  
    WHERE monumoper = @NumOp  
    AND mocodpos1 = CONVERT(NUMERIC(2,0), @codProducto)  
    AND motipoper = @tipoOp  
  
   /* Primero, insertar en tabla LINEA_TRANSACCION */  
   IF NOT EXISTS(SELECT NumeroOperacion FROM BacLineas..LINEA_TRANSACCION  
      WHERE Id_Sistema = @codSistema  
      AND NumeroOperacion = @NumOp  
      AND Rut_Cliente = @RutCliente  
      AND Codigo_Cliente = @CodCliente)  
   BEGIN  
    INSERT INTO BacLineas..LINEA_TRANSACCION (  
       NumeroOperacion  
      ,NumeroDocumento  
      ,NumeroCorrelativo  
      ,Rut_Cliente  
      ,Codigo_Cliente  
      ,Id_Sistema  
      ,Codigo_Producto  
      ,Tipo_Operacion  
      ,Tipo_Riesgo  
      ,FechaInicio  
      ,FechaVencimiento  
      ,MontoOriginal  
      ,TipoCambio  
      ,MatrizRiesgo  
      ,MontoTransaccion  
      ,Operador  
      ,Activo  
      )  
     VALUES( @NumOp,  
      @NumDocu,  
      2,  
      @RutCliente,  
      @CodCliente,  
      @codSistema,  
      @codProducto,  
      '',  
      'C',  
      @fechaInicio,  
      @fechaVcto,  
      CONVERT(NUMERIC(19, 4), @MontoOp),  
      CONVERT(NUMERIC(8, 4), @TipoCambio),  
      0,  
      0,  
      @Operador,  
      'S'  
      )  
      
    IF @@ROWCOUNT = 0  
    BEGIN  
     SELECT 'Error','No se pudo insertar en tabla LINEA_TRANSACCION'  
     RETURN 0  
    END  
   END  
     
   INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE(  
      NumeroOperacion  
     ,NumeroDocumento  
     ,NumeroCorrelativo  
     ,NumeroCorre_Detalle  
     ,Rut_Cliente  
     ,Codigo_Cliente  
     ,Id_Sistema  
     ,Codigo_Producto  
     ,Tipo_Detalle  
     ,Tipo_Movimiento  
     ,Linea_Transsaccion  
     ,MontoTransaccion  
     ,MontoExceso  
     ,PlazoDesde  
     ,PlazoHasta  
     ,Actualizo_Linea  
     ,Error  
     ,Mensaje_Error  
     ,moneda  
     ,forma_pago  
     ,Grupo_Emisor  
     ,instrumento  
     )  
    VALUES( @NumOp,  
     @NumDocu,  
     2,  
     @correlInterno,  
     @RutCliente,  
     @CodCliente,  
     @codSistema,  
     @codProducto,  
     'L',  
     'S',  
     'BLQCLI',  
     @MontoOp,  
     0,  
     0,  
     0,  
     'N',  
     'S',  
     @Motivo,  
     0,  
     0,  
     '',  
     0 )  
   IF @@ROWCOUNT = 0  
   BEGIN  
    SELECT 'Error','No se pudo insertar en tabla LINEA_TRANSACCION_DETALLE'  
    RETURN 0  
   END  
     
   SELECT 'OK','OK'  
  END  
 END --- @codSistema = 'BFW'  
 IF @codSistema = 'PCS'  
 BEGIN  
  /* Primero traducir el tipo de Swap */  
  /*  
  IF @codProducto = 'ST'  
   SELECT @codProdSwap = 1  
  IF @codProducto = 'SM'  
   SELECT @codProdSwap = 2  
  IF @codProducto = 'SP'  
   SELECT @codProdSwap = 3  
  */  
    
  SELECT @codProdSwap = CONVERT(NUMERIC(1,0), @codProducto)   
  
                DECLARE @iMinFlujo   NUMERIC(9)  
                    SET @iMinFlujo   = (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA  
                                                                WHERE numero_operacion = @NumOp and tipo_flujo = 1)  
  
  IF NOT EXISTS(SELECT numero_operacion  
    FROM BacSwapSuda..MovDiario  
    WHERE numero_operacion = @NumOp  
    AND tipo_swap = @codProdSwap  
    AND tipo_operacion = @tipoOp  
    AND numero_flujo = @iMinFlujo  
    AND tipo_flujo = 1)  
  
   SELECT 'Error','No se encontró el movimiento en tabla MovDiario'  
  ELSE   
  BEGIN  
   SELECT  @RutCliente = rut_cliente,  
    @CodCliente = codigo_cliente,  
    @Operador   = operador,  
    @fechaInicio= fecha_cierre,  
    @fechaVcto  = fecha_termino,  
    @TipoCambio = 0.0  
  
    FROM BacSwapSuda..MovDiario  
    WHERE numero_operacion = @NumOp  
    AND tipo_swap = @codProdSwap  
    AND tipo_operacion = @tipoOp  
    AND numero_flujo = @iMinFlujo  
    AND tipo_flujo = 1  
  
   IF @tipoOp = 'C'  
    SELECT  @MontoOp = compra_capital  
     FROM BacSwapSuda..MovDiario  
     WHERE numero_operacion = @NumOp  
     AND tipo_swap = @codProdSwap  
     AND tipo_operacion = @tipoOp  
     AND @tipoOp = 'C'  
     AND numero_flujo = @iMinFlujo  
     AND tipo_flujo = 1  
   ELSE  
    SELECT  @MontoOp = venta_capital  
     FROM BacSwapSuda..MovDiario  
     WHERE numero_operacion = @NumOp  
     AND tipo_swap = @codProdSwap  
     AND tipo_operacion = @tipoOp  
     AND @tipoOp = 'V'  
     AND numero_flujo = @iMinFlujo  
     AND tipo_flujo = 1  
  
  
   /* Primero, insertar en tabla LINEA_TRANSACCION */  
   IF NOT EXISTS(SELECT NumeroOperacion FROM BacLineas..LINEA_TRANSACCION  
      WHERE Id_Sistema = @codSistema  
      AND NumeroOperacion = @NumOp  
      AND Rut_Cliente = @RutCliente  
      AND Codigo_Cliente = @CodCliente)  
   BEGIN  
    INSERT INTO BacLineas..LINEA_TRANSACCION (  
       NumeroOperacion  
      ,NumeroDocumento  
      ,NumeroCorrelativo  
      ,Rut_Cliente  
      ,Codigo_Cliente  
      ,Id_Sistema  
      ,Codigo_Producto  
      ,Tipo_Operacion  
      ,Tipo_Riesgo  
      ,FechaInicio  
      ,FechaVencimiento  
      ,MontoOriginal  
      ,TipoCambio  
      ,MatrizRiesgo  
      ,MontoTransaccion  
      ,Operador  
      ,Activo  
      )  
     VALUES( @NumOp,  
      @NumDocu,  
      2,  
      @RutCliente,  
      @CodCliente,  
      @codSistema,  
      @codProducto,  
      '',  
      'C',  
      @fechaInicio,  
      @fechaVcto,  
      @MontoOp,  
      @TipoCambio,  
      0,  
      0,  
      @Operador,  
      'S'  
      )  
    IF @@ROWCOUNT = 0  
    BEGIN  
     SELECT 'Error','No se pudo insertar en tabla LINEA_TRANSACCION'  
     RETURN 0  
    END  
   END  
     
   INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE(  
      NumeroOperacion  
     ,NumeroDocumento  
     ,NumeroCorrelativo  
     ,NumeroCorre_Detalle  
     ,Rut_Cliente  
     ,Codigo_Cliente  
     ,Id_Sistema  
     ,Codigo_Producto  
     ,Tipo_Detalle  
     ,Tipo_Movimiento  
     ,Linea_Transsaccion  
     ,MontoTransaccion  
     ,MontoExceso  
     ,PlazoDesde  
     ,PlazoHasta  
     ,Actualizo_Linea  
     ,Error  
     ,Mensaje_Error  
     ,moneda  
     ,forma_pago  
     ,Grupo_Emisor  
     ,instrumento  
     )  
    VALUES( @NumOp,  
     @NumDocu,  
     2,  
     @correlInterno,  
     @RutCliente,  
     @CodCliente,  
     @codSistema,  
     @codProdSwap,  
     'L',  
     'S',  
     'BLQCLI',  
     @MontoOp,  
     0,  
     0,  
     0,  
     'N',  
     'S',  
     @Motivo,  
     0,  
     0,  
     '',  
     0 )  
   IF @@ROWCOUNT = 0  
   BEGIN  
    SELECT 'Error','No se pudo insertar en tabla LINEA_TRANSACCION_DETALLE'  
    RETURN 0  
   END  
       
   SELECT 'OK','OK'  
  END  
 END --- @codSistema = 'PCS'  
END
GO
