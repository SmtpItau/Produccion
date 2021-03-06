USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[OPT_SP_CAFIXDESDEHASTAOPT]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OPT_SP_CAFIXDESDEHASTAOPT](   
                                         @f1          datetime 
                                       , @f2          datetime
                                       , @NumContrato numeric(10)
                                       , @Usuario     Varchar(15) 
                                        ) 
AS BEGIN			

     -- INSTRUCCIONES GENERALES DE MANTENCION
     -- Agregar el campo o modificar primero en la sección que genera el 
     -- Registro vacío
     -- Luego agregar o modificar el campo que corresponde en la sección de reuperación de datos
     -- Ejecutar y actualizar los reportes atachados a este sp.

	 -- ASVG 29 Marzo 2011 Se agrega campo para encabezado de reporte que debe indicar dato de 
	 -- compra/venta estructura desde tabla de encabezado de contrato.


     -- OPT_Sp_CaFixDesdeHastaOpt '19000101', '20300101' , 7010, 'MARIAS' -- 'IHAMEL' 

     SET NOCOUNT ON			
     Declare  @Nombre Char(120)
            , @Dv     Char(1)
            , @FechaProceso datetime
            , @NombreBanco  Char(45) 
            , @Observ        Varchar(5000)    -- 08 Oct. 2009 
 


     select @Observ = ''  	-- 08 Oct. 2009 

     select @FechaProceso = FechaProc 
          , @NombreBanco  = 'BANCO '+ Nombre   
     from LnkOpc.CbMdbOpc.dbo.OpcionesGeneral


 /*=======================================================================*/
     DECLARE @firma1  char(15)  -- 26 Oct. 2009
     DECLARE @firma2  char(15)
     DECLARE @EstadoP char(01)

	  SELECT @firma1=res.Firma1,
		 @firma2=res.Firma2,
                 @EstadoP = res.Estado               
	   FROM  BacLineas..detalle_aprobaciones res
	  WHERE  res.Numero_Operacion  = @NumContrato
            AND  Id_Sistema       = 'OPT'


    SELECT A.NumeroOperacion 
         , A.Rut_Cliente
         , A.Codigo_Cliente
         , A.MontoOriginal As Matriz
         , A.MontoTransaccion As AjusteAVR
         , A.MontoOriginal + A.MontoTransaccion As Imputacion 
         , A.MatrizRiesgo  
         , A.TipoCambio  
         , B.Moneda  As MonLinGenCli
         , C.mnnemo
    INTO  #TEMP_LINEA_TRANSACCION_OPT  
    FROM   BacLineas..LINEA_TRANSACCION A
         , BacLineas..LINEA_GENERAL B     
         , BacParamSuda..Moneda C         
    WHERE A.Id_Sistema       = 'OPT' 
    AND   A.FechaInicio      = @FechaProceso
    AND   A.NumeroOperacion  = @NumContrato    
    AND   A.Rut_Cliente      = B.Rut_Cliente
    AND   A.Codigo_Cliente   = B.Codigo_Cliente   
    AND   B.Moneda           = C.mncodmon



   
 /*=======================================================================*/


      
     -- Sección que genera el registro vacío.
     Select   'Pantalla'        = convert( Varchar(40) , 'FIJACION DE CONTRATOS VIGENTE' )
            , 'NumContrato'     = convert( numeric(8)  , 0 )
            , 'NumFolio'        = convert( numeric(8)  , 0 )
            , 'CliRut'  	= Convert( numeric(13) , 0 )
            , 'CliCod'          = convert( numeric(5)  , 0 )
            , 'CliDv'           = Convert( varchar(1)  , ''   )
            , 'CliNom'  	= Convert( varchar(100), 'NO HAY DATOS' )
            , 'Operador'        = Convert( varchar(15) , '' )
            , 'OpcEstCod'       = Convert( varchar(2)  , '' )
            , 'OpcEstDsc'       = COnvert( Varchar(20) , '' )  
            , 'NumComponente'       = convert( numeric(6)  , 0 )
            , 'PayOffTipCod'        = convert( VarChar(2)  , '' )
            , 'PayOffTipDsc'        = Convert( VarChar(20) , '' )
            , 'CallPut'             = convert( VarChar(5)  , '' )
            , 'CVOpcCod'            = Convert( varchar(3)  , '' )
            , 'CompraVentaOpcDsc'   = Convert( varchar(6)  , '' )
            , 'FechaPagoEjer'       = Convert( datetime    , '' , 112 )
            , 'Mon1Cod'             = convert( numeric(5)  , 0 )
        , 'Mon1Dsc'             = convert( char(35)    , ''  )
            , 'MontoMon1'           = Convert( numeric(21,6) , 0 )
            , 'Mon2Cod'             = convert( numeric(5)  , 0 )
            , 'Mon2Dsc'             = convert( char(35)    , '' )
            , 'MontoMon2'           = Convert( numeric(21,6) , 0 )
            , 'ModalidadCod'        = Convert( varchar(1)  , ''  )
            , 'ModalidadDsc'        = Convert( varchar(15) , ''  )
            , 'MdaCompensacionCod'  = Convert( numeric(5)  , 0 )
            , 'MdaCompensacionDsc'  = convert( char(35)    , ''  )
            , 'Strike' = convert( float, 0.0 )
            , 'NumeroFijacion'      = Convert( numeric(6)  , 0 )
            , 'FechaFijacion'       = Convert( datetime    , '' , 112 )
            , 'PesoFijacion'        = Convert( float, 0.0 )
            , 'FixBenchCompCod'     = convert( numeric(5), 0 )
            , 'FixBenchCompDsc'     = convert( varchar(40), '' )
            , 'FixBenchCompHora'  = convert( varchar(8) , '00:00:00' ) 
            , 'FixBenchEsEditable'  = convert( varchar(1) , '' ) 
            , 'FixBenchMdaCodValorDef' = convert( numeric(5) , 0 )
            , 'FixBenchMdaCodValorDefValor' = convert( float , 0 )  
            , 'FixParBench'         = convert( varchar(7) , '' ) 
            , 'FixEstado'           = convert( varchar(1) , '' ) 
            , 'FixValorFijacion'    = convert( float, 0.0 )
            , 'EstadoEjercicioCod'  = convert( varchar(2) , '' )
            , 'EstadoEjercicioDsc'  = convert( varchar(20), '' )
            , 'EstadoMotorPagoCod'     = convert( varchar(2) , '' )
          , 'EstadoMotorPagoDsc'  = convert( varchar(20), '' ) 
            , 'Refijable'           = convert( varchar(10), 'RE-FIJABLE' )
            , 'Usuario'             = convert( varchar(15), '' )
            , 'TipoTransaccion'     = convert( varchar(10), '' )
            , 'FechaContrato'       = Convert( datetime   , '' , 112)
            , 'Estado'              = Convert( varchar(30) , 'Estado no Existe')
            , 'Contrapartida'       = Convert( varchar(8)  , '' )
            , 'FechaCreacionRegistro' = convert( Datetime , '', 112 )
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
            , 'MonVrCod'               = Convert( numeric(5)  , 0 )
            , 'MonVrDsc'               = Convert( Char(35)    , '' )
            , 'Vr'                     = Convert( float       , 0.0 )
            , 'Vr_Costo'               = Convert( float       , 0.0 )
            , 'MonPagPrimaCod'         = Convert( numeric(5)  , 0 )
            , 'MonPagPrimaDsc'         = Convert( char(35)    , '' )
            , 'fPagoPrimaCod'          = Convert( NUMERIC(3)  , 0 )
            , 'fPagoPrimaDsc'          = Convert( CHAR(30)    , '' )
            , 'PrimaInicial'           = Convert( float, 0.0 )
            , 'FechaPagoPrima'         = Convert( datetime    , '' ,112)
            , 'MonPrimaTrfCod'         = Convert( numeric(5)  , 0 )
            , 'MonPrimaTrfDsc'         = Convert( char(35)    , '' )  
            , 'PrimaTranferencia'      = Convert( float    , 0.0 )
            , 'PrimaTranferenciaML'    = Convert( float  , 0.0 )
            , 'MonPrimaCostoCod'       = Convert( numeric(5)  , 0 )
            , 'MonPrimaCostoDsc'       = Convert( char(35)    , '' )
            , 'PrimaCosto'             = Convert( float       , 0.0 )
            , 'PrimaCostoML'           = Convert( float       , 0.0 )
            , 'MonPrimaCarryCod'       = Convert( numeric(5)  , 0 )
            , 'MonPrimaCarryDsc'       = Convert( char(35)    , '' ) 
  , 'PrimaCarry'             = Convert( float       , 0.0 )
            , 'Banco'                  = Convert( Char(45), '' )
            , 'FechaUnwind'            = convert( datetime  , '' , 112 ) 
            , 'NominalUnwind'          = convert( float     ,  0.0  ) 
            , 'UnwindMonCod'           = convert( numeric(5), 0 )
            , 'UnwindMonDsc'           = Convert( Char(35)  , '' )
            , 'Unwind'                 = Convert( numeric(21,4), 0.0 )
            , 'UnwindML'               = Convert( numeric(21,4), 0.0 )
            , 'FormPagoUnwindCod'      = Convert( numeric(3)   , 0 )
            , 'FormPagoUnwindDsc'      = Convert( char(30)     , '' ) 
 , 'UnwindTransfMonCod'     = Convert( numeric(5)    , 0 ) 
            , 'UnwindTransfMonDsc'     = Convert( Char(35)      , '' ) 
            , 'UnwindTransf'           = Convert( numeric(21,4) , 0.0 )
            , 'UnwindTransfML'         = Convert( numeric(21,4) , 0.0 )
            , 'UnwindCosto'            = Convert( numeric(21,4) , 0.0 )
            , 'UnwindCostoML'          = Convert( numeric(21,4) , 0.0 )
            , 'OpcTipCod'              = Convert( char(1)     , '' )
            , 'OpcTipDsc'     = Convert( char(20)    , '' )
            , 'SubyacenteCod'          = Convert( char(3)     , '' )
            , 'SubyacenteDsc'          = Convert( varchar(40) , '' )
            , 'NumEstructura'          = Convert( numeric(6)  , 0 )
            , 'TipoEmisionPTCod'       = Convert( varchar(3)  , '' )
            , 'TipoEmisionPTDsc'       = Convert( varchar(8)  , '' )
            , 'FechaInicioOpc'         = Convert( datetime    , '', 112 )
            , 'FechaFijacionOpc'       = Convert( datetime    , '' , 112 )
            , 'FechaVcto'              = Convert( datetime    , '' , 112 )
            , 'IteAsoSisCod'           = Convert( char(3)     , '' )
            , 'IteAsoSisDsc'           = Convert( char(20)    , '' )
            , 'FormaPagoMon1Cod'       = Convert( numeric(3)  , 0 )
            , 'FormaPagoMon1Dsc'       = Convert( char(30)    , '' )
            , 'FormaPagoMon2Cod'       = Convert( numeric(3)  , 0 )
            , 'FormaPagoMon2Dsc'       = Convert( char(30)    , ''  )
            , 'FechaPagMon1'           = Convert( datetime    , '' , 112 )
            , 'FechaPagMon2'           = Convert( datetime    , '' , 112 )
            , 'Fijacion'               = Convert( float       , 0.0 )
            , 'FixEstadoBenchDsc'      = Convert( varchar(12) , '' )
            , 'Observaciones'          = Convert( varchar(5000) , '' )
            , 'Firma1'		       = Convert( varchar(15) , '' )	
            , 'Firma2'		       = Convert( varchar(15) , '' )	
            , 'MtoImputacion'          = Convert( float       , 0.0 )
            , 'MonLineaGenCli'         = Convert( numeric(5)  , 0 )
            , 'MonLineaGenCliNemo'     = Convert( char(8)     , '')
            , 'EstadoPend'             = Convert( char(1)     , '')
            , 'TCM_Prima'              = Convert( float, 0.0  )
            , 'CompraVentaOpcEncDsc'   = Convert( varchar(6)  , '' ) --ASVG_20110329 C/V Estructura desde encabezado.
            INTO #Resultado -- Genera tabla con el registro vacío

            CREATE INDEX INumContrato ON #Resultado(NumContrato,NumComponente ) 
      -- Estrategria
      -- Cargar tabla con los datos Fixing por fecha
      -- mediante update aplicar los datos de:
      -- CaEncContrato, CaDetContrato, CaVenEncContrato y CaVenEncContrato
      -- por ahora tratar de mantener información historica junto con 
      -- la vigente, si el desempeño no mejora separamos la cosa.
      Select  'Pantalla'        = convert( Varchar(40) , 'FIJACION DE CONTRATOS VIGENTE' )
            , 'NumContrato'     = convert( numeric(8)  , Fix.CaNumContrato )
            , 'NumFolio'       = convert( numeric(8)  , Enc.CaNumFolio )
            , 'CliRut'  	= Convert( numeric(13) , Enc.CaRutCliente )
            , 'CliCod'          = convert( numeric(5)  , Enc.CaCodigo )
            , 'CliDv'           = Convert( varchar(1)  , isnull( Cliente.ClDv, '' )   )
            , 'CliNom'  	= Convert( varchar(100), isnull( Cliente.ClNombre, 'Cliente no esta en BAC' ) )
            , 'Operador'        = Convert( varchar(15) , Enc.CaOperador )
            , 'OpcEstCod'       = Convert( varchar(2)  , Enc.CaCodEstructura )
            , 'OpcEstDsc'       = COnvert( Varchar(20) , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )   
            , 'NumComponente'       = convert( numeric(6)  , Fix.CaNumEstructura )
            , 'PayOffTipCod'        = convert( VarChar(2)  , Det.CaTipoPayOff ) 
            , 'PayOffTipDsc'        = Convert( VarChar(20) , PayOffTipo.PayOffTipDsc )          
            , 'CallPut'             = convert( VarChar(5)  , Det.CaCallPut )
            , 'CVOpcCod'            = Convert( varchar(3)  , Det.CaCVOpc )
            , 'CompraVentaOpcDsc'   = Convert( varchar(6)  , Case when Det.CaCVOpc = 'C' then 'Compra' else 'Venta' end )
            , 'FechaPagoEjer'       = Convert( datetime    , Det.CaFechaPagoEjer , 112 )
            , 'Mon1Cod'             = convert( numeric(5)  , Det.CaCodMon1 )
            , 'Mon1Dsc'             = convert( char(35)    , isnull( MonedaM1.MnGlosa, 'Moneda M1 no existe' )  )
            , 'MontoMon1'           = Convert( numeric(21,6) , Det.CaMontoMon1 )
            , 'Mon2Cod'             = convert( numeric(5)  , Det.CaCodMon2 )
            , 'Mon2Dsc'             = convert( char(35)    , isnull( MonedaM2.MnGlosa, 'Moneda M2 no existe' ) )
            , 'MontoMon2'           = Convert( numeric(21,6) , Det.CaMontoMon2 )
            , 'ModalidadCod'        = Convert( varchar(1)  , Det.CaModalidad )
            , 'ModalidadDsc'        = Convert( varchar(15) , case when Det.CaModalidad  = 'E' then 'Entrega Fis.' else 'Compensación' end  )
            , 'MdaCompensacionCod'  = Convert( numeric(5)  , CaMdaCompensacion ) 
            , 'MdaCompensacionDsc'  = convert( char(35)    , isnull( MdaComp.MnGlosa, 'Moneda Comp. no existe' )  )
            , 'Strike'              = convert( float, Det.CaStrike )
            , 'NumeroFijacion'      = Convert( numeric(6)  , Fix.CaFixNumero )
            , 'FechaFijacion'       = Convert( datetime    , Fix.cafixFecha , 112 )
            , 'PesoFijacion'        = Convert( float, Fix.CaPesoFij )
            , 'FixBenchCompCod'     = convert( numeric(5), Fix.CaFixBenchComp )
            , 'FixBenchCompDsc'     = convert( varchar(40),BenchFix.BenchMarkDescripcion )
            , 'FixBenchCompHora'    = convert( varchar(8) , BenchFix.BenchMarkHora, 108 ) 
            , 'FixBenchEsEditable'  = convert( varchar(1) , BenchFix.BenchEditable ) 
            , 'FixBenchMdaCodValorDef' = convert( numeric(5) , BenchFix.BenchMdaCodValorDef )
            , 'FixBenchMdaCodValorDefValor' = convert( float , 544.23 /*DefectoBench.vmvalor */ )  
            , 'FixParBench'         = convert( varchar(7) , Fix.CaFixParBench ) 
            , 'FixEstado'           = convert( varchar(1) , Fix.CaFixEstado ) 
            , 'FixValorFijacion'    = convert( float, Fix.CaFijacion )
            , 'EstadoEjercicioCod'  = convert( varchar(2) , isnull( 
                                               ( select CaCajEstado 
                                                            from LnkOpc.CbMdbOpc.dbo.CaCaja Caj 
                where Caj.CanumContrato   = Fix.CaNumContrato
                                                             and  Caj.CaNumEstructura = Fix.CaNumEstructura
                                                             and  Caj.CaCajOrigen     <> 'PP' ) , 'NE'   ) )
            , 'EstadoEjercicioDsc'  = convert( varchar(20), '' )
            , 'EstadoMotorPagoCod'     = convert( varchar(2) , isnull( 
                                                            ( select CaCajMotorPago 
  from LnkOpc.CbMdbOpc.dbo.CaCaja Caj 
                                                            where Caj.CanumContrato   = Fix.CaNumContrato
                                                             and Caj.CaNumEstructura = Fix.CaNumEstructura
                                                             and  Caj.CaCajOrigen     <> 'PP' ) , 'NE'   ) )
            , 'EstadoMotorPagoDsc'  = convert( varchar(20), '' )
            , 'Refijable'           = convert( varchar(10), 'RE-FIJABLE' )
            , 'Usuario'             = convert( varchar(15), @Usuario )
            , 'TipoTransaccion'     = convert( varchar(10), Enc.CaTipoTransaccion ) 
            , 'FechaContrato'       = Convert( datetime   , Enc.CaFechaContrato , 112 )
            , 'Estado'              = Convert( varchar(30) ,Estado.ConOpcEstDsc )
            , 'Contrapartida'       = Convert( varchar(8)  ,Enc.CaTipoContrapartida )
            , 'FechaCreacionRegistro' = convert( Datetime , Enc.CaFechaCreacionRegistro, 112 )
            , 'CarteraFinancieraCod'   = Convert( Varchar(6), Enc.CaCarteraFinanciera )
            , 'CarteraFinancieraDsc'   = Convert( Char(50)  , isnull( Financiera.tbglosa, 'Cartera Fin. no exite' ) )
            , 'CarteraNormativaCod'    = Convert( Varchar(6), Enc.CaCarNormativa )
            , 'CarteraNormativaDsc'    = Convert( Char(50)  , isnull( Normativa.tbglosa, 'Catera Normativa no existe' ) )
            , 'LibroCod'               = Convert( Varchar(6), Enc.CaLibro ) 
            , 'LibroDsc'               = Convert( Char(50)  , isnull( Libro.tbglosa, 'Libro no existe' ) )
            , 'AreaResponsalbleCod'    = Convert( VarChar(6), 6 )   -- Mesa de dinero siempre no tenemos el campo
            , 'AreaResponsalbleDsc'    = Convert( VarChar(50), isnull( Responsable.tbglosa, 'No existe area responsable' )  )   -- Mesa de dinero siempre no tenemos el campo
            , 'SubCarNormativaCod'     = Convert( VarChar(6), Enc.CaSubCarNormativa )
            , 'SubCarNormativaDsc'     = Convert( Varchar(50), isnull( SubCartera.tbglosa,  'Falto SubCarNormatica'  ) )
            , 'MonVrCod'               = Convert( numeric(5)  , Enc.CaMon_Vr )
            , 'MonVrDsc'               = Convert( Char(35)    , isnull( MonedaVr.MnGlosa, 'Moneda Vr no existe' ) )
            , 'Vr'                     = Convert( float       , Enc.CaVr )
            , 'Vr_Costo'               = Convert( float       , Enc.CaVr_Costo )
            , 'MonPagPrimaCod'         = Convert( numeric(5)  , Enc.CaCodMonPagPrima )
            , 'MonPagPrimaDsc'         = Convert( char(35)    , isnull( MonedaPrima.MnGlosa, 'Moneda Prima no existe' ) )
            , 'fPagoPrimaCod'          = Convert( NUMERIC(3)  , Enc.CafPagoPrima )
            , 'fPagoPrimaDsc'          = Convert( CHAR(30)    , isnull( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )  
            , 'PrimaInicial'           = Convert( float       , Enc.CaPrimaInicial )
            , 'FechaPagoPrima'         = Convert( datetime    , Enc.CaFechaPagoPrima,112)
            , 'MonPrimaTrfCod'         = Convert( numeric(5)  , Enc.CaMonPrimaTrf )
            , 'MonPrimaTrfDsc'         = Convert( char(35)    , isnull( MonedaPrimaTranf.MnGlosa, 'Moneda Prima Traf. no existe' ) )  
            , 'PrimaTranferencia'      = Convert( float       , Enc.CaPrimaTrf )
            , 'PrimaTranferenciaML'    = Convert( float       , Enc.CaPrimaTrfML )
            , 'MonPrimaCostoCod'       = Convert( numeric(5)  , Enc.CaMonPrimaCosto )
            , 'MonPrimaCostoDsc'       = Convert( char(35)    , isnull( MonedaPrimaCosto.MnGlosa, 'Moneda Prima Costo. no existe' )  )
            , 'PrimaCosto'             = Convert( float       , Enc.CaPrimaCosto )
            , 'PrimaCostoML'           = Convert( float       , Enc.CaPrimaCostoML )
            , 'MonPrimaCarryCod'       = Convert( numeric(5)  , Enc.CaMonCarryPrima )
            , 'MonPrimaCarryDsc'       = Convert( char(35)   , isnull( MonedaPrimaCarry.MnGlosa, 'Moneda Prima Carry. no existe' ) ) 
            , 'PrimaCarry'             = Convert( float       , Enc.CaCarryPrima )
            , 'Banco'                  = Convert( varchar(40) , @NombreBanco )
            , 'FechaUnwind'            = Convert( datetime    , Enc.CaFechaUnwind , 112 ) 
            , 'NominalUnwind'          = Convert( float       , isnull( Enc.CaNominalUnwind    , 0.0 ) ) 
            , 'UnwindMonCod'           = Convert( numeric(5) , isnull( Enc.CaUnwindMon, 0.0 ) )
            , 'UnwindMonDsc'           = Convert( Char(35)    , isnull( MonedaUnwind.MnGlosa, 'Moneda Unwind no existe' ) )
            , 'Unwind'                 = Convert( numeric(21,4), isnull( Enc.CaUnwind, 0.0 ) )
            , 'UnwindML'               = Convert( numeric(21,4), isnull( Enc.CaUnwindML, 0.0 ) )
            , 'FormPagoUnwindCod'      = Convert( numeric(3)   , isnull( Enc.CaFormPagoUnwind, 0.0 ) )
            , 'FormPagoUnwindDsc'      = Convert( char(30)     , isnull( FormaPagoUnwind.glosa, 'Forma Pago Unwind no existe' ) ) 
            , 'UnwindTransfMonCod'     = Convert( numeric(5)   , isnull( Enc.CaUnwindTransfMon, 0.0 ) ) 
            , 'UnwindTransfMonDsc'     = Convert( Char(35)     , isnull( MonedaUnwindTrf.MnGlosa, 'Moneda Traf. Unwind no existe' ) ) 
            , 'UnwindTransf'           = Convert( numeric(21,4), isnull( Enc.CaUnwindTransf, 0.0 ) )
            , 'UnwindTransfML'         = Convert( numeric(21,4), isnull( Enc.CaUnwindTransfML, 0.0 ) )
            , 'UnwindCosto'            = Convert( numeric(21,4), Enc.CaUnwindCosto )
            , 'UnwindCostoML'          = Convert( numeric(21,4), Enc.CaUnwindCostoML )
            , 'OpcTipCod'              = Convert( char(1)      , Det.CaTipoOpc )
            , 'OpcTipDsc'              = Convert( char(20)     , isnull( OpcionTipo.OpcTipDsc, 'No existe Tipo de Opción' ) )
            , 'SubyacenteCod'          = Convert( char(3)      , Det.CaSubyacente )
            , 'SubyacenteDsc'          = Convert( varchar(40)  , isnull( Subyacente.SubyacenteDescripcion, 'No existe Subyacente' ) )
            , 'NumEstructura'        = Convert( numeric(6)   , Det.CaNumEstructura )
            , 'TipoEmisionPTCod'       = Convert( varchar(3)   , Det.CaTipoEmisionPT )
            , 'TipoEmisionPTDsc'       = Convert( varchar(8)   , Case when Det.CaTipoEmisionPT = 'P' then 'Propia' else 'Terceros' end  )
            , 'FechaInicioOpc'         = Convert( datetime     , Det.CaFechaInicioOpc, 112 )
            , 'FechaFijacionOpc'       = Convert( datetime     , Det.CaFechaFijacion, 112 )
            , 'FechaVcto'              = Convert( datetime     , Det.CaFechaVcto, 112 )
            , 'IteAsoSisCod'           = Convert( char(3)      , Det.CaIteAsoSis )
            , 'IteAsoSisDsc'           = Convert( char(20)     , isnull( Sistema.Nombre_Sistema, 'N/A' ) )
            , 'FormaPagoMon1Cod'       = Convert( numeric(3)   , Det.CaFormaPagoMon1 )
            , 'FormaPagoMon1Dsc'       = Convert( char(30)     , FormaPagoM1.Glosa )
            , 'FormaPagoMon2Cod'       = Convert( numeric(3)   , Det.CaFormaPagoMon2 )
            , 'FormaPagoMon2Dsc'       = Convert( char(30)     , FormaPagoM2.Glosa )
            , 'FechaPagMon1'           = Convert( datetime     , Det.CaFechaPagMon1, 112 )
            , 'FechaPagMon2'           = Convert( datetime     , Det.CaFechaPagMon2, 112 )
            , 'Fijacion'               = Convert( float        , Fix.CaFijacion )
            , 'FixEstadoBenchDsc'      = Convert( varchar(12)  , Case when Fix.CaFixEstado = 'F' then 'Fijado' else 'No Fijado' end )
            , 'Observaciones'          = Convert( varchar(5000) , '' )
            , 'Firma1'		       = Convert( varchar(15) , @Firma1)	
            , 'Firma2'		  = Convert( varchar(15) , @Firma2)	
            , 'MtoImputacion'          = Convert( float       , CASE WHEN LinTrans.MonLinGenCli = 999 THEN ISNULL(LinTrans.Imputacion,0.0) /1  ELSE ISNULL(LinTrans.Imputacion,0.0) /ISNULL(LinTrans.TipoCambio,1.0)END)
            , 'MonLineaGenCli'         = Convert( numeric(5)  , LinTrans.MonLinGenCli ) 
            , 'MonLineaGenCliNemo'     = Convert( char(8)     , LinTrans.mnnemo)
            , 'EstadoPend'             = Convert( char(1)     , @EstadoP)
            , 'TCM_Prima'              = CONVERT( FLOAT,  (CASE WHEN Enc.CaPrimaInicial = 0 THEN 0.0 ELSE Enc.CaPrimaInicialML END)
                                                      / (CASE WHEN Enc.CaPrimaInicial = 0 THEN 1.0 ELSE Enc.CaPrimaInicial   END ) )
            , 'CompraVentaOpcEncDsc'   = Convert( varchar(6)  , Case when Enc.CaCVEstructura = 'C' then 'Compra' else 'Venta' end ) --ASVG_20110329 C/V Estructura desde encabezado.

      into #Fixing
      from LnkOpc.CbMdbOpc.dbo.CaFixing       Fix 
        LEFT JOIN   LnkOpc.CbMdbOpc.dbo.Benchmark BenchFix                    ON BenchFix.BenchMarkCod = Fix.CaFixBenchComp     
        LEFT JOIN   BacParamSuda.dbo.Valor_Moneda DefectoBench ON Fix.cafixFecha = DefectoBench.VmFecha and BenchFix.BenchMdaCodValorDef = DefectoBench.vmcodigo
           , LnkOpc.CbMdbOpc.dbo.CaDetContrato  Det
             LEFT JOIN     LnkOpc.CbMdbOpc.dbo.OpcionTipo OpcionTipo  ON Opciontipo.OpcTipCod    = Det.CaTipoOpc
             LEFT JOIN     LnkOpc.CbMdbOpc.dbo.Subyacente Subyacente  ON Subyacente.Subyacente   = Det.CaSubyacente 
             LEFT JOIN     LnkOpc.CbMdbOpc.dbo.PayOffTipo PayOffTipo  ON PayOffTipo.PayOffTipCod = Det.CaTipoPayOff 
             LEFT JOIN     BacParamSuda.dbo.Sistema_Cnt   Sistema     ON Sistema.Id_sistema      = Det.CaIteAsoSis
             LEFT JOIN     BacParamSuda.dbo.Forma_de_Pago FormaPagoM1 ON FormaPagoM1.Codigo      = Det.CaFormaPagoMon1
             LEFT JOIN     BacParamSuda.dbo.Forma_de_Pago FormaPagoM2 ON FormaPagoM2.Codigo      = Det.CaFormaPagoMon2
             LEFT JOIN     BacParamSuda.dbo.Moneda MonedaM1   ON MonedaM1.MnCodMon = Det.CaCodMon1
             LEFT JOIN     BacParamSuda.dbo.Moneda MonedaM2   ON MonedaM2.MnCodMon = Det.CaCodMon2
             LEFT JOIN     BacParamSuda.dbo.Moneda MdaComp    ON MdaComp.MnCodMon = Det.CaMdaCompensacion
                         , LnkOpc.CbMdbOpc.dbo.CaEncContrato Enc
                LEFT JOIN  BacParamSuda.dbo.Moneda MonedaVr                ON MonedaVr.MnCodMon         = Enc.CaMon_Vr
                LEFT JOIN  BacParamSuda.dbo.Moneda MonedaPrima             ON MonedaPrima.MnCodMon      = Enc.CaCodMonPagPrima
                LEFT JOIN  BacParamSuda.dbo.Moneda MonedaPrimaTranf        ON MonedaPrimaTranf.MnCodMon = Enc.CaMonPrimaTrf
                LEFT JOIN  BacParamSuda.dbo.Moneda MonedaPrimaCosto        ON MonedaPrimaCosto.MnCodMon = Enc.CaMonPrimaCosto
                LEFT JOIN  BacParamSuda.dbo.Moneda MonedaPrimaCarry        ON MonedaPrimaCarry.MnCodMon = Enc.CaMonCarryPrima
                LEFT JOIN  BacParamSuda.dbo.Moneda MonedaUnwindTrf         ON MonedaUnwindTrf.MnCodMon  = Enc.CaUnwindTransfMon               
                LEFT JOIN  BacParamSuda.dbo.Moneda MonedaUnwind            ON MonedaUnwind.MnCodMon     = Enc.CaUnwindMon
                LEFT JOIN  BacParamSuda.dbo.Forma_de_Pago FormaPagoUnwind  ON FormaPagoUnwind.Codigo    = Enc.CaFormPagoUnwind 
                LEFT JOIN  BacParamSuda.dbo.Forma_de_Pago FormaPagoPrima   ON FormaPagoPrima.Codigo     = Enc.CafPagoPrima 
                LEFT JOIN  BacParamSuda.dbo.Cliente Cliente    ON Cliente.ClRut = Enc.CaRutCliente and Cliente.ClCodigo = Enc.CaCodigo 
                LEFT JOIN  LnkOpc.CbMdbOpc.dbo.OpcionEstructura    Estructura ON Estructura.OpcEstCod = Enc.CaCodEstructura
        LEFT JOIN LnkOpc.CbMdbOpc.dbo.ConOpcEstado Estado     ON Estado.ConOpcEstCod = Enc.CaEstado
        LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Financiera  ON Financiera.tbcateg   = 204  AND Financiera.tbcodigo1  = Enc.CaCarteraFinanciera
        LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Normativa   ON Normativa.tbcateg    = 1111 AND Normativa.tbcodigo1   = Enc.CaCarNormativa
        LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Libro       ON Libro.tbcateg        = 1552 AND Libro.tbcodigo1 = Enc.CaLibro
        LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Responsable ON Responsable.tbcateg  = 1553 AND Responsable.tbcodigo1 = 6 -- No tenemos area responsable !!!
        LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE SubCartera  ON SubCartera.tbcateg   = 1554 AND SubCartera.tbcodigo1  = Enc.CaSubCarNormativa  
           , #TEMP_LINEA_TRANSACCION_OPT  LinTrans
      where  CaFixFecha >= @f1 and CaFixFecha <= @f2 
         and Det.CaNumContrato = Fix.CaNumContrato
         and Det.CaNumEstructura = Fix.CaNumEstructura 
         and Enc.CaNumContrato = Det.CaNumContrato
         and ( Enc.CanumContrato = @NumContrato or @NumContrato = 0 )
         and Fix.CaNumContrato   = LinTrans.NumeroOperacion

     
      EXEC Sp_Trae_Msj_Errores 'OPT', @NumContrato, @Observ OUTPUT    -- 08 Oct. 2009 - Si existen errores de lineas o limites los debe mostrar en papeleta


      IF exists( select (1) from #Fixing  ) BEGIN
          update #Fixing 
             set EstadoEjercicioDsc = case when EstadoEjercicioCod = 'NE' then 'No hay' 
                                           when EstadoEjercicioCod = 'E'  then 'Ejercido'
                                           when EstadoEjercicioCod = 'N'  then 'Cancelado'
                                           when EstadoEjercicioCod = 'P'  then 'Decisión Pendiente'
                                           else 'ERROR'
                                      end              
              ,  EstadoMotorPagoDsc = case when EstadoMotorPagoCod = 'P'  then 'Pendiente' 
                                           when EstadoMotorPagoCod = 'G'  then 'Generado en BAC' 
                                           when EstadoMotorPagoCod = 'NE' then 'No hay' 
                                           else 'ERROR' 
                                      end
              ,  Refijable          = Case when       FechaFijacion <= @FechaProceso 
                                                 and  EstadoEjercicioCod in ( 'P', 'NE' ) then 'FIJABLE' 
                                           else 'NO-FIJABLE' end 

              ,  Observaciones      =  convert( Varchar(5000),@Observ)  -- 08 Oct. 2009 


          select * 
               from #fixing order by NumCOntrato, NumComponente
     
      END
      ELSE
         -- Se despliega el registro Sin Datos.
         select * from   #Resultado        			

END 
GO
