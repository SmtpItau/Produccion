USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_AGRUPACION]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MNT_AGRUPACION]
   (   @iTag           INTEGER
   ,   @dLiquidacion   DATETIME
   ,   @iOperacion     NUMERIC(9)   = 0
   ,   @cModulo        CHAR(3)      = ''
   ,   @cTipo          VARCHAR(10)  = ''
   ,   @iRut           NUMERIC(10)  = 0
   ,   @iCodigo        NUMERIC(10)  = 0
   ,   @iMoneda        INTEGER      = 0
   ,   @iMedioPago     INTEGER      = 0
   ,   @cEstado        CHAR(1)      = 'D'
   ,   @cUsuario       VARCHAR(50)  = ''
   ,   @iFolio         INTEGER      = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT acfecproc FROM BacTraderSuda..MDAC with (nolock) )

   IF @iTag = 1
   BEGIN
      UPDATE MDLBTR
      SET    Reservado          = ''
      WHERE  Fecha              = @dFechaProceso
      AND    fecha_vencimiento  = @dLiquidacion
        AND  Estado_Envio       = 'P'
        AND  Reservado          = @cUsuario

      SELECT  'MARCA'    = CASE WHEN Id_Paquete = 0 THEN ' ' ELSE 'M' END
         ,    'MODULO'   = sistema 
         ,    'TIPO'     = tipo_mercado
         ,    'NUMERO'   = numero_operacion
         ,    'RUT'      = rut_cliente
         ,    'CODIGO'   = codigo_cliente
         ,    'NOMBRE'   = clnombre
         ,    'MONEDA'   = mnnemo
         ,    'MONTO'    = monto_operacion
         ,    'FORMAPAGO'= glosa
         ,    'MOVTO'    = CASE WHEN Tipo_Movimiento = 'C' THEN 'CARGO' ELSE 'ABONO' END 
         ,    'CORR'     = RecCodSwift
         ,    'MT'       = CASE WHEN cltipcli = 1 THEN 'MT 202' ELSE 'MT 103' END
         ,    'EstEnvio' = Estado_Envio
        INTO  #TMP_OPERACIONES
        FROM  BacParamSuda..MDLBTR                   with (nolock)
              LEFT JOIN BacParamSuda..CLIENTE        with (nolock) ON clrut = rut_cliente and clcodigo = codigo_cliente
              LEFT JOIN BacParamSuda..MONEDA         with (nolock) ON mncodmon = moneda
              LEFT JOIN BacParamSuda..FORMA_DE_PAGO  with (nolock) ON codigo   = forma_pago
       WHERE  Fecha              = @dFechaProceso
         AND  fecha_vencimiento  = @dLiquidacion
         AND  Estado_Envio       = 'P' --> CASE WHEN @cEstado = 'D' THEN 'P' ELSE Estado_Envio END
         AND  Tipo_Movimiento    = 'C'
         AND  NOT (Sistema       = 'BTR' and tipo_mercado IN('CP','CI','VI'))
         AND (Sistema            = @cModulo    OR @cModulo    = '')
         AND (tipo_mercado       = @cTipo      OR @cTipo      = '')
         AND (Rut_Cliente        = @iRut       OR @iRut       = 0)
         AND (Codigo_Cliente     = @iCodigo    OR @iCodigo    = 0)
         AND (Moneda             = @iMoneda    OR @iMoneda    = 0)
         AND (forma_pago         = @iMedioPago OR @iMedioPago = 0)
         AND (Estado_Paquete     = @cEstado    OR @cEstado    = '')
         AND (Id_Paquete         = @iFolio     OR @iFolio     = 0)
      --> ORDER BY sistema, moneda, forma_pago, rut_cliente, codigo_cliente, numero_operacion, Tipo_Movimiento, Id_Paquete, Estado_Paquete

      UPDATE BacParamSuda..MDLBTR
         SET Reservado          = @cUsuario
        FROM #TMP_OPERACIONES 
       WHERE Fecha              = @dFechaProceso
         AND fecha_vencimiento  = @dLiquidacion
         AND Estado_Envio       = 'P'
         AND Sistema            = MODULO 
         AND numero_operacion   = NUMERO

      SELECT * FROM #TMP_OPERACIONES ORDER BY MODULO, TIPO, RUT, MONEDA, FORMAPAGO
   END

   IF @iTag = 2
   BEGIN
      UPDATE MDLBTR
      SET    Reservado          = @cUsuario
      WHERE  Fecha              = @dFechaProceso
      AND    fecha_vencimiento  = @dLiquidacion
      AND    Estado_Envio       = 'P'
      AND    numero_operacion   = @iOperacion
   END

   IF @iTag = 3
   BEGIN
      UPDATE MDLBTR
      SET    Reservado          = ''
      WHERE  Fecha              = @dFechaProceso
      AND    fecha_vencimiento  = @dLiquidacion
      AND    Estado_Envio       = 'P'
      AND    numero_operacion   = @iOperacion
      AND    Reservado    = @cUsuario
   END

   IF @iTag = 4
   BEGIN
      UPDATE MDLBTR
      SET    Reservado  = ''
      WHERE  Fecha              = @dFechaProceso
      AND    fecha_vencimiento  = @dLiquidacion
      AND    Estado_Envio       = 'P'
      AND    Reservado          = @cUsuario
   END

   IF @iTag = 5
   BEGIN
      DECLARE @iFolioGrupo      INTEGER
          SET @iFolioGrupo      = ISNULL( (SELECT MAX(Id_Paquete) FROM MDLBTR with (nolock) ) ,0) + 1

       UPDATE MDLBTR
          SET Id_Paquete        = @iFolioGrupo
            , Estado_Paquete    = 'A'
        WHERE fecha             = @dFechaProceso
          AND fecha_vencimiento = @dLiquidacion
          AND numero_operacion  = @iOperacion
          AND sistema           = @cModulo
          AND tipo_mercado      = @cTipo
          AND Tipo_Movimiento   = 'C'

       SELECT @iFolioGrupo
   END

   IF @iTag = 6 AND @iFolio > 0
   BEGIN   
       UPDATE MDLBTR
          SET Id_Paquete        = @iFolio
            , Estado_Paquete    = 'A'
        WHERE fecha             = @dFechaProceso
          AND fecha_vencimiento = @dLiquidacion
          AND numero_operacion  = @iOperacion
          AND sistema           = @cModulo
          AND tipo_mercado      = @cTipo
          AND Tipo_Movimiento   = 'C'
   END

   IF @iTag = 7
   BEGIN
      SELECT  'MARCA'            = ' ' -->Estado_Paquete
         ,    'MODULO'           = sistema 
         ,    'TIPO'             = tipo_mercado
         ,    'NUMERO'           = Id_Paquete --> numero_operacion
         ,    'RUT'              = rut_cliente
         ,    'CODIGO'           = codigo_cliente
         ,    'NOMBRE'           = clnombre
         ,    'MONEDA'           = mnnemo
         ,    'MONTO'            = monto_operacion
         ,    'FORMAPAGO'        = glosa
         ,    'MOVTO'            = CASE WHEN Tipo_Movimiento = 'C' THEN 'CARGO' ELSE 'ABONO' END 
         ,    'CORR'             = RecCodSwift
         ,    'MT'               = CASE WHEN cltipcli = 1 THEN 'MT 202' ELSE 'MT 103' END
         ,    'EE'               = Estado_Envio
        INTO  #TMP_RETORNO_GRUPO
        FROM  BacParamSuda..MDLBTR                   with (nolock)
              LEFT JOIN BacParamSuda..CLIENTE        with (nolock) ON clrut = rut_cliente and clcodigo = codigo_cliente
              LEFT JOIN BacParamSuda..MONEDA         with (nolock) ON mncodmon = moneda
              LEFT JOIN BacParamSuda..FORMA_DE_PAGO  with (nolock) ON codigo   = forma_pago
       WHERE  Fecha              = @dFechaProceso
         AND  fecha_vencimiento  = @dLiquidacion
         AND  Estado_Envio       = 'P'
         AND  Tipo_Movimiento    = 'C'
         AND  Estado_Paquete     = 'A'
         AND  Id_Paquete         > 0
         AND (Sistema            = @cModulo    OR @cModulo    = '')
         AND (tipo_mercado       = @cTipo      OR @cTipo      = '')
         AND (Rut_Cliente        = @iRut       OR @iRut       = 0)
         AND (Codigo_Cliente     = @iCodigo    OR @iCodigo    = 0)
         AND (Moneda             = @iMoneda    OR @iMoneda    = 0)
         AND (forma_pago         = @iMedioPago OR @iMedioPago = 0)
         AND (Estado_Paquete     = @cEstado    OR @cEstado    = '')

         SELECT MARCA 
         ,      MODULO
         ,      TIPO
         ,      NUMERO
         ,      RUT
         ,      CODIGO
         ,      NOMBRE
         ,      MONEDA
         ,      MONTO = SUM(MONTO)
         ,      FORMAPAGO
         ,      MOVTO
         ,      CORR
         ,      MT
         ,      EE
         FROM   #TMP_RETORNO_GRUPO
         GROUP BY MARCA, MODULO, TIPO, NUMERO, RUT, CODIGO, NOMBRE, MONEDA, FORMAPAGO, MOVTO, CORR, MT, EE
   END

   IF @iTag = 8
   BEGIN
      IF EXISTS(SELECT 1 FROM MDLBTR with (nolock) WHERE Id_Paquete = @iOperacion AND fecha_vencimiento = @dLiquidacion AND estado_envio = 'E')
      BEGIN
         SELECT -8, 'Grupo ya fue enviado, no se puede Desagrupar.'
         RETURN
      END

      UPDATE MDLBTR 
      SET    Id_Paquete        = 0
      ,      Estado_Paquete    = 'D'
      ,      Reservado         = ''
      WHERE  Id_Paquete        = @iOperacion   --> @iFolio
      AND    fecha_vencimiento = @dLiquidacion

      SELECT 0, 'Operaciones pendientes de envio, es posible desagrupar.'
   END

END



GO
