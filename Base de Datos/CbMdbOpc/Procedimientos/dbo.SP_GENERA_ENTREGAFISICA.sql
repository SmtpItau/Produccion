USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_ENTREGAFISICA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GENERA_ENTREGAFISICA]
       (
         @NumContrato      NUMERIC(8) 
       , @NumComponente    NUMERIC(6) 
       , @CajFolio         NUMERIC(8)
       , @Usuario          VARCHAR(15)
       )
AS
BEGIN
    /*************************************************************************************/
    /* 1. Los lnkserver no permiten generar integridad transaccional.                    */
    /*    Por instrucción de Ma.Paz se quitaron. mail enviado: Martes 20-10-2009 11:46.  */
    /* 2. @motipmer  = 'PTAS' . Ma.Paz Definio este valor estatico (PTAS).               */
    /*    Posteriormente debera ser parametrizado                                        */
    /* MAP 05 Nov. se tuvo que generar tabla fisica y por ende                           */
    /*             con el campo Usuario para evitar bloqueos.                            */
    /*                                                                                   */
    /* MAP-20130131 Se saca el valor en duro EMPR para el tipo de mercado Spot           */
    /* PROD-17862 Problemas contabilizacion de Prima como utilidad/perdida al            */
    /*            al verncimiento cuando no hay pago.                                    */
    /*************************************************************************************/
    SET NOCOUNT ON

    /*************************************************************************************/
    /* Declaracion de Variables                                                          */
    /*************************************************************************************/
    DECLARE @msg           VARCHAR(80)
    DECLARE @moentidad     NUMERIC(10)
    DECLARE @monumope      NUMERIC(7)
    DECLARE @motipmer      CHAR(4)
    DECLARE @motipope      CHAR(1)
    DECLARE @morutcli      NUMERIC(9)
    DECLARE @mocodcli      NUMERIC(9)
    DECLARE @mocodmon      CHAR(3)
    DECLARE @mocodcnv      CHAR(3)
    DECLARE @momonmo       NUMERIC(19,4)
    DECLARE @motipcam      NUMERIC(19,4)
    DECLARE @moparme       NUMERIC(19,8)
    DECLARE @moprecio      NUMERIC(19,4)
    DECLARE @moussme       NUMERIC(19,4)
    DECLARE @momonpe       NUMERIC(19,4)
    DECLARE @moentre       NUMERIC(3)
    DECLARE @morecib       NUMERIC(3)
    DECLARE @movaluta1     DATETIME        -- Entregamos
    DECLARE @movaluta2     DATETIME        -- Recibimos
    DECLARE @mooper        CHAR(15)
    DECLARE @mofech        DATETIME
    DECLARE @mohora        CHAR(8)
    DECLARE @moterm        CHAR(12)
    DECLARE @motipcar      NUMERIC(3)
    DECLARE @monumfut      NUMERIC(8)
    DECLARE @mofecini      DATETIME
    DECLARE @fecha         CHAR(8)
    DECLARE @OpExiste      CHAR(1)
    DECLARE @DolarObserv   FLOAT
    declare @MTMIMplicito  Float          -- MAP 17-04-2013

    SET @msg = ''

    /*************************************************************************************/
    /* Recupera el Dolar Observado                                                       */
    /*************************************************************************************/
    SELECT @DolarObserv = vmvalor 
      FROM lnkBAC.BacParamSuda.dbo.view_valor_moneda 
         , dbo.OpcionesGeneral Opc
     WHERE vmcodigo = 994
       AND vmfecha  = Opc.fechaproc

    /*************************************************************************************/
    /* Navegacion en Base de Datos para Asignar las variables                            */
    /*************************************************************************************/
    SELECT @moentidad = CONVERT(NUMERIC(9), Opc.entidad )
      -- , @motipmer  = 'PTAS'  -- Ma.Paz Definio este valor estatico (PTAS). Posteriormente debera ser parametrizado
         , @motipmer  = case when Cli.CltipCli in (1,2,3,4) and Det.CaCodMon1 = 13 then 'PTAS' else 'EMPR' end  -- MAP-20130131
         , @motipope  = CASE Det.CaCVOpc WHEN 'C' THEN CASE Det.CaCallPut WHEN 'Call' THEN 'C' ELSE 'V' END
                                         WHEN 'V' THEN CASE Det.CaCallPut WHEN 'Call' THEN 'V' ELSE 'C' END
                        END
         , @morutcli  = Enc.CaRutCliente
         , @mocodcli  = Enc.CaCodigo
         , @mocodmon  = CONVERT( CHAR(3), Caj.CaCajMdaM1)
         , @mocodcnv  = CONVERT( CHAR(3), Caj.CaCajMdaM2)
         , @momonmo   = ABS( Caj.CaCajMtoMon1 )
         , @motipcam  = round( ABS( Caj.CaCajMtoMon2 ) / ABS( Caj.CaCajMtoMon1 ), 4 ) -- Det.CaStrike MAP 20130418   --@DolarObserv
         , @moparme   = 1              -- (Para USD-CLP)
         , @moprecio  = round( ABS( Caj.CaCajMtoMon2 ) / ABS( Caj.CaCajMtoMon1 ), 4 ) -- Det.CaStrike MAP 20130418
         , @moussme   = Det.CaMontoMon1

                        -- MAP 20130418
         , @momonpe   = ABS( Caj.CaCajMtoMon2 ) * ISNULL( ( SELECT vmvalor 
                                                      FROM lnkbac.bacparamsuda.dbo.Valor_Moneda
                                                     WHERE vmcodigo = ( CASE WHEN Det.CaCodMon2 = 13 THEN 994 ELSE Det.CaCodMon2 END )
                                                       AND vmfecha  = Opc.fechaproc ), 1 )
         , @moentre   = CASE WHEN Caj.CaCajMtoMon1 < 0  THEN Caj.CaCajFormaPagoMon1
                                                        ELSE Caj.CaCajFormaPagoMon2 
                        END
         , @morecib   = CASE WHEN Caj.CaCajMtoMon1 < 0  THEN Caj.CaCajFormaPagoMon2
                                                        ELSE Caj.CaCajFormaPagoMon1 
                        END
         , @movaluta1 = CASE WHEN Caj.CaCajMtoMon1 < 0  THEN Caj.CaCajFechaPagMon1
                                                        ELSE Caj.CaCajFechaPagMon2
                        END
         , @movaluta2 = CASE WHEN Caj.CaCajMtoMon1 < 0  THEN Caj.CaCajFechaPagMon2
                                                        ELSE Caj.CaCajFechaPagMon1
                        END
         , @mooper    = Enc.CaOperador
         , @mofech    = Det.CaFechaPagoEjer
         , @mohora    = CONVERT( VARCHAR(8), GETDATE(), 108 )
         , @moterm    = 'OPCIONES'
         , @motipcar  = Enc.CaCodEstructura
         , @monumfut  = Caj.CaNumContrato * 10 + Caj.CaNumEstructura
         , @mofecini  = Det.CaFechaInicioOpc 
         , @MTMIMplicito = case when Enc.CaCodEstructura in ( 8 ) then 1 else CaMTMImplicito end   -- MAP 20140205 Error no genera entrega fisica
      FROM dbo.CaCaja          Caj
         , dbo.CaDetContrato   Det
         , dbo.CaEncContrato   Enc 
         , lnkBac.BacParamsuda.dbo.Cliente Cli  -- MAP-20130131
         , dbo.OpcionesGeneral Opc
     WHERE Caj.CaNumContrato   = @NumContrato
       AND Caj.CaNumEstructura = @NumComponente
       AND Det.CaNumContrato   = Caj.CaNumContrato
       AND Det.CaNumEstructura = Caj.CaNumEstructura
       AND Caj.CaCajFolio      = @CajFolio
       AND Det.CaNumContrato   = Enc.CanumContrato
       AND Cli.Clrut           = Enc.CaRutCliente
       AND Cli.ClCodigo        = Enc.CaCodigo

    IF @@ROWCOUNT = 0 BEGIN
        SELECT @msg = CONVERT( VARCHAR(80) ,  'Caja No Existe' ) 
        GOTO FinSinCambios
    END

    IF @@ERROR <> 0
    BEGIN
        SELECT @Msg = @msg + CONVERT( VARCHAR(80) ,  'Sp_Cambia_Desicion: ERROR' ) 
        GOTO FinSinCambios
    END

    IF @MTMIMplicito = 0 BEGIN
        SELECT @Msg = @msg + CONVERT( VARCHAR(80) ,  'No Ejerce por tener MTM = 0' ) 
        GOTO FinSinCambios
    END
    --------------------------<< Monedas
    SET @mocodmon = (SELECT mnnemo FROM  lnkbac.bacparamsuda.dbo.MONEDA  with (nolock) WHERE mncodmon = CONVERT(NUMERIC(3),@mocodmon) )
    SET @mocodcnv = (SELECT mnnemo FROM lnkbac.bacparamsuda.dbo.MONEDA with (nolock) WHERE mncodmon = CONVERT(NUMERIC(3),@mocodcnv) )
    --------------------------<< Cliente y Mercado

    -- Chequea que Operación no Exista en tabla de paso
    SELECT @OpExiste = 'N'

    SELECT @OpExiste = 'S'
      FROM lnkBac.BacCamSuda.dbo.TBVencimientosForward
     WHERE MoNumFut  = @NumContrato * 10 + @NumComponente

    -- Si Operación ya se encuentra en tabla de paso no se puede
    -- volver a generar
    IF @OpExiste = 'S' BEGIN
        SELECT @msg = CONVERT( VARCHAR(80) ,  'Entrega Fisica ya generada' )
        GOTO FinSinCambios
    END

    -- Inicio de Transaccion

    --BEGIN TRAN
    DELETE FROM lnkBac.BacCamSuda.dbo.TBVencimientosForward
     WHERE monumfut = @monumfut AND moterm = @moterm

    INSERT INTO lnkBac.BacCamSuda.dbo.TBVencimientosForward
           VALUES ( 
                    @moentidad
                  , @motipmer
                  , @motipope
                  , @morutcli
                  , @mocodcli
                  , @mocodmon
                  , @mocodcnv
                  , @momonmo
                  , @motipcam
                  , @moparme
                  , @moprecio
                  , @moussme
                  , @momonpe
                  , @moentre
                  , @morecib
                  , @movaluta1
                  , @movaluta2
                  , @mooper
       , @mofech
                  , @mohora
                  , @moterm
                  , @motipcar
                  , @monumfut
                  , @mofecini
                  )

    IF @@ERROR <> 0
    BEGIN
        SELECT @Msg = @msg + CONVERT( VARCHAR(80) ,  'Insert en Sp_Cambia_Desicion: ERROR' ) 
        GOTO FinConRollBack            
    END

    SELECT @msg = @msg + CONVERT( VARCHAR(80) ,  'Genera Spot Exitosamente' ) 

    GOTO FinConCommit

FinSinCambios:
    INSERT INTO dbo.OpcEntFis 
           SELECT Usuario = @Usuario, Estado  = CONVERT( VARCHAR(2) , 'ER' )
               , Mensaje  = CONVERT( VARCHAR(80) , @Msg )
    RETURN(1)

FinConRollBack:
    INSERT INTO dbo.OpcEntFis
           SELECT Usuario = @Usuario, Estado  = CONVERT( VARCHAR(2) , 'ER' )
                , Mensaje = CONVERT( VARCHAR(80) , @Msg )
    --ROLLBACK
    RETURN(1)

FinConCommit:
    INSERT INTO dbo.OpcEntFis
           SELECT Usuario = @Usuario, Estado  = CONVERT( VARCHAR(2) , 'OK' )
                ,  Mensaje = CONVERT( VARCHAR(80) , @Msg )
    --COMMIT
    RETURN(1)

END
GO
