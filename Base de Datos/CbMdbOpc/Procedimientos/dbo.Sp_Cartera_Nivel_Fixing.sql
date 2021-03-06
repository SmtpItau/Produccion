USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Cartera_Nivel_Fixing]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[Sp_Cartera_Nivel_Fixing](   @fecha datetime , @Usuario Varchar(15) ) AS BEGIN			

     -- INSTRUCCIONES GENERALES DE MANTENCION
     -- Agregar el campo o modificar primero en la sección que genera el 
     -- Registro vacío
     -- Luego agregar o modificar el campo que corresponde en la sección de reuperación de datos
     -- Ejecutar y actualizar los reportes atachados a este sp.


     SET NOCOUNT ON 			
     Declare  @Nombre Char(120)
            , @Dv     Char(1)
            , @FechaProceso datetime
            

     select * into #Moneda  from LNKBAC.bacparamsuda.dbo.Moneda

     select * into #Valor_Moneda  from LNKBAC.bacparamsuda.dbo.Valor_moneda where vmfecha = @fecha
     -- PENDIENTE: entrega fisica utilizará el Valor_Moneda Contable

     -- Solo se cargarán Clientes que alguna vez han tenido opciones
     select ClRut, ClCodigo, ClDv, ClNombre 
     into #Cliente from LNKBAC.bacparamsuda.dbo.Cliente 
     where Clrut in ( select MoRutCliente from MoEncContrato union select MoRutCliente from MoHisEncContrato )


     select @FechaProceso = ''
     select @FechaProceso = fechaproc from opcionesGeneral

     if ( select count(1) from #CLiente ) = 0 
        insert into #Cliente
	select ClRut = 0, ClCodigo = 0, ClDv = '', ClNombre = 'CLIENTE NO EXISTE EN BAC'

     select * into #Formas_Pago  from LNKBAC.bacparamsuda.dbo.Forma_de_Pago 

     select * into #Tabla_General_Detalle  from LNKBAC.bacparamsuda.dbo.Tabla_general_detalle 
     where tbcateg in ( 204, 1111, 1552, 1553, 1554 )

     select * into #GEN_SISTEMAS from LNKBAC.BacParamSuda.dbo.SISTEMA_CNT

     -- Sección que genera el registro vacío.
     Select   'Pantalla'        = 'FIJACION DE CONTRATOS'
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
            , 'fPagoPrimaCod'      = convert( NUMERIC(3)  , 0 )
            , 'fPagoPrimaDsc'      = convert( CHAR(30)    , '' )
            , 'PrimaInicial'    = convert( float, 0.0 )
            , 'FechaPagoPrima'  = convert( datetime    , '' ,112)
            , 'CarteraFinancieraCod'   = Convert( Varchar(6), '' )
            , 'CarteraFinancieraDsc'   = Convert( Char(50)  , '' )
            , 'CarteraNormativaCod'    = Convert( Varchar(6), '' )
            , 'CarteraNormativaDsc'    = Convert( Char(50)  , '' )
            , 'LibroCod'               = Convert( Varchar(6), '' ) 
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

            , 'TipoEjercicioCod'    = Convert( varchar(1), ''  ) 
            , 'TipoEjercicioDsc'    = Convert( Varchar(10) , ''  )
            , 'VrDet'               = convert( float, 0.0 )
            , 'IteAsoSisCod'        = Convert( char(3), '' )
            , 'IteAsoSisDsc'        = Convert( char(20), '' )
            , 'IteAsoCon'           = Convert( NUmeric(8), 0.0  )
            -- 
            , 'NumeroFijacion'      = Convert( numeric(6)  , 0 )
            , 'FechaFijacion'       = Convert( datetime    , '' , 112 )
            , 'PesoFijacion'        = Convert( float, 0.0 )
            , 'VolatilidadFijacion' = convert( float, 0.0 )
            , 'Fijacion'            = convert( float, 0.0 )
            , 'FixBenchCompCod'     = convert( numeric(5), 0 )
            , 'FixBenchCompDsc'     = convert( varchar(40), '' )
            , 'FixBenchCompHora'    = convert( varchar(8) , '00:00:00' ) 
            , 'FixBenchEsEditable'  = convert( varchar(1) , '' ) 
            , 'FixBenchMdaCodValorDef' = convert( numeric(5) , 0 )
            , 'FixBenchMdaCodValorDefValor' = convert( float , 0 )  
            , 'FixParBench'         = convert( varchar(7) , '' ) 
            , 'FixEstadoBench'      = convert( varchar(1) , '' ) 


            INTO #Resultado -- Genera tabla con el registro vacío

            -- Sección de recuperación de datos
            Select   'Reporte'        = 'FIJACION DE CONTRATOS'
            , 'NumContrato'     = convert( numeric(8)  , Cartera.CaNumContrato )
            , 'NumFolio'        = convert( numeric(8)  , Cartera.CaNumFolio )
            , 'TipoTransaccion' = convert( varchar(10) , Cartera.CaTipoTransaccion )
            , 'FechaContrato'   = convert( datetime    , Cartera.CaFechaContrato,112)
            , 'ConOpcEstCod'	= Convert( varchar(1)  , Cartera.CaEstado )
            , 'ConOpcEstDsc'    = Convert( varchar(30) , isnull( Estado.ConOpcEstDsc,  'Estado no Existe' ) )
            , 'CliRut'  	= Convert( numeric(13) , Cartera.CaRutCliente )
            , 'CliCod'          = convert( numeric(5)  , Cartera.CaCodigo )
            , 'CliDv'           = Convert( varchar(1)  , isnull( Cliente.ClDv, ' '  ) )
            , 'CliNom'  	= Convert( varchar(100), isnull( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )
            , 'Operador'        = Convert( varchar(15) , Cartera.CaOperador )
            , 'OpcEstCod'       = Convert( varchar(2)  , Cartera.CaCodEstructura  )
            , 'OpcEstDsc'       = COnvert( Varchar(20) , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )  
            , 'Contrapartida'   = Convert( varchar(8)  , Cartera.CaTipoContrapartida )
            , 'CVEstructura'    = convert( varchar(1)  , Cartera.CaCVEstructura )
            , 'CompraVentaEstructura'    = convert( varchar(6) , Case when Cartera.CaCVEstructura = 'C' then 'COMPRA' else 'VENTA' end )
            , 'MonPagPrimaCod'  = Convert( numeric(5)  , Cartera.CaCodMonPagPrima )
            , 'MonPagPrimaDsc'  = convert( char(35)    , isnull( MonedaPrima.MnGlosa, 'Moneda Prima no existe' ) )
            , 'fPagoPrimaCod'      = convert( NUMERIC(3)  , Cartera.CafPagoPrima )
            , 'fPagoPrimaDsc'      = convert( CHAR(30)    , isnull( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )

  
            , 'PrimaInicial'    = convert( float, Cartera.CaPrimaInicial )
            , 'FechaPagoPrima'  = convert( datetime    , Cartera.CaFechaPagoPrima,112)

            , 'CarteraFinancieraCod'   = Convert( Varchar(6), Cartera.CaCarteraFinanciera )
            , 'CarteraFinancieraDsc'   = Convert( Char(50)  , isnull( Financiera.tbglosa, 'Cartera Fin. no exite' ) )
            , 'CarteraNormativaCod'    = Convert( Varchar(6), Cartera.CaCarNormativa )
            , 'CarteraNormativaDsc'    = Convert( Char(50)  , isnull( Normativa.tbglosa, 'Catera Normativa no existe' ) )
            , 'LibroCod'               = Convert( Varchar(6), Cartera.CaLibro ) 
            , 'LibroDsc'               = Convert( Char(50)  , isnull( Libro.tbglosa, 'Libro no existe' ) )
            , 'AreaResponsalbleCod'    = Convert( VarChar(6), 6 )   -- Mesa de dinero siempre no tenemos el campo
            , 'AreaResponsalbleDsc'    = Convert( VarChar(50), isnull( Responsable.tbglosa, 'No existe area responsable' )  )   -- Mesa de dinero siempre no tenemos el campo

            , 'SubCarNormativaCod'     = Convert( VarChar(6), Cartera.CaSubCarNormativa )
            , 'SubCarNormativaDsc'     = Convert( Varchar(50), isnull( SubCartera.tbglosa,  'Falto SubCarNormatica'  ) )

            , 'MonPrimaTrfCod'  = Convert( numeric(5)  , Cartera.CaMonPrimaTrf )
            , 'MonPrimaTrfDsc'  = convert( char(35)    , isnull( MonedaPrimaTranf.MnGlosa, 'Moneda Prima Traf. no existe' ) )  
            , 'PrimaTranferencia'  = convert( float    , Cartera.CaPrimaTrf )
            , 'PrimaTranferenciaML'  = convert( float  , Cartera.CaPrimaTrfML )

            , 'MonPrimaCostoCod'  = Convert( numeric(5)  , Cartera.CaMonPrimaCosto )
            , 'MonPrimaCostoDsc'  = convert( char(35)    , isnull( MonedaPrimaCosto.MnGlosa, 'Moneda Prima Costo. no existe' )  )
            , 'PrimaCosto'        = convert( float       , Cartera.CaPrimaCosto )
            , 'PrimaCostoML'      = convert( float       , Cartera.CaPrimaCostoML )

            , 'MonPrimaCarryCod'  = Convert( numeric(5)  , Cartera.CaMonCarryPrima )
            , 'MonPrimaCarryDsc'  = convert( char(35)    , isnull( MonedaPrimaCarry.MnGlosa, 'Moneda Prima Carry. no existe' ) ) 
            , 'PrimaCarry'        = convert( float       , Cartera.CaCarryPrima )

            , 'MonVrCod'          = Convert( numeric(5)  , Cartera.CaMon_Vr )
            , 'MonVrDsc'          = Convert( Char(35)    , isnull( MonedaVr.MnGlosa, 'Moneda Vr no existe' ) )
            , 'Vr'                = convert( float       , Cartera.CaVr )
            , 'Vr_Costo'          = convert( float       , Cartera.CaVr_Costo )

            , 'MonDeltaCod'          = Convert( numeric(5)  , Cartera.CaMonDelta )
            , 'MonDeltaDsc'          = Convert( Char(35)    , isnull( MonedaDelta.MnGlosa, 'Moneda Delta no existe' ) )

            , 'MonGammaCod'          = Convert( numeric(5)  , Cartera.CaMon_Gamma )
            , 'MonGammaDsc'          = Convert( Char(35)    , isnull( MonedaGamma.MnGlosa, 'Moneda Gamma no existe' ) )
         
            , 'MonVegaCod'          = Convert( numeric(5)  , Cartera.CaMon_Vega )
            , 'MonVegaDsc'          = Convert( Char(35)    , isnull( MonedaVega.MnGlosa, 'Moneda Vega no existe' ) )

            , 'MonVannaCod'          = Convert( numeric(5)  , Cartera.CaMon_Vanna )
            , 'MonVannaDsc'          = Convert( Char(35)    , isnull( MonedaVanna.MnGlosa, 'Moneda Vanna no existe' ) )

            , 'MonVolgaCod'          = Convert( numeric(5)  , Cartera.CaMon_Volga )
            , 'MonVolvaDsc'          = Convert( Char(35)    , isnull( MonedaVolga.MnGlosa, 'Moneda Volga no existe' ) )

            , 'MonThetaCod'          = Convert( numeric(5)  , Cartera.CaMon_Theta )
            , 'MonThetaDsc'          = convert( Char(35)    , isnull( MonedaVolga.MnGlosa, 'Moneda Theta no existe' ) )


            , 'MonRhoCod'          = Convert( numeric(5)  , Cartera.CaMon_Rho )
            , 'MonRhoDsc'          = Convert( Char(35)    , isnull( MonedaRho.MnGlosa, 'Moneda Rho no existe' ) )

            , 'MonRhofCod'          = Convert( numeric(5)  , Cartera.CaMon_Rhof )
            , 'MonRhofDsc'          = Convert( Char(35)    , isnull( MonedaRho.MnGlosa, 'Moneda Rhof no existe' ) )

            , 'MonCharmCod'          = Convert( numeric(5)  , Cartera.CaMon_Charm )
            , 'MonCharmDsc'          = Convert( Char(35)    , isnull( MonedaCharm.MnGlosa, 'Moneda Charm no existe' ) )

            , 'MonZommaCod'          = Convert( numeric(5)  , Cartera.CaMon_Zomma )
            , 'MonZommaDsc'          = Convert( Char(35)    , isnull( MonedaZomma.MnGlosa, 'Moneda Zomma no existe' ) )

            , 'MonSpeedCod'          = Convert( numeric(5)  , Cartera.CaMon_Speed )
            , 'MonSpeedDsc'          = Convert( Char(35)    , isnull( MonedaSpeed.MnGlosa, 'Moneda Speed no existe' ) )


            , 'PrimaBSSpotCont'      = convert( float, isnull( Cartera.CaPrimaBSSpotCont  , 0.0 ) )
            , 'DeltaSpotCont'        = convert( float, isnull( Cartera.CaDeltaSpotCont    , 0.0 ) )
            , 'DeltaForwardCont'     = convert( float, isnull( Cartera.CaDeltaForwardCont , 0.0 ) )
            , 'GammaSpotCont'        = convert( float, isnull( Cartera.CaGammaSpotCont        , 0.0 ) )
            , 'GammaFwdCont'         = convert( float, isnull( Cartera.CaGammaFwdCont        , 0.0 ) )

            , 'VegaCont'             = convert( float, isnull( Cartera.CaVegaCont         , 0.0 ) )
            , 'VannaSpotCont'        = convert( float, isnull( Cartera.CaVannaSpotCont        , 0.0 ) )
            , 'VannaFwdCont'         = convert( float, isnull( Cartera.CaVannaFwdCont        , 0.0 ) )

            , 'VolgaCont'            = convert( float, isnull( Cartera.CaVolgaCont        , 0.0 ) )
            , 'ThetaCont'            = convert( float, isnull( Cartera.CaThetaCont        , 0.0 ) )
            , 'RhoDomCont'           = convert( float, isnull( Cartera.CaRhoDomCont       , 0.0 ) )
            , 'RhoForCont'           = convert( float, isnull( Cartera.CaRhoForCont       , 0.0 ) )

            , 'CharmSpotCont'     = convert( float, isnull( Cartera.CaCharmSpotCont        , 0.0 ) )
            , 'CharmFwdCont'      = convert( float, isnull( Cartera.CaCharmFwdCont        , 0.0 ) )

            , 'ZommaSpotCont'     = convert( float, isnull( Cartera.CaZommaspotCont        , 0.0 ) )
            , 'ZommaFwdCont'      = convert( float, isnull( Cartera.CaZommaFwdCont        , 0.0 ) )


            , 'SpeedSpotCont'     = convert( float, isnull( Cartera.CaSpeedSpotCont        , 0.0 ) )
            , 'SpeedFwdCont'     = convert( float, isnull( Cartera.CaSpeedFwdCont        , 0.0 ) )


            , 'FechaUnwind'          = convert( datetime  , Cartera.CaFechaUnwind , 112 ) 
            , 'NominalUnwind'        = convert( float     , isnull( Cartera.CaNominalUnwind    , 0.0 ) ) 
            , 'UnwindMonCod'         = convert( numeric(5), isnull( Cartera.CaUnwindMon, 0.0 ) )
            , 'UnwindMonDsc'         = Convert( Char(35)  , isnull( MonedaUnwind.MnGlosa, 'Moneda Unwind no existe' ) )

            , 'Unwind'               = Convert( numeric(21,4), isnull( Cartera.CaUnwind, 0.0 ) )
            , 'UnwindML'             = Convert( numeric(21,4), isnull( Cartera.CaUnwindML, 0.0 ) )
            , 'FormPagoUnwindCod'    = Convert( numeric(3)   , isnull( Cartera.CaFormPagoUnwind, 0.0 ) )
            , 'FormPagoUnwindDsc'    = Convert( char(30)     , isnull( FormaPagoUnwind.glosa, 'Forma Pago Unwind no existe' ) )
 
            , 'UnwindTransfMonCod'   = convert( numeric(5)    , isnull( Cartera.CaUnwindTransfMon, 0.0 ) ) 
            , 'UnwindTransfMonDsc'   = convert( Char(35)      , isnull( MonedaUnwindTrf.MnGlosa, 'Moneda Traf. Unwind no existe' ) ) 
            , 'UnwindTransf'         = convert( numeric(21,4) , isnull( Cartera.CaUnwindTransf, 0.0 ) )
            , 'UnwindTransfML'       = convert( numeric(21,4) , isnull( Cartera.CaUnwindTransfML, 0.0 ) )

            , 'Glosa'                 = convert( Varchar(80)   , isnull( Cartera.CaGlosa , ' ' ) )
            , 'Usuario'               = convert( VarChar(15) , @Usuario )
            , 'FechaProceso'          = convert( datetime, @FechaProceso, 112 )
            , 'FechaCreacionRegistro' = convert( Datetime , isnull( Cartera.CaFechaCreacionRegistro, '' ) )
        
        Into #Encabezado
  
        from   CaEncContrato As Cartera
               LEFT JOIN #Cliente               Cliente 	 ON Cliente.ClRut            = Cartera.CaRutCliente and Cartera.CaCodigo = Cliente.ClCodigo 
               LEFT JOIN #Moneda                MonedaUnwindTrf  ON MonedaUnwindTrf.MnCodMon = Cartera.CaUnwindTransfMon               
               LEFT JOIN #Formas_Pago           FormaPagoUnwind  ON FormaPagoUnwind.Codigo = Cartera.CaFormPagoUnwind 
               LEFT JOIN #Formas_Pago           FormaPagoPrima   ON FormaPagoPrima.Codigo = Cartera.CafPagoPrima 
               LEFT JOIN #Moneda                MonedaUnwind     ON MonedaUnwind.MnCodMon = Cartera.CaUnwindMon
               LEFT JOIN #Moneda                MonedaSpeed      ON MonedaSpeed.MnCodMon = Cartera.CaMon_Speed
               LEFT JOIN #Moneda                MonedaZomma      ON MonedaZomma.MnCodMon = Cartera.CaMon_Zomma
               LEFT JOIN #Moneda                MonedaCharm      ON MonedaCharm.MnCodMon = Cartera.CaMon_Charm
               LEFT JOIN #Moneda                MonedaRhof       ON MonedaRhof.MnCodMon = Cartera.CaMon_Rhof
               LEFT JOIN #Moneda                MonedaRho        ON MonedaRho.MnCodMon = Cartera.CaMon_Rho
               LEFT JOIN #Moneda                MonedaVolga      ON MonedaVolga.MnCodMon = Cartera.CaMon_Volga
               LEFT JOIN #Moneda                MonedaVanna      ON MonedaVanna.MnCodMon = Cartera.CaMon_Vanna
               LEFT JOIN #Moneda                MonedaVega       ON MonedaVega.MnCodMon = Cartera.CaMon_Vega
               LEFT JOIN #Moneda                MonedaGamma      ON MonedaGamma.MnCodMon = Cartera.CaMon_Gamma
               LEFT JOIN #Moneda                MonedaDelta      ON MonedaDelta.MnCodMon = Cartera.CaMonDelta
               LEFT JOIN #Moneda                MonedaPrima      ON MonedaPrima.MnCodMon = Cartera.CaCodMonPagPrima
               LEFT JOIN #Moneda                MonedaPrimaTranf ON MonedaPrimaTranf.MnCodMon = Cartera.CaMonPrimaTrf
               LEFT JOIN #Moneda                MonedaPrimaCosto ON MonedaPrimaCosto.MnCodMon = Cartera.CaMonPrimaCosto
               LEFT JOIN #Moneda                MonedaPrimaCarry ON MonedaPrimaCarry.MnCodMon = Cartera.CaMonCarryPrima
               LEFT JOIN #Moneda                MonedaVr         ON MonedaVr.MnCodMon = Cartera.CaMon_Vr
               LEFT JOIN ConOpcEstado           Estado           ON Estado.ConOpcEstCod = Cartera.CaEstado
               LEFT JOIN OpcionEstructura       Estructura       ON Estructura.OpcEstCod = Cartera.CaCodEstructura
               LEFT JOIN #TABLA_GENERAL_DETALLE Financiera  ON Financiera.tbcateg   = 204  AND Financiera.tbcodigo1  = Cartera.CaCarteraFinanciera
               LEFT JOIN #TABLA_GENERAL_DETALLE Normativa   ON Normativa.tbcateg    = 1111 AND Normativa.tbcodigo1   = Cartera.CaCarNormativa
               LEFT JOIN #TABLA_GENERAL_DETALLE Libro       ON Libro.tbcateg        = 1552 AND Libro.tbcodigo1 = Cartera.CaLibro
               LEFT JOIN #TABLA_GENERAL_DETALLE Responsable ON Responsable.tbcateg  = 1553 AND Responsable.tbcodigo1 = 6 -- No tenemos area responsable !!!
               LEFT JOIN #TABLA_GENERAL_DETALLE SubCartera  ON SubCartera.tbcateg   = 1554 AND SubCartera.tbcodigo1  = Cartera.CaSubCarNormativa  
     --   where Cartera.CaNumFolio    = @NumFolio
     -- Deberían existir otros Folio

     -- 3. Se navega el detalle y se genera #Detalle (se le adosó la información #Encabezado).
     Select #Encabezado.*
            , 'OpcTipCod'           = Convert( char(1)     ,  CarDet.CaTipoOpc )
            , 'OpcTipDsc'           = Convert( char(20)    , isnull( OpcionTipo.OpcTipDsc, 'No existe Tipo de Opción' ) )
            , 'SubyacenteCod'       = Convert( char(3)     , CarDet.CaSubyacente )
            , 'SubyacenteDsc'       = Convert( varchar(40) , isnull( Subyacente.SubyacenteDescripcion, 'No existe Subyacente' ) )
            , 'NumEstructura'       = convert( numeric(6)  , CarDet.CaNumEstructura )
            , 'PayOffTipCod'        = convert( VarChar(2)  , CarDet.CaTipoPayOff )
            , 'PayOffTipDsc'        = Convert( VarChar(20) , isnull( PayOffTipo.PayOffTipDsc, 'PayOff no existe' ) )
            , 'CallPut'             = convert( VarChar(5)  , CarDet.CaCallPut )
            , 'CVOpcCod'            = Convert( varchar(3)  , CarDet.CaCVOpc )
            , 'CompraVentaOpcDsc'   = Convert( varchar(6)  , Case when CarDet.CaCVOpc = 'C' then 'Compra' else 'Venta' end )
            , 'TipoEmisionPTCod'    = Convert( varchar(3)  , CarDet.CaTipoEmisionPT )
            , 'TipoEmisionPTDsc'    = Convert( varchar(8)  , Case when CarDet.CaTipoEmisionPT = 'P' then 'Propia' else 'Terceros' end  )
            , 'FechaInicioOpc'      = Convert( datetime    , CarDet.CaFechaInicioOpc, 112 )

            , 'FechaFijacionOpc'    = Convert( datetime    , CarDet.CaFechaFijacion, 112 )
            , 'FechaVcto'           = Convert( datetime    , CarDet.CaFechaVcto, 112 )
            , 'FechaPagoEjer'       = Convert( datetime    , CarDet.CaFechaPagoEjer, 112 )
            , 'FechaPagMon1'        = Convert( datetime    , CarDet.CaFechaPagMon1, 112 )
            , 'FechaPagMon2'        = Convert( datetime    , CarDet.CaFechaPagMon2, 112 )


            , 'Mon1Cod'             = convert( numeric(5)  , CarDet.CaCodMon1 )
            , 'Mon1Dsc'             = convert( char(35)    , isnull( MonedaM1.MnGlosa, 'Moneda M1 no existe' ) )
            , 'MontoMon1'           = Convert( numeric(21,6) , CarDet.CaMontoMon1 )

            , 'FormaPagoMon1Cod'    = convert( numeric(3)  , CarDet.CaFormaPagoMon1 )
            , 'FormaPagoMon1Dsc'    = convert( char(30)    , FormaPagoM1.Glosa )

            , 'Mon2Cod'             = convert( numeric(5)  , CarDet.CaCodMon2 )
            , 'Mon2Dsc'             = convert( char(35)    , isnull( MonedaM2.MnGlosa, 'Moneda M2 no existe' ) )
            , 'MontoMon2'           = Convert( numeric(21,6) , CarDet.CaMontoMon2 )
            , 'FormaPagoMon2Cod'    = convert( numeric(3)  , CarDet.CaFormaPagoMon2 )
            , 'FormaPagoMon2Dsc'    = convert( char(30)    , FormaPagoM2.Glosa )
            , 'ModalidadCod'        = Convert( varchar(1)  , CarDet.CaModalidad )
            , 'ModalidadDsc'        = Convert( varchar(15) ,  Case when CarDet.CaModalidad = 'C' then 'Compensación' else 'Entrega Fisica' end )

            , 'MdaCompensacionCod'  = Convert( numeric(5)  , CarDet.CaMdaCompensacion )
            , 'MdaCompensacionDsc'  = convert( char(35)    , isnull( MonedaCompensacion.MnGlosa, 'N/A' ) )

            , 'BenchCompCod'        = convert( numeric(5)  , CarDet.CaBenchComp )
            , 'BenchCompDsc'        = convert( varchar(40) , isnull( BenchMark.BenchMarkDescripcion, 'No existe BechMark' ) )


            , 'ParStrike'           = convert( varchar(7), CarDet.CaParStrike )
            , 'Strike'              = convert( float, CarDet.CaStrike )
            , 'PorcStrike'          = convert( float, CarDet.CaPorcStrike )

            , 'TipoEjercicioCod'    = Convert( varchar(1), CarDet.CaTipoEjercicio ) 
            , 'TipoEjercicioDsc'    = Convert( Varchar(10) , Case when CarDet.CaTipoEjercicio = 'E' then 'EUROPEA' else 'AMERICANA' end )
            , 'VrDet'               = convert(float, CarDet.CaVrDet )
            , 'IteAsoSisCod'        = Convert( char(3), CarDet.CaIteAsoSis )
            , 'IteAsoSisDsc'        = Convert( char(20), isnull( Sistema.Nombre_Sistema, 'N/A' ) )
            , 'IteAsoCon'           = Convert( NUmeric(8), isnull( CarDet.CaIteAsoCon, 0 )  )

     into #Detalle
     From    #Encabezado
           , CaDetContrato CarDet
             LEFT JOIN     OpcionTipo               ON Opciontipo.OpcTipCod  = CarDet.CaTipoOpc
             LEFT JOIN     Subyacente               ON Subyacente.Subyacente = CarDet.CaSubyacente 
             LEFT JOIN     PayOffTipo               ON PayOffTipo.PayOffTipCod = CarDet.CaTipoPayOff 
             LEFT JOIN     #Formas_Pago FormaPagoM1 ON FormaPagoM1.Codigo      = CarDet.CaFormaPagoMon1
             LEFT JOIN     #Formas_Pago FormaPagoM2 ON FormaPagoM2.Codigo      = CarDet.CaFormaPagoMon2

             LEFT JOIN     #Moneda        MonedaM1    ON MonedaM1.MnCodMon           = CarDet.CaCodMon1
             LEFT JOIN     #Moneda        MonedaM2    ON MonedaM2.MnCodMon           = CarDet.CaCodMon2
             LEFT JOIN     #Moneda MonedaCompensacion ON MonedaCompensacion.MnCodMon = CarDet.CaMdaCompensacion

             LEFT JOIN     BenchMark                 ON  BenchMark.BenchMarkCod   = CarDet.CaBenchComp 
             LEFT JOIN     #GEN_SISTEMAS Sistema     ON  Sistema.Id_sistema       = CarDet.CaIteAsoSis

     where     CarDet.CaNumContrato    = #Encabezado.NumContrato


     select   Det.* 
            , 'NumeroFijacion'              = Convert( numeric(6)  , Fix.CaFixNumero )
            , 'FechaFijacion'               = Convert( datetime    , Fix.CaFixFecha , 112 )
            , 'PesoFijacion'                = Convert( float, Fix.CaPesoFij )
            , 'VolatilidadFijacion'         = convert( float, Fix.CaVolFij )
            , 'Fijacion'                    = convert( float, Fix.CaFijacion )
            , 'FixBenchCompCod'             = convert( numeric(5), Fix.CaFixBenchComp )
            , 'FixBenchCompDsc'             = convert( varchar(40), isnull( BenchMarkFix.BenchMarkDescripcion, 'No existe Bench de Fijacion' ) )
            , 'FixBenchCompHora'            = convert( varchar(8) , isnull( BenchMarkFix.BenchMarkHora,'00:00:00' ), 108 ) 
            , 'FixBenchEsEditable'          = convert( varchar(1) , isnull( BenchMarkFix.BenchEditable, ' ' ) )
            , 'FixBenchMdaCodValorDef'      = convert( numeric(5) , isnull( BenchMarkFix.BenchMdaCodValorDef, 0 ) )
            , 'FixBenchMdaCodValorDefValor' = convert( float      , isnull( ValorBenchMarkFix.VmValor, 0 ) )  
            , 'FixParBench'                 = convert( varchar(7) , CaFixParBench ) 
            , 'FixEstadoBench'              = convert( varchar(1) , CaFixEstado ) 
            into #Fixing  
                  from    
                        #Detalle    Det
                      , cafixing    Fix
                  LEFT JOIN     BenchMark BenchMarkFix    
                                ON  BenchMarkFix.BenchMarkCod   = Fix.CaFixBenchComp 
                  LEFT JOIN     #Valor_Moneda  ValorBenchMarkFix 
                                ON ValorBenchMarkFix.vmcodigo = BenchMarkFix.BenchMdaCodValorDef AND Fix.CaFixFecha = ValorBenchMarkFix.vmFecha
               where 
               Fix.CaNumContrato   = Det.NumContrato
           and Fix.CaNumEstructura = Det.NumEstructura
           and Fix.CaFixFecha = @Fecha

         order by CaFixFecha asc

     IF exists( select (1) from #Fixing  ) BEGIN
          truncate table #Resultado     -- Cuando termine desarrollo borrar esto 
          insert into #Resultado        -- y mostrar desde MovDet y no desde resultado
          select Fixing.* 
               from #fixing Fixing
          select * from #Resultado
     END
     ELSE
         -- Se despliega el registro Sin Datos.
         select * from   #Resultado        			

END  

GO
