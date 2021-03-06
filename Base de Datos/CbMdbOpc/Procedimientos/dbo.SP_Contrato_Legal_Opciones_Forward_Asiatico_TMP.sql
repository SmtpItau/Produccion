USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_Contrato_Legal_Opciones_Forward_Asiatico_TMP]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_Contrato_Legal_Opciones_Forward_Asiatico_TMP]
   (   
       @Usuario      VarChar(15) 
     , @RutRepCli01 numeric(9) = 0 
     , @RutRepCli02 numeric(9) = 0 
     , @RutRepBan01 numeric(9) = 0 
     , @RutRepBan02 numeric(9) = 0 
     , @Grupo       numeric(8) 

   )
AS 
BEGIN

     -- INSTRUCCIONES GENERALES DE MANTENCION
     -- @RutRep01 numeric(9) , @RutRep02 numeric(9) corresponden a los rut de rep legales
     -- que puede que no haya.

     /* truncate table IMPRESION
	select * from caencContrato
	SELECT * FROM IMPRESION ORDER BY IMPGRUPO
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7000, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7000, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7001, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7002, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7004, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7005, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7007, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7008, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7009, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7010, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7011, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7012, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7016, 'MARIAS' 
        SP_Contrato_Legal_Opciones_Forward_Asiatico  7018, 'MARIAS' 

        SP_Contrato_Legal_Opciones  8011, 'MARIAS'
SP_Contrato_Legal_Opciones  8000, 'MARIAS' 

    /*  --  Prueba con Contratos vencidos
        select ImpGrupo from impresion where ImpNumContrato in ( select canumcontrato from caVenEncContrato ) 
        order by ImpGrupo desc   
        SP_Contrato_Legal_Opciones_TMP 'XX', 0, 0, 0, 0, 420

        --  Prueba con Contratos vencidos
        select ImpGrupo from impresion where ImpNumContrato in ( select canumcontrato from caEncContrato )
        order by ImpGrupo desc
        sp_Contrato_Legal_Opciones_TMP 'XX', 0, 0, 0, 0, 558
        sp_Contrato_Legal_Opciones 'XX', 0, 0, 0, 0, 558
    */






     */
     -- Idea: utilizar distinct y tablas verticales ( si existen )

     -- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente

     SET NOCOUNT ON			

     -- Pora hacer por elegancia: generalizar con @@DATEFIRST cualquiera
     set DATEFIRST 7


     Declare  @Nombre Char(120)
            , @Rut    Numeric(9)
            , @Dv     Char(1)
            , @FechaProceso datetime
            , @Domicilio VarChar( 50 )
            , @Fax       VarChar( 100 )
            , @Fono       VarChar(100)
            , @Codigo     Numeric( 2 )
            

     select  @FechaProceso = FechaProc
           , @Nombre       = nombre  
           , @Rut          = rut 
           , @Domicilio    = direccion
           , @Fono         = telefono
           , @Fax          = Fax            
           , @Codigo       = 1
           from OpcionesGeneral   

     select @Dv = ClDv, @Fax = ClFax from LnkBac.BacParamSuda.dbo.VIEW_CLIENTEParaOpc
     where clrut = @Rut

     -- Sección que genera el registro vacío.
     Select   'Reporte'         = convert( Varchar(40) , 'CONTRATO LEGAL' )
            , 'TipReg'          = Convert( Varchar(10), 'VACIO'  )
            , 'NumContrato'     = convert( numeric(8)  , 0 )
            , 'CliRut'  	= Convert( numeric(13) , 0 )
            , 'CliCod'          = convert( numeric(5)  , 0 )
            , 'CliDv'           = Convert( varchar(1)  , ''   )
            , 'CliNom'  	= Convert( varchar(100), 'NO HAY DATOS' )
            , 'Operador'        = Convert( varchar(15) , '' )
            , 'OpcEstCod'       = Convert( varchar(2)  , '' )
            , 'OpcEstDsc'       = COnvert( Varchar(30) , '' )  
            , 'OpcCompraEstrucutura'= Convert( varchar(100),  ''  )
            , 'OpcVendeEstrucutura' = Convert( varchar(100),  ''  )
            , 'NumComponente'       = convert( numeric(6)  , 0 )
            , 'PayOffTipCod'        = convert( VarChar(2)  , '' )
            , 'PayOffTipDsc'        = Convert( VarChar(20) , '' )
            , 'CallPut'             = convert( VarChar(5)  , '' )
            , 'CVOpcCod'            = Convert( varchar(3)  , '' )
            , 'CompraVentaOpcDsc'   = Convert( varchar(6)  , '' )
            , 'FechaContrato'       = Convert( datetime    , '' , 112 )
            , 'FechaPagoEjer'       = Convert( datetime    , '' , 112 )
            , 'FechaVcto'  = Convert( datetime    , '' , 112 )
            , 'FechaCG'             = Convert( datetime    , '' , 112 )
            , 'ChkFechaCG'          = Convert( char(1)     , 'N')
            , 'FechaCGComp'         = Convert( datetime    , '' , 112 )
            , 'ChkFechaCGComp'      = Convert( numeric(1)  , 0)
            , 'FechaCGSup'          = Convert( datetime    , '' , 112 )
            , 'ChkFechaCGSup'       = Convert( numeric(1)  , 0)
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
            , 'Refijable'           = convert( varchar(10), 'RE-FIJABLE' )
            , 'Usuario'             = convert( varchar(15), '' )
            , 'Anno'                = convert( Varchar(4) , '2000' )
            , 'Banco'               = convert( VarChar(16), substring( @Nombre, 1, 16 ) )
            , 'Rut'                 = Convert( Numeric(9) , @Rut )
            , 'Dv'                  = Convert( VARCHAR(1) , @Dv )
            , 'FechaContratoLarga'  = convert( VarChar(30), '01 de Enero del año 1900' )   
            , 'FechaCondGeneLarga'  = convert( VarChar(30), '01 de Enero del año 1900' )  
            , 'FechaCondGeneOpcLarga' = convert( VarChar(30), '01 de Enero del año 1900' )
            , 'FechaCondGeneOpcSupLarga' = Convert( VarChar(30), '01 de Enero del año 1900' ) 
            , 'TipoEjercicioCod'    = Convert( varchar(1),  ' ' ) 
            , 'TipoEjercicioDsc'    = Convert( Varchar(10) , 'AMERICANA' )
            , 'PrecioSuperior'      = Convert( float, 0.0 )
            , 'PrecioMedio'         = Convert( float, 0.0 )
            , 'PrecioPiso'          = Convert( Float, 0.0 )
            , 'MtoPrima'            = Convert( Float, 0.0 )  
            , 'FormaPagoPrimaCod'   = Convert( numeric(3) , 0 )  
            , 'FormaPagoPrimaDsc'   = convert( CHAR(30)   , '' ) 
            , 'MdaPagoPrimaCod'     = Convert( numeric(5), 0 ) 
            , 'MdaPagoPrimaDsc'     = Convert( char(35)   , ''   ) 
            , 'FechaPagoPrima'      = Convert( datetime, '19000101' )   

            , 'ApoderadoClienteRut01'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoClienteDv01'          = Convert( Varchar(1)  , 0 )
            , 'ApoderadoClienteNombre01'     = Convert( Varchar(100), '' )
            , 'ApoderadoClienteDomicilio01'   = Convert( Varchar(100), '' )
            , 'ApoderadoClienteFax01'         = Convert( Varchar(50) , '' ) 
            , 'ApoderadoClienteFono01'        = Convert( VarChar(50) , '' )

            , 'ApoderadoBancoRut01'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoBancoDv01'     = Convert( Varchar(1)  , '' )
            , 'ApoderadoBancoNombre01'      = Convert( Varchar(100), '' )
            , 'ApoderadoBancoDomicilio01'   = Convert( Varchar(100), '' )
            , 'ApoderadoBancoFax01'         = Convert( Varchar(50) , '' ) 
            , 'ApoderadoBancoFono01'        = Convert( VarChar(50) , '' ) 
/* Por mientras uno de cada parte
            , 'ApoderadoClienteRut02'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoClienteDv02'          = Convert( Varchar(1)  , 0 )
            , 'ApoderadoClienteNombre02'      = Convert( Varchar(100), '' )
            , 'ApoderadoClienteDomicilio02'   = Convert( Varchar(100), '' )
            , 'ApoderadoClienteFax02'         = Convert( Varchar(50) , '' ) 

            , 'ApoderadoBancoRut02'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoBancoDv02'          = Convert( Varchar(1)  , '' )
            , 'ApoderadoBancoNombre02'      = Convert( Varchar(100), '' )
            , 'ApoderadoBancoDomicilio02'   = Convert( Varchar(100), '' )
            , 'ApoderadoBancoFax02'         = Convert( Varchar(50) , '' ) 

*/       
            , 'MtoPrecioSuperior'      = Convert( float, 0.0 )
            , 'MtoPrecioMedio'         = Convert( float, 0.0 )
            , 'MtoPrecioPiso'          = Convert( Float, 0.0 )

            , 'ReceptorPrima'          = convert( varchar(100), '' )
            , 'PagadorPrima'           = convert( varchar(100), '' )
            , 'Control'                = convert( varchar(500), '' )
 
            INTO #Resultado -- Genera tabla con el registro vacío

            CREATE INDEX INumContrato ON #Resultado(NumContrato,NumComponente ) 


    -- Acopio de todos los contratos (incluso los vencidos)
    select * into #CaEncContrato
    from CaEncContrato
    union
    select * from CaVenEnccontrato

    select * into #CaDetContrato
    from CaDetContrato
    union
    select * from CaVenDetContrato

    select * into #CaFixing
    from CaFixing
    union
    select * from CaVenFixing

    select * into #CaCaja
    from CaCaja
    union
    select * from CaVenCaja
    -- Acopio de todos los contratos (incluso los vencidos)




      -- Estrategria
      -- Cargar tabla con los datos Fixing por fecha
      -- mediante update aplicar los datos de:
      -- CaEncContrato, CaDetContrato, CaVenEncContrato y CaVenEncContrato
      -- por ahora tratar de mantener información historica junto con 
      -- la vigente, si el desempeño no mejora separamos la cosa.
      Select distinct
              'Reporte'        = convert( Varchar(40) , 'CONTRATO LEGAL' )
            , 'TipReg'          = Convert( Varchar(10), 'CONTRATO'  )
            , 'NumContrato'     = convert( numeric(8)  , Fix.CaNumContrato )
            , 'CliRut'  	= Convert( numeric(13) , Enc.CaRutCliente )
            , 'CliCod'          = convert( numeric(5)  , Enc.CaCodigo )
            , 'CliDv'           = Convert( varchar(1)  , isnull( Cliente.ClDv, '' )   )
            , 'CliNom'  	= Convert( varchar(100), isnull( Cliente.ClNombre, 'Cliente no esta en BAC' ) )
            , 'Operador'        = Convert( varchar(15) , Enc.CaOperador )
            , 'OpcEstCod'       = Convert( varchar(2)  , Enc.CaCodEstructura )
            , 'OpcEstDsc'       = COnvert( Varchar(30) , isnull(  Estructura.OpcEstDsc  , 'Estructura no Existe'  ) )  
            , 'OpcCompraEstrucutura'= Convert( varchar(100), Case when CaCVEstructura = 'C' then @Nombre else Cliente.ClNombre end )
            , 'OpcVendeEstrucutura' = Convert( varchar(100), Case when CaCVEstructura = 'C' then Cliente.ClNombre else @Nombre end )
            , 'NumComponente'       = convert( numeric(6)  , Case when Det.CaVinculacion = 'Estructura'
                                                                    then 0 else Fix.CaNumEstructura end )
            , 'PayOffTipCod'        = convert( VarChar(2)  , Det.CaTipoPayOff ) 
            , 'PayOffTipDsc'        = Convert( VarChar(20) , upper( PayOffTipo.PayOffTipDsc ) )          
            , 'CallPut'             = convert( VarChar(5)  , upper( Case when Det.CaVinculacion = 'Estructura'
                                                                    then 'N/A' 
                                                                    else Det.CaCallPut End ) )
            , 'CVOpcCod'            = Convert( varchar(3)  , Case when Det.CaVinculacion = 'Estructura'
                                    then 'N/A' 
                                                                    else Det.CaCVOpc end )
            , 'CompraVentaOpcDsc'   = Convert( varchar(6)  , Case when Det.CaVinculacion = 'Estructura'
                                                                    then 'N/A' 
                                                                    else case when Det.CaCVOpc = 'C' 
                                                                              then 'Compra' 
                                                                              else 'Venta' end end )
            , 'FechaContrato'       = Convert( datetime    , Enc.CaFechacontrato , 112 ) 
            , 'FechaPagoEjer'       = Convert( datetime    , Det.CaFechaPagoEjer , 112 )
            , 'FechaVcto'           = Convert( datetime    , Det.CaFechaVcto , 112 )
            , 'FechaCG'             = Convert( datetime    , Cliente.clFechaFirma_cond , 112 )
            , 'ChkFechaCG'          = Convert( char(1)     , isnull(clCondicionesGenerales, 'N'))
            , 'FechaCGComp'         = Convert( datetime    , isnull( ( select clFechaFirma_cond_Opc 
                                                                       from breakBacParamSudaCLIENTE CGOp
                                                                       where CGOp.ClRut = Cliente.ClRut 
                                                                           and CGOp.ClCodigo = Cliente.ClCodigo
                                                                      ), '19000101' ) 
                                                                     , 112 )
            , 'ChkFechaCGComp'      = Convert( numeric(1)  , isnull(( select clFechaFirma_cond_OpcChk 
                                                                       from breakBacParamSudaCLIENTE CGOp
                                                                       where CGOp.ClRut = Cliente.ClRut 
                                                                           and CGOp.ClCodigo = Cliente.ClCodigo
                                                                      ),0))
            , 'FechaCGSup'         = Convert( datetime    , isnull( ( select clFechaFirma_Supl_Opc 
                                                                       from breakBacParamSudaCLIENTE CGOp
                                                                       where CGOp.ClRut = Cliente.ClRut 
                                                                           and CGOp.ClCodigo = Cliente.ClCodigo
                                                                      ), '19000101' ) 
                                                                     , 112 )   

            , 'ChkFechaCGSup'      = Convert( numeric(1)  , isnull(( select clFechaFirma_Supl_OpcChk
                                                                       from breakBacParamSudaCLIENTE CGOp
                                                                       where CGOp.ClRut = Cliente.ClRut 
                                                                           and CGOp.ClCodigo = Cliente.ClCodigo
                                                                      ),0))
            , 'Mon1Cod'             = convert( numeric(5)  , Det.CaCodMon1 )
            , 'Mon1Dsc'             = convert( char(35)    , isnull( MonedaM1.MnGlosa, 'Moneda M1 no existe' )  )
            , 'MontoMon1'           = Convert( numeric(21,6) , Det.CaMontoMon1 )
            , 'Mon2Cod'             = convert( numeric(5)  , Det.CaCodMon2 )
   , 'Mon2Dsc'             = convert( char(35)    , isnull( MonedaM2.MnGlosa, 'Moneda M2 no existe' ) )
            , 'MontoMon2'           = Convert( numeric(21,6) , Case when Det.CaVinculacion = 'Estructura'
                                                                    then 0 else Det.CaMontoMon2 end )
            , 'ModalidadCod'        = Convert( varchar(1)  , Det.CaModalidad  )
            , 'ModalidadDsc'        = Convert( varchar(15) , case when Det.CaModalidad  = 'E' then 'Entrega Fis.' else 'Compensación' end  )
            , 'MdaCompensacionCod'  = Convert( numeric(5)  , CaMdaCompensacion ) 
            , 'MdaCompensacionDsc'  = convert( char(35)    , isnull( MdaComp.MnGlosa, 'Moneda Comp. no existe' )  )
            , 'Strike'              = convert( float, Case when Det.CaVinculacion = 'Estructura'
                                                                    then 0.0 else  Det.CaStrike end )
            , 'NumeroFijacion'      = Convert( numeric(6)  , Fix.CaFixNumero )
            , 'FechaFijacion'       = Convert( datetime    , Fix.cafixFecha , 112 )
            , 'PesoFijacion'        = Convert( float, Fix.CaPesoFij )
            , 'FixBenchCompCod'     = convert( numeric(5), Fix.CaFixBenchComp )
            , 'FixBenchCompDsc'     = convert( varchar(40),BenchFix.BenchMarkDescripcion )
            , 'FixBenchCompHora'    = convert( varchar(8) , BenchFix.BenchMarkHora, 108 ) 
            , 'FixBenchEsEditable'  = convert( varchar(1) , BenchFix.BenchEditable ) 
            , 'FixBenchMdaCodValorDef' = convert( numeric(5) , BenchFix.BenchMdaCodValorDef )
            , 'FixBenchMdaCodValorDefValor' = convert( float , isnull(  DefectoBench.vmvalor, 0 )  )  
            , 'FixParBench'         = convert( varchar(7) , Fix.CaFixParBench ) 
            , 'FixEstado'           = convert( varchar(1) , Fix.CaFixEstado ) 
            , 'FixValorFijacion'    = convert( float, Fix.CaFijacion )
            , 'EstadoEjercicioCod'  = convert( varchar(2) , isnull( 
                                   ( select CaCajEstado 
                                                       from #CaCaja Caj 
                                                            where Caj.CanumContrato   = Fix.CaNumContrato
                                                             and  Caj.CaNumEstructura = Fix.CaNumEstructura
                                                             and  Caj.CaCajOrigen     <> 'PP' ) , 'NE'   ) )
            , 'EstadoEjercicioDsc'  = convert( varchar(20), '' )
            , 'EstadoMotorPagoCod'     = convert( varchar(2) , isnull( 
                                                            ( select CaCajMotorPago 
                          from #CaCaja Caj 
                                                            where Caj.CanumContrato   = Fix.CaNumContrato
                                                             and  Caj.CaNumEstructura = Fix.CaNumEstructura
                                                             and  Caj.CaCajOrigen     <> 'PP' ) , 'NE'   ) )
            , 'EstadoMotorPagoDsc'  = convert( varchar(20), '' )
            , 'Refijable'           = convert( varchar(10), 'RE-FIJABLE' )
            , 'Usuario'             = convert( varchar(15), @Usuario )
            , 'Anno'                = convert( Varchar(4) , '2000' )
            , 'Banco'               = convert( VarChar(16), substring( @Nombre, 1, 16 ) )            
            , 'Rut'                 = Convert( Numeric(9) , @Rut )
            , 'Dv'                  = Convert( VARCHAR(1) , @Dv )
            , 'FechaContratoLarga'  = convert( VarChar(30), '01 de Enero del año 1900' )   
            , 'FechaCondGeneLarga'  = convert( VarChar(30), '01 de Enero del año 1900' )  
            , 'FechaCondGeneOpcLarga' = convert( VarChar(30), '01 de Enero del año 1900' ) 
            , 'FechaCondGeneOpcSupLarga' = Convert( VarChar(30), '01 de Enero del año 1900' ) 
            , 'TipoEjercicioCod'    = Convert( varchar(1)  ,  CaTipoEjercicio ) 
            , 'TipoEjercicioDsc'    = Convert( Varchar(10) , Case when CaTipoEjercicio = 'E' then  'EUROPEA' else 'AMERICANA' end  )
            , 'PrecioSuperior'      = Convert( float, 0.0 )
            , 'PrecioMedio'         = Convert( float, 0.0 )
            , 'PrecioPiso'          = Convert( Float, 0.0 )
            , 'MtoPrima'            = Convert( Float, CaPrimaInicial )  
            , 'FormaPagoPrimaCod'   = Convert( numeric(3) , CafPagoPrima )   
            , 'FormaPagoPrimaDsc'   = convert( CHAR(30)    , isnull( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )
            , 'MdaPagoPrimaCod'     = Convert( numeric(5) , CaCodMonPagPrima ) 
            , 'MdaPagoPrimaDsc'     = Convert( char(35)   , isnull( MonedaPrima.MnGlosa, 'Moneda Prima no existe' )  )  
            , 'FechaPagoPrima'      = Convert( datetime   , CaFechaPagoPrima )                

            , 'ApoderadoClienteRut01'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoClienteDv01'          = Convert( Varchar(1)  , 0 )
            , 'ApoderadoClienteNombre01'      = Convert( Varchar(100), '' )
            , 'ApoderadoClienteDomicilio01'   = Convert( Varchar(100), '' )
            , 'ApoderadoClienteFax01'         = Convert( Varchar(50) , '' ) 
            , 'ApoderadoClienteFono01'        = Convert( VarChar(50) , '' )

            , 'ApoderadoBancoRut01'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoBancoDv01'          = Convert( Varchar(1)  , '' )
            , 'ApoderadoBancoNombre01'      = Convert( Varchar(100), '' )
            , 'ApoderadoBancoDomicilio01'   = Convert( Varchar(100), '' )
            , 'ApoderadoBancoFax01'         = Convert( Varchar(50) , '' ) 
            , 'ApoderadoBancoFono01'        = Convert( VarChar(50) , '' )
/* por mientras uno de cada uno
            , 'ApoderadoClienteRut02'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoClienteDv02'          = Convert( Varchar(1)  , 0 )
            , 'ApoderadoClienteNombre02'      = Convert( Varchar(100), '' )
            , 'ApoderadoClienteDomicilio02'   = Convert( Varchar(100), '' )
            , 'ApoderadoClienteFax02'         = Convert( Varchar(50) , '' ) 

            , 'ApoderadoBancoRut02'         = Convert( numeric(9)  , 0 )
            , 'ApoderadoBancoDv02'          = Convert( Varchar(1)  , '' )
            , 'ApoderadoBancoNombre02'      = Convert( Varchar(100), '' )
            , 'ApoderadoBancoDomicilio02'   = Convert( Varchar(100), '' )
            , 'ApoderadoBancoFax02'         = Convert( Varchar(50) , '' )  
*/
            , 'MtoPrecioSuperior'      = Convert( Float, 0.0 )
            , 'MtoPrecioMedio'         = Convert( float, 0.0 )
            , 'MtoPrecioPiso'          = Convert( Float, 0.0 )

            , 'ReceptorPrima'         = convert( varchar(100), case when CaPrimaInicial > 0 
                                                                     then @Nombre 
                                                                     else substring( isnull( Cliente.ClNombre, 'Cliente no esta en BAC' ), 1, 100 ) end  )
            , 'PagadorPrima'           = convert( varchar(100), case when CaPrimaInicial < 0 
                                                                     then @Nombre 
                                                                     else substring( isnull( Cliente.ClNombre, 'Cliente no esta en BAC' ), 1, 100 ) end  )
            
            , 'Control'                = convert( varchar(500), '' )

      into #Fixing
      from #CaFixing       Fix 
        LEFT JOIN   Benchmark BenchFix                    ON BenchFix.BenchMarkCod = Fix.CaFixBenchComp     
        LEFT JOIN   BacParamSudaValor_Moneda DefectoBench ON Fix.cafixFecha = DefectoBench.VmFecha and BenchFix.BenchMdaCodValorDef = DefectoBench.vmcodigo
	, IMPRESION IMP
           , #CaDetContrato  Det
LEFT JOIN     PayOffTipo               ON PayOffTipo.PayOffTipCod = Det.CaTipoPayOff 
-- POR HACER: cambiar a BDOpciones.BacParamMoneda
             LEFT JOIN     LnkBac.BacParamSuda.dbo.Moneda MonedaM1   ON MonedaM1.MnCodMon = Det.CaCodMon1
             LEFT JOIN     LnkBac.BacParamSuda.dbo.Moneda MonedaM2   ON MonedaM2.MnCodMon = Det.CaCodMon2
             LEFT JOIN     LnkBac.BacParamSuda.dbo.Moneda MdaComp   ON MdaComp.MnCodMon = Det.CaMdaCompensacion
             , #CaEncContrato Enc
                LEFT JOIN BacParamSudaCliente Cliente    ON Cliente.ClRut = Enc.CaRutCliente and Cliente.ClCodigo = Enc.CaCodigo 
                LEFT JOIN OpcionEstructura    Estructura ON Estructura.OpcEstCod = Enc.CaCodEstructura 
                LEFT JOIN LnkBac.BacParamSuda.dbo.Forma_de_Pago FormaPagoPrima ON FormaPagoPrima.Codigo = Enc.CafPagoPrima
                LEFT JOIN LnkBac.BacParamSuda.dbo.Moneda MonedaPrima ON MonedaPrima.MnCodMon = Enc.CaCodMonPagPrima
--select aprutcli,  apcodcli, aprutapo, apdvapo, apnombre   from CLIENTE_APODERADO where aprutcli = 97004000
          
      where  IMP.IMPGRUPO = @Grupo
         and Det.CaNumContrato = Fix.CaNumContrato
         and Det.CaNumEstructura = Fix.CaNumEstructura 
         and Fix.CaNumEstructura = 1      -- Forward Asiatico debe mostrar una sola tabla de Fixing
         and Enc.CaNumContrato = Det.CaNumContrato
         and ( Enc.CanumContrato = IMP.ImpNumContrato )

      IF exists( select (1) from #Fixing  ) BEGIN
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
                                                 and  EstadoEjercicioCod in ( 'P', 'NE' ) then 'FIJABLE' 
                                           else 'NO-FIJABLE' end   
              ,  FechaContratoLarga = convert( varchar(2), day( FechaContrato ) )  +
                                      Case when month( FechaContrato ) = 1 then ' Enero '
                                           when month( FechaContrato ) = 2 then ' Febrero '
                                           when month( FechaContrato ) = 3 then ' Marzo '
                                           when month( FechaContrato ) = 4 then ' Abril '     
                                           when month( FechaContrato ) = 5 then ' Mayo '  
                                           when month( FechaContrato ) = 6 then ' Junio '
                                           when month( FechaContrato ) = 7 then ' Julio ' 
                                           when month( FechaContrato ) = 8 then ' Agosto ' 
                                           when month( FechaContrato ) = 9 then ' Septiembre ' 
                                           when month( FechaContrato ) = 10 then ' Octubre '  
                                           when month( FechaContrato ) = 11 then ' Noviembre ' 
                      when month( FechaContrato ) = 12 then ' Diciembre ' End +
                                       'del año ' + convert( varchar(4) , year( FechaContrato ) )      
              ,  FechaCondGeneLarga = convert( varchar(2), day( FechaCG ) )  +
                                      Case when month( FechaCG ) = 1 then ' Enero '
                                           when month( FechaCG ) = 2 then ' Febrero '
                                           when month( FechaCG ) = 3 then ' Marzo '
                                           when month( FechaCG ) = 4 then ' Abril '     
                                           when month( FechaCG ) = 5 then ' Mayo '  
                                           when month( FechaCG ) = 6 then ' Junio '
                                           when month( FechaCG ) = 7 then ' Julio ' 
                                           when month( FechaCG ) = 8 then ' Agosto ' 
                                           when month( FechaCG ) = 9 then ' Septiembre ' 
                                           when month( FechaCG ) = 10 then ' Octubre '  
                                           when month( FechaCG ) = 11 then ' Noviembre ' 
                                           when month( FechaCG ) = 12 then ' Diciembre ' End +
                                       'del año ' + convert( varchar(4) , year( FechaCG ) ) 
              , FechaCondGeneOpcLarga = convert( varchar(2), day( FechaCGComp ) )  +
                                      Case when month( FechaCGComp ) = 1 then ' Enero '
                                           when month( FechaCGComp ) = 2 then ' Febrero '
                                           when month( FechaCGComp ) = 3 then ' Marzo '
                                           when month( FechaCGComp ) = 4 then ' Abril '     
                                           when month( FechaCGComp ) = 5 then ' Mayo '  
                                           when month( FechaCGComp ) = 6 then ' Junio '
                                           when month( FechaCGComp ) = 7 then ' Julio ' 
                                            when month( FechaCGComp ) = 8 then ' Agosto ' 
                                           when month( FechaCGComp ) = 9 then ' Septiembre ' 
                                           when month( FechaCGComp ) = 10 then ' Octubre '  
                                           when month( FechaCGComp ) = 11 then ' Noviembre ' 
                                           when month( FechaCGComp ) = 12 then ' Diciembre ' End +
                                       'del año ' + convert( varchar(4) , year( FechaCGComp ) )
              , FechaCondGeneOpcSupLarga = convert( varchar(2), day( FechaCGSup ) )  +
                                      Case when month( FechaCGSup ) = 1 then ' Enero '
                                           when month( FechaCGSup ) = 2 then ' Febrero '
                                           when month( FechaCGSup ) = 3 then ' Marzo '
                                           when month( FechaCGSup ) = 4 then ' Abril '     
                                           when month( FechaCGSup ) = 5 then ' Mayo '  
                                           when month( FechaCGSup ) = 6 then ' Junio '
                                           when month( FechaCGSup ) = 7 then ' Julio ' 
                                           when month( FechaCGSup ) = 8 then ' Agosto ' 
                                           when month( FechaCGSup ) = 9 then ' Septiembre ' 
                                           when month( FechaCGSup ) = 10 then ' Octubre '  
                                           when month( FechaCGSup ) = 11 then ' Noviembre ' 
                                           when month( FechaCGSup ) = 12 then ' Diciembre ' End +
                                       'del año ' + convert( varchar(4) , year( FechaCGSup ) )

     , PrecioSuperior      = ( select max( CaStrike ) from #CaDetContrato Dx where CanumContrato = NumContrato )                                         
              , PrecioPiso          = ( select min( CaStrike ) from #CaDetContrato Dx where CanumContrato = NumContrato )
              , ApoderadoClienteRut01         = Convert( numeric(9), isnull( ( select Top 1 aprutapo from lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                              where aprutcli = CliRut
                                                                                and ApCodCli = CliCod 
                                                                                and ( aprutapo = @RutRepCli01 or @RutRepCli01 = 0 ) )
                                                                            , 0 ) )
              , ApoderadoClienteDv01          = Convert( Varchar(1)  , isnull( ( select Top 1 apdvapo  from lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                              where aprutcli = CliRut 
                                                                                 and ApCodCli = CliCod 
                                                                                 and ( aprutapo = @RutRepCli01 or @RutRepCli01 = 0 ) )
                                                                            , 0 ) ) 
              , ApoderadoClienteNombre01      = Convert( Varchar(100), isnull( ( select Top 1 apNombre  from lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                              where aprutcli = CliRut 
                                                                                and ApCodCli = CliCod 
                                                                                and ( aprutapo = @RutRepCli01 or @RutRepCli01 = 0 ) )
                                                                            , 'No hay apoderados definidos' ) )
              , ApoderadoClienteDomicilio01   = Convert( Varchar(100), isnull( (select top 1 Cldirecc from BacParamSudaCliente where ClRut = CliRut and ClCodigo = CliCod), '' ) )
              , ApoderadoClienteFax01         = Convert( Varchar(50) , isnull( (select top 1 ClFax from BacParamSudaCliente where ClRut = CliRut and ClCodigo = CliCod), '' ) ) 
              , ApoderadoClienteFono01        = Convert( VarChar(50) , isnull( (select top 1 ClFono from BacParamSudaCliente where ClRut = CliRut and ClCodigo = CliCod), '' ) )
           
              , ApoderadoBancoRut01         = Convert( numeric(9)  , isnull( ( select Top 1 aprutapo from lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                              where aprutcli = @Rut 
                                                                                and ApCodCli = @Codigo
                                                                                and ( aprutapo = @RutRepBan01 or @RutRepBan01 = 0 ) )
                                                                            , 0 ) )
              , ApoderadoBancoDv01          = Convert( Varchar(1)  , isnull( ( select Top 1 apdvapo  from lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                              where aprutcli = @Rut 
                                                                 and ApCodCli = @Codigo 
                                                                               and ( aprutapo = @RutRepBan01 or @RutRepBan01 = 0 ) )
                                                                            , 0 ) )
              , ApoderadoBancoNombre01      = Convert( Varchar(100), isnull( ( select Top 1 apNombre  from lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                              where aprutcli = @Rut 
                                                          and ApCodCli = @Codigo 
                                                                                and ( aprutapo = @RutRepBan01 or @RutRepBan01 = 0 ) )
                                                                            , 'No hay apoderados definidos'  ) )
              , ApoderadoBancoDomicilio01   = Convert( Varchar(100), @Domicilio )
              , ApoderadoBancoFax01         = Convert( Varchar(50) , @Fax ) 
              , ApoderadoBancoFono01        = Convert( VarChar(50) , @Fono )

/*
              , Control                     = Case when FechaCG = '19000101' then 'CONTRATO NO VALIDO: CLIENTE SIN FIRMA CONDICIONES GENERALES' else '' end
                                            + Case when FechaCGComp = '19000101' then 'CONTRATO NO VALIDO: CLIENTE SIN FIRMA COMPLEMENTO OPCIONES CONDICIONES GENERALES' else '' end  
*/

              , Control                     = Case when FechaCG = '19000101' then '- FECHA CONDICIONES GENERALES '  else '' end
                                            + Case when ChkFechaCG = 'N' then '- FIRMA CONDICIONES GENERALES ' else '' end
                                            + Case when FechaCGComp = '19000101' then '- COMPLEMENTO ' else '' end 
                                            + Case when ChkFechaCGComp = 0 then '- FIRMA COMPLEMENTO ' else '' end
                                            + Case when FechaCGSup = '19000101' then '- SUPLEMENTO '  else '' end     -- MAP 12 NOv.
                                            + Case when ChkFechaCGSup = 0 then '- FIRMA SUPLEMENTO '  else '' end     -- MAP 12 Nov.

          update #Fixing
	      set PrecioMedio       = isnull( ( select max( CaStrike ) from #CaDetContrato Dx 
                                                where Dx.CaStrike > PrecioPiso and Dx.CaStrike < PrecioSuperior )
                                             , 0)	

                , Control           = case when  Control <> '' then 'CONTRATO NO VÁLIDO.  FALTA : ' + Control  else '' end


          update #Fixing
            set MtoPrecioSuperior      = Convert( float, round( MontoMon1 * PrecioSuperior, 0 ) )
              , MtoPrecioMedio         = Convert( float, round( MontoMon1 * PrecioMedio   , 0 ) )
              , MtoPrecioPiso          = Convert( Float, round( MontoMon1 * PrecioPiso    , 0 ) )
                                   
          select * 
               from #fixing order by NumCOntrato, NumComponente
     
      END
      ELSE
         -- Se despliega el registro Sin Datos.
         select * from   #Resultado        		   

END


-- 99565970
--select Top 1 apNombre, *   from lnkbac.bacparamsuda.dbo.Cliente_Apoderado where aprutcli = 99565970
GO
