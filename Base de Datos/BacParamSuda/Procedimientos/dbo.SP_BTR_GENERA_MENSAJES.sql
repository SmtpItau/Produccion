USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BTR_GENERA_MENSAJES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BTR_GENERA_MENSAJES]
   (   @par_sistema         CHAR(03)     = ''
   ,   @par_tp_operacion    CHAR(05)     = ''
   ,   @par_nr_operacion    NUMERIC(9,0) = 0
   ,   @iMoneda             INTEGER      = 0
   ,   @iEstado             CHAR(1)      = 'P'
   )
AS 
BEGIN

    SET NOCOUNT ON

    DECLARE @fc_proceso  DATETIME
    DECLARE @fc_procant  DATETIME	

    SELECT @fc_proceso = acfecproc 
    ,      @fc_procant = acfecante 
    FROM   bactradersuda..MDAC with (nolock) 

    EXECUTE SP_BTR_CARGA_TABLA_MDLBTR

    SELECT sistema
    ,      tipo_mercado
    ,      tipo_operacion
    ,      estado_envio
    ,      numero_operacion = MIN( numero_operacion )
    ,      rut_cliente
    ,      codigo_cliente
    ,      moneda
    ,      monto_operacion  = SUM( monto_operacion )
    ,      forma_pago
    ,      fecha_operacion
    ,      fecha_vencimiento
    ,      liquidada
    ,      RecRutBanco
    ,      RecCodBanco
    ,      RecCodSwift
    ,      RecDireccion
    ,      RecCtaCte
    ,      Tipo_Movimiento
    ,      GlosaAnticipo
    ,      Id_Paquete
    ,      Estado_Paquete
    ,      Reservado
    INTO   #TMP_LBTR_GRUPO
    FROM   MDLBTR            with (nolock) 
    WHERE (fecha             = @fc_proceso)
--> WHERE (fecha_vencimiento = @fc_proceso)
    AND   (sistema           = ltrim(rtrim(@par_sistema))      OR ltrim(rtrim(@par_sistema))      = '')
    AND   (tipo_mercado      = ltrim(rtrim(@par_tp_operacion)) OR ltrim(rtrim(@par_tp_operacion)) = '')
    AND   (numero_operacion  = @par_nr_operacion               OR @par_nr_operacion               = 0 )
    AND   (Tipo_Movimiento   = 'C')
    AND   (moneda            = @iMoneda                        OR @iMoneda                        = 0)
    AND   (estado_envio      = @iEstado                        OR @iEstado                        = '')
    AND   (Reservado         = '')
    AND   (Estado_Paquete    = 'A')
    AND   (Id_Paquete        > 0)
    GROUP BY sistema,   tipo_mercado, tipo_operacion, estado_envio, rut_cliente,  codigo_cliente, moneda,          forma_pago,    fecha_operacion, fecha_vencimiento,
            liquidada, RecRutBanco,  RecCodBanco,    RecCodSwift,  RecDireccion, RecCtaCte,      Tipo_Movimiento, GlosaAnticipo, Id_Paquete,      Estado_Paquete,   Reservado

   SELECT 'Estado'           = CASE WHEN a.estado_envio = 'P' THEN 'Pendiente'
                                    WHEN a.estado_envio = 'R' THEN 'Recibido'
                                    WHEN a.estado_envio = 'E' THEN 'Enviado'
                                    WHEN a.estado_envio = 'A' THEN 'Anulado'
                                    WHEN a.estado_envio = 'I' THEN 'Impreso'
                               END   
   ,      'Operacion'        = CASE WHEN a.liquidada ='*' THEN d.descripcion + '  * PM * ' ELSE d.descripcion END
   ,      numero_operacion   = CONVERT(NUMERIC(10),a.numero_operacion)
   ,      Clnombre           = b.Clnombre
   ,      mnnemo             = c.mnnemo
   ,      monto_operacion    = a.monto_operacion
   ,      glosa              = f.glosa
   ,      perfil             = f.perfil
   ,      forma_pago         = a.forma_pago
   ,      sistema            = a.sistema
   ,      fecha_operacion    = a.fecha_operacion
   ,      fecha_vencimiento  = a.fecha_vencimiento
   ,      liquidada          = a.liquidada
   ,      cltipcli           = b.cltipcli
   ,      GlosaAnticipo      = a.GlosaAnticipo
   ,      Estado_Paquete     = a.Estado_Paquete
   ,      IdPaquete          = a.Id_Paquete
   INTO   #TMP_RETORNO
   FROM   MDLBTR   a         WITH (NOLOCK)
          LEFT JOIN CLIENTE       b with (nolock) ON a.rut_cliente = b.clrut   AND a.codigo_cliente = b.clcodigo
          LEFT JOIN MONEDA        c with (nolock) ON a.moneda      = c.mncodmon
          LEFT JOIN FORMA_DE_PAGO f with (nolock) ON a.forma_pago  = f.codigo
          LEFT JOIN PRODUCTO      d with (nolock) ON a.sistema     = d.id_sistema AND a.tipo_mercado   = d.codigo_producto
   WHERE (a.fecha          = @fc_proceso)
-->WHERE (a.fecha_vencimiento= @fc_proceso)
   AND   (a.sistema          = ltrim(rtrim(@par_sistema))      OR ltrim(rtrim(@par_sistema))      = '')
   AND   (a.tipo_mercado     = ltrim(rtrim(@par_tp_operacion)) OR ltrim(rtrim(@par_tp_operacion)) = '')
   AND   (a.numero_operacion = @par_nr_operacion               OR @par_nr_operacion               = 0 )
   AND    a.Tipo_Movimiento  = 'C'
   AND   (a.moneda           = @iMoneda                        OR @iMoneda                        = 0)
   AND   (a.estado_envio     = @iEstado                        OR @iEstado                        = '')
   AND   (Reservado          = '')
   AND   (Estado_Paquete     = 'D')
   AND   (Id_Paquete         = 0)
   ORDER BY a.sistema , a.numero_operacion 

   INSERT INTO #TMP_RETORNO
   SELECT 'Estado'           = CASE WHEN a.estado_envio = 'P' THEN 'Pendiente'
                                    WHEN a.estado_envio = 'R' THEN 'Recibido'
                                    WHEN a.estado_envio = 'E' THEN 'Enviado'
                                    WHEN a.estado_envio = 'A' THEN 'Anulado'
                                    WHEN a.estado_envio = 'I' THEN 'Impreso'
                               END   
   ,      'Operacion'        = CASE WHEN a.liquidada = '*' THEN d.descripcion + '  * PM * ' ELSE d.descripcion END
   ,      numero_operacion   = CONVERT(NUMERIC(10),a.numero_operacion)
   ,      Clnombre           = b.Clnombre
   ,      mnnemo             = c.mnnemo
   ,      monto_operacion    = a.monto_operacion
   ,      glosa              = f.glosa
   ,      perfil             = f.perfil
   ,      forma_pago         = a.forma_pago
   ,      sistema            = a.sistema
   ,      fecha_operacion    = @fc_proceso
   ,      fecha_vencimiento  = a.fecha_vencimiento
   ,      liquidada          = a.liquidada
   ,      cltipcli           = b.cltipcli
   ,      GlosaAnticipo      = a.GlosaAnticipo   
   ,      Estado_Paquete     = a.Estado_Paquete
   ,      IdPaquete          = a.Id_Paquete
   FROM   #TMP_LBTR_GRUPO         a
          LEFT JOIN CLIENTE       b with (nolock) ON a.rut_cliente = b.clrut   AND a.codigo_cliente = b.clcodigo
          LEFT JOIN MONEDA        c with (nolock) ON a.moneda      = c.mncodmon
          LEFT JOIN FORMA_DE_PAGO f with (nolock) ON a.forma_pago  = f.codigo
          LEFT JOIN PRODUCTO      d with (nolock) ON a.sistema     = d.id_sistema AND a.tipo_mercado   = d.codigo_producto
   ORDER BY a.sistema , a.numero_operacion 

   SELECT * FROM #TMP_RETORNO 
      ORDER BY Estado_Paquete, Estado, IdPaquete DESC, sistema, Operacion, Clnombre, mnnemo, perfil, numero_operacion

END
GO
