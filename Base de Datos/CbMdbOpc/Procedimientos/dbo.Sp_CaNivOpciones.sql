USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CaNivOpciones]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_CaNivOpciones]

       (    

         @fecha     datetime    

       , @Usuario   VARCHAR(15)    

       )    

AS    

BEGIN    

    

    SET NOCOUNT ON    

    

    DECLARE @Nombre         VARCHAR(120)    

    DECLARE @Dv             CHAR(1)    

    DECLARE @FechaProceso   DATETIME    

    DECLARE @FechaProcAnt   DATETIME    

        

    -- Version Certificación 05 Nove.    

    SELECT *    

      INTO #Moneda    

      FROM LNKBAC.bacparamsuda.dbo.Moneda    

    

    -- Solo se cargarán Clientes que alguna vez han tenido opciones    

    SELECT ClRut    

         , ClCodigo    

         , ClDv    

         , ClNombre     

      INTO #Cliente    

      FROM LNKBAC.bacparamsuda.dbo.VIEW_CLIENTEParaOpc    

     WHERE Clrut IN ( SELECT MoRutCliente FROM MoEncContrato UNION SELECT MoRutCliente FROM MoHisEncContrato )    

    

    SET @FechaProceso = ''    

    SET @FechaProcAnt = ''    

    

    SELECT @FechaProceso = fechaproc     

         , @FechaProcAnt = fechaant    

      FROM dbo.opcionesGeneral    

    

    --     if ( select count(1) from #CLiente ) = 0     

    --         insert into #Cliente    

    -- select ClRut = 0, ClCodigo = 0, ClDv = '', ClNombre = 'CLIENTE NO EXISTE EN BAC'    

    

    SELECT *    

      INTO #Formas_Pago    

      FROM LNKBAC.bacparamsuda.dbo.Forma_de_Pago     

    

    SELECT *    

      INTO #Tabla_General_Detalle    

      FROM LNKBAC.bacparamsuda.dbo.Tabla_general_detalle    

     WHERE tbcateg IN ( 204, 1111, 1552, 1553, 1554 )    

    

    SELECT *    

      INTO #GEN_SISTEMAS    

      FROM LNKBAC.BacParamSuda.dbo.SISTEMA_CNT    

    

    -- 0. Se asume que no hay registros, se crea la tabla y se llena con el registro de "NO HAY DATOS" (Tabla #Detalle)    

    SELECT 'Reporte'                = 'CARTERA A NIVEL COMPONENTE'    

         , 'NumContrato'            = CONVERT( NUMERIC(8), 0 )    

         , 'NumFolio'               = CONVERT( NUMERIC(8), 0 )    

         , 'TipoTransaccion'        = CONVERT( VARCHAR(10), 'SIN DATOS' )    

         , 'FechaContrato'          = CONVERT( DATETIME, '', 112 )    

         , 'ConOpcEstCod'           = CONVERT( VARCHAR(1), '' )    

         , 'ConOpcEstDsc'           = CONVERT( VARCHAR(30), '' )    

         , 'CliRut'                 = CONVERT( NUMERIC(13), 0 )    

         , 'CliCod'                 = CONVERT( NUMERIC(5), 0 )    

         , 'CliDv'                  = CONVERT( VARCHAR(1), '' )    

         , 'CliNom'                 = CONVERT( VARCHAR(100), '' )    

         , 'Operador'               = CONVERT( VARCHAR(15), '' )    

         , 'OpcEstCod'              = CONVERT( VARCHAR(2), '' )    

         , 'OpcEstDsc'              = CONVERT( VARCHAR(30), '' )    

         , 'Contrapartida'          = CONVERT( VARCHAR(8), '' )    

         , 'CVEstructura'           = CONVERT( VARCHAR(1), '' )    

         , 'CompraVentaEstructura'  = CONVERT( VARCHAR(6), '' )    

         , 'MonPagPrimaCod'         = CONVERT( NUMERIC(5), 0 )    

         , 'MonPagPrimaDsc'         = CONVERT( VARCHAR(35), '' )    

         , 'fPagoPrimaCod'          = CONVERT( NUMERIC(3), 0 )    

         , 'fPagoPrimaDsc'          = CONVERT( VARCHAR(30), '' )    

         , 'PrimaInicial'           = CONVERT( FLOAT, 0.0 )    

         , 'FechaPagoPrima'         = CONVERT( DATETIME, '', 112 )    

         , 'CarteraFinancieraCod'   = CONVERT( VARCHAR(6), '' )    

         , 'CarteraFinancieraDsc'   = CONVERT( VARCHAR(50), '' )    

         , 'CarteraNormativaCod'    = CONVERT( VARCHAR(6), '' )    

         , 'CarteraNormativaDsc'    = CONVERT( VARCHAR(50), '' )    

         , 'LibroCod'               = CONVERT( VARCHAR(6), '' )    

         , 'LibroDsc'               = CONVERT( VARCHAR(50), '' )    

         , 'AreaResponsalbleCod'    = CONVERT( VARCHAR(6), '' )    

         , 'AreaResponsalbleDsc'    = CONVERT( VARCHAR(50),'' )    

    

         , 'SubCarNormativaCod'     = CONVERT( VARCHAR(6), '' )    

         , 'SubCarNormativaDsc'     = CONVERT( VARCHAR(50), '' )    

    

         , 'MonPrimaTrfCod'         = CONVERT( NUMERIC(5), 0 )    

         , 'MonPrimaTrfDsc'         = CONVERT( VARCHAR(35), '' )    

         , 'PrimaTranferencia'      = CONVERT( FLOAT, 0.0 )    

         , 'PrimaTranferenciaML'    = CONVERT( FLOAT, 0.0 )    

    

         , 'MonPrimaCostoCod'       = CONVERT( NUMERIC(5), 0 )    

         , 'MonPrimaCostoDsc'       = CONVERT( VARCHAR(35), '' )    

         , 'PrimaCosto'             = CONVERT( FLOAT, 0.0 )    

         , 'PrimaCostoML'           = CONVERT( FLOAT, 0.0 )    

    

         , 'MonPrimaCarryCod'       = CONVERT( NUMERIC(5), 0 )    

         , 'MonPrimaCarryDsc'       = CONVERT( VARCHAR(35), '' )    

         , 'PrimaCarry'             = CONVERT( FLOAT, 0.0 )    

    

         , 'MonVrCod'               = CONVERT( NUMERIC(5), 0 )    

         , 'MonVrDsc'               = CONVERT( VARCHAR(35), '' )    

         , 'Vr'                     = CONVERT( FLOAT, 0.0 )    

         , 'Vr_Costo'               = CONVERT( FLOAT, 0.0 )    

    

         , 'MonDeltaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonDeltaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonGammaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonGammaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonVegaCod'             = CONVERT( NUMERIC(5), 0 )    

         , 'MonVegaDsc'             = CONVERT( VARCHAR(35), '' )    

    

         , 'MonVannaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonVannaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonVolgaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonVolgaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonThetaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonThetaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonRhoCod'              = CONVERT( NUMERIC(5), 0 )    

         , 'MonRhoDsc'              = CONVERT( VARCHAR(35), '' )    

    

         , 'MonRhofCod'             = CONVERT( NUMERIC(5), 0 )    

         , 'MonRhofDsc'             = CONVERT( VARCHAR(35), '' )    

    

         , 'MonCharmCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonCharmDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonZommaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonZommaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonSpeedCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonSpeedDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'PrimaBSSpotCont'        = CONVERT( FLOAT, 0.0 )    

         , 'DeltaSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'DeltaForwardCont'       = CONVERT( FLOAT, 0.0 )    

         , 'GammaSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'GammaFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'VegaCont'               = CONVERT( FLOAT, 0.0 )    

    

         , 'VannaSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'VannaFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'VolgaCont'              = CONVERT( FLOAT, 0.0 )    

         , 'ThetaCont'              = CONVERT( FLOAT, 0.0 )    

         , 'RhoDomCont'             = CONVERT( FLOAT, 0.0 )    

         , 'RhoForCont'             = CONVERT( FLOAT, 0.0 )    

    

         , 'CharmSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'CharmFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'ZommaSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'ZommaFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'SpeedSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'SpeedFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'FechaUnwind'            = CONVERT( DATETIME, '', 112 )    

         , 'NominalUnwind'          = CONVERT( FLOAT,  0.0  )     

         , 'UnwindMonCod'           = CONVERT( NUMERIC(5), 0 )    

         , 'UnwindMonDsc'           = CONVERT( VARCHAR(35), '' )    

    

         , 'Unwind'                 = CONVERT( NUMERIC(21,4), 0.0 )    

         , 'UnwindML'               = CONVERT( NUMERIC(21,4), 0.0 )    

         , 'FormPagoUnwindCod'      = CONVERT( NUMERIC(3), 0 )    

         , 'FormPagoUnwindDsc'      = CONVERT( VARCHAR(30), '' )    

    

         , 'UnwindTransfMonCod'     = CONVERT( NUMERIC(5), 0 )     

         , 'UnwindTransfMonDsc'     = CONVERT( VARCHAR(35), '' )     

         , 'UnwindTransf'           = CONVERT( NUMERIC(21,4), 0.0 )    

         , 'UnwindTransfML'         = CONVERT( NUMERIC(21,4), 0.0 )    

    

         , 'Glosa'                  = CONVERT( VARCHAR(80), '' )    

         , 'Usuario'                = CONVERT( VARCHAR(15), @Usuario )    

         , 'FechaProceso'           = CONVERT( DATETIME, @FechaProceso, 112 )    

         , 'FechaCreacionRegistro'  = CONVERT( DATETIME, '', 112 )    

    

         , 'OpcTipCod'              = CONVERT( CHAR(1), '' )    

         , 'OpcTipDsc'              = CONVERT( VARCHAR(20), '' )    

         , 'SubyacenteCod'          = CONVERT( CHAR(3), '' )    

         , 'SubyacenteDsc'          = CONVERT( VARCHAR(40), '' )    

         , 'NumEstructura'          = CONVERT( NUMERIC(6), 0 )    

         , 'PayOffTipCod'           = CONVERT( VARCHAR(2), '' )    

         , 'PayOffTipDsc'           = CONVERT( VARCHAR(20), '' )    

         , 'CallPut'                = CONVERT( VARCHAR(5), '' )    

         , 'CVOpcCod'               = CONVERT( VARCHAR(3), '' )    

         , 'CompraVentaOpcDsc'      = CONVERT( VARCHAR(6), '' )    

         , 'TipoEmisionPTCod'       = CONVERT( VARCHAR(3), '' )    

         , 'TipoEmisionPTDsc'       = CONVERT( VARCHAR(8), '' )    

         , 'FechaInicioOpc'         = CONVERT( DATETIME, '', 112 )    

    

         , 'FechaFijacionOpc'       = CONVERT( DATETIME, '', 112 )    

         , 'FechaVcto'              = CONVERT( DATETIME, '', 112 )    

         , 'FechaPagoEjer'          = CONVERT( DATETIME, '', 112 )    

         , 'FechaPagMon1'           = CONVERT( DATETIME, '', 112 )    

         , 'FechaPagMon2'           = CONVERT( DATETIME, '', 112 )    

    

         , 'Mon1Cod'                = CONVERT( NUMERIC(5), 0 )    

         , 'Mon1Dsc'                = CONVERT( VARCHAR(35), ''  )    

         , 'MontoMon1'              = CONVERT( NUMERIC(21,6) , 0 )    

    

         , 'FormaPagoMon1Cod'       = CONVERT( NUMERIC(3), 0 )    

         , 'FormaPagoMon1Dsc'       = CONVERT( VARCHAR(30), '' )    

    

         , 'Mon2Cod'                = CONVERT( NUMERIC(5), 0 )    

         , 'Mon2Dsc'                = CONVERT( VARCHAR(35), '' )    

         , 'MontoMon2'              = CONVERT( NUMERIC(21,6) , 0 )    

         , 'FormaPagoMon2Cod'       = CONVERT( NUMERIC(3), 0 )    

         , 'FormaPagoMon2Dsc'       = CONVERT( VARCHAR(30), '' )    

         , 'ModalidadCod'           = CONVERT( VARCHAR(1), '' )    

         , 'ModalidadDsc'           = CONVERT( VARCHAR(15), '' )    

    

         , 'MdaCompensacionCod'     = CONVERT( NUMERIC(5), 0 )    

         , 'MdaCompensacionDsc'     = CONVERT( VARCHAR(35), '' )    

    

         , 'BenchCompCod'           = CONVERT( NUMERIC(5), 0 )    

         , 'BenchCompDsc'           = CONVERT( VARCHAR(40), '' )    

    

         , 'ParStrike'              = CONVERT( VARCHAR(7), ''  )    

         , 'Strike'                 = CONVERT( FLOAT, 0.0 )    

         , 'PorcStrike'             = CONVERT( FLOAT, 0.0 )    

    

         , 'TipoEjercicioCod'       = CONVERT( VARCHAR(1), '' )     

         , 'TipoEjercicioDsc'       = CONVERT( VARCHAR(10), '' )    

         , 'VrDet'                  = CONVERT( FLOAT, 0.0 )    

         , 'IteAsoSisCod'           = CONVERT( CHAR(3), '' )    

         , 'IteAsoSisDsc'           = CONVERT( CHAR(20), '' )    

         , 'IteAsoCon'              = CONVERT( NUMERIC(8), 0.0 )    

         , 'PrimaDet'               = CONVERT( FLOAT, 0.0 )    

         , 'AjusteVR'               = CONVERT( FLOAT, 0.0 )    

      INTO #Detalle    

    

    -- 1. Se asume que no hay registros, se crea la tabla y se llena con el registro de "NO HAY DATOS" (Tabla #Resultado)    

    SELECT 'Reporte'                = 'CARTERA A NIVEL COMPONENTE'    

         , 'NumContrato'            = CONVERT( NUMERIC(8), 0 )    

         , 'NumFolio'               = CONVERT( NUMERIC(8), 0 )    

         , 'TipoTransaccion'        = CONVERT( VARCHAR(10), 'SIN DATOS' )    

         , 'FechaContrato'          = CONVERT( DATETIME, '', 112 )    

         , 'ConOpcEstCod'           = CONVERT( VARCHAR(1), '' )    

         , 'ConOpcEstDsc'           = CONVERT( VARCHAR(30), '' )    

         , 'CliRut'                 = CONVERT( NUMERIC(13), 0 )    

         , 'CliCod'                 = CONVERT( NUMERIC(5), 0 )    

         , 'CliDv'                  = CONVERT( VARCHAR(1), '' )    

         , 'CliNom'                 = CONVERT( VARCHAR(100), '' )    

         , 'Operador'               = CONVERT( VARCHAR(15), '' )    

         , 'OpcEstCod'              = CONVERT( VARCHAR(2), '' )    

         , 'OpcEstDsc'              = CONVERT( VARCHAR(30), '' )    

         , 'Contrapartida'          = CONVERT( VARCHAR(8), '' )    

         , 'CVEstructura'           = CONVERT( VARCHAR(1), '' )    

         , 'CompraVentaEstructura'  = CONVERT( VARCHAR(6), '' )    

         , 'MonPagPrimaCod'         = CONVERT( NUMERIC(5), 0 )    

         , 'MonPagPrimaDsc'         = CONVERT( VARCHAR(35), '' )    

         , 'fPagoPrimaCod'          = CONVERT( NUMERIC(3), 0 )    

         , 'fPagoPrimaDsc'          = CONVERT( CHAR(30), '' )    

         , 'PrimaInicial'           = CONVERT( FLOAT, 0.0 )    

         , 'FechaPagoPrima'         = CONVERT( DATETIME, '', 112 )    

         , 'CarteraFinancieraCod'   = CONVERT( VARCHAR(6), '' )    

         , 'CarteraFinancieraDsc'   = CONVERT( VARCHAR(50), '' )    

         , 'CarteraNormativaCod'    = CONVERT( VARCHAR(6), '' )    

         , 'CarteraNormativaDsc'    = CONVERT( VARCHAR(50), '' )    

         , 'LibroCod'               = CONVERT( VARCHAR(6), '' )    

         , 'LibroDsc'               = CONVERT( VARCHAR(50), '' )    

         , 'AreaResponsalbleCod'    = CONVERT( VARCHAR(6), '' )    

         , 'AreaResponsalbleDsc'    = CONVERT( VARCHAR(50),'' )    

    

         , 'SubCarNormativaCod'     = CONVERT( VARCHAR(6), '' )    

         , 'SubCarNormativaDsc'     = CONVERT( VARCHAR(50), '' )    

    

         , 'MonPrimaTrfCod'         = CONVERT( NUMERIC(5), 0 )    

         , 'MonPrimaTrfDsc'         = CONVERT( VARCHAR(35), '' )    

         , 'PrimaTranferencia'      = CONVERT( FLOAT, 0.0 )    

         , 'PrimaTranferenciaML'    = CONVERT( FLOAT, 0.0 )    

    

         , 'MonPrimaCostoCod'       = CONVERT( NUMERIC(5), 0 )    

         , 'MonPrimaCostoDsc'       = CONVERT( VARCHAR(35), '' )    

         , 'PrimaCosto'             = CONVERT( FLOAT, 0.0 )    

         , 'PrimaCostoML'           = CONVERT( FLOAT, 0.0 )    

    

         , 'MonPrimaCarryCod'       = CONVERT( NUMERIC(5), 0 )    

         , 'MonPrimaCarryDsc'       = CONVERT( VARCHAR(35), '' )    

         , 'PrimaCarry'             = CONVERT( FLOAT, 0.0 )    

    

         , 'MonVrCod'               = CONVERT( NUMERIC(5), 0 )    

         , 'MonVrDsc'               = CONVERT( VARCHAR(35), '' )    

         , 'Vr'                     = CONVERT( FLOAT, 0.0 )    

         , 'Vr_Costo'               = CONVERT( FLOAT, 0.0 )    

    

         , 'MonDeltaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonDeltaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonGammaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonGammaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonVegaCod'             = CONVERT( NUMERIC(5), 0 )    

         , 'MonVegaDsc'             = CONVERT( VARCHAR(35), '' )    

    

         , 'MonVannaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonVannaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonVolgaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonVolgaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonThetaCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonThetaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonRhoCod'              = CONVERT( NUMERIC(5), 0 )    

         , 'MonRhoDsc'              = CONVERT( VARCHAR(35), '' )    

    

         , 'MonRhofCod'             = CONVERT( NUMERIC(5), 0 )    

         , 'MonRhofDsc'             = CONVERT( VARCHAR(35), '' )    

    

         , 'MonCharmCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonCharmDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonZommaCod'            = CONVERT( NUMERIC(5) , 0 )    

         , 'MonZommaDsc'            = CONVERT( VARCHAR(35), '' )    

    

         , 'MonSpeedCod'            = CONVERT( NUMERIC(5), 0 )    

         , 'MonSpeedDsc' = CONVERT( VARCHAR(35), '' )    

    

         , 'PrimaBSSpotCont'        = CONVERT( FLOAT, 0.0 )    

         , 'DeltaSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'DeltaForwardCont'       = CONVERT( FLOAT, 0.0 )    

         , 'GammaSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'GammaFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'VegaCont'               = CONVERT( FLOAT, 0.0 )    

    

         , 'VannaSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'VannaFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'VolgaCont'              = CONVERT( FLOAT, 0.0 )    

         , 'ThetaCont'              = CONVERT( FLOAT, 0.0 )    

         , 'RhoDomCont'             = CONVERT( FLOAT, 0.0 )    

         , 'RhoForCont'             = CONVERT( FLOAT, 0.0 )    

    

         , 'CharmSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'CharmFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'ZommaSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'ZommaFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'SpeedSpotCont'          = CONVERT( FLOAT, 0.0 )    

         , 'SpeedFwdCont'           = CONVERT( FLOAT, 0.0 )    

    

         , 'FechaUnwind'            = CONVERT( DATETIME, '', 112 )    

         , 'NominalUnwind'          = CONVERT( FLOAT,  0.0  )     

         , 'UnwindMonCod'           = CONVERT( NUMERIC(5), 0 )    

         , 'UnwindMonDsc'           = CONVERT( VARCHAR(35), '' )    

    

         , 'Unwind'                 = CONVERT( NUMERIC(21,4), 0.0 )    

         , 'UnwindML'               = CONVERT( NUMERIC(21,4), 0.0 )    

         , 'FormPagoUnwindCod'      = CONVERT( NUMERIC(3), 0 )    

         , 'FormPagoUnwindDsc'      = CONVERT( VARCHAR(30), '' )    

    

         , 'UnwindTransfMonCod'     = CONVERT( NUMERIC(5), 0 )     

         , 'UnwindTransfMonDsc'     = CONVERT( VARCHAR(35), '' )    

         , 'UnwindTransf'           = CONVERT( NUMERIC(21,4), 0.0 )    

         , 'UnwindTransfML'         = CONVERT( NUMERIC(21,4), 0.0 )    

    

         , 'Glosa'                  = CONVERT( VARCHAR(80), '' )    

         , 'Usuario'                = CONVERT( VARCHAR(15), @Usuario )    

         , 'FechaProceso'           = CONVERT( DATETIME, @FechaProceso, 112 )    

         , 'FechaCreacionRegistro'  = CONVERT( DATETIME, '', 112 )    

    

         , 'OpcTipCod'              = CONVERT( CHAR(1), '' )    

         , 'OpcTipDsc'              = CONVERT( VARCHAR(20), '' )    

         , 'SubyacenteCod'          = CONVERT( CHAR(3), '' )    

         , 'SubyacenteDsc'          = CONVERT( VARCHAR(40), '' )   

         , 'NumEstructura'          = CONVERT( NUMERIC(6), 0 )    

         , 'PayOffTipCod'           = CONVERT( VARCHAR(2), '' )    

         , 'PayOffTipDsc'           = CONVERT( VARCHAR(20), '' )    

         , 'CallPut'                = CONVERT( VARCHAR(5), '' )    

         , 'CVOpcCod'               = CONVERT( VARCHAR(3), '' )    

         , 'CompraVentaOpcDsc'      = CONVERT( VARCHAR(6), '' )    

         , 'TipoEmisionPTCod'       = CONVERT( VARCHAR(3), '' )    

         , 'TipoEmisionPTDsc'       = CONVERT( VARCHAR(8), '' )    

         , 'FechaInicioOpc'         = CONVERT( DATETIME, '', 112 )    

    

         , 'FechaFijacionOpc'       = CONVERT( DATETIME, '', 112 )    

         , 'FechaVcto'              = CONVERT( DATETIME, '', 112 )    

     , 'FechaPagoEjer'          = CONVERT( DATETIME, '', 112 )    

         , 'FechaPagMon1'           = CONVERT( DATETIME, '', 112 )    

         , 'FechaPagMon2'           = CONVERT( DATETIME, '', 112 )    

    

         , 'Mon1Cod'                = CONVERT( NUMERIC(5), 0 )    

         , 'Mon1Dsc'                = CONVERT( VARCHAR(35), '' )    

         , 'MontoMon1'              = CONVERT( NUMERIC(21,6), 0 )    

    

         , 'FormaPagoMon1Cod'       = CONVERT( NUMERIC(3), 0 )    

         , 'FormaPagoMon1Dsc'       = CONVERT( VARCHAR(30), '' )    

    

         , 'Mon2Cod'                = CONVERT( NUMERIC(5), 0 )    

         , 'Mon2Dsc'                = CONVERT( VARCHAR(35), '' )    

         , 'MontoMon2'              = CONVERT( NUMERIC(21,6), 0 )    

         , 'FormaPagoMon2Cod'       = CONVERT( NUMERIC(3), 0 )    

         , 'FormaPagoMon2Dsc'       = CONVERT( VARCHAR(30), '' )    

         , 'ModalidadCod'           = CONVERT( VARCHAR(1), '' )    

         , 'ModalidadDsc'           = CONVERT( VARCHAR(15), '' )    

    

         , 'MdaCompensacionCod'     = CONVERT( NUMERIC(5), 0 )    

         , 'MdaCompensacionDsc'     = CONVERT( VARCHAR(35), ''  )    

    

         , 'BenchCompCod'           = CONVERT( NUMERIC(5), 0 )    

         , 'BenchCompDsc'           = CONVERT( VARCHAR(40) , ''  )    

    

         , 'ParStrike'              = CONVERT( VARCHAR(7), '' )    

         , 'Strike'                 = CONVERT( FLOAT, 0.0 )    

         , 'PorcStrike'             = CONVERT( FLOAT, 0.0 )    

    

         , 'TipoEjercicioCod'       = CONVERT( VARCHAR(1), '' )    

         , 'TipoEjercicioDsc'       = CONVERT( VARCHAR(10), '' )    

         , 'VrDet'                  = CONVERT( FLOAT, 0.0 )    

         , 'IteAsoSisCod'           = CONVERT( VARCHAR(3), '' )    

         , 'IteAsoSisDsc'           = CONVERT( VARCHAR(20), '' )    

         , 'IteAsoCon'              = CONVERT( NUMERIC(8), 0.0  )    

         , 'PrimaDet'               = CONVERT( FLOAT, 0.0 )    

         , 'AjusteVR'               = CONVERT( FLOAT, 0.0 )    

         , 'CantidadComponentes'    = CONVERT( NUMERIC(5), 0 )   

      INTO #Resultado      

    

    -- 2. Se navega el encabezado y se lleva info a tabla #Encabezado    

    SELECT 'Reporte'                = 'CARTERA A NIVEL COMPONENTE'    

         , 'NumContrato'            = CONVERT( NUMERIC(8), Cartera.CaNumContrato )    

         , 'NumFolio'               = CONVERT( NUMERIC(8), Cartera.CaNumFolio )    

         , 'TipoTransaccion'        = CONVERT( VARCHAR(10), Cartera.CaTipoTransaccion )    

         , 'FechaContrato'          = CONVERT( DATETIME, Cartera.CaFechaContrato, 112 )    

         , 'ConOpcEstCod'           = CONVERT( VARCHAR(1), Cartera.CaEstado )    

         , 'ConOpcEstDsc'           = CONVERT( VARCHAR(30), ISNULL( Estado.ConOpcEstDsc, 'Estado no Existe' ) )    

         , 'CliRut'                 = CONVERT( NUMERIC(13), Cartera.CaRutCliente )    

         , 'CliCod'                 = CONVERT( NUMERIC(5), Cartera.CaCodigo )    

         , 'CliDv'                  = CONVERT( VARCHAR(1), ISNULL( Cliente.ClDv, ' ' ) )    

         , 'CliNom'                 = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no existe, Crear en BAC' ) )    

         , 'Operador'               = CONVERT( VARCHAR(15), Cartera.CaOperador )    

         , 'OpcEstCod'              = CONVERT( VARCHAR(2), Cartera.CaCodEstructura )    

         

          --PRD10449 PAE

         , 'OpcEstDsc'              = CASE WHEN Cartera.CaCodEstructura = 0 AND Cartera.CaRelacionaPAE = 1 

										  THEN CONVERT( VARCHAR(30),Estructura.OpcEstDsc + ' - PAE ESTRUCTURADO')

										  ELSE CONVERT( VARCHAR(30), ISNULL( Estructura.OpcEstDsc, 'Estructura no Existe'  ) ) END

          --PRD10449 PAE

         , 'Contrapartida'          = CONVERT( VARCHAR(8), Cartera.CaTipoContrapartida )    

         , 'CVEstructura'           = CONVERT( VARCHAR(1), Cartera.CaCVEstructura )    

         , 'CompraVentaEstructura'  = CONVERT( VARCHAR(6), CASE WHEN Cartera.CaCVEstructura = 'C' THEN 'COMPRA' ELSE 'VENTA' END )    

         , 'MonPagPrimaCod'         = CONVERT( NUMERIC(5), Cartera.CaCodMonPagPrima )    

         , 'MonPagPrimaDsc'         = CONVERT( VARCHAR(35), ISNULL( MonedaPrima.MnGlosa, 'Moneda Prima no existe' ) )    

         , 'fPagoPrimaCod'          = CONVERT( NUMERIC(3), Cartera.CafPagoPrima )    

         , 'fPagoPrimaDsc'          = CONVERT( VARCHAR(30), ISNULL( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )    

    

         , 'PrimaInicial'           = CONVERT( FLOAT, Cartera.CaPrimaInicial )          -- PrimaInicial -> PrimaInicialDet   -- MAP 05 Nov 2009    

         , 'FechaPagoPrima'         = CONVERT( DATETIME, Cartera.CaFechaPagoPrima, 112 )    

    

         , 'CarteraFinancieraCod'   = CONVERT( VARCHAR(6), Cartera.CaCarteraFinanciera )    

         , 'CarteraFinancieraDsc'   = CONVERT( VARCHAR(50), ISNULL( Financiera.tbglosa, 'Cartera Fin. no exite' ) )    

         , 'CarteraNormativaCod'    = CONVERT( VARCHAR(6), Cartera.CaCarNormativa )    

         , 'CarteraNormativaDsc'    = CONVERT( VARCHAR(50), ISNULL( Normativa.tbglosa, 'Catera Normativa no existe' ) )    

         , 'LibroCod'               = CONVERT( VARCHAR(6), Cartera.CaLibro )     

         , 'LibroDsc'               = CONVERT( VARCHAR(50), ISNULL( Libro.tbglosa, 'Libro no existe' ) )    

         , 'AreaResponsalbleCod'    = CONVERT( VARCHAR(6), 6 )                                                              -- Mesa de dinero siempre no tenemos el campo    

         , 'AreaResponsalbleDsc'    = CONVERT( VARCHAR(50), ISNULL( Responsable.tbglosa, 'No existe area responsable' ) )   -- Mesa de dinero siempre no tenemos el campo    

    

         , 'SubCarNormativaCod'     = CONVERT( VARCHAR(6), Cartera.CaSubCarNormativa )    

         , 'SubCarNormativaDsc'     = CONVERT( VARCHAR(50), ISNULL( SubCartera.tbglosa, 'Falto SubCarNormatica' ) )    

    

         , 'MonPrimaTrfCod'         = CONVERT( NUMERIC(5), Cartera.CaMonPrimaTrf )    

         , 'MonPrimaTrfDsc'         = CONVERT( VARCHAR(35), ISNULL( MonedaPrimaTranf.MnGlosa, 'Moneda Prima Traf. no existe' ) )    

        , 'PrimaTranferencia'      = CONVERT( FLOAT    , Cartera.CaPrimaTrf )    

         , 'PrimaTranferenciaML'    = CONVERT( FLOAT  , Cartera.CaPrimaTrfML )    

    

         , 'MonPrimaCostoCod'       = CONVERT( NUMERIC(5), Cartera.CaMonPrimaCosto )    

         , 'MonPrimaCostoDsc'       = CONVERT( VARCHAR(35), ISNULL( MonedaPrimaCosto.MnGlosa, 'Moneda Prima Costo. no existe' ) )    

         , 'PrimaCosto'             = CONVERT( FLOAT, Cartera.CaPrimaCosto )    

         , 'PrimaCostoML'           = CONVERT( FLOAT, Cartera.CaPrimaCostoML )    

    

         , 'MonPrimaCarryCod'       = CONVERT( NUMERIC(5), Cartera.CaMonCarryPrima )    

         , 'MonPrimaCarryDsc'       = CONVERT( VARCHAR(35), ISNULL( MonedaPrimaCarry.MnGlosa, 'Moneda Prima Carry. no existe' ) )    

         , 'PrimaCarry'             = CONVERT( FLOAT, Cartera.CaCarryPrima )    

    

         , 'MonVrCod'               = CONVERT( NUMERIC(5), Cartera.CaMon_Vr )    

         , 'MonVrDsc'               = CONVERT( VARCHAR(35), ISNULL( MonedaVr.MnGlosa, 'Moneda Vr no existe' ) )    

         , 'Vr'                     = CONVERT( FLOAT, Cartera.CaVr )    

         , 'Vr_Costo'               = CONVERT( FLOAT, Cartera.CaVr_Costo )    

    

         , 'MonDeltaCod'            = CONVERT( NUMERIC(5), Cartera.CaMonDelta )    

         , 'MonDeltaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaDelta.MnGlosa, 'Moneda Delta no existe' ) )    

    

         , 'MonGammaCod'            = CONVERT( NUMERIC(5), Cartera.CaMon_Gamma )    

         , 'MonGammaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaGamma.MnGlosa, 'Moneda Gamma no existe' ) )    

    

         , 'MonVegaCod'             = CONVERT( NUMERIC(5), Cartera.CaMon_Vega )    

         , 'MonVegaDsc'             = CONVERT( VARCHAR(35), ISNULL( MonedaVega.MnGlosa, 'Moneda Vega no existe' ) )    

    

         , 'MonVannaCod'            = CONVERT( NUMERIC(5), Cartera.CaMon_Vanna )    

         , 'MonVannaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaVanna.MnGlosa, 'Moneda Vanna no existe' ) )    

    

         , 'MonVolgaCod'            = CONVERT( NUMERIC(5), Cartera.CaMon_Volga )    

        , 'MonVolvaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaVolga.MnGlosa, 'Moneda Volga no existe' ) )    

    

         , 'MonThetaCod'            = CONVERT( NUMERIC(5), Cartera.CaMon_Theta )    

         , 'MonThetaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaVolga.MnGlosa, 'Moneda Theta no existe' ) )    

    

    

         , 'MonRhoCod'              = CONVERT( NUMERIC(5), Cartera.CaMon_Rho )    

         , 'MonRhoDsc'              = CONVERT( VARCHAR(35), ISNULL( MonedaRho.MnGlosa, 'Moneda Rho no existe' ) )    

    

         , 'MonRhofCod'             = CONVERT( NUMERIC(5), Cartera.CaMon_Rhof )    

         , 'MonRhofDsc'             = CONVERT( VARCHAR(35), ISNULL( MonedaRho.MnGlosa, 'Moneda Rhof no existe' ) )    

    

         , 'MonCharmCod'            = CONVERT( NUMERIC(5), Cartera.CaMon_Charm )    

         , 'MonCharmDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaCharm.MnGlosa, 'Moneda Charm no existe' ) )    

    

         , 'MonZommaCod'            = CONVERT( NUMERIC(5), Cartera.CaMon_Zomma )    

         , 'MonZommaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaZomma.MnGlosa, 'Moneda Zomma no existe' ) )    

    

         , 'MonSpeedCod'            = CONVERT( NUMERIC(5), Cartera.CaMon_Speed )    

         , 'MonSpeedDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaSpeed.MnGlosa, 'Moneda Speed no existe' ) )    

    

         , 'PrimaBSSpotCont'        = CONVERT( FLOAT, ISNULL( Cartera.CaPrimaBSSpotCont, 0.0 ) )    

         , 'DeltaSpotCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaDeltaSpotCont, 0.0 ) )    

         , 'DeltaForwardCont'       = CONVERT( FLOAT, ISNULL( Cartera.CaDeltaForwardCont, 0.0 ) )    

         , 'GammaSpotCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaGammaSpotCont, 0.0 ) )    

         , 'GammaFwdCont'           = CONVERT( FLOAT, ISNULL( Cartera.CaGammaFwdCont, 0.0 ) )    

    

         , 'VegaCont'               = CONVERT( FLOAT, ISNULL( Cartera.CaVegaCont, 0.0 ) )    

         , 'VannaSpotCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaVannaSpotCont, 0.0 ) )    

         , 'VannaFwdCont'           = CONVERT( FLOAT, ISNULL( Cartera.CaVannaFwdCont, 0.0 ) )    

    

         , 'VolgaCont'              = CONVERT( FLOAT, ISNULL( Cartera.CaVolgaCont, 0.0 ) )    

         , 'ThetaCont'              = CONVERT( FLOAT, ISNULL( Cartera.CaThetaCont, 0.0 ) )    

         , 'RhoDomCont'             = CONVERT( FLOAT, ISNULL( Cartera.CaRhoDomCont, 0.0 ) )    

         , 'RhoForCont'             = CONVERT( FLOAT, ISNULL( Cartera.CaRhoForCont, 0.0 ) )    

    

         , 'CharmSpotCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaCharmSpotCont, 0.0 ) )    

         , 'CharmFwdCont'           = CONVERT( FLOAT, ISNULL( Cartera.CaCharmFwdCont, 0.0 ) )    

    

         , 'ZommaSpotCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaZommaspotCont, 0.0 ) )    

         , 'ZommaFwdCont'           = CONVERT( FLOAT, ISNULL( Cartera.CaZommaFwdCont, 0.0 ) )    

    

         , 'SpeedSpotCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaSpeedSpotCont, 0.0 ) )    

         , 'SpeedFwdCont'           = CONVERT( FLOAT, ISNULL( Cartera.CaSpeedFwdCont, 0.0 ) )    

    

         , 'FechaUnwind'            = CONVERT( DATETIME, Cartera.CaFechaUnwind, 112 )     

         , 'NominalUnwind'          = CONVERT( FLOAT, ISNULL( Cartera.CaNominalUnwind, 0.0 ) )     

         , 'UnwindMonCod'           = CONVERT( NUMERIC(5), ISNULL( Cartera.CaUnwindMon, 0.0 ) )    

         , 'UnwindMonDsc'           = CONVERT( VARCHAR(35), ISNULL( MonedaUnwind.MnGlosa, 'Moneda Unwind no existe' ) )    

    

         , 'Unwind'                 = CONVERT( NUMERIC(21,4), ISNULL( Cartera.CaUnwind, 0.0 ) )    

         , 'UnwindML'               = CONVERT( NUMERIC(21,4), ISNULL( Cartera.CaUnwindML, 0.0 ) )    

         , 'FormPagoUnwindCod'      = CONVERT( NUMERIC(3), ISNULL( Cartera.CaFormPagoUnwind, 0.0 ) )    

         , 'FormPagoUnwindDsc'      = CONVERT( VARCHAR(30), ISNULL( FormaPagoUnwind.glosa, 'Forma Pago Unwind no existe' ) )    

    

 , 'UnwindTransfMonCod'     = CONVERT( NUMERIC(5), ISNULL( Cartera.CaUnwindTransfMon, 0.0 ) )     

         , 'UnwindTransfMonDsc'     = CONVERT( VARCHAR(35), ISNULL( MonedaUnwindTrf.MnGlosa, 'Moneda Traf. Unwind no existe' ) )    

         , 'UnwindTransf'           = CONVERT( NUMERIC(21,4), ISNULL( Cartera.CaUnwindTransf, 0.0 ) )    

         , 'UnwindTransfML'         = CONVERT( NUMERIC(21,4), ISNULL( Cartera.CaUnwindTransfML, 0.0 ) )    

    

         , 'Glosa'                  = CONVERT( VARCHAR(80), ISNULL( Cartera.CaGlosa , ' ' ) )    

         , 'Usuario'                = CONVERT( VARCHAR(15), @Usuario )    

         , 'FechaProceso'           = CONVERT( DATETIME, @FechaProceso, 112 )    

         , 'FechaCreacionRegistro'  = CONVERT( DATETIME, ISNULL( Cartera.CaFechaCreacionRegistro, '' ) )    

      INTO #Encabezado    

      FROM dbo.CaEncContrato                Cartera    

           LEFT JOIN #Cliente               Cliente           ON Cliente.ClRut             = Cartera.CaRutCliente    

                                                             AND Cartera.CaCodigo          = Cliente.ClCodigo    

           LEFT JOIN #Moneda                MonedaUnwindTrf   ON MonedaUnwindTrf.MnCodMon  = Cartera.CaUnwindTransfMon    

           LEFT JOIN #Formas_Pago           FormaPagoUnwind   ON FormaPagoUnwind.Codigo    = Cartera.CaFormPagoUnwind    

           LEFT JOIN #Formas_Pago           FormaPagoPrima    ON FormaPagoPrima.Codigo     = Cartera.CafPagoPrima    

         LEFT JOIN #Moneda                MonedaUnwind      ON MonedaUnwind.MnCodMon     = Cartera.CaUnwindMon    

           LEFT JOIN #Moneda                MonedaSpeed       ON MonedaSpeed.MnCodMon      = Cartera.CaMon_Speed    

           LEFT JOIN #Moneda                MonedaZomma       ON MonedaZomma.MnCodMon      = Cartera.CaMon_Zomma    

           LEFT JOIN #Moneda                MonedaCharm       ON MonedaCharm.MnCodMon      = Cartera.CaMon_Charm    

           LEFT JOIN #Moneda                MonedaRhof        ON MonedaRhof.MnCodMon       = Cartera.CaMon_Rhof    

           LEFT JOIN #Moneda                MonedaRho         ON MonedaRho.MnCodMon        = Cartera.CaMon_Rho    

           LEFT JOIN #Moneda                MonedaVolga       ON MonedaVolga.MnCodMon      = Cartera.CaMon_Volga    

           LEFT JOIN #Moneda                MonedaVanna       ON MonedaVanna.MnCodMon      = Cartera.CaMon_Vanna    

           LEFT JOIN #Moneda                MonedaVega        ON MonedaVega.MnCodMon       = Cartera.CaMon_Vega    

           LEFT JOIN #Moneda                MonedaGamma       ON MonedaGamma.MnCodMon      = Cartera.CaMon_Gamma    

           LEFT JOIN #Moneda                MonedaDelta       ON MonedaDelta.MnCodMon      = Cartera.CaMonDelta    

           LEFT JOIN #Moneda                MonedaPrima       ON MonedaPrima.MnCodMon      = Cartera.CaCodMonPagPrima    

           LEFT JOIN #Moneda                MonedaPrimaTranf  ON MonedaPrimaTranf.MnCodMon = Cartera.CaMonPrimaTrf    

           LEFT JOIN #Moneda                MonedaPrimaCosto  ON MonedaPrimaCosto.MnCodMon = Cartera.CaMonPrimaCosto    

           LEFT JOIN #Moneda                MonedaPrimaCarry  ON MonedaPrimaCarry.MnCodMon = Cartera.CaMonCarryPrima    

           LEFT JOIN #Moneda                MonedaVr          ON MonedaVr.MnCodMon         = Cartera.CaMon_Vr    

           LEFT JOIN ConOpcEstado           Estado            ON Estado.ConOpcEstCod       = Cartera.CaEstado    

           LEFT JOIN OpcionEstructura       Estructura        ON Estructura.OpcEstCod      = Cartera.CaCodEstructura    

           LEFT JOIN #TABLA_GENERAL_DETALLE Financiera        ON Financiera.tbcateg        = 204    

                                                             AND Financiera.tbcodigo1      = Cartera.CaCarteraFinanciera    

           LEFT JOIN #TABLA_GENERAL_DETALLE Normativa         ON Normativa.tbcateg         = 1111    

                                                             AND Normativa.tbcodigo1       = Cartera.CaCarNormativa    

           LEFT JOIN #TABLA_GENERAL_DETALLE Libro             ON Libro.tbcateg             = 1552    

                                                             AND Libro.tbcodigo1           = Cartera.CaLibro    

           LEFT JOIN #TABLA_GENERAL_DETALLE Responsable       ON Responsable.tbcateg       = 1553    

                                                             AND Responsable.tbcodigo1     = 6             -- No tenemos area responsable !!!    

           LEFT JOIN #TABLA_GENERAL_DETALLE SubCartera        ON SubCartera.tbcateg        = 1554    

                                                             AND SubCartera.tbcodigo1      = Cartera.CaSubCarNormativa    

     WHERE @FechaProceso = @fecha    

    UNION    

    SELECT 'Reporte'                = 'CARTERA A NIVEL COMPONENTE'    

         , 'NumContrato'            = CONVERT( NUMERIC(8), CarteraRes.CaNumContrato )    

         , 'NumFolio'               = CONVERT( NUMERIC(8), CarteraRes.CaNumFolio )    

         , 'TipoTransaccion'        = CONVERT( VARCHAR(10), CarteraRes.CaTipoTransaccion )    

         , 'FechaContrato'          = CONVERT( DATETIME, CarteraRes.CaFechaContrato, 112 )    

         , 'ConOpcEstCod'          = CONVERT( VARCHAR(1), CarteraRes.CaEstado )    

         , 'ConOpcEstDsc'           = CONVERT( VARCHAR(30), ISNULL( Estado.ConOpcEstDsc,  'Estado no Existe' ) )    

         , 'CliRut'                 = CONVERT( NUMERIC(13), CarteraRes.CaRutCliente )    

         , 'CliCod'                 = CONVERT( NUMERIC(5), CarteraRes.CaCodigo )    

         , 'CliDv'                  = CONVERT( VARCHAR(1), ISNULL( Cliente.ClDv, ' ' ) )    

         , 'CliNom'                 = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no existe, Crear en BAC' ) )    

         , 'Operador'               = CONVERT( VARCHAR(15), CarteraRes.CaOperador )    

         , 'OpcEstCod'              = CONVERT( VARCHAR(2), CarteraRes.CaCodEstructura )    

         

          --PRD10449 PAE

         , 'OpcEstDsc'             = CASE WHEN CarteraRes.CaCodEstructura = 0 AND CarteraRes.CaRelacionaPAE = 1 

												 THEN CONVERT( VARCHAR(30),Estructura.OpcEstDsc + ' - PAE ESTRUCTURADO')

											     ELSE CONVERT( VARCHAR(30), ISNULL( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )    END

          --PRD10449 PAE

         , 'Contrapartida'          = CONVERT( VARCHAR(8), CarteraRes.CaTipoContrapartida )    

         , 'CVEstructura'           = CONVERT( VARCHAR(1), CarteraRes.CaCVEstructura )    

         , 'CompraVentaEstructura'  = CONVERT( VARCHAR(6), CASE WHEN CarteraRes.CaCVEstructura = 'C' THEN 'COMPRA' ELSE 'VENTA' END )    

         , 'MonPagPrimaCod'         = CONVERT( NUMERIC(5), CarteraRes.CaCodMonPagPrima )    

         , 'MonPagPrimaDsc'         = CONVERT( VARCHAR(35), ISNULL( MonedaPrima.MnGlosa, 'Moneda Prima no existe' ) )    

         , 'fPagoPrimaCod'          = CONVERT( NUMERIC(3), CarteraRes.CafPagoPrima )    

         , 'fPagoPrimaDsc'          = CONVERT( VARCHAR(30), ISNULL( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )    

    

         , 'PrimaInicial'           = CONVERT( FLOAT, CarteraRes.CaPrimaInicial ) -- PrimaInicial -> PrimaInicialDet  -- MAP 05 NOv. 2009    

         , 'FechaPagoPrima'         = CONVERT( DATETIME, CarteraRes.CaFechaPagoPrima, 112 )    

    

         , 'CarteraFinancieraCod'   = CONVERT( VARCHAR(6), CarteraRes.CaCarteraFinanciera )    

         , 'CarteraFinancieraDsc'   = CONVERT( VARCHAR(50), ISNULL( Financiera.tbglosa, 'Cartera Fin. no exite' ) )    

         , 'CarteraNormativaCod'    = CONVERT( VARCHAR(6), CarteraRes.CaCarNormativa )    

         , 'CarteraNormativaDsc'    = CONVERT( VARCHAR(50), ISNULL( Normativa.tbglosa, 'Catera Normativa no existe' ) )    

         , 'LibroCod'               = CONVERT( VARCHAR(6), CarteraRes.CaLibro )     

         , 'LibroDsc'               = CONVERT( VARCHAR(50), ISNULL( Libro.tbglosa, 'Libro no existe' ) )    

         , 'AreaResponsalbleCod'    = CONVERT( VARCHAR(6), 6 )                                                              -- Mesa de dinero siempre no tenemos el campo    

         , 'AreaResponsalbleDsc'    = CONVERT( VARCHAR(50), ISNULL( Responsable.tbglosa, 'No existe area responsable' ) )   -- Mesa de dinero siempre no tenemos el campo    

    

         , 'SubCarNormativaCod'     = CONVERT( VARCHAR(6), CarteraRes.CaSubCarNormativa )    

         , 'SubCarNormativaDsc'     = CONVERT( VARCHAR(50), ISNULL( SubCartera.tbglosa,  'Falto SubCarNormatica' ) )    

    

         , 'MonPrimaTrfCod'         = CONVERT( NUMERIC(5), CarteraRes.CaMonPrimaTrf )    

         , 'MonPrimaTrfDsc'         = CONVERT( VARCHAR(35), ISNULL( MonedaPrimaTranf.MnGlosa, 'Moneda Prima Traf. no existe' ) )    

         , 'PrimaTranferencia'      = CONVERT( FLOAT, CarteraRes.CaPrimaTrf )    

         , 'PrimaTranferenciaML'    = CONVERT( FLOAT, CarteraRes.CaPrimaTrfML )    

    

         , 'MonPrimaCostoCod'       = CONVERT( NUMERIC(5), CarteraRes.CaMonPrimaCosto )    

         , 'MonPrimaCostoDsc'       = CONVERT( VARCHAR(35), ISNULL( MonedaPrimaCosto.MnGlosa, 'Moneda Prima Costo. no existe' ) )    

         , 'PrimaCosto'             = CONVERT( FLOAT, CarteraRes.CaPrimaCosto )    

         , 'PrimaCostoML'           = CONVERT( FLOAT, CarteraRes.CaPrimaCostoML )    

    

         , 'MonPrimaCarryCod'       = CONVERT( NUMERIC(5), CarteraRes.CaMonCarryPrima )    

         , 'MonPrimaCarryDsc'       = CONVERT( VARCHAR(35), ISNULL( MonedaPrimaCarry.MnGlosa, 'Moneda Prima Carry. no existe' ) )    

         , 'PrimaCarry'      = CONVERT( FLOAT, CarteraRes.CaCarryPrima )    

    

         , 'MonVrCod'               = CONVERT( NUMERIC(5), CarteraRes.CaMon_Vr )    

         , 'MonVrDsc'               = CONVERT( VARCHAR(35), ISNULL( MonedaVr.MnGlosa, 'Moneda Vr no existe' ) )    

         , 'Vr'                     = CONVERT( FLOAT, CarteraRes.CaVr )    

         , 'Vr_Costo'               = CONVERT( FLOAT, CarteraRes.CaVr_Costo )    

    

         , 'MonDeltaCod'            = CONVERT( NUMERIC(5), CarteraRes.CaMonDelta )    

         , 'MonDeltaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaDelta.MnGlosa, 'Moneda Delta no existe' ) )    

    

         , 'MonGammaCod'            = CONVERT( NUMERIC(5), CarteraRes.CaMon_Gamma )    

         , 'MonGammaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaGamma.MnGlosa, 'Moneda Gamma no existe' ) )    

    

         , 'MonVegaCod'             = CONVERT( NUMERIC(5), CarteraRes.CaMon_Vega )    

         , 'MonVegaDsc'             = CONVERT( VARCHAR(35), ISNULL( MonedaVega.MnGlosa, 'Moneda Vega no existe' ) )    

    

         , 'MonVannaCod'            = CONVERT( NUMERIC(5), CarteraRes.CaMon_Vanna )    

         , 'MonVannaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaVanna.MnGlosa, 'Moneda Vanna no existe' ) )    

    

         , 'MonVolgaCod'            = CONVERT( NUMERIC(5), CarteraRes.CaMon_Volga )    

         , 'MonVolvaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaVolga.MnGlosa, 'Moneda Volga no existe' ) )    

    

         , 'MonThetaCod'            = CONVERT( NUMERIC(5), CarteraRes.CaMon_Theta )    

         , 'MonThetaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaVolga.MnGlosa, 'Moneda Theta no existe' ) )    

    

         , 'MonRhoCod'              = CONVERT( NUMERIC(5), CarteraRes.CaMon_Rho )    

         , 'MonRhoDsc'              = CONVERT( VARCHAR(35), ISNULL( MonedaRho.MnGlosa, 'Moneda Rho no existe' ) )    

    

         , 'MonRhofCod'             = CONVERT( NUMERIC(5), CarteraRes.CaMon_Rhof )    

         , 'MonRhofDsc'             = CONVERT( VARCHAR(35), ISNULL( MonedaRho.MnGlosa, 'Moneda Rhof no existe' ) )    

    

         , 'MonCharmCod'            = CONVERT( NUMERIC(5), CarteraRes.CaMon_Charm )    

         , 'MonCharmDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaCharm.MnGlosa, 'Moneda Charm no existe' ) )    

    

         , 'MonZommaCod'            = CONVERT( NUMERIC(5), CarteraRes.CaMon_Zomma )    

         , 'MonZommaDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaZomma.MnGlosa, 'Moneda Zomma no existe' ) )    

    

         , 'MonSpeedCod'            = CONVERT( NUMERIC(5), CarteraRes.CaMon_Speed )    

         , 'MonSpeedDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaSpeed.MnGlosa, 'Moneda Speed no existe' ) )    

    

         , 'PrimaBSSpotCont'        = CONVERT( FLOAT, ISNULL( CarteraRes.CaPrimaBSSpotCont, 0.0 ) )    

         , 'DeltaSpotCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaDeltaSpotCont, 0.0 ) )    

         , 'DeltaForwardCont'       = CONVERT( FLOAT, ISNULL( CarteraRes.CaDeltaForwardCont, 0.0 ) )    

         , 'GammaSpotCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaGammaSpotCont, 0.0 ) )    

         , 'GammaFwdCont'           = CONVERT( FLOAT, ISNULL( CarteraRes.CaGammaFwdCont, 0.0 ) )    

    

         , 'VegaCont'               = CONVERT( FLOAT, ISNULL( CarteraRes.CaVegaCont, 0.0 ) )    

         , 'VannaSpotCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaVannaSpotCont, 0.0 ) )    

         , 'VannaFwdCont'           = CONVERT( FLOAT, ISNULL( CarteraRes.CaVannaFwdCont, 0.0 ) )    

    

         , 'VolgaCont'              = CONVERT( FLOAT, ISNULL( CarteraRes.CaVolgaCont, 0.0 ) )    

         , 'ThetaCont'              = CONVERT( FLOAT, ISNULL( CarteraRes.CaThetaCont, 0.0 ) )    

         , 'RhoDomCont'             = CONVERT( FLOAT, ISNULL( CarteraRes.CaRhoDomCont, 0.0 ) )    

         , 'RhoForCont'             = CONVERT( FLOAT, ISNULL( CarteraRes.CaRhoForCont, 0.0 ) )    

    

         , 'CharmSpotCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaCharmSpotCont, 0.0 ) )    

         , 'CharmFwdCont'           = CONVERT( FLOAT, ISNULL( CarteraRes.CaCharmFwdCont, 0.0 ) )    

    

         , 'ZommaSpotCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaZommaspotCont, 0.0 ) )    

         , 'ZommaFwdCont'           = CONVERT( FLOAT, ISNULL( CarteraRes.CaZommaFwdCont, 0.0 ) )    

    

         , 'SpeedSpotCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaSpeedSpotCont, 0.0 ) )    

         , 'SpeedFwdCont'           = CONVERT( FLOAT, ISNULL( CarteraRes.CaSpeedFwdCont, 0.0 ) )    

    

         , 'FechaUnwind'            = CONVERT( DATETIME, CarteraRes.CaFechaUnwind , 112 )     

         , 'NominalUnwind'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaNominalUnwind, 0.0 ) )    

         , 'UnwindMonCod'           = CONVERT( NUMERIC(5), ISNULL( CarteraRes.CaUnwindMon, 0.0 ) )    

         , 'UnwindMonDsc'           = CONVERT( CHAR(35), ISNULL( MonedaUnwind.MnGlosa, 'Moneda Unwind no existe' ) )    

    

         , 'Unwind'                 = CONVERT( NUMERIC(21,4), ISNULL( CarteraRes.CaUnwind, 0.0 ) )    

         , 'UnwindML'               = CONVERT( NUMERIC(21,4), ISNULL( CarteraRes.CaUnwindML, 0.0 ) )    

         , 'FormPagoUnwindCod'      = CONVERT( NUMERIC(3), ISNULL( CarteraRes.CaFormPagoUnwind, 0.0 ) )    

         , 'FormPagoUnwindDsc'      = CONVERT( VARCHAR(30), ISNULL( FormaPagoUnwind.glosa, 'Forma Pago Unwind no existe' ) )    

    

         , 'UnwindTransfMonCod'     = CONVERT( NUMERIC(5), ISNULL( CarteraRes.CaUnwindTransfMon, 0.0 ) )     

         , 'UnwindTransfMonDsc'     = CONVERT( VARCHAR(35), ISNULL( MonedaUnwindTrf.MnGlosa, 'Moneda Traf. Unwind no existe' ) )    

         , 'UnwindTransf'           = CONVERT( NUMERIC(21,4), ISNULL( CarteraRes.CaUnwindTransf, 0.0 ) )    

         , 'UnwindTransfML'         = CONVERT( NUMERIC(21,4), ISNULL( CarteraRes.CaUnwindTransfML, 0.0 ) )    

    

         , 'Glosa'                  = CONVERT( VARCHAR(80), ISNULL( CarteraRes.CaGlosa , ' ' ) )    

         , 'Usuario'                = CONVERT( VARCHAR(15), @Usuario )    

         , 'FechaProceso'           = CONVERT( DATETIME, @FechaProceso, 112 )    

         , 'FechaCreacionRegistro'  = CONVERT( DATETIME, ISNULL( CarteraRes.CaFechaCreacionRegistro, '' ) )    

      FROM dbo.CaResEncContrato             CarteraRes    

           LEFT JOIN #Cliente               Cliente           ON Cliente.ClRut             = CarteraRes.CaRutCliente    

                                                             AND CarteraRes.CaCodigo       = Cliente.ClCodigo    

           LEFT JOIN #Moneda                MonedaUnwindTrf   ON MonedaUnwindTrf.MnCodMon  = CarteraRes.CaUnwindTransfMon    

           LEFT JOIN #Formas_Pago           FormaPagoUnwind   ON FormaPagoUnwind.Codigo    = CarteraRes.CaFormPagoUnwind    

           LEFT JOIN #Formas_Pago           FormaPagoPrima    ON FormaPagoPrima.Codigo     = CarteraRes.CafPagoPrima    

           LEFT JOIN #Moneda                MonedaUnwind      ON MonedaUnwind.MnCodMon     = CarteraRes.CaUnwindMon    

           LEFT JOIN #Moneda                MonedaSpeed       ON MonedaSpeed.MnCodMon      = CarteraRes.CaMon_Speed    

           LEFT JOIN #Moneda                MonedaZomma       ON MonedaZomma.MnCodMon      = CarteraRes.CaMon_Zomma    

           LEFT JOIN #Moneda                MonedaCharm       ON MonedaCharm.MnCodMon      = CarteraRes.CaMon_Charm    

           LEFT JOIN #Moneda                MonedaRhof        ON MonedaRhof.MnCodMon       = CarteraRes.CaMon_Rhof    

           LEFT JOIN #Moneda                MonedaRho         ON MonedaRho.MnCodMon        = CarteraRes.CaMon_Rho    

           LEFT JOIN #Moneda                MonedaVolga       ON MonedaVolga.MnCodMon      = CarteraRes.CaMon_Volga    

           LEFT JOIN #Moneda                MonedaVanna       ON MonedaVanna.MnCodMon      = CarteraRes.CaMon_Vanna    

           LEFT JOIN #Moneda                MonedaVega        ON MonedaVega.MnCodMon       = CarteraRes.CaMon_Vega    

           LEFT JOIN #Moneda                MonedaGamma       ON MonedaGamma.MnCodMon      = CarteraRes.CaMon_Gamma    

           LEFT JOIN #Moneda                MonedaDelta       ON MonedaDelta.MnCodMon      = CarteraRes.CaMonDelta    

           LEFT JOIN #Moneda                MonedaPrima       ON MonedaPrima.MnCodMon      = CarteraRes.CaCodMonPagPrima    

           LEFT JOIN #Moneda                MonedaPrimaTranf  ON MonedaPrimaTranf.MnCodMon = CarteraRes.CaMonPrimaTrf    

           LEFT JOIN #Moneda                MonedaPrimaCosto  ON MonedaPrimaCosto.MnCodMon = CarteraRes.CaMonPrimaCosto    

           LEFT JOIN #Moneda                MonedaPrimaCarry  ON MonedaPrimaCarry.MnCodMon = CarteraRes.CaMonCarryPrima    

           LEFT JOIN #Moneda                MonedaVr          ON MonedaVr.MnCodMon         = CarteraRes.CaMon_Vr    

           LEFT JOIN ConOpcEstado           Estado            ON Estado.ConOpcEstCod       = CarteraRes.CaEstado    

           LEFT JOIN OpcionEstructura       Estructura        ON Estructura.OpcEstCod      = CarteraRes.CaCodEstructura    

           LEFT JOIN #TABLA_GENERAL_DETALLE Financiera        ON Financiera.tbcateg        = 204    

                                                             AND Financiera.tbcodigo1      = CarteraRes.CaCarteraFinanciera    

           LEFT JOIN #TABLA_GENERAL_DETALLE Normativa         ON Normativa.tbcateg         = 1111    

                                                             AND Normativa.tbcodigo1       = CarteraRes.CaCarNormativa    

           LEFT JOIN #TABLA_GENERAL_DETALLE Libro             ON Libro.tbcateg             = 1552    

                                                             AND Libro.tbcodigo1           = CarteraRes.CaLibro    

           LEFT JOIN #TABLA_GENERAL_DETALLE Responsable       ON Responsable.tbcateg       = 1553    

                                                             AND Responsable.tbcodigo1     = 6     -- No tenemos area responsable !!!    

           LEFT JOIN #TABLA_GENERAL_DETALLE SubCartera        ON SubCartera.tbcateg        = 1554    

                                                             AND SubCartera.tbcodigo1      = CarteraRes.CaSubCarNormativa    

     WHERE CarteraRes.CaEncFechaRespaldo = @fecha    

       AND CarteraRes.CaEncFechaRespaldo < @FechaProceso    

    

    -- 3. Se navega el detalle y se genera #TempDetalle (se le adosó la información #Encabezado).    

    SELECT CarEnc.*    

         , 'OpcTipCod'              = CONVERT( CHAR(1),  CarDet.CaTipoOpc )    

         , 'OpcTipDsc'              = CONVERT( VARCHAR(20), ISNULL( OpcionTipo.OpcTipDsc, 'No existe Tipo de Opción' ) )    

         , 'SubyacenteCod'          = CONVERT( CHAR(3), CarDet.CaSubyacente )    

         , 'SubyacenteDsc'          = CONVERT( VARCHAR(40), ISNULL( Subyacente.SubyacenteDescripcion, 'No existe Subyacente' ) )    

         , 'NumEstructura'          = CONVERT( NUMERIC(6), CarDet.CaNumEstructura )    

         , 'PayOffTipCod'           = CONVERT( VARCHAR(2), CarDet.CaTipoPayOff )    

         , 'PayOffTipDsc'           = CONVERT( VARCHAR(20), ISNULL( PayOffTipo.PayOffTipDsc, 'PayOff no existe' ) )    

         , 'CallPut'                = CONVERT( VARCHAR(5), CarDet.CaCallPut )    

         , 'CVOpcCod'               = CONVERT( VARCHAR(3), CarDet.CaCVOpc )    

         , 'CompraVentaOpcDsc'      = CONVERT( VARCHAR(6), CASE WHEN CarDet.CaCVOpc = 'C' THEN 'Compra' ELSE 'Venta' END )    

         , 'TipoEmisionPTCod'       = CONVERT( VARCHAR(3), CarDet.CaTipoEmisionPT )    

         , 'TipoEmisionPTDsc'       = CONVERT( VARCHAR(8), CASE WHEN CarDet.CaTipoEmisionPT = 'P' THEN 'Propia' ELSE 'Terceros' END )    

         , 'FechaInicioOpc'         = CONVERT( DATETIME, CarDet.CaFechaInicioOpc, 112 )    

    

         , 'FechaFijacionOpc'       = CONVERT( DATETIME, CarDet.CaFechaFijacion, 112 )    

         , 'FechaVcto'              = CONVERT( DATETIME, CarDet.CaFechaVcto, 112 )    

         , 'FechaPagoEjer'          = CONVERT( DATETIME, CarDet.CaFechaPagoEjer, 112 )    

         , 'FechaPagMon1'           = CONVERT( DATETIME, CarDet.CaFechaPagMon1, 112 )    

         , 'FechaPagMon2'           = CONVERT( DATETIME, CarDet.CaFechaPagMon2, 112 )    

    

         , 'Mon1Cod'                = CONVERT( NUMERIC(5), CarDet.CaCodMon1 )    

         , 'Mon1Dsc'         = CONVERT( VARCHAR(35), ISNULL( MonedaM1.MnNemo, 'Moneda M1 no existe' ) )    

         , 'MontoMon1'              = CONVERT( NUMERIC(21,6), CarDet.CaMontoMon1 )    

    

         , 'FormaPagoMon1Cod'       = CONVERT( NUMERIC(3), CarDet.CaFormaPagoMon1 )    

         , 'FormaPagoMon1Dsc'       = CONVERT( VARCHAR(30), FormaPagoM1.Glosa )    

    
         , 'Mon2Cod'                = CONVERT( NUMERIC(5), CarDet.CaCodMon2 )    

         , 'Mon2Dsc'                = CONVERT( VARCHAR(35), ISNULL( MonedaM2.MnNemo, 'Moneda M2 no existe' ) )    

         , 'MontoMon2'              = CONVERT( NUMERIC(21,6), CarDet.CaMontoMon2 )    

         , 'FormaPagoMon2Cod'       = CONVERT( NUMERIC(3), CarDet.CaFormaPagoMon2 )    

         , 'FormaPagoMon2Dsc'       = CONVERT( VARCHAR(30), FormaPagoM2.Glosa )    

         , 'ModalidadCod'           = CONVERT( VARCHAR(1), CarDet.CaModalidad )    

         , 'ModalidadDsc'           = CONVERT( VARCHAR(15), CASE WHEN CarDet.CaModalidad = 'C' THEN 'Comp.' ELSE 'E.Fisica.' END )    

    

         , 'MdaCompensacionCod'     = CONVERT( NUMERIC(5), CarDet.CaMdaCompensacion )    

         , 'MdaCompensacionDsc'     = CONVERT( VARCHAR(35), ISNULL( MonedaCompensacion.MnNemo, 'N/A' ) )    

    

         , 'BenchCompCod'           = CONVERT( NUMERIC(5), CarDet.CaBenchComp )    

         , 'BenchCompDsc'           = CONVERT( VARCHAR(40), ISNULL( BenchMark.BenchMarkDescripcion, 'No existe BechMark' ) )    

    

         , 'ParStrike'              = CONVERT( VARCHAR(7), CarDet.CaParStrike )    

         , 'Strike'                 = CONVERT( FLOAT, CarDet.CaStrike )    

         , 'PorcStrike'             = CONVERT( FLOAT, CarDet.CaPorcStrike )    

    

         , 'TipoEjercicioCod'       = CONVERT( VARCHAR(1), CarDet.CaTipoEjercicio )     

         , 'TipoEjercicioDsc'       = CONVERT( VARCHAR(10), CASE WHEN CarDet.CaTipoEjercicio = 'E' THEN 'EUROPEA' ELSE 'AMERICANA' END )    

         , 'VrDet'                  = CONVERT( FLOAT, CarDet.CaVrDet )    

         , 'IteAsoSisCod'           = CONVERT( CHAR(3), CarDet.CaIteAsoSis )    

         , 'IteAsoSisDsc'           = CONVERT( VARCHAR(20), ISNULL( Sistema.Nombre_Sistema, 'N/A' ) )    

         , 'IteAsoCon'              = CONVERT( NUMERIC(8), ISNULL( CarDet.CaIteAsoCon, 0 )  )    

         , 'PrimaDet'               = CONVERT( FLOAT, CarDet.CaPrimaInicialDet )  -- PrimaInicial -> PrimaInicialDet    

         , 'AjusteVR'               = CONVERT( FLOAT, ISNULL(CarDet.CaVrDet - (-CarDet.CaPrimaInicialDetML), 0.0 ) )  -- MAP 05 Nov. 2009    

      INTO #TempDetalle    

      FROM #Encabezado CarEnc    

         , dbo.CaDetContrato CarDet    

           LEFT JOIN dbo.OpcionTipo       OpcionTipo          ON Opciontipo.OpcTipCod        = CarDet.CaTipoOpc    

           LEFT JOIN dbo.Subyacente       Subyacente          ON Subyacente.Subyacente       = CarDet.CaSubyacente    

           LEFT JOIN dbo.PayOffTipo       PayOffTipo          ON PayOffTipo.PayOffTipCod     = CarDet.CaTipoPayOff    

           LEFT JOIN #Formas_Pago         FormaPagoM1         ON FormaPagoM1.Codigo          = CarDet.CaFormaPagoMon1    

           LEFT JOIN #Formas_Pago         FormaPagoM2         ON FormaPagoM2.Codigo          = CarDet.CaFormaPagoMon2    

           LEFT JOIN #Moneda              MonedaM1            ON MonedaM1.MnCodMon           = CarDet.CaCodMon1    

           LEFT JOIN #Moneda              MonedaM2            ON MonedaM2.MnCodMon           = CarDet.CaCodMon2    

           LEFT JOIN #Moneda              MonedaCompensacion  ON MonedaCompensacion.MnCodMon = CarDet.CaMdaCompensacion    

           LEFT JOIN dbo.BenchMark        BenchMark           ON BenchMark.BenchMarkCod      = CarDet.CaBenchComp    

           LEFT JOIN #GEN_SISTEMAS        Sistema             ON Sistema.Id_sistema          = CarDet.CaIteAsoSis    

           LEFT JOIN dbo.CaResDetContrato ResDet              ON ResDet.CaDetFechaRespaldo   = @FechaProcAnt    

                                                             AND CarDet.CaNumContrato        = ResDet.CaNumContrato    

               AND CarDet.CaNumEstructura      = ResDet.CaNumEstructura    

     WHERE CarDet.CaNumContrato     = CarEnc.NumContrato    

       AND @FechaProceso            = @fecha    

    UNION    

    SELECT CarEnc.*    

     , 'OpcTipCod'              = CONVERT( CHAR(1), CarResDet.CaTipoOpc )    

         , 'OpcTipDsc'              = CONVERT( VARCHAR(20), ISNULL( OpcionTipo.OpcTipDsc, 'No existe Tipo de Opción' ) )    

         , 'SubyacenteCod'          = CONVERT( CHAR(3), CarResDet.CaSubyacente )    

         , 'SubyacenteDsc'          = CONVERT( VARCHAR(40), ISNULL( Subyacente.SubyacenteDescripcion, 'No existe Subyacente' ) )    

         , 'NumEstructura'          = CONVERT( NUMERIC(6), CarResDet.CaNumEstructura )    

         , 'PayOffTipCod'           = CONVERT( VARCHAR(2), CarResDet.CaTipoPayOff )    

         , 'PayOffTipDsc'           = CONVERT( VARCHAR(20), ISNULL( PayOffTipo.PayOffTipDsc, 'PayOff no existe' ) )    

         , 'CallPut'                = CONVERT( VARCHAR(5), CarResDet.CaCallPut )    

         , 'CVOpcCod'               = CONVERT( VARCHAR(3), CarResDet.CaCVOpc )    

         , 'CompraVentaOpcDsc'      = CONVERT( VARCHAR(6), CASE WHEN CarResDet.CaCVOpc = 'C' THEN 'Compra' ELSE 'Venta' END )    

         , 'TipoEmisionPTCod'       = CONVERT( VARCHAR(3), CarResDet.CaTipoEmisionPT )    

         , 'TipoEmisionPTDsc'       = CONVERT( VARCHAR(8), CASE WHEN CarResDet.CaTipoEmisionPT = 'P' THEN 'Propia' ELSE 'Terceros' END )    

         , 'FechaInicioOpc'         = CONVERT( DATETIME, CarResDet.CaFechaInicioOpc, 112 )    

    

         , 'FechaFijacionOpc'       = CONVERT( DATETIME, CarResDet.CaFechaFijacion, 112 )    

         , 'FechaVcto'              = CONVERT( DATETIME, CarResDet.CaFechaVcto, 112 )    

         , 'FechaPagoEjer'          = CONVERT( DATETIME, CarResDet.CaFechaPagoEjer, 112 )    

         , 'FechaPagMon1'           = CONVERT( DATETIME, CarResDet.CaFechaPagMon1, 112 )    

         , 'FechaPagMon2'           = CONVERT( DATETIME, CarResDet.CaFechaPagMon2, 112 )    

    

         , 'Mon1Cod'                = CONVERT( NUMERIC(5), CarResDet.CaCodMon1 )    

         , 'Mon1Dsc'                = CONVERT( VARCHAR(35), ISNULL( MonedaM1.MnNemo, 'Moneda M1 no existe' ) )    

         , 'MontoMon1'              = CONVERT( NUMERIC(21,6), CarResDet.CaMontoMon1 )    

    

         , 'FormaPagoMon1Cod'       = CONVERT( NUMERIC(3), CarResDet.CaFormaPagoMon1 )    

         , 'FormaPagoMon1Dsc'       = CONVERT( VARCHAR(30), FormaPagoM1.Glosa )    

    

         , 'Mon2Cod'                = CONVERT( NUMERIC(5), CarResDet.CaCodMon2 )    

         , 'Mon2Dsc'                = CONVERT( VARCHAR(35), ISNULL( MonedaM2.MnNemo, 'Moneda M2 no existe' ) )    

         , 'MontoMon2'              = CONVERT( NUMERIC(21,6), CarResDet.CaMontoMon2 )    

         , 'FormaPagoMon2Cod'       = CONVERT( NUMERIC(3), CarResDet.CaFormaPagoMon2 )    

         , 'FormaPagoMon2Dsc'       = CONVERT( VARCHAR(30), FormaPagoM2.Glosa )    

         , 'ModalidadCod'           = CONVERT( VARCHAR(1), CarResDet.CaModalidad )    

         , 'ModalidadDsc'           = CONVERT( VARCHAR(15), CASE WHEN CarResDet.CaModalidad = 'C' THEN 'Comp.' ELSE 'E.Fisica.' END )    

    

         , 'MdaCompensacionCod'     = CONVERT( NUMERIC(5), CarResDet.CaMdaCompensacion )    

         , 'MdaCompensacionDsc'     = CONVERT( VARCHAR(35), ISNULL( MonedaCompensacion.MnNemo, 'N/A' ) )    

    

         , 'BenchCompCod'           = CONVERT( NUMERIC(5), CarResDet.CaBenchComp )    

         , 'BenchCompDsc'           = CONVERT( VARCHAR(40), ISNULL( BenchMark.BenchMarkDescripcion, 'No existe BechMark' ) )    

    

         , 'ParStrike'              = CONVERT( VARCHAR(7), CarResDet.CaParStrike )    

         , 'Strike'                 = CONVERT( FLOAT, CarResDet.CaStrike )    

         , 'PorcStrike'             = CONVERT( FLOAT, CarResDet.CaPorcStrike )    

    

         , 'TipoEjercicioCod'       = CONVERT( VARCHAR(1), CarResDet.CaTipoEjercicio )     

         , 'TipoEjercicioDsc'       = CONVERT( VARCHAR(10), CASE WHEN CarResDet.CaTipoEjercicio = 'E' THEN 'EUROPEA' ELSE 'AMERICANA' END )    

         , 'VrDet'                = CONVERT( FLOAT, CarResDet.CaVrDet )    

      , 'IteAsoSisCod'           = CONVERT( CHAR(3), CarResDet.CaIteAsoSis )    

         , 'IteAsoSisDsc'           = CONVERT( CHAR(20), ISNULL( Sistema.Nombre_Sistema, 'N/A' ) )    

         , 'IteAsoCon'              = CONVERT( NUMERIC(8), ISNULL( CarResDet.CaIteAsoCon, 0 ) )    

         , 'PrimaDet'               = CONVERT( FLOAT, CarResDet.CaPrimaInicialDet )  -- PrimaInicial -> PrimaInicialDet    

         , 'AjusteVR'               = CONVERT( FLOAT, ISNULL(CarResDet.CaVrDet - (-CarResDet.CaPrimaInicialDetML) ,0.0))    

      FROM #Encabezado   CarEnc    

         , dbo.CaResDetContrato CarResDet    

           LEFT JOIN dbo.OpcionTipo       OpcionTipo          ON Opciontipo.OpcTipCod        = CarResDet.CaTipoOpc    

           LEFT JOIN dbo.Subyacente       Subyacente          ON Subyacente.Subyacente       = CarResDet.CaSubyacente    

           LEFT JOIN dbo.PayOffTipo       PayOffTipo          ON PayOffTipo.PayOffTipCod     = CarResDet.CaTipoPayOff    

           LEFT JOIN #Formas_Pago         FormaPagoM1         ON FormaPagoM1.Codigo          = CarResDet.CaFormaPagoMon1    

           LEFT JOIN #Formas_Pago         FormaPagoM2         ON FormaPagoM2.Codigo          = CarResDet.CaFormaPagoMon2    

           LEFT JOIN #Moneda              MonedaM1            ON MonedaM1.MnCodMon           = CarResDet.CaCodMon1    

           LEFT JOIN #Moneda              MonedaM2            ON MonedaM2.MnCodMon           = CarResDet.CaCodMon2    

           LEFT JOIN #Moneda              MonedaCompensacion  ON MonedaCompensacion.MnCodMon = CarResDet.CaMdaCompensacion    

           LEFT JOIN dbo.BenchMark        BenchMark           ON BenchMark.BenchMarkCod      = CarResDet.CaBenchComp    

           LEFT JOIN #GEN_SISTEMAS        Sistema             ON Sistema.Id_sistema          = CarResDet.CaIteAsoSis    

           LEFT JOIN dbo.CaResDetContrato ResDet              ON ResDet.CaDetFechaRespaldo   = @FechaProcAnt    

                                                             AND CarResDet.CaNumContrato     = ResDet.CaNumContrato    

                  AND CarResDet.CaNumEstructura   = ResDet.CaNumEstructura    

     WHERE CarResDet.CaNumContrato      = CarEnc.NumContrato    

       AND CarResDet.CaDetFechaRespaldo = @fecha     

       AND CarResDet.CaDetFechaRespaldo < @FechaProceso    

    

    DELETE #TempDetalle WHERE ConOpcEstCod  = 'C'    

    DELETE #TempDetalle WHERE FechaVcto    <= @fecha -- @FechaProceso  

    

    IF EXISTS( SELECT 1 FROM #TempDetalle )    

    BEGIN    

        TRUNCATE TABLE #Detalle    

        INSERT INTO #Detalle    

               SELECT *    

                 FROM #TempDetalle    

    

        SELECT 'NumContrato'   = A.NumContrato    

             , 'CantComp'      = count(*)    

          INTO #ComponentesXContrato    

          FROM #Encabezado  A    

             , #detalle     B    

         WHERE A.NumContrato = B.NumContrato    

         GROUP BY A.NumContrato    

    

        TRUNCATE TABLE #Resultado     -- Cuando termine desarrollo borrar esto    

        INSERT INTO #Resultado        -- y mostrar desde MovDet y no desde resultado    

               SELECT MovDet.*    

                    , Comp.CantComp    

                 FROM #detalle              MovDet    

                    , #ComponentesXContrato Comp    

                WHERE MovDet.NumContrato = Comp.NumContrato    

    

        SELECT *, 'BannerLargo' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales) 

          FROM #Resultado

    

    END ELSE    

    BEGIN    

        -- Se despliega el registro Sin Datos.    

        SELECT *, 'BannerLargo' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)    

          FROM #Resultado

    

    END    

    

END    

GO
