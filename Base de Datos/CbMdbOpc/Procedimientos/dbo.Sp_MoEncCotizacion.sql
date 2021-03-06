USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MoEncCotizacion]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[Sp_MoEncCotizacion]( @CliRut numeric(10) , @CliCodigo numeric(1) ) AS BEGIN			
     SET NOCOUNT ON 			
     
     Declare  @Nombre Char(120)
            , @Dv     Char(1)
            , @FechaProceso datetime

     select @FechaProceso = fechaproc from opcionesgeneral

     -- Sp_MoEncCotizacion   99565970, 1
     -- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente

     select * into #Moneda  from bacparamsuda.dbo.Moneda

     -- Reducir el contenido de la tabla Cliente
     select * into #Cliente from bacparamsuda.dbo.View_ClienteParaOpc  
     where ( @CliRut = 0 and ClRut in ( select MoRutCliente from MoEncContrato )  )
        or ( @CliRut <> 0 and ClRut = @CliRut and ClCodigo = @CliCodigo )

     -- Validar si existe el cliente que viene del parámetro
     select @Nombre = ''
     if @CliRut <> 0  select @Nombre = 'Cliente no existe, crear en BAC'
     select @Nombre = ClNOmbre from #Cliente where @CliRut <> 0 and ClRut = @CliRut and ClCodigo = @CliCodigo 


     Select   'NumContrato'     	= Convert( numeric(8)  , Movimiento.MoNumContrato ) 
            , 'NumFolio'        	= Convert( numeric(8)  , Movimiento.MoNumFolio )
            , 'CliNom'  		= Convert( varchar(100), isnull( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )
            , 'OpcEstDsc'       	= Convert( varchar(20) , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) ) 
            , 'Operador'        	= Convert( varchar(15) , Movimiento.MoOperador )
            , 'Objeto'          	= Convert( varchar(40) , 'CONSULTA COTIZACIONES' )
            , 'CliCod'          	= Convert( numeric(5)  , Movimiento.MoCodigo )
            , 'CliRut'  		= Convert( numeric(13) , Movimiento.MoRutCliente )
            , 'CliDv'           	= Convert( varchar(1)  , isnull( Cliente.ClDv, ' '   ) )
            , 'OpcEstCod'       	= Convert( varchar(2)  , Movimiento.MoCodEstructura  )
            , 'FechaCreacionRegistro' 	= Convert( datetime    , Movimiento.MoFechaCreacionRegistro,112)
            , 'FechaContrato'   	= Convert( datetime    , Movimiento.MoFechaContrato,112)
        
        Into #Encabezado
  
        from  MoEncContrato Movimiento
              left join #Cliente Cliente            on Movimiento.MoRutCliente     = Cliente.ClRut and Movimiento.MoCodigo = Cliente.ClCodigo
              left join OpcionEstructura Estructura on Estructura.OpcEstCod        = Movimiento.MoCodEstructura 
              left join ConOpcEstado     Estado     on Estado.ConOpcEstCod         = Movimiento.MoEstado
        -- Filtros del procedimiento
        where (   ( @CliRut = 0 and ClRut in ( select MoRutCliente from MoEncContrato )  )
               or ( @CliRut <> 0 and ClRut = @CliRut and ClCodigo = @CliCodigo )
              ) And Movimiento.MoEstado = 'C'
                And Movimiento.MoFechaCreacionRegistro >= @FechaProceso 
        -- select 'Debug', * from #Encabezado

     if exists( select (1) from #encabezado )
	     Select * from #encabezado
     else
	select 'NumContrato'     	= Convert( numeric(8)  , 0 ) 
            , 'NumFolio'        	= Convert( numeric(8)  , 0 )
            , 'CliNom'  		= Convert( varchar(100),  'NO HAY COTIZACIONES PARA CLIENTE'    )
            , 'OpcEstDsc'       	= Convert( Varchar(20) , ' ' )  
            , 'Operador'        	= Convert( varchar(15) , ' ' )
            , 'Objeto'          	= Convert( varchar(40) , 'CONSULTA COTIZACIONES' )
            , 'CliCod'          	= Convert( numeric(5)  , 0 )
            , 'CliRut'  		= Convert( numeric(13) , 0 )
            , 'CliDv'           	= Convert( varchar(1)  ,  ' '    )
            , 'OpcEstCod'       	= Convert( varchar(2)  , '  '  )
            , 'FechaCreacionRegistro' 	= Convert( datetime , '19000101 00:00:00',112)
            , 'FechaContrato'   	= Convert( datetime    , '19000101' ,112)

     			
END

GO
