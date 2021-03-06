USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MoEncAnticipos]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- Sp_MoEncAnticipos 0, 0, '', '20080101', '20080101', '20080101', '20080101'
-- Sp_MoEncAnticipos 1, 1, '', '20080101', '20080101', '20080101', '20080101'
CREATE PROC [dbo].[Sp_MoEncAnticipos] ( @CliRut numeric(10) , @CliCodigo numeric(1), @Estado varchar(2), @fContratoIni datetime, @fContratoFin datetime, @fEjercicioIni datetime, @fEjercicioFin datetime  ) AS BEGIN			
     SET NOCOUNT ON 			

     Declare  @Nombre Char(120)
            , @Dv     Char(1)
            , @FechaProceso datetime

     Select * 
     into #MoEncContrato from MoEncContrato   
     where MoTipoTransaccion = 'ANTICIPA'        
     union
     select * from MoHisEncContrato
     where MoTipoTransaccion = 'ANTICIPA'       

     select * into #Formas_Pago  from LNKBAC.bacparamsuda.dbo.Forma_de_Pago 

     select * into #Moneda  from LNKBAC.bacparamsuda.dbo.Moneda

     -- Reducir el contenido de la tabla Cliente
     -- Solo seleccionar clientes con algun movimiento
     select * into #Cliente from LNKBAC.bacparamsuda.dbo.Cliente  
     where ( @CliRut = 0 and ClRut in ( select MoRutCliente from MoEncContrato
                                     union select MoRutCliente from MoHisEncContrato )  )
        or ( @CliRut <> 0 and ClRut = @CliRut and ClCodigo = @CliCodigo )

     -- Validar si existe el cliente que viene del parámetro
     select @Nombre = ''
     if @CliRut <> 0  select @Nombre = 'Cliente no existe, crear en BAC'
     select @Nombre = ClNOmbre from #Cliente where @CliRut <> 0 and ClRut = @CliRut and ClCodigo = @CliCodigo 


     Select   'Objeto'          = convert( varchar(40) , 'CONSULTA ANTICIPOS' )
            , 'NumContrato'     = convert( numeric(8)  , Movimiento.MoNumContrato ) 
            , 'TipoTransaccion' = convert( Varchar(10) , Movimiento.MoTipoTransaccion )
            , 'NumFolio'        = convert( numeric(8)  , Movimiento.MoNumFolio )
            , 'FechaContrato'   = convert( datetime    , Movimiento.MoFechaContrato,112)
            , 'ConOpcEstCod'	= Convert( varchar(1)  , Movimiento.MoEstado )
            , 'ConOpcEstDsc'    = Convert( varchar(30) , isnull( Estado.ConOpcEstDsc,  'Estado no Existe' ) )
            , 'CliRut'  	= Convert( numeric(13) , Movimiento.MoRutCliente )
            , 'CliCod'          = convert( numeric(5)  , Movimiento.MoCodigo )
            , 'CliDv'           = Convert( varchar(1)  , isnull( Cliente.ClDv, ' '   ) )
            , 'CliNom'  	= Convert( varchar(100), isnull( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )
            , 'Operador'        = Convert( varchar(15) , Movimiento.MoOperador )
            , 'OpcEstCod'       = Convert( varchar(2)  , Movimiento.MoCodEstructura  )
            , 'OpcEstDsc'       = COnvert( Varchar(20) , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )  
            , 'Contrapartida'   = Convert( varchar(8)  , Movimiento.MoTipoContrapartida )
            , 'NominalUnwind'   = Convert( numeric(21,4) , Movimiento.MoNominalUnwind )
            , 'UnwindMon'	= Convert( numeric(5), Movimiento.MoUnwindMon )
            , 'UnwindMonDsc'    = Convert( char(35), isnull( MonedaUnwind.MnGlosa, 'Moneda Anticipo no existe' ) )
            , 'Unwind'          = Convert( numeric(21,4) , Movimiento.MoUnwind )
            , 'UnwindML'        = Convert( numeric(21), Movimiento.MoUnwindML )
            , 'FormPagoUnwind'      = Convert( numeric(5), Movimiento.MoFormPagoUnwind )
            , 'FormPagoUnwindDsc'   = Convert( char(30)  , isnull( FormaPagoUnwind.Glosa , 'Forma Pago Ant. no existe' ) )
            , 'UnwindTransfMon'     = Convert( numeric(5) , Movimiento.MoUnwindTransfMon )
            , 'UnwindTransfMonDsc'  = Convert( char(35), isnull( MonedaUnwindTrf.MnGlosa, 'Moneda Tranf Anticipo no existe' ) )
            , 'UnwindTransf'        = Convert( numeric(24,4), Movimiento.MoUnwindTransf )
            , 'UnwindTransfML'      = Convert( numeric(21), Movimiento.MoUnwindTransfML )
            , 'UnwindCostoMon'    = Convert( numeric(5), Movimiento.MoUnwindCostoMon )
            , 'UnwindCostoMonDsc' = Convert( char(35), isnull( MonedaUnwindCos.MnGlosa, 'Moneda Costo Anticipo no existe' ) )
            , 'UnwindCosto'     = Convert( numeric(24,4), Movimiento.MoUnwindCosto )
            , 'MoUnwindCostoML'  = Convert( numeric(21), Movimiento.MoUnwindCosto )
    
        Into #Encabezado
  
        from  #MoEncContrato Movimiento
              left join #Cliente Cliente            on Movimiento.MoRutCliente     = Cliente.ClRut and Movimiento.MoCodigo = Cliente.ClCodigo
              left join OpcionEstructura Estructura on Estructura.OpcEstCod        = Movimiento.MoCodEstructura 
              left join ConOpcEstado     Estado     on Estado.ConOpcEstCod         = Movimiento.MoEstado
              LEFT JOIN  #Moneda         MonedaUnwind ON MonedaUnwind.MnCodMon     = Movimiento.MoUnwindMon
              LEFT JOIN  #Formas_Pago    FormaPagoUnwind ON FormaPagoUnwind.Codigo   = Movimiento.MoFormPagoUnwind
              LEFT JOIN  #Moneda         MonedaUnwindTrf ON MonedaUnwindTrf.MnCodMon = Movimiento.MoUnwindTransfMon
              LEFT JOIN  #Moneda         MonedaUnwindCos ON MonedaUnwindCos.MnCodMon = Movimiento.MoUnwindCostoMon
        -- Filtros del procedimiento  
        where ( @CliRut = 0   )
           or ( @CliRut <> 0 and ClRut = @CliRut and ClCodigo = @CliCodigo )

        -- select 'Debug', * from #Encabezado

     if exists( select (1) from #encabezado )
	     Select * from #encabezado
     else
	select 'Objeto'          = convert( varchar(40) , 'CONSULTA CARTERA SIN DATOS' )
            , 'NumContrato'     = convert( numeric(8)  , 0 ) 
            , 'TipoTransaccion' = convert( Varchar(10) , ' ' )
            , 'NumFolio'        = convert( numeric(8)  , 0 )
            , 'FechaContrato'   = convert( datetime    , '19000101' ,112)
            , 'ConOpcEstCod'	= Convert( varchar(1)  , ' ' )
            , 'ConOpcEstDsc'    = Convert( varchar(30) , ' ' )
            , 'CliRut'  	= Convert( numeric(13) , 0 )
            , 'CliCod'          = convert( numeric(5)  , 0 )
            , 'CliDv'           = Convert( varchar(1)  ,  ' '    )
            , 'CliNom'  	= Convert( varchar(100),  ' '    )
            , 'Operador'        = Convert( varchar(15) , ' ' )
            , 'OpcEstCod'       = Convert( varchar(2)  , '  '  )
            , 'OpcEstDsc'       = COnvert( Varchar(20) , ' ' )  
            , 'Contrapartida'   = Convert( varchar(8)  , ' ' )
            , 'NominalUnwind'   = Convert( numeric(21,4) , 0.0 )
            , 'UnwindMon'	= Convert( numeric(5), 0 )
            , 'UnwindMonDsc'    = Convert( char(35), ''  )
            , 'Unwind'          = Convert( numeric(21,4) , 0.0 )
            , 'UnwindML'        = Convert( numeric(21), 0 )
            , 'FormPagoUnwind'      = Convert( numeric(5), 0 )
            , 'FormPagoUnwindDsc'   = Convert( char(30)  , ' ' )
            , 'UnwindTransfMon'     = Convert( numeric(5) , 0 )
            , 'UnwindTransfMonDsc'  = Convert( char(35), '' )
            , 'UnwindTransf'        = Convert( numeric(24,4), 0.0 )
            , 'UnwindTransfML'      = Convert( numeric(21), 0 )
            , 'UnwindCostoMon'      = Convert( numeric(5), 0 )
            , 'UnwindCostoMonDsc'   = Convert( char(35), ''  )
            , 'UnwindCosto'         = Convert( numeric(24,4), 0 )
            , 'MoUnwindCostoML'  = Convert( numeric(21), 0 )
     			
END

GO
