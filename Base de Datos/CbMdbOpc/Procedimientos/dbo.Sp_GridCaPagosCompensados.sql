USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GridCaPagosCompensados]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_GridCaPagosCompensados]
       (
         @Rut        NUMERIC(9)
       , @Codigo     NUMERIC(1)
       , @f1         DATETIME
       , @f2         DATETIME
       ) 
AS
BEGIN            
            
    SET NOCOUNT ON

    DECLARE @HayErrorValidacion         NUMERIC(10)
    DECLARE @fechaProc                  DATETIME
    -- En este proceso no habrá validación
    -- MAP 27 Oct. 2009 Corrige join de moneda compensación

	-- ASVG 23 Marzo 2011 Se incluye código de estructura para diferenciar reportes de vencimiento/pagos compensados

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

    SELECT CAJ.*
         , CaTemporalidad     = CONVERT( VARCHAR(10) , 'Vigente' )
      INTO #Caja
      FROM dbo.CaCaja                    CAJ
     WHERE CAJ.CaCajFecPago   BETWEEN @f1 AND @f2
       AND CAJ.CaCajModalidad = 'C'
    UNION 
    SELECT CAJ.*
         , CaTemporalidad     = CONVERT( VARCHAR(10) , 'Historico' )
      FROM dbo.CaVenCaja                   CAJ
     WHERE CAJ.CaCajFecPago   BETWEEN @f1 AND @f2
       AND CAJ.CaCajModalidad = 'C'

    --- Falta poner criterio de compra - Venta 
    INSERT INTO #Caja
           SELECT DET.CaNumContrato
                , DET.CaNumEstructura
                , CaCajFolio         = 0
                , CaCajFechaGen      = DET.CaFechaFijacion
                , CaCajFecPago       = DET.CaFechaPagoEjer
                , CaCajFDeMon1       = 1
                , CaCajMtoMon1       = DET.CaVrDet
                , CaCajFDeMon2       = 1
                , CaCajMtoMon2       = 0
                , CaCajEstado        = 'F'  /* Futuro */
                , CaMTMImplicito     = DET.CaVrDet
                , CaCajFormaPagoMon1 = DET.CaFormaPagoComp 
                , CaCajFormaPagoMon2 = 0  
                , CaCajMdaM1         = DET.CaMdaCompensacion 
                , CaCajMdaM2         = 0                 
                , CaCajOrigen        = 'PV'
                , CaCajMotorPago     = 'P'
                , CaCajModalidad     = DET.CaModalidad
                , CaCajFechaPagMon1  = DET.CaFechaPagMon1                      /* MAP 03 Septiembre Corrige cambio estructura */
                , CaCajFechaPagMon2  = CONVERT( DATETIME, '19000101' ) 
                , CaTemporalidad     = CONVERT( VARCHAR(10), 'Futuro' )   /* MAP 03 Septiembre Corrige cambio estructura */
             FROM dbo.CaDetContrato             DET
            WHERE DET.CaFechaPagoEjer BETWEEN @f1 AND @f2 
              AND DET.CaModalidad     = 'C'
              AND (DET.CaNumContrato * 100 + DET.CaNumEstructura) NOT IN ( SELECT CaNumContrato * 100 + CaNumEstructura FROM #Caja )  -- Solo lo proyectado

    SELECT *
      INTO #Encabezado
      FROM dbo.CaEncContrato
     WHERE CaNumContrato IN ( SELECT CaNumContrato FROM #Caja )
    UNION 
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
     WHERE CaNumContrato  IN ( SELECT CaNumContrato FROM #Caja )

   SELECT Pantalla           = CONVERT( VARCHAR(30), 'PANTALLA DE PAGOS COMPENSADOS' )   
        , NumContrato        = CONVERT( NUMERIC(8), Caja.CaNumContrato )
        , NumEstructura      = CONVERT( NUMERIC(6), Caja.CaNumEstructura )
        , FechaEjercicio     = CONVERT( DATETIME,  Caja.CaCajFecPago )
        , FechaContrato      = CONVERT( DATETIME,  Enc.CaFechaContrato )
        , CliRut             = CONVERT( NUMERIC(9), Enc.CaRutCliente )
        , CliCod             = CONVERT( NUMERIC(5), Enc.CaCodigo )
        , CliDv              = CONVERT( VARCHAR(1), ISNULL( Cliente.ClDv, ' ' ) )
        , CliNom             = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente No Existe' )  )
        , MdaCompCod         = CONVERT( NUMERIC(5), CASE WHEN CaCajOrigen = 'PP' THEN Enc.CaCodMonPagPrima ELSE Det.CaMdaCompensacion /* MAP 27 Oct. 2009 Det.CaCodMon1*/ END  )
        , MdaCompDsc         = CONVERT( VARCHAR(35), ISNULL( CASE WHEN CaCajOrigen = 'PP' THEN MdaPrima.mnnemo ELSE MdaComp.mnnemo END, 'NEMO' ) ) -- MnGLosa, 'Mda. Pago Comp. no existe' ) )
        , FormaPagoCompCod   = CONVERT( NUMERIC(3), CASE WHEN CaCajOrigen = 'PP' THEN Enc.CafPagoPrima ELSE  Caja.CaCajFormaPagoMon1 END )
        , FormaPagoCompDsc   = CONVERT( VARCHAR(30), ISNULL( CASE WHEN CaCajOrigen = 'PP' THEN FormaPagoPrima.Glosa ELSE FormaPagoComp.Glosa end, 'Forma Pago no existe' ) )
        , MontoRecibir       = CONVERT( NUMERIC(21,4), CASE WHEN Caja.CaCajMtoMon1 > 0 THEN Caja.CaCajMtoMon1  ELSE 0 END )
        , MontoPagar         = CONVERT( NUMERIC(21,4), CASE WHEN Caja.CaCajMtoMon1 < 0 THEN -Caja.CaCajMtoMon1 ELSE 0 END )
        , OrigenCod          = CONVERT( VARCHAR(2), CaCajOrigen )
        , OrigenDsc          = CONVERT( VARCHAR(16), CASE WHEN CaCajOrigen = 'PP' THEN 'Pago Prima' ELSE 'Pago Vencimiento' END )
        , Temporalidad       = CONVERT( VARCHAR(10), CaTemporalidad )
        , VctoValuta         = CONVERT( DATETIME, Caja.CaCajFechaPagMon1 )
		, CodEstructura		 = CONVERT( VARCHAR(10), Enc.CaCodEstructura ) --ASVG_20110322 Para diferenciar reportes de vencimiento/pagos compensados
		, TipoTransaccion	 = CONVERT(varchar(10),Enc.CaTipoTransaccion)--Papeleta productos Asiáticos PRD_12567
        , TipoPayOff		 = CONVERT(varchar(2),Det.CaTipoPayOff)--Papeleta productos Asiáticos PRD_12567
        , TipoBfwOpt         = CONVERT( varchar(3), CASE WHEN  Enc.CaCodEstructura IN (4,5,6,8,13) THEN 'BFW'ELSE 'OPT'END)--PRD_12567
     INTO #Pagos
     FROM #Caja Caja 
          LEFT JOIN  #Detalle        Det             ON Caja.CaNumContrato    = Det.CaNumContrato 
                                                    AND Caja.CaNumEstructura  = Det.CaNumEstructura
          LEFT JOIN  #Moneda         MdaComp         ON MdaComp.MnCodMon      = Det.CaMdaCompensacion -- Det.CaCodMon1  -- MAP 27 Oct. 2009 Moneda Comp.
          LEFT JOIN  #Formas_Pago    FormaPagoComp   ON FormaPagoComp.Codigo  = Caja.CaCajFormaPagoMon1
          INNER JOIN #Encabezado     Enc             ON Enc.CaNumContrato     = Det.CaNumContrato
                                                    AND Enc.CaEstado         <> 'C'
          LEFT JOIN  #Formas_Pago    FormaPagoPrima  ON FormaPagoPrima.Codigo = Enc.CafPagoPrima
          LEFT JOIN  #Moneda         MdaPrima        ON MdaPrima.MnCodMon     = Enc.CaCodMonPagPrima 
          LEFT JOIN  #Cliente        Cliente         ON Cliente.ClRut         = Enc.CaRutCliente
                                                    AND Enc.CaCodigo          = Cliente.ClCodigo 
    WHERE Caja.CaNumContrato = Enc.CaNumContrato

    IF NOT EXISTS( SELECT (1) FROM #Pagos )
    BEGIN
        SELECT Pantalla           = CONVERT( VARCHAR(30), 'PANTALLA DE PAGOS COMPENSADOS' )   
             , NumContrato        = CONVERT( NUMERIC(8), 0 )
             , NumEstructura      = CONVERT( NUMERIC(6), 0 )
             , FechaEjercicio     = CONVERT( DATETIME, '19000101' )
             , FechaContrato      = CONVERT( DATETIME, '19000101' )
             , CliRut             = CONVERT( NUMERIC(9), 0  )
             , CliCod             = CONVERT( NUMERIC(5), 0 )
             , CliDv              = CONVERT( VARCHAR(1), ' '  )
             , CliNom             = CONVERT( VARCHAR(100), 'SIN INFORMACION'   )
             , MdaCompCod         = CONVERT( NUMERIC(5), 0 )
             , MdaCompDsc         = CONVERT( VARCHAR(35) , ' '  )
             , FormaPagoCompCod   = CONVERT( NUMERIC(3), 0 )
             , FormaPagoCompDsc   = CONVERT( VARCHAR(30), 'Forma Pago no existe' ) 
             , MontoRecibir       = CONVERT( NUMERIC(21,4), 0 )
             , MontoPagar         = CONVERT( NUMERIC(21,4), 0 )
             , OrigenCod          = CONVERT( VARCHAR(2), '' )
             , OrigenDsc          = CONVERT( VARCHAR(16), '' )
             , Temporalidad       = CONVERT( VARCHAR(10), '' )
             , VctoValuta         = CONVERT( DATETIME, '19000101' )
			 , CodEstructura	  = CONVERT( VARCHAR(10), '' ) --ASVG_20110322 Para diferenciar reportes de vencimiento/pagos compensados
			 , TipoTransaccion	  = CONVERT(varchar(10),'')--Papeleta productos Asiáticos PRD_12567
             , TipoPayOff		  = CONVERT(varchar(2),'')--Papeleta productos Asiáticos PRD_12567
             , TipoBfwOpt         = CONVERT( varchar(3),'')--PRD_12567
    END ELSE
    BEGIN
        SELECT * FROM #Pagos

    END
    RETURN 0
END
GO
