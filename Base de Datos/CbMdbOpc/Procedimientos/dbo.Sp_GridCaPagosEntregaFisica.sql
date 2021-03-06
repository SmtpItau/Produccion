USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GridCaPagosEntregaFisica]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_GridCaPagosEntregaFisica] 
       (
    	 @Rut        NUMERIC(9)
       , @Codigo     NUMERIC(1)
       , @f1         DATETIME
       , @f2         DATETIME
       ) 
AS
BEGIN            
            
    SET NOCOUNT ON
    
    -- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente
	-- ASVG 23 Marzo 2011 Se incluye código de estructura para diferenciar reportes de vencimiento/pagos entrega física

    -- Sp_GridCaPagosEntregaFisica 0,0, '20081201', '20081230'
    -- Sp_GridCaPagosEntregaFisica 0,0, '20081201', '20381230'

    DECLARE @HayErrorValidacion         NUMERIC(10)
    DECLARE @fechaProc                  DATETIME

    -- En este proceso no habrá validación
    SET @HayErrorValidacion = 0

    SELECT *
      INTO #Moneda
      FROM LNKBAC.bacparamsuda.dbo.Moneda

    SELECT *
      INTO #Formas_Pago
      FROM LNKBAC.bacparamsuda.dbo.Forma_de_Pago 

    -- Solo se cargarán Clientes que alguna vez han tenido opciones
    SELECT ClRut
         , ClCodigo
         , ClDv
         , ClNombre
      INTO #Cliente
      FROM LNKBAC.bacparamsuda.dbo.VIEW_CLIENTEParaOpc
     WHERE Clrut in ( SELECT MoRutCliente FROM MoEncContrato UNION SELECT MoRutCliente FROM MoHisEncContrato )

    -- Si la informacion es futura, se debe obtener de CaDetContrato, si es del dia de proceso
    -- y del pasado debe leer de caja.
    SELECT @fechaproc = fechaproc
      FROM dbo.opcionesgeneral

    SELECT *
         , CaTemporalidad   = CONVERT( VARCHAR(10), 'Vigente' )
      INTO #Caja
      FROM dbo.CaCaja  
     WHERE CaCajFecPago     BETWEEN @f1 AND @f2
       AND CaCajModalidad   = 'E'
    UNION 
    SELECT *
         ,  CaTemporalidad  = CONVERT( VARCHAR(10), 'Historico' )
      FROM dbo.CaVenCaja  
     WHERE CaCajFecPago     BETWEEN @f1 AND @f2
       AND CaCajModalidad   = 'E'

    --- si es Compra Call monto m1 es positivo, m2 es nevativo
    --- si es Venta  Call monto m1 es nevativo, m2 es positivo
    --- si es Compra put  monto m1 es negativo, m2 es positivo
    --- si es Venta  put  monto m1 es positivo, m2 es negativo
    --- Se le CaDetContrato y se deja en "formato Caja"
    --select 'debug' , * from #Caja

    INSERT INTO #Caja   
           SELECT CaNumContrato
                , CaNumEstructura
                , CaCajFolio         = 0
                , CaCajFechaGen      = CaFechaFijacion
                , CaCajFecPago       = CaFechaPagoEjer
                , CaCajFDeMon1       = 1
                , CaCajMtoMon1       = CASE WHEN ( CaCVOpc = 'C' AND CaCallPut = 'Call' ) OR ( CaCVOpc = 'V' AND CaCallPut = 'Put' ) THEN CaMontoMon1 ELSE -CaMontoMon1 END
                , CaCajFDeMon2       = 1
                , CaCajMtoMon2       = CASE WHEN ( CaCVOpc = 'C' and CaCallPut = 'Call' ) OR ( CaCVOpc = 'V' AND CaCallPut = 'Put' ) THEN -CaMontoMon2 ELSE +CaMontoMon2 END
                , CaCajEstado        = 'F'  /* Futuro */
                , CaMTMImplicito     = CaVrDet
                , CaCajFormaPagoMon1 = CaFormaPagoMon1 
                , CaCajFormaPagoMon2 = CaFormaPagoMon2  
                , CaCajMdaM1         = CaCodMon1 
                , CaCajMdaM2         = CaCodMon2                 
                , CaCajOrigen        = 'PV'
                , CaCajMotorPago     = 'P'
                , CaCajModalidad     = CaModalidad
                /* MAP 04 Septiembre Corrige cambio estructura */
                , CaCajFechaPagMon1  = CaFechaPagMon1 
                , CaCajFechaPagMon2  = CaFechaPagMon2
                /* MAP 04 Septiembre Corrige cambio estructura */
                , CaTemporalidad     = CONVERT( VARCHAR(10) , 'Futuro' )
             FROM dbo.CaDetContrato 
            WHERE CaFechaPagoEjer    BETWEEN @f1 AND @f2 
              AND CaModalidad        = 'E'
              --  Solo lo proyectado
              AND CaNumContrato * 100 + CaNumEstructura NOT IN ( SELECT CaNumContrato * 100 + CaNumEstructura FROM #Caja ) 
              --  select  camodalidad, * from CaDetContrato where CaNUmContrato = 954 

    SELECT *
      INTO #Encabezado
      FROM dbo.CaEncContrato
     WHERE CaNumContrato IN ( SELECT CaNumContrato FROM #Caja )
    union 
    SELECT *
      FROM dbo.CaVenEncContrato
     WHERE CaNumContrato IN ( SELECT CaNumContrato FROM #Caja )

    SELECT *
      INTO #Detalle
      FROM dbo.CaDetContrato
     WHERE CaNumContrato IN ( SELECT CaNumContrato FROM #Caja )
    UNION
    SELECT *
      FROM dbo.CaVenDetContrato
     WHERE CaNumContrato IN ( SELECT CaNumContrato FROM #Caja )

    SELECT Pantalla             = CONVERT( VARCHAR(32), 'PANTALLA DE PAGOS ENTREGA FISICA' )   
         , NumContrato          = CONVERT( NUMERIC(8), Caja.CaNumContrato )
         , NumEstructura        = CONVERT( NUMERIC(6), Caja.CaNumEstructura )
         , FechaEjercicio       = CONVERT( DATETIME, Caja.CaCajFecPago )
         , FechaContrato        = CONVERT( DATETIME,  Enc.CaFechaContrato )
         , CliRut               = CONVERT( NUMERIC(9), Enc.CaRutCliente )
         , CliCod               = CONVERT( NUMERIC(5), Enc.CaCodigo )
         , CliDv                = CONVERT( VARCHAR(1), ISNULL( Cliente.ClDv, ' ' ) )
         , CliNom               = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente No Existe' )  )
         , MdaRecibirCod        = CONVERT( NUMERIC(5), CASE WHEN CaCajMtoMon1 > 0 THEN CaCajMdaM1 ELSE CaCajMdaM2 END )
         , MdaRecibirDsc        = CONVERT( VARCHAR(35), ' ' )
         , FormaPagoRecibirCod  = CONVERT( NUMERIC(3), CASE WHEN  CaCajMtoMon1 > 0 THEN CaCajFormaPagoMon1 ELSE CaCajFormaPagoMon2 END )
         , FormaPagorecibirDsc  = CONVERT( VARCHAR(35), ' ' )
         , MontoRecibir         = CONVERT( NUMERIC(21,4), CASE WHEN Caja.CaCajMtoMon1 > 0 THEN Caja.CaCajMtoMon1  ELSE Caja.CaCajMtoMon2 END )

         , MdaPagarCod          = CONVERT( NUMERIC(5), CASE WHEN CaCajMtoMon1 > 0 THEN CaCajMdaM2 ELSE CaCajMdaM1 END )
         , MdaPagarDsc          = CONVERT( VARCHAR(35), ' ' )
         , FormaPagoPagarCod    = CONVERT( NUMERIC(3), CASE WHEN  CaCajMtoMon1 > 0 THEN CaCajFormaPagoMon2 ELSE CaCajFormaPagoMon1 END )
         , FormaPagoPagarDsc    = CONVERT( VARCHAR(35), ' ' )

         , MontoPagar           = CONVERT( NUMERIC(21,4), CASE WHEN Caja.CaCajMtoMon1 < 0 THEN -Caja.CaCajMtoMon1 ELSE -Caja.CaCajMtoMon2 END )
         , OrigenCod            = CONVERT( VARCHAR(2), CaCajOrigen )
         , OrigenDsc            = CONVERT( VARCHAR(16), CASE WHEN CaCajOrigen = 'PP' THEN 'Pago Prima' ELSE 'Pago Vencimiento' END )
         , Temporalidad         = CONVERT( VARCHAR(10), CaTemporalidad )
         , MTMImplicito         = CONVERT( NUMERIC(21,4), CaMTMImplicito )
         , VctoValutaRecibir    = CONVERT( DATETIME, CASE WHEN CaCajMtoMon1 > 0 THEN Caja.CaCajFechaPagMon1 ELSE Caja.CaCajFechaPagMon2 END )
         , VctoValutaPagar      = CONVERT( DATETIME, CASE WHEN CaCajMtoMon2 > 0 THEN Caja.CaCajFechaPagMon2 ELSE Caja.CaCajFechaPagMon1 END )
		 , CodEstructura		= CONVERT( VARCHAR(10), Enc.CaCodEstructura ) --ASVG_20110322 Para diferenciar reportes de vencimiento/pagos entrega física.
		 , TipoBfwOpt           = CONVERT( varchar(3), CASE WHEN  Enc.CaCodEstructura IN (4,5,6,8,13) THEN 'BFW'ELSE 'OPT'END)--PRD_12567
      INTO #Pagos
      from #Caja Caja 
           LEFT JOIN #Detalle     Det       ON Caja.CaNumContrato    = Det.CaNumContrato 
                                           AND Caja.CaNumEstructura  = Det.CaNumEstructura
           INNER JOIN #Encabezado Enc       ON Enc.CaNumContrato     = Det.CaNumContrato
                                           AND Enc.CaEstado         <> 'C'
           LEFT JOIN #Cliente     Cliente   ON Cliente.ClRut         = Enc.CaRutCliente
                                           AND Enc.CaCodigo          = Cliente.ClCodigo 
     WHERE Caja.CaNumContrato = Enc.CaNumContrato
       AND CaCajModalidad     = 'E'

    UPDATE #Pagos
       SET MdaRecibirDsc       = ( SELECT MdaRecibir.MnNemo      FROM #Moneda MdaRecibir   WHERE #Pagos.MdaRecibirCod       = MdaRecibir.MnCodMon ) 
         , MdaPagarDsc         = ( SELECT MdaPagar.MnNemo        FROM #Moneda MdaPagar              WHERE #Pagos.MdaPagarCod         = MdaPagar.MnCodMon )
         , FormaPagoRecibirDsc = ( SELECT FormaPagoRecibir.glosa FROM #Formas_Pago FormaPagoRecibir WHERE #Pagos.FormaPagorecibirCod = FormaPagoRecibir.Codigo )
         , FormaPagoPagarDsc   = ( SELECT FormaPagoPagar.glosa   FROM #Formas_Pago FormaPagoPagar   WHERE #Pagos.FormaPagoPagarCod   = FormaPagoPagar.Codigo )

    IF NOT EXISTS( SELECT (1) FROM #Pagos ) 
    BEGIN
        SELECT Pantalla            = CONVERT( VARCHAR(32), 'PANTALLA DE PAGOS ENTREGA FISICA' )   
             , NumContrato         = CONVERT( NUMERIC(8), 0 )
             , NumEstructura       = CONVERT( NUMERIC(6), 0 )
             , FechaEjercicio      = CONVERT( DATETIME,  '19000101' )
             , FechaContrato       = CONVERT( DATETIME,  '19000101' )
             , CliRut              = CONVERT( NUMERIC(9), 0 )
             , CliCod              = CONVERT( NUMERIC(5), 0 )
             , CliDv               = CONVERT( VARCHAR(1),  ' ' )
             , CliNom              = CONVERT( VARCHAR(100), 'NO HAY DATOS'  )
             , MdaRecibirCod       = CONVERT( NUMERIC(5) , 0 )
             , MdaRecibirDsc       = CONVERT( VARCHAR(35), ' ' )
             , FormaPagoRecibirCod = CONVERT( NUMERIC(3), 0 ) 
             , FormaPagorecibirDsc = CONVERT( VARCHAR(35), ' ' )
             , MontoRecibir        = CONVERT( NUMERIC(21,4), 0 )
             , MdaPagarCod         = CONVERT( NUMERIC(5) , 0 )
             , MdaPagarDsc         = CONVERT( VARCHAR(35), ' ' )
             , FormaPagoPagarCod   = CONVERT( NUMERIC(3) , 0 ) 
             , FormaPagoPagarDsc   = CONVERT( VARCHAR(35), ' ' )
             , MontoPagar          = CONVERT( NUMERIC(21,4), 0 )
             , OrigenCod           = CONVERT( VARCHAR(2), '' )
             , OrigenDsc           = CONVERT( VARCHAR(16), ''  )
             , Temporalidad        = CONVERT( VARCHAR(10), 'V' )
             , MTMImplicito        = CONVERT( NUMERIC(21,4) , 0 ) 
             , VctoValutaRecibir   = CONVERT( DATETIME,  '19000101' )
             , VctoValutaPagar     = CONVERT( DATETIME,  '19000101' )
			 , CodEstructura	   = CONVERT( VARCHAR(10), '' ) --ASVG_20110322 Para diferenciar reportes de vencimiento/pagos entrega física.
			 , TipoBfwOpt         = CONVERT( varchar(3),'')--PRD_12567

    END ELSE
    BEGIN
        SELECT * FROM #Pagos

    END

    RETURN 0

END
GO
