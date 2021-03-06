USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_ActualizaFormaPagoCompensacion]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ActualizaFormaPagoCompensacion]
       (
         @NumeroContrato         NUMERIC(08)
       , @NumeroEstructura       NUMERIC(06)
       , @Origen                 VARCHAR(02)
       , @FormaPago              NUMERIC(05)
       )
AS
BEGIN

    DECLARE @Status  INT
    Declare @proceso datetime
   -- Declare @MotorBAC varchar(1)
    Declare @MotorBAC NUMERIC(1)

    SET NOCOUNT ON

    Select @proceso = fechaproc from OpcionesGeneral

    /* LA IDEA ES SOLO VERIFICAR EXISTENCIA */
   
    select @MotorBAC = 0  -- Si no hay registro en Motor es como pendiente
    select @MotorBAC =  1 /*estado_envio*/ from bacparamsuda.dbo.VIEW_MOTOR 
    where
           sistema = 'OPT' 
       and fecha = @proceso
       and numero_operacion = @NumeroContrato


    -- CREA TABLA DE RESULTADO
    CREATE TABLE #tmpResult
    (
      RegType                VARCHAR(04) NOT NULL DEFAULT ''
    , Error                  INT         NOT NULL DEFAULT 0
    , FilasModificadas       INT         NOT NULL DEFAULT 0
    )

    -- VERIFICA SI EL ORIGEN ES PAGO DE PRIMA
    IF @Origen = 'PP'
    BEGIN



        -- ACTUALIZA FORMA DE PAGO DEL ENCABEZADO CONTRATO
        UPDATE dbo.CAENCCONTRATO
           SET CafPagoPrima    = @FormaPago
         WHERE  CaNumContrato   = @NumeroContrato 
            and @MotorBAC = 0  -- DEBE SER REEMPLADO POR: EL REGISTRO DEL MOTOR DE PAGO NO EXISTE

 
        SET @Status = @@ERROR
 
        -- INSERTA REGISTRO DE STATUS DE LA ACTUALIZACION DEL REGISTRO ENCABEZADO
        INSERT INTO #tmpResult VALUES ( 'ENC', @Status, @@ROWCOUNT )
 
        -- VERIFICA QUE NO EXISTA UN ERROR EN LA ACTUALIZACION DE LA FORMA DE PAGO
        IF @Status = 0
        BEGIN
            -- ACTUALIZA FORMA DE PAGO DE LA CAJA
            UPDATE dbo.CACAJA
               SET CaCajFormaPagoMon1 = @FormaPago
             WHERE CaNumContrato      = @NumeroContrato
               AND CaNumEstructura    = @NumeroEstructura
               AND CaCajOrigen        = 'PP'
               AND @MotorBAC = 0

           -- INSERTA REGISTRO DE STATUS DE LA ACTUALIZACION DEL REGISTRO CAJA
           INSERT INTO #tmpResult VALUES ( 'CAJA', @@ERROR, @@ROWCOUNT )

        END

    -- PAGO DE ORIGEN ES VENCIMIENTO
    END ELSE
    BEGIN
       if @MotorBAC = 0 begin
           -- ACTUALIZA FORMA DE PAGO DEL DETALLE CONTRATO
           UPDATE dbo.CADETCONTRATO
              SET CaFormaPagoComp = @FormaPago                   -- MAP 29 Septiembre 2009
            WHERE CaNumContrato   = @NumeroContrato
           --   AND CaNumEstructura = @NumeroEstructura          -- MAP 27 Octubre 2009 Se deben afectar todos los componentes
              
           -- INSERTA REGISTRO DE STATUS DE LA ACTUALIZACION DEL REGISTRO DETALLE
           INSERT INTO #tmpResult VALUES ( 'DET', @@ERROR, @@ROWCOUNT )

            -- ACTUALIZA FORMA DE PAGO DE LA CAJA
            UPDATE dbo.CACAJA
               SET CaCajFormaPagoMon1 = @FormaPago
             WHERE CaNumContrato      = @NumeroContrato
               -- AND CaNumEstructura    = @NumeroEstructura  -- MAP 27 Octubre 2009 Se deben afectar todos los componentes
               AND CaCajOrigen        = 'PV'
               AND @MotorBAC = 0

           -- INSERTA REGISTRO DE STATUS DE LA ACTUALIZACION DEL REGISTRO CAJA
           INSERT INTO #tmpResult VALUES ( 'CAJA', @@ERROR, @@ROWCOUNT )

       end
    END

    -- RETORNA EL STATUS DE LA ACTUALIZACION
    SELECT RegType
         , Error
         , FilasModificadas
      FROM #tmpResult

END
GO
