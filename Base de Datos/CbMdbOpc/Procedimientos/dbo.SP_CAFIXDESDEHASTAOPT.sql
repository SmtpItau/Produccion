USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAFIXDESDEHASTAOPT]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CAFIXDESDEHASTAOPT](   @f1 datetime , @f2 datetime, @NumContrato numeric(10),  @Usuario Varchar(15) ) 
AS BEGIN			

     -- INSTRUCCIONES GENERALES DE MANTENCION
     -- Agregar el campo o modificar primero en la sección que genera el 
     -- Registro vacío
     -- Luego agregar o modificar el campo que corresponde en la sección de reuperación de datos
     -- Ejecutar y actualizar los reportes atachados a este sp.


     -- MAP 28 Septiembre 2009 Carga Parametros antes de Imprimir si no se ha hecho Nunca.


     -- Sp_CaFixDesdeHastaOpt '20140101', '20141216' , 0, 'MARIAS' 

     -- MAP: en ciert instancia enviaba RE-FIJABLE en vez de FIJABLE que es lo que
     -- procesa .net

     -- MAP-20130131 No se puede refijar si ya se generó caja, para repetir solicitar a Informatica que borre CaCaja y 
     -- posible entrega fisica en Baccambios y registro en motor de pagos SADP.

     SET NOCOUNT ON			
     Declare  @Nombre Char(120)
            , @Dv     Char(1)
            , @FechaProceso datetime

     select @FechaProceso = FechaProc from OpcionesGeneral

     declare @ErrorProc      numeric(2)
     declare @CargoParametro numeric(1)
     select  @CargoParametro = CargaParamSudaCierre from opcionesgeneral

     -- MAP 06 Octubre 2009
     -- Sp_ImportaDataBacParamSuda ahora retorna mensaje
     if @CargoParametro = 0 begin -- No ha ejecutado carga parametros BAc
        create table #MensajeParametros ( msg Varchar(300) )
        insert into #MensajeParametros
        Exec @ErrorProc  = Sp_ImportaDataBacParamSuda
     end

	 -- MAP AVISA QUE FALTAN FIJACIONES
	 declare @FaltaFijacionContrato numeric(10)
	 declare @FaltaFijacionFecha    datetime
	 declare @AVISO                 varchar(50)
	 select @FaltaFijacionContrato = 0
	 select   @FaltaFijacionContrato = Fix.CaNumContrato 
	        , @FaltaFijacionFecha = Fix.CaFixFecha
	    from CaFixing Fix 
	                         , OpcionesGeneral 
							 , CaEncContrato Enc 
	              where cafijacion = 0 
				    and caFixFecha < fechaproc 
					and Fix.Canumcontrato = Enc.CaNumContrato 
					and enc.CaEstado <> 'C'   
					and enc.CaCodEstructura <> 8
     select @AVISO = ''
	 if @FaltaFijacionContrato <> 0
	 Begin	    
	    select @AVISO = 'ERROR FIJACION CONT N° ' + convert( varchar(10), @FaltaFijacionContrato ) + ' '
		              + convert(  varchar(15), @FaltaFijacionFecha , 110 ) 

	 end


     -- Sección que genera el registro vacío.
     Select   'Pantalla'        = convert( Varchar(40) , 'FIJACION DE CONTRATOS VIGENTE' )
            , 'NumContrato'     = convert( numeric(8)  , 0 )
            , 'CliRut'  	= Convert( numeric(13) , 0 )
            , 'CliCod'          = convert( numeric(5)  , 0 )
            , 'CliDv'           = Convert( varchar(1)  , ''   )
            , 'CliNom'  	= Convert( varchar(100), case when @AVISO <> '' then @AVISO else 'NO HAY DATOS' end )
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
            , 'Strike'              = convert( float, 0.0 )
            , 'NumeroFijacion'      = Convert( numeric(6)  , 0 )
            , 'FechaFijacion'       = Convert( datetime    , '' , 112 )
            , 'PesoFijacion'        = Convert( float, 0.0 )
            , 'FixBenchCompCod'     = convert( numeric(5), 0 )
            , 'FixBenchCompDsc'     = convert( varchar(40), '' )
            , 'FixBenchCompHora'    = convert( varchar(8) , '00:00:00' ) 
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
            , 'Refijable'           = convert( varchar(10), 'NO-FIJABLE' )
            , 'Usuario'             = convert( varchar(15), '' )
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
            , 'ModalidadCod'        = Convert( varchar(1)  , Det.CaModalidad  )
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
            , 'FixBenchMdaCodValorDefValor' = convert( float , isnull( DefectoBench.vmvalor , 0 ) )  
, 'FixParBench'         = convert( varchar(7) , Fix.CaFixParBench ) 
            , 'FixEstado'           = convert( varchar(1) , Fix.CaFixEstado ) 
            , 'FixValorFijacion'    = convert( float, Fix.CaFijacion )
            , 'EstadoEjercicioCod'  = convert( varchar(2) , isnull( 
                                                            ( select CaCajEstado 
                                                            from CaCaja Caj 
                where Caj.CanumContrato   = Fix.CaNumContrato
                                                             and  Caj.CaNumEstructura = Fix.CaNumEstructura
                                                             and  Caj.CaCajOrigen     <> 'PP' ) , 'NE'   ) )
            , 'EstadoEjercicioDsc'  = convert( varchar(20), '' )
            , 'EstadoMotorPagoCod'     = convert( varchar(2) , isnull( 
                                                            ( select CaCajMotorPago 
                                                            from CaCaja Caj 
                                                            where Caj.CanumContrato   = Fix.CaNumContrato
                                                             and  Caj.CaNumEstructura = Fix.CaNumEstructura
                                                             and  Caj.CaCajOrigen     <> 'PP' ) , 'NE'   ) )
            , 'EstadoMotorPagoDsc'  = convert( varchar(20), '' )
            , 'Refijable'           = convert( varchar(10), 'FIJABLE' )
            , 'Usuario'             = convert( varchar(15), @Usuario )

      into #Fixing
      from CaFixing       Fix 
        LEFT JOIN   Benchmark BenchFix                    ON BenchFix.BenchMarkCod = Fix.CaFixBenchComp     
        LEFT JOIN   BacParamSudaValor_Moneda DefectoBench ON Fix.cafixFecha = DefectoBench.VmFecha and BenchFix.BenchMdaCodValorDef = DefectoBench.vmcodigo
           , CaDetContrato  Det
             LEFT JOIN     PayOffTipo               ON PayOffTipo.PayOffTipCod = Det.CaTipoPayOff 
-- POR HACER: cambiar a BDOpciones.BacParamMoneda
             LEFT JOIN     lnkbac.BacParamSuda.dbo.Moneda MonedaM1   ON MonedaM1.MnCodMon = Det.CaCodMon1
             LEFT JOIN     lnkbac.BacParamSuda.dbo.Moneda MonedaM2   ON MonedaM2.MnCodMon = Det.CaCodMon2
             LEFT JOIN     lnkbac.BacParamSuda.dbo.Moneda MdaComp   ON MdaComp.MnCodMon = Det.CaMdaCompensacion
             , CaEncContrato Enc
                LEFT JOIN BacParamSudaCliente Cliente    ON Cliente.ClRut = Enc.CaRutCliente and Cliente.ClCodigo = Enc.CaCodigo 
                LEFT JOIN OpcionEstructura    Estructura ON Estructura.OpcEstCod = Enc.CaCodEstructura
      where  CaFixFecha >= @f1 and CaFixFecha <= @f2 
         and Det.CaNumContrato = Fix.CaNumContrato
         and Det.CaNumEstructura = Fix.CaNumEstructura 
         and Enc.CaNumContrato = Det.CaNumContrato
         and ( Enc.CanumContrato = @NumContrato or @NumContrato = 0 )


      IF exists( select (1) from #Fixing  ) and @AVISO = '' BEGIN
          update #Fixing 
             set EstadoEjercicioDsc = case when EstadoEjercicioCod = 'NE' then 'No hay' 
                                           when EstadoEjercicioCod = 'E'  then 'Ejercido'
                                           when EstadoEjercicioCod = 'N'  then 'Cancelado'
                                           when EstadoEjercicioCod = 'P'  then 'Decisión Pendiente'
                                           else 'ERROR'
                                      end
                                      -- Motor de pagos es solo informativo
              ,  EstadoMotorPagoDsc = case when EstadoMotorPagoCod = 'P'  then 'Pendiente'
                                           when EstadoMotorPagoCod = 'G'  then 'Generado en BAC'
                                 when EstadoMotorPagoCod = 'NE' then 'No hay'
                                           else 'ERROR'
                                      end
             -- Se puede fijar si la fecha fijacion es futura 
                                      -- y  CaCaja esta con estado 'P' o no existe 
			   ,  Refijable          = Case when       FechaFijacion <= @FechaProceso 
									 and  EstadoEjercicioCod in ( 'P', 'NE' )                                   
									 and  NumContrato not in ( select CaNumContrato  from CaCaja where CaCaja.CaNumContrato = NumContrato and CaCaja.CaCajOrigen <> 'PP' ) -- MAP-20130131
						   then 'FIJABLE'
						   else 'NO-FIJABLE' end 

          select * 
               from #fixing order by NumCOntrato, NumComponente
     
      END
      ELSE
         -- Se despliega el registro Sin Datos.
         select * from   #Resultado        			

END
GO
