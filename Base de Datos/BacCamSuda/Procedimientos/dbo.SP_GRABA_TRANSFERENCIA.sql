USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_TRANSFERENCIA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_TRANSFERENCIA]( @numero_operacion  NUMERIC( 7)  ,
                                         @tipo                 CHAR( 1)  ,
                                         @correlativo       NUMERIC( 2)  ,
                                         @codigo            NUMERIC( 3)  ,
                                         @swift             VARCHAR(11)  ,
                                         @receptor          VARCHAR(50)  ,
                                         @mt_20             VARCHAR(16)  ,  -- Referencia
                                         @mt_21             VARCHAR(16)  ,  -- ref. relacionada
                                         @mt_32a_fecha      DATETIME     ,  -- Fecha/Monto/Moneda
                                         @mt_32a_monto      NUMERIC(19,2),
                                         @mt_32a_moneda     VARCHAR( 3)  ,
                                         @mt_50             VARCHAR(250) ,  -- Cliente Ordenante
                                         @mt_52_cuenta      VARCHAR(35)  ,  -- Banco Ordenante
                                         @mt_52_swift       VARCHAR(11)  ,
                                         @mt_52_direccion   VARCHAR(150) ,
                                         @mt_53_cuenta      VARCHAR(35)  ,  -- Bco.Corresponsal del Remitente
                                         @mt_53_swift       VARCHAR(11)  ,
                                         @mt_53_sucursal    VARCHAR(35)  ,
                                         @mt_53_direccion   VARCHAR(150) ,
                                         @mt_54_cuenta      VARCHAR(35)  ,  -- Bco.Corresponsal del Receptor
                                         @mt_54_swift       VARCHAR(11)  ,
                                         @mt_54_sucursal    VARCHAR(35)  ,
                                         @mt_54_direccion   VARCHAR(150) ,
                                         @mt_56_cuenta      VARCHAR(35)  ,  -- Bco.Intermediario
                                         @mt_56_swift       VARCHAR(11)  ,
                                         @mt_56_direccion   VARCHAR(150) ,
                                         @mt_57_cuenta      VARCHAR(35)  ,  -- Bco.donde esta abierta la cuenta
                                         @mt_57_swift       VARCHAR(11)  ,
                                         @mt_57_sucursal    VARCHAR(35)  ,
                                         @mt_57_direccion   VARCHAR(150) ,
                                         @mt_58_cuenta      VARCHAR(35)  ,  -- Bco.Beneficiario
                                         @mt_58_swift       VARCHAR(11)  ,
                                         @mt_58_direccion   VARCHAR(150) ,
                                         @mt_59             VARCHAR(250) ,  -- Cliente Beneficiario
                                         @mt_70             VARCHAR(250) ,  -- Detalles del Pago
                                         @mt_71a            VARCHAR( 3)  ,  -- Detalles del Cargo
                                         @mt_72             VARCHAR(250) ,  -- InformaciÃ³n Bco. a Bco.
                                         @usuario           VARCHAR(10)  ,  -- ultimo usuario que modifica
                                         @estado               CHAR( 1)  )  -- A=Aprobada / P=Pendiente
WITH RECOMPILE
AS
BEGIN
     SET NOCOUNT ON
     IF NOT EXISTS (SELECT * FROM tbTransferencia
                            WHERE numero_operacion = @numero_operacion
                              AND tipo        = @tipo
                              AND correlativo = @correlativo )   BEGIN
         INSERT tbTransferencia(  numero_operacion,  tipo,  correlativo)
                         VALUES( @numero_operacion, @tipo, @correlativo)
         IF @@ERROR<>0   BEGIN
            SELECT -1, 'No se pudo Agregar Transferencia a operacion'
            RETURN
         END
     END
     ------<< Actualiza
  UPDATE tbTransferencia
        SET codigo            = @codigo          ,
            swift             = @swift           ,
            receptor          = @receptor        ,
            mt_20             = @mt_20           ,
            mt_21             = @mt_21           ,
            mt_32a_fecha      = @mt_32a_fecha    ,
            mt_32a_monto      = @mt_32a_monto    ,
            mt_32a_moneda     = @mt_32a_moneda   ,
            mt_50             = @mt_50           ,
            mt_52_cuenta      = @mt_52_cuenta    ,
            mt_52_swift       = @mt_52_swift     ,
            mt_52_direccion   = @mt_52_direccion ,
            mt_53_cuenta      = @mt_53_cuenta    ,
            mt_53_swift       = @mt_53_swift     ,
            mt_53_sucursal    = @mt_53_sucursal  ,
            mt_53_direccion   = @mt_53_direccion ,
            mt_54_cuenta      = @mt_54_cuenta    ,
            mt_54_swift       = @mt_54_swift     ,
            mt_54_sucursal    = @mt_54_sucursal  ,
            mt_54_direccion   = @mt_54_direccion ,
            mt_56_cuenta      = @mt_56_cuenta    ,
            mt_56_swift       = @mt_56_swift     ,
            mt_56_direccion   = @mt_56_direccion ,
            mt_57_cuenta      = @mt_57_cuenta    ,
            mt_57_swift       = @mt_57_swift     ,
            mt_57_sucursal    = @mt_57_sucursal  ,
            mt_57_direccion   = @mt_57_direccion ,
            mt_58_cuenta      = @mt_58_cuenta    ,
            mt_58_swift       = @mt_58_swift     ,
            mt_58_direccion   = @mt_58_direccion ,
            mt_59             = @mt_59           ,
            mt_70             = @mt_70           ,
            mt_71a            = @mt_71a          ,
            mt_72             = @mt_72           ,
            estado            = @estado          ,  -- estado de aprobacion de transferencia
            usuario           = @usuario         ,
            fecha             = GETDATE()
       WHERE numero_operacion = @numero_operacion
         AND correlativo      = @correlativo
         AND tipo             = @tipo
      IF @@ERROR<>0
         SELECT -1, 'No se pudo actualizar Transferencia'
END

GO
