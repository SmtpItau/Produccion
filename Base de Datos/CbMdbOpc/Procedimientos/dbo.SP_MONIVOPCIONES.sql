USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONIVOPCIONES]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_MONIVOPCIONES] (
  @Tipo varchar(40),  @FechaDesde datetime , @FechaHasta  datetime , @Usuario Varchar(15)
, @NumeroContrato	INT = 0 --ASVG_20110425 Para no alterar invocación y funcionamiento
 )     AS BEGIN			
     SET NOCOUNT ON 	

     -- MAP 28 Oct. 2009 para poder ver los anticipos
     -- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente
     -- Sp_moNivOpciones '', '20081210' , '20081210', 'PPPPP'  select * from moDetContrato  select * from moEncContrato
     Declare  @Nombre Char(120)
            , @Dv     Char(1)
            , @FechaProceso datetime
            


     select * into #Moneda  from bacparamsuda.dbo.Moneda

     select * into #MoEncContrato 
     from MoEncContrato 
     where ( MoFechaContrato >= @FechaDesde and MofechaContrato <= @FechaHasta  AND  MoTipoTransaccion = @Tipo )
     OR    ( MoFechaContrato >= @FechaDesde and MofechaContrato <= @FechaHasta  AND  @Tipo <> 'ANULA' )  
     union 
     select * from mohisEncContrato
     where ( MoFechaContrato >= @FechaDesde and MofechaContrato <= @FechaHasta  AND  MoTipoTransaccion = @Tipo )
     OR    ( MoFechaContrato >= @FechaDesde and MofechaContrato <= @FechaHasta  AND  @Tipo <> 'ANULA' ) 



     select * into #MoDetContrato 
     from MoDetContrato 
     where MoNumfolio in ( select monumfolio from #MoEncContrato )
     union
     select * from moHisDetContrato
     where MoNumfolio in ( select monumfolio from #MoEncContrato )



     -- Solo se cargarán Clientes que alguna vez han tenido opciones
     select ClRut, ClCodigo, ClDv, ClNombre 
     into #Cliente from BacParamSuda.dbo.View_CLIENTEParaOpc  
     where Clrut in ( select MoRutCliente from MoEncContrato union select MoRutCliente from MoHisEncContrato )


     select @FechaProceso = ''
     select @FechaProceso = fechaproc from opcionesGeneral

     if ( select count(1) from #CLiente ) = 0 
        insert into #Cliente
	select ClRut = 0, ClCodigo = 0, ClDv = '', ClNombre = 'CLIENTE NO EXISTE EN BAC'

     select * into #Formas_Pago  from bacparamsuda.dbo.Forma_de_Pago 

     select * into #Tabla_General_Detalle  from bacparamsuda.dbo.Tabla_general_detalle 
     where tbcateg in ( 204, 1111, 1552, 1553, 1554 )

     select * into #GEN_SISTEMAS from BacParamSuda.dbo.SISTEMA_CNT

     -- 1. Se asume que no hay registros, se crea la tabla y se llena con el registro de "NO HAY DATOS"
     Select   'Reporte'         = convert( Varchar(50) , 'REPORTE MOVIMIENTOS A NIVEL COMPONENTE'  )
            , 'TipoReporte'     = convert( varchar(49), '*' + @Tipo + '*' )
            , 'NumContrato'     = convert( numeric(8)  , 0 )
            , 'NumFolio'        = convert( numeric(8)  , 0 )
            , 'TipoTransaccion' = convert( varchar(10) , 'SIN DATOS' )
            , 'FechaContrato'   = convert( datetime    , '',112)
            , 'ConOpcEstCod'	= Convert( varchar(1)  , '' )
            , 'ConOpcEstDsc'    = Convert( varchar(30) , '' )
            , 'CliRut'  	= Convert( numeric(13) , 0 )
            , 'CliCod'          = convert( numeric(5)  , 0 )
            , 'CliDv'           = Convert( varchar(1)  , ''   )
            , 'CliNom'  	= Convert( varchar(100), '' )
            , 'Operador'        = Convert( varchar(15) , '' )
            , 'OpcEstCod'       = Convert( varchar(2)  , '' )
            , 'OpcEstDsc'       = COnvert( Varchar(20) , '' )  
            , 'Contrapartida'   = Convert( varchar(8)  , '' )
            , 'CVEstructura'    = convert( varchar(1)  , '' )
            , 'CompraVentaEstructura'    = Convert( varchar(6), '' )
            , 'MonPagPrimaCod'  = Convert( numeric(5)  , 0 )
            , 'MonPagPrimaDsc'  = convert( char(35)    , '' )
            , 'MonPagPrimaNemo' = convert( char(08)    , '' )
            , 'fPagoPrimaCod'      = convert( NUMERIC(3)  , 0 )
            , 'fPagoPrimaDsc'      = convert( CHAR(30)    , '' )
            , 'PrimaInicial'    = convert( float, 0.0 )
            , 'FechaPagoPrima'  = convert( datetime    , '' ,112)
            , 'CarteraFinancieraCod'   = Convert( Varchar(6), '' )
            , 'CarteraFinancieraDsc'   = Convert( Char(50)  , '' )
            , 'CarteraNormativaCod'   = Convert( Varchar(6), '' )
            , 'CarteraNormativaDsc'    = Convert( Char(50)  , '' )
            , 'LibroCod'  = Convert( Varchar(6), '' ) 
            , 'LibroDsc'               = Convert( Char(50)  , '' )
            , 'AreaResponsalbleCod'    = Convert( VarChar(6), '' )   
            , 'AreaResponsalbleDsc'    = Convert( VarChar(50),'' ) 

            , 'SubCarNormativaCod'     = Convert( VarChar(6), '' )
            , 'SubCarNormativaDsc'     = Convert( Varchar(50), '' )

            , 'MonPrimaTrfCod'  = Convert( numeric(5)  , 0 )
            , 'MonPrimaTrfDsc'  = convert( char(35)    , '' )  
            , 'PrimaTranferencia'  = convert( float    , 0.0 )
            , 'PrimaTranferenciaML'  = convert( float  , 0.0 )

            , 'MonPrimaCostoCod'  = Convert( numeric(5)  , 0 )
            , 'MonPrimaCostoDsc'  = convert( char(35)    , '' )
            , 'PrimaCosto'        = convert( float       , 0.0 )
            , 'PrimaCostoML'      = convert( float       , 0.0 )

            , 'MonPrimaCarryCod'  = Convert( numeric(5)  , 0 )
            , 'MonPrimaCarryDsc'  = convert( char(35)    , '' ) 
            , 'PrimaCarry'        = convert( float       , 0.0 )


            , 'MonVrCod'          = Convert( numeric(5)  , 0 )
            , 'MonVrDsc'          = Convert( Char(35)    , '' )
            , 'MonVrNemo'         = Convert( Char(8)     , '')
            , 'Vr'                = convert( float       , 0.0 )
            , 'Vr_Costo'          = convert( float       , 0.0 )

            , 'MonDeltaCod'          = Convert( numeric(5)  , 0 )
            , 'MonDeltaDsc'          = Convert( Char(35)    , '' )

            , 'MonGammaCod'          = Convert( numeric(5)  , 0 )
            , 'MonGammaDsc'          = Convert( Char(35)    , '' )
         
            , 'MonVegaCod'          = Convert( numeric(5)  , 0 )
            , 'MonVegaDsc'          = Convert( Char(35)    , '' )

            , 'MonVannaCod'          = Convert( numeric(5)  , 0 )
            , 'MonVannaDsc'          = Convert( Char(35)    , '' )

            , 'MonVolgaCod'          = Convert( numeric(5)  , 0 )
            , 'MonVolgaDsc'          = Convert( Char(35)    , '' )

            , 'MonThetaCod'          = Convert( numeric(5)  , 0 )
            , 'MonThetaDsc'          = convert( Char(35)    , '' )


            , 'MonRhoCod'          = Convert( numeric(5)  , 0 )
            , 'MonRhoDsc'          = Convert( Char(35)    , '' )

            , 'MonRhofCod'          = Convert( numeric(5)  , 0 )
            , 'MonRhofDsc'          = Convert( Char(35)    , '' )

            , 'MonCharmCod'          = Convert( numeric(5)  , 0 )
            , 'MonCharmDsc'          = Convert( Char(35)    , '' )

            , 'MonZommaCod'          = Convert( numeric(5)  , 0 )
            , 'MonZommaDsc'          = Convert( Char(35)    , '' )

            , 'MonSpeedCod'          = Convert( numeric(5)  , 0 )
            , 'MonSpeedDsc'          = Convert( Char(35)    , '' )


            , 'PrimaBSSpotCont'      = convert( float, 0.0 )
            , 'DeltaSpotCont'        = convert( float, 0.0 )
            , 'DeltaForwardCont'     = convert( float, 0.0 )
            , 'GammaSpotCont'        = convert( float, 0.0 )
            , 'GammaFwdCont'         = convert( float, 0.0 )

            , 'VegaCont'             = convert( float, 0.0 )

            , 'VannaSpotCont'        = convert( float, 0.0 )
            , 'VannaFwdCont'        = convert( float, 0.0 )

            , 'VolgaCont'            = convert( float, 0.0 )
            , 'ThetaCont'            = convert( float, 0.0 )
            , 'RhoDomCont'           = convert( float, 0.0 )
            , 'RhoForCont'           = convert( float, 0.0 )

            , 'CharmSpotCont'        = convert( float, 0.0 )
            , 'CharmFwdCont'         = convert( float, 0.0 )

            , 'ZommaSpotCont'         = convert( float, 0.0 )
            , 'ZommaFwdCont'         = convert( float, 0.0 )

            , 'SpeedSpotCont'         = convert( float, 0.0 )
            , 'SpeedFwdCont'         = convert( float, 0.0 )

            , 'FechaUnwind'          = convert( datetime  , '' , 112 ) 
            , 'NominalUnwind'        = convert( float     ,  0.0  ) 
            , 'UnwindMonCod'         = convert( numeric(5), 0 )
            , 'UnwindMonDsc'         = Convert( Char(35)  , '' )

            , 'Unwind'               = Convert( numeric(21,4), 0.0 )
            , 'UnwindML'             = Convert( numeric(21,4), 0.0 )
            , 'FormPagoUnwindCod'    = Convert( numeric(3)   , 0 )
            , 'FormPagoUnwindDsc'    = Convert( char(30)     , '' )
 
            , 'UnwindTransfMonCod'   = convert( numeric(5)    , 0 ) 
            , 'UnwindTransfMonDsc'   = convert( Char(35)      , '' ) 
            , 'UnwindTransf'         = convert( numeric(21,4) , 0.0 )
            , 'UnwindTransfML'       = convert( numeric(21,4) , 0.0 )

            , 'Glosa'                 = convert( Varchar(80) , '' )
            , 'Usuario'               = convert( VarChar(15) , @Usuario )
            , 'FechaProceso'          = convert( datetime , @FechaProceso, 112 )
            , 'FechaCreacionRegistro' = convert( Datetime , '', 112 )
 
            , 'OpcTipCod'           = Convert( char(1)     , '' )
            , 'OpcTipDsc'           = Convert( char(20)    , '' )
            , 'SubyacenteCod'       = Convert( char(3)     , '' )
            , 'SubyacenteDsc'       = Convert( varchar(40) , '' )
            , 'NumEstructura'       = convert( numeric(6)  , 0 )
            , 'PayOffTipCod'        = convert( VarChar(2)  , '' )
            , 'PayOffTipDsc'        = Convert( VarChar(20) , '' )
            , 'CallPut'             = convert( VarChar(5)  , '' )
            , 'CVOpcCod'            = Convert( varchar(3)  , '' )
            , 'CompraVentaOpcDsc'   = Convert( varchar(6)  , '' )
            , 'TipoEmisionPTCod'    = Convert( varchar(3)  , '' )
            , 'TipoEmisionPTDsc'    = Convert( varchar(8)  , '' )
            , 'FechaInicioOpc'      = Convert( datetime    , '', 112 )

            , 'FechaFijacionOpc'    = Convert( datetime    , '' , 112 )
            , 'FechaVcto'           = Convert( datetime    , '' , 112 )
            , 'FechaPagoEjer'       = Convert( datetime    , '' , 112 )
            , 'FechaPagMon1'        = Convert( datetime    , '' , 112 )
            , 'FechaPagMon2'        = Convert( datetime    , '' , 112 )


            , 'Mon1Cod'             = convert( numeric(5)  , 0 )
            , 'Mon1Dsc'             = convert( char(35)    , ''  )
            , 'MontoMon1'           = Convert( numeric(21,6) , 0 )

            , 'FormaPagoMon1Cod'    = convert( numeric(3)  , 0 )
            , 'FormaPagoMon1Dsc'    = convert( char(30)    , '' )

            , 'Mon2Cod'             = convert( numeric(5)  , 0 )
            , 'Mon2Dsc'             = convert( char(35)    , '' )
            , 'MontoMon2'           = Convert( numeric(21,6) , 0 )
            , 'FormaPagoMon2Cod'    = convert( numeric(3)  , 0 )
            , 'FormaPagoMon2Dsc'    = convert( char(30)    , ''  )
            , 'ModalidadCod'        = Convert( varchar(1)  , ''  )
            , 'ModalidadDsc'        = Convert( varchar(15) , ''  )

            , 'MdaCompensacionCod'  = Convert( numeric(5)  , 0 )
            , 'MdaCompensacionDsc'  = convert( char(35)    , ''  )

            , 'BenchCompCod'        = convert( numeric(5)  , 0 )
            , 'BenchCompDsc'        = convert( varchar(40) , ''  )


            , 'ParStrike'           = convert( varchar(7), ''  )
            , 'Strike'              = convert( float, 0.0 )
            , 'PorcStrike'          = convert( float, 0.0 )

            , 'TipoEjercicioCod'   = Convert( varchar(1), ''  ) 
            , 'TipoEjercicioDsc'    = Convert( Varchar(10) , ''  )
			, 'VrDet'               = convert( float, 0.0 )
            , 'CantidadComponentes'   = convert( NUMERIC(3)   , 0 )
            
   INTO #Resultado  

     -- 2. Se navega el encabezado y se lleva info a tabla #Encabezado
            Select   'Reporte'  = convert( Varchar(50) , 'REPORTE MOVIMIENTOS A NIVEL COMPONENTE' )
            , 'TipoReporte'     = convert( varchar(49),  '*' + @Tipo + '*')
            , 'NumContrato'     = convert( numeric(8)  , Cartera.MoNumContrato )
            , 'NumFolio'        = convert( numeric(8)  , Cartera.MoNumFolio )
            , 'TipoTransaccion' = convert( varchar(10) , Cartera.MoTipoTransaccion )
            , 'FechaContrato'   = convert( datetime    , Cartera.MoFechaContrato,112)
            , 'ConOpcEstCod'	= Convert( varchar(1)  , Cartera.MoEstado )
            , 'ConOpcEstDsc'    = Convert( varchar(30) , isnull( Estado.ConOpcEstDsc,  'Estado no Existe' ) )
            , 'CliRut'  	= Convert( numeric(13) , Cartera.MoRutCliente )
            , 'CliCod'          = convert( numeric(5)  , Cartera.MoCodigo )
            , 'CliDv'           = Convert( varchar(1)  , isnull( Cliente.ClDv, ' '  ) )
            , 'CliNom'  	= Convert( varchar(100), isnull( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )
            , 'Operador'        = Convert( varchar(15) , Cartera.MoOperador )
            , 'OpcEstCod'       = Convert( varchar(2)  , Cartera.MoCodEstructura  )
            , 'OpcEstDsc'       = COnvert( Varchar(20) , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )  
            , 'Contrapartida'   = Convert( varchar(8)  , Cartera.MoTipoContrapartida )
            , 'CVEstructura'    = convert( varchar(1)  , Cartera.MoCVEstructura )
            , 'CompraVentaEstructura'    = convert( varchar(6) , Case when Cartera.MoCVEstructura = 'C' then 'COMPRA' else 'VENTA' end )
            , 'MonPagPrimaCod'  = Convert( numeric(5)  , Cartera.MoCodMonPagPrima )
            , 'MonPagPrimaDsc'  = convert( char(35)    , isnull( MonedaPrima.MnGlosa, 'Moneda Prima no existe' ) )
	    , 'MonPagPrimaNemo' = convert( char(8)     , isnull( MonedaPrima.MnNemo, 'No existe' ) )
            , 'fPagoPrimaCod'      = convert( NUMERIC(3)  , Cartera.MofPagoPrima )
            , 'fPagoPrimaDsc'      = convert( CHAR(30)    , isnull( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )

  
            , 'PrimaInicial'    = convert( float, Cartera.MoPrimaInicial )
            , 'FechaPagoPrima'  = convert( datetime    , Cartera.MoFechaPagoPrima,112)

            , 'CarteraFinancieraCod'   = Convert( Varchar(6), Cartera.MoCarteraFinanciera )
            , 'CarteraFinancieraDsc'   = Convert( Char(50)  , isnull( Financiera.tbglosa, 'Cartera Fin. no exite' ) )
            , 'CarteraNormativaCod'    = Convert( Varchar(6), Cartera.MoCarNormativa )
            , 'CarteraNormativaDsc'    = Convert( Char(50)  , isnull( Normativa.tbglosa, 'Catera Normativa no existe' ) )
            , 'LibroCod'               = Convert( Varchar(6), Cartera.MoLibro ) 
            , 'LibroDsc'               = Convert( Char(50)  , isnull( Libro.tbglosa, 'Libro no existe' ) )
            , 'AreaResponsalbleCod'    = Convert( VarChar(6), 6 )   -- Mesa de dinero siempre no tenemos el campo
            , 'AreaResponsalbleDsc'    = Convert( VarChar(50), isnull( Responsable.tbglosa, 'No existe area responsable' )  )   -- Mesa de dinero siempre no tenemos el campo

            , 'SubCarNormativaCod'     = Convert( VarChar(6), Cartera.MoSubCarNormativa )
            , 'SubCarNormativaDsc'     = Convert( Varchar(50), isnull( SubCartera.tbglosa,  'Falto SubCarNormatica'  ) )

            , 'MonPrimaTrfCod'  = Convert( numeric(5)  , Cartera.MoMonPrimaTrf )
            , 'MonPrimaTrfDsc'  = convert( char(35)    , isnull( MonedaPrimaTranf.MnGlosa, 'Moneda Prima Traf. no existe' ) )  
            , 'PrimaTranferencia'  = convert( float    , Cartera.MoPrimaTrf )
            , 'PrimaTranferenciaML'  = convert( float  , Cartera.MoPrimaTrfML )

            , 'MonPrimaCostoCod'  = Convert( numeric(5)  , Cartera.MoMonPrimaCosto )
            , 'MonPrimaCostoDsc'  = convert( char(35)    , isnull( MonedaPrimaCosto.MnGlosa, 'Moneda Prima Costo. no existe' )  )
            , 'PrimaCosto'        = convert( float       , Cartera.MoPrimaCosto )
            , 'PrimaCostoML'      = convert( float       , Cartera.MoPrimaCostoML )

            , 'MonPrimaCarryCod'  = Convert( numeric(5)  , Cartera.MoMonCarryPrima )
            , 'MonPrimaCarryDsc'  = convert( char(35)    , isnull( MonedaPrimaCarry.MnGlosa, 'Moneda Prima Carry. no existe' ) ) 
            , 'PrimaCarry'        = convert( float       , Cartera.MoCarryPrima )


            , 'MonVrCod'          = Convert( numeric(5)  , Cartera.MoMon_Vr )
            , 'MonVrDsc'          = Convert( Char(35)    , isnull( MonedaVr.MnGlosa, 'Moneda Vr no existe' ) )
            , 'MonVrNemo'         = Convert( Char(8)     , isnull( MonedaVr.MnNemo, 'No existe' ) )
            , 'Vr'                = convert( float       , Cartera.MoVr )
            , 'Vr_Costo'          = convert( float       , Cartera.MoVr_Costo )

            , 'MonDeltaCod'          = Convert( numeric(5)  , Cartera.MoMonDelta )
            , 'MonDeltaDsc'          = Convert( Char(35)    , isnull( MonedaDelta.MnGlosa, 'Moneda Delta no existe' ) )

            , 'MonGammaCod'          = Convert( numeric(5)  , Cartera.MoMon_Gamma )
            , 'MonGammaDsc'          = Convert( Char(35)    , isnull( MonedaGamma.MnGlosa, 'Moneda Gamma no existe' ) )
         
            , 'MonVegaCod'          = Convert( numeric(5)  , Cartera.MoMon_Vega )
            , 'MonVegaDsc'          = Convert( Char(35)    , isnull( MonedaVega.MnGlosa, 'Moneda Vega no existe' ) )

            , 'MonVannaCod'          = Convert( numeric(5)  , Cartera.MoMon_Vanna )
            , 'MonVannaDsc'          = Convert( Char(35)    , isnull( MonedaVanna.MnGlosa, 'Moneda Vanna no existe' ) )

            , 'MonVolgaCod'          = Convert( numeric(5)  , Cartera.MoMon_Volga )
            , 'MonVolvaDsc'          = Convert( Char(35)    , isnull( MonedaVolga.MnGlosa, 'Moneda Volga no existe' ) )

            , 'MonThetaCod'          = Convert( numeric(5)  , Cartera.MoMon_Theta )
            , 'MonThetaDsc'          = convert( Char(35)    , isnull( MonedaVolga.MnGlosa, 'Moneda Theta no existe' ) )


            , 'MonRhoCod'          = Convert( numeric(5)  , Cartera.MoMon_Rho )
            , 'MonRhoDsc'          = Convert( Char(35)    , isnull( MonedaRho.MnGlosa, 'Moneda Rho no existe' ) )

            , 'MonRhofCod'          = Convert( numeric(5)  , Cartera.MoMon_Rhof )
            , 'MonRhofDsc'          = Convert( Char(35)    , isnull( MonedaRho.MnGlosa, 'Moneda Rhof no existe' ) )

            , 'MonCharmCod'          = Convert( numeric(5)  , Cartera.MoMon_Charm )
            , 'MonCharmDsc'          = Convert( Char(35)    , isnull( MonedaCharm.MnGlosa, 'Moneda Charm no existe' ) )

            , 'MonZommaCod'          = Convert( numeric(5)  , Cartera.MoMon_Zomma )
            , 'MonZommaDsc'          = Convert( Char(35)    , isnull( MonedaZomma.MnGlosa, 'Moneda Zomma no existe' ) )

            , 'MonSpeedCod'          = Convert( numeric(5)  , Cartera.MoMon_Speed )
            , 'MonSpeedDsc'          = Convert( Char(35)    , isnull( MonedaSpeed.MnGlosa, 'Moneda Speed no existe' ) )


            , 'PrimaBSSpotCont'      = convert( float, isnull( Cartera.MoPrimaBSSpotCont  , 0.0 ) )
            , 'DeltaSpotCont'        = convert( float, isnull( Cartera.MoDeltaSpotCont    , 0.0 ) )
            , 'DeltaForwardCont'     = convert( float, isnull( Cartera.MoDeltaForwardCont , 0.0 ) )
            , 'GammaSpotCont'        = convert( float, isnull( Cartera.MoGammaSpotCont        , 0.0 ) )
            , 'GammaFwdCont'         = convert( float, isnull( Cartera.MoGammaFwdCont        , 0.0 ) )

            , 'VegaCont'   = convert( float, isnull( Cartera.MoVegaCont         , 0.0 ) )
            , 'VannaSpotCont'        = convert( float, isnull( Cartera.MoVannaSpotCont        , 0.0 ) )
            , 'VannaFwdCont' = convert( float, isnull( Cartera.MoVannaFwdCont        , 0.0 ) )

            , 'VolgaCont'            = convert( float, isnull( Cartera.MoVolgaCont        , 0.0 ) )
            , 'ThetaCont'            = convert( float, isnull( Cartera.MoThetaCont        , 0.0 ) )
            , 'RhoDomCont'           = convert( float, isnull( Cartera.MoRhoDomCont       , 0.0 ) )
            , 'RhoForCont'           = convert( float, isnull( Cartera.MoRhoForCont       , 0.0 ) )

            , 'CharmSpotCont'     = convert( float, isnull( Cartera.MoCharmSpotCont        , 0.0 ) )
            , 'CharmFwdCont'      = convert( float, isnull( Cartera.MoCharmFwdCont        , 0.0 ) )

            , 'ZommaSpotCont'     = convert( float, isnull( Cartera.MoZommaspotCont        , 0.0 ) )
            , 'ZommaFwdCont'      = convert( float, isnull( Cartera.MoZommaFwdCont        , 0.0 ) )


            , 'SpeedSpotCont'     = convert( float, isnull( Cartera.MoSpeedSpotCont        , 0.0 ) )
            , 'SpeedFwdCont'     = convert( float, isnull( Cartera.MoSpeedFwdCont        , 0.0 ) )


            , 'FechaUnwind'          = convert( datetime  , Cartera.MoFechaUnwind , 112 ) 
            , 'NominalUnwind'        = convert( float     , isnull( Cartera.MoNominalUnwind    , 0.0 ) ) 
            , 'UnwindMonCod'         = convert( numeric(5), isnull( Cartera.MoUnwindMon, 0.0 ) )
            , 'UnwindMonDsc'         = Convert( Char(35)  , isnull( MonedaUnwind.MnGlosa, 'Moneda Unwind no existe' ) )

            , 'Unwind'               = Convert( numeric(21,4), isnull( Cartera.MoUnwind, 0.0 ) )
            , 'UnwindML'             = Convert( numeric(21,4), isnull( Cartera.MoUnwindML, 0.0 ) )
            , 'FormPagoUnwindCod'    = Convert( numeric(3)   , isnull( Cartera.MoFormPagoUnwind, 0.0 ) )
            , 'FormPagoUnwindDsc'    = Convert( char(30)     , isnull( FormaPagoUnwind.glosa, 'Forma Pago Unwind no existe' ) )
 
            , 'UnwindTransfMonCod'   = convert( numeric(5)    , isnull( Cartera.MoUnwindTransfMon, 0.0 ) ) 
            , 'UnwindTransfMonDsc'   = convert( Char(35)      , isnull( MonedaUnwindTrf.MnGlosa, 'Moneda Traf. Unwind no existe' ) ) 
            , 'UnwindTransf'         = convert( numeric(21,4) , isnull( Cartera.MoUnwindTransf, 0.0 ) )
            , 'UnwindTransfML'       = convert( numeric(21,4) , isnull( Cartera.MoUnwindTransfML, 0.0 ) )

            , 'Glosa'                 = convert( Varchar(80)   , isnull( Cartera.MoGlosa , ' ' ) )
            , 'Usuario'               = convert( VarChar(15) , @Usuario )
            , 'FechaProceso'          = convert( datetime, @FechaProceso, 112 )
            , 'FechaCreacionRegistro' = convert( Datetime , isnull( Cartera.MoFechaCreacionRegistro, '' ) )
        
        Into #Encabezado
  
        from   #MoEncContrato As Cartera
               LEFT JOIN #Cliente               Cliente 	 ON Cliente.ClRut            = Cartera.MoRutCliente and Cartera.MoCodigo = Cliente.ClCodigo 
               LEFT JOIN #Moneda                MonedaUnwindTrf  ON MonedaUnwindTrf.MnCodMon = Cartera.MoUnwindTransfMon               
               LEFT JOIN #Formas_Pago           FormaPagoUnwind  ON FormaPagoUnwind.Codigo = Cartera.MoFormPagoUnwind 
               LEFT JOIN #Formas_Pago           FormaPagoPrima   ON FormaPagoPrima.Codigo = Cartera.MofPagoPrima 
               LEFT JOIN #Moneda                MonedaUnwind     ON MonedaUnwind.MnCodMon = Cartera.MoUnwindMon
               LEFT JOIN #Moneda                MonedaSpeed      ON MonedaSpeed.MnCodMon = Cartera.MoMon_Speed
               LEFT JOIN #Moneda                MonedaZomma      ON MonedaZomma.MnCodMon = Cartera.MoMon_Zomma
               LEFT JOIN #Moneda                MonedaCharm      ON MonedaCharm.MnCodMon = Cartera.MoMon_Charm
               LEFT JOIN #Moneda                MonedaRhof       ON MonedaRhof.MnCodMon = Cartera.MoMon_Rhof
               LEFT JOIN #Moneda                MonedaRho  ON MonedaRho.MnCodMon = Cartera.MoMon_Rho
               LEFT JOIN #Moneda                MonedaVolga      ON MonedaVolga.MnCodMon = Cartera.MoMon_Volga
               LEFT JOIN #Moneda                MonedaVanna      ON MonedaVanna.MnCodMon = Cartera.MoMon_Vanna
               LEFT JOIN #Moneda                MonedaVega       ON MonedaVega.MnCodMon = Cartera.MoMon_Vega
               LEFT JOIN #Moneda                MonedaGamma      ON MonedaGamma.MnCodMon = Cartera.MoMon_Gamma
               LEFT JOIN #Moneda                MonedaDelta      ON MonedaDelta.MnCodMon = Cartera.MoMonDelta
               LEFT JOIN #Moneda                MonedaPrima      ON MonedaPrima.MnCodMon = Cartera.MoCodMonPagPrima
               LEFT JOIN #Moneda                MonedaPrimaTranf ON MonedaPrimaTranf.MnCodMon = Cartera.MoMonPrimaTrf
               LEFT JOIN #Moneda                MonedaPrimaCosto ON MonedaPrimaCosto.MnCodMon = Cartera.MoMonPrimaCosto
               LEFT JOIN #Moneda                MonedaPrimaCarry ON MonedaPrimaCarry.MnCodMon = Cartera.MoMonCarryPrima
               LEFT JOIN #Moneda                MonedaVr         ON MonedaVr.MnCodMon = Cartera.MoMon_Vr
               LEFT JOIN ConOpcEstado           Estado           ON Estado.ConOpcEstCod = Cartera.MoEstado
               LEFT JOIN OpcionEstructura       Estructura       ON Estructura.OpcEstCod = Cartera.MoCodEstructura
               LEFT JOIN #TABLA_GENERAL_DETALLE Financiera  ON Financiera.tbcateg   = 204  AND Financiera.tbcodigo1  = Cartera.MoCarteraFinanciera
               LEFT JOIN #TABLA_GENERAL_DETALLE Normativa   ON Normativa.tbcateg    = 1111 AND Normativa.tbcodigo1   = Cartera.MoCarNormativa
               LEFT JOIN #TABLA_GENERAL_DETALLE Libro       ON Libro.tbcateg        = 1552 AND Libro.tbcodigo1 = Cartera.MoLibro
               LEFT JOIN #TABLA_GENERAL_DETALLE Responsable ON Responsable.tbcateg  = 1553 AND Responsable.tbcodigo1 = 6 -- No tenemos area responsable !!!
               LEFT JOIN #TABLA_GENERAL_DETALLE SubCartera  ON SubCartera.tbcateg   = 1554 AND SubCartera.tbcodigo1  = Cartera.MoSubCarNormativa  


     -- 3. Se navega el detalle y se genera #Detalle (se le adosó la información #Encabezado).
     Select #Encabezado.*
            , 'OpcTipCod'           = Convert( char(1)     ,  CarDet.MoTipoOpc )
            , 'OpcTipDsc'           = Convert( char(20)    , isnull( OpcionTipo.OpcTipDsc, 'No existe Tipo de Opción' ) )
            , 'SubyacenteCod'       = Convert( char(3)     , CarDet.MoSubyacente )
            , 'SubyacenteDsc'       = Convert( varchar(40) , isnull( Subyacente.SubyacenteDescripcion, 'No existe Subyacente' ) )
            , 'NumEstructura'       = convert( numeric(6)  , CarDet.MoNumEstructura )
            , 'PayOffTipCod'        = convert( VarChar(2)  , CarDet.MoTipoPayOff )
            , 'PayOffTipDsc'        = Convert( VarChar(20) , isnull( PayOffTipo.PayOffTipDsc, 'PayOff no existe' ) )
            , 'CallPut'             = convert( VarChar(5)  , CarDet.MoCallPut )
            , 'CVOpcCod'            = Convert( varchar(3)  , CarDet.MoCVOpc )
            , 'CompraVentaOpcDsc'   = Convert( varchar(6)  , Case when CarDet.MoCVOpc = 'C' then 'Compra' else 'Venta' end )
            , 'TipoEmisionPTCod'    = Convert( varchar(3)  , CarDet.MoTipoEmisionPT )
            , 'TipoEmisionPTDsc'    = Convert( varchar(8)  , Case when CarDet.MoTipoEmisionPT = 'P' then 'Propia' else 'Terceros' end  )
            , 'FechaInicioOpc'      = Convert( datetime    , CarDet.MoFechaInicioOpc, 112 )

            , 'FechaFijacionOpc'    = Convert( datetime    , CarDet.MoFechaFijacion, 112 )
            , 'FechaVcto'           = Convert( datetime    , CarDet.MoFechaVcto, 112 )
            , 'FechaPagoEjer'       = Convert( datetime    , CarDet.MoFechaPagoEjer, 112 )
            , 'FechaPagMon1'        = Convert( datetime    , CarDet.MoFechaPagMon1, 112 )
            , 'FechaPagMon2'        = Convert( datetime    , CarDet.MoFechaPagMon2, 112 )


            , 'Mon1Cod'             = convert( numeric(5)  , CarDet.MoCodMon1 )
            , 'Mon1Dsc'  = convert( char(35)    , isnull( MonedaM1.MnGlosa, 'Moneda M1 no existe' ) )
            , 'MontoMon1'           = Convert( numeric(21,6) , CarDet.MoMontoMon1 )

            , 'FormaPagoMon1Cod'    = convert( numeric(3)  , CarDet.MoFormaPagoMon1 )
            , 'FormaPagoMon1Dsc'    = convert( char(30)    , FormaPagoM1.Glosa )

            , 'Mon2Cod'             = convert( numeric(5)  , CarDet.MoCodMon2 )
            , 'Mon2Dsc'             = convert( char(35)    , isnull( MonedaM2.MnGlosa, 'Moneda M2 no existe' ) )
            , 'MontoMon2'           = Convert( numeric(21,6) , CarDet.MoMontoMon2 )
            , 'FormaPagoMon2Cod'    = convert( numeric(3)  , CarDet.MoFormaPagoMon2 )
            , 'FormaPagoMon2Dsc'    = convert( char(30)    , FormaPagoM2.Glosa )
            , 'ModalidadCod'        = Convert( varchar(1)  , CarDet.MoModalidad )
            , 'ModalidadDsc'        = Convert( varchar(15) ,  Case when CarDet.MoModalidad = 'C' then 'Compensación' else 'Entrega Fisica' end )

            , 'MdaCompensacionCod'  = Convert( numeric(5)  , CarDet.MoMdaCompensacion )
            , 'MdaCompensacionDsc'  = convert( char(35)    , isnull( MonedaCompensacion.MnGlosa, 'N/A' ) )

            , 'BenchCompCod'        = convert( numeric(5)  , CarDet.MoBenchComp )
            , 'BenchCompDsc'        = convert( varchar(40) , isnull( BenchMark.BenchMarkDescripcion, 'No existe BechMark' ) )


            , 'ParStrike'           = convert( varchar(7), CarDet.MoParStrike )
            , 'Strike'              = convert( float, CarDet.MoStrike )
            , 'PorcStrike'          = convert( float, CarDet.MoPorcStrike )

            , 'TipoEjercicioCod'    = Convert( varchar(1), CarDet.MoTipoEjercicio ) 
            , 'TipoEjercicioDsc'    = Convert( Varchar(10) , Case when CarDet.MoTipoEjercicio = 'E' then 'EUROPEA' else 'AMERICANA' end )
            , 'VrDet'               = convert(float, CarDet.MoVrDet )

     into #Detalle
     From    #Encabezado
           , #MoDetContrato CarDet
             LEFT JOIN     OpcionTipo               ON Opciontipo.OpcTipCod  = CarDet.MoTipoOpc
             LEFT JOIN     Subyacente               ON Subyacente.Subyacente = CarDet.MoSubyacente 
             LEFT JOIN     PayOffTipo               ON PayOffTipo.PayOffTipCod = CarDet.MoTipoPayOff 
             LEFT JOIN     #Formas_Pago FormaPagoM1 ON FormaPagoM1.Codigo      = CarDet.MoFormaPagoMon1
             LEFT JOIN     #Formas_Pago FormaPagoM2 ON FormaPagoM2.Codigo      = CarDet.MoFormaPagoMon2

             LEFT JOIN     #Moneda        MonedaM1    ON MonedaM1.MnCodMon           = CarDet.MoCodMon1
             LEFT JOIN     #Moneda        MonedaM2    ON MonedaM2.MnCodMon           = CarDet.MoCodMon2
             LEFT JOIN     #Moneda MonedaCompensacion ON MonedaCompensacion.MnCodMon = CarDet.MoMdaCompensacion

             LEFT JOIN     BenchMark                 ON  BenchMark.BenchMarkCod   = CarDet.MoBenchComp 
             LEFT JOIN     #GEN_SISTEMAS Sistema     ON  Sistema.Id_sistema       = CarDet.MoIteAsoSis

     where     CarDet.MoNumFolio    = #Encabezado.NumFolio



     IF exists( select (1) from #detalle  ) BEGIN

          select  'NumContrato'   = NumContrato
                 ,'CantComp'      = count(*) 
          into  #ComponentesXContrato
          from #detalle
			where (@NumeroContrato = 0 OR NumContrato = @NumeroContrato) --ASVG_20110425 Filtrado por número de contrato
          group by NumContrato

          truncate table #Resultado     -- Cuando termine desarrollo borrar esto 
          insert into #Resultado        -- y mostrar desde MovDet y no desde resultado
     select MovDet.* 
               , CantComp 
          from #detalle MovDet 
            ,  #ComponentesXContrato Comp
          where  MovDet.NumContrato = Comp.NumContrato 

          select *,'BannerLargo' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales) from #Resultado
     END
     ELSE
         -- Se despliega el registro Sin Datos.
         select *,'BannerLargo' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales) from   #Resultado        			

END

GO
