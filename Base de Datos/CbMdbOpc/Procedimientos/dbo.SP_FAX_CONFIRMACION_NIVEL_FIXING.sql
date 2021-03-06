USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_FAX_CONFIRMACION_NIVEL_FIXING]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SP_FAX_CONFIRMACION_NIVEL_FIXING 7392, 'rfuentes'

--sp_helptext SP_FAX_CONFIRMACION_NIVEL_FIXING 2715, 'rfuentes'

--SP_FAX_CONFIRMACION_NIVEL_FIXING 7331, 'rfuentes'

-- SP_FAX_CONFIRMACION_NIVEL_FIXING 4218, 'rfuentes'

--SP_FAX_CONFIRMACION_NIVEL_FIXING  11319, 'rfuentes'


CREATE PROCEDURE [dbo].[SP_FAX_CONFIRMACION_NIVEL_FIXING]
       (          
         @Grupo int          
       , @Usuario Varchar(15)           
       )           
AS          
BEGIN          
          
    SET NOCOUNT ON          
          
    DECLARE @Nombre         CHAR(120)          
    DECLARE @Rut            NUMERIC(9)          
    DECLARE @Dv             CHAR(1)          
    DECLARE @FechaProceso   DATETIME          
    DECLARE @Domicilio      VARCHAR(50)          
    DECLARE @Fax            VARCHAR(100)          
    DECLARE @Fono           VARCHAR(100)          
    DECLARE @Codigo         NUMERIC(2)          
                      
          
    SELECT @FechaProceso = FechaProc          
         , @Nombre       = nombre          
         , @Rut          = rut          
         , @Domicilio    = direccion          
         , @Fono         = telefono          
         , @Fax          = Fax          
         , @Codigo       = 1          
    FROM dbo.OpcionesGeneral          
          
    SELECT *          
      INTO #Moneda          
      FROM lnkbac.bacparamsuda.dbo.Moneda          
          
    SELECT *          
      INTO #Valor_Moneda          
      FROM lnkbac.bacparamsuda.dbo.Valor_moneda          
     WHERE vmfecha = @FechaProceso          
    -- PENDIENTE: entrega fisica utilizará el Valor_Moneda Contable          
          
    -- Solo se cargarán Clientes que alguna vez han tenido opciones          
    SELECT  ClRut          
         , ClCodigo          
         , ClDv          
         , ClNombre          
         , ClFax           
      INTO #Cliente          
      FROM LNKBAC.bacparamsuda.dbo.VIEW_CLIENTEParaOpc           
     WHERE Clrut in ( SELECT MoRutCliente FROM MoEncContrato UNION SELECT MoRutCliente FROM MoHisEncContrato )          
              
          
    IF ( SELECT COUNT(1) FROM #CLiente ) = 0           
        INSERT INTO #Cliente          
               SELECT ClRut = 0, ClCodigo = 0, ClDv = '', ClNombre = 'CLIENTE NO EXISTE EN BAC', ClFax = 'No aplica'          
          
    SELECT 'OperadorNom' = MIN(ISNULL(Op_Cli.opnombre,''))          
          
          
          
          
         , 'ClienteRut' = ISNULL(#Cliente.ClRut,0)          
         , 'ClienteCod' = ISNULL(#Cliente.ClCodigo,'')          
         , 'ClienteNom' = ISNULL(#Cliente.ClNombre,'')          
      INTO #Operador_Cliente          
      FROM #Cliente          
           LEFT JOIN LNKBAC.bacparamsuda.dbo.CLIENTE_OPERADOR Op_Cli ON #Cliente.ClRut = Op_Cli.oprutcli AND #Cliente.ClCodigo = Op_Cli.opcodcli          
     GROUP BY          
           #Cliente.ClRut          
         , #Cliente.ClCodigo          
         , #Cliente.ClNombre          
                  
    SELECT *          
      INTO #Formas_Pago          
      FROM lnkbac.bacparamsuda.dbo.Forma_de_Pago           
          
    SELECT *          
      INTO #Tabla_General_Detalle          
      FROM lnkbac.bacparamsuda.dbo.Tabla_general_detalle           
     WHERE tbcateg in ( 204, 1111, 1552, 1553, 1554 )          
          
     SELECT *          
       INTO #GEN_SISTEMAS          
       FROM lnkbac.BacParamSuda.dbo.SISTEMA_CNT          
          
     SELECT 'CaNumContrato'        = CONVERT( NUMERIC(8), 0 )          
          , 'CaNumEstructura'      = CONVERT( NUMERIC(6), 0 )           
		  , 'TipoTransaccion'      = CONVERT( VARCHAR(10), '' )          
          , 'CaFixFecha'           = CONVERT( DATETIME, '', 112 )                            
          , 'CaFixNumero'          = CONVERT( NUMERIC(6), 0 )          
          , 'CaPesoFij'            = CONVERT( FLOAT, 0.0 )          
          , 'CaVolFij'  = CONVERT( FLOAT, 0.0 )          
          , 'CaFijacion'           = CONVERT( FLOAT, 0.0 )          
          , 'CaFixBenchComp'       = CONVERT( NUMERIC(5), 0 )      
       , 'CaFixParBench'        = CONVERT( VARCHAR(7), '' )          
		  , 'CaFixEstado'          = CONVERT( CHAR(1), '' )             
          , 'FixEstadoBenchDsc'    = CONVERT( VARCHAR(12) , '' )          
          , 'OperadorCont'         = CONVERT( VARCHAR(100),'' )          
          , 'CliRut'               = CONVERT( NUMERIC(13) , 0 )          
          , 'CliCod'            = CONVERT( NUMERIC(5), 0 )          
          , 'CliDv'                = CONVERT( CHAR(1), '' )          
          , 'CliNom'               = CONVERT( VARCHAR(100), 'NO HAY DATOS' )          
          , 'Operador'             = CONVERT( VARCHAR(100), '' )                     
          , 'OpcEstCod'            = CONVERT( VARCHAR(2), '' )          
          , 'OpcEstDsc'            = CONVERT( VARCHAR(30), '' )            
          , 'OpcCompraEstrucutura' = CONVERT( VARCHAR(100), '' )          
          , 'OpcVendeEstrucutura'  = CONVERT( VARCHAR(100), '' )          
          , 'NumComponente'        = CONVERT( NUMERIC(6), 0 )          
          , 'PayOffTipCod'         = CONVERT( VARCHAR(2), '' )           
          , 'PayOffTipDsc'         = CONVERT( VARCHAR(20), '' )                    
          , 'CallPut'              = CONVERT( VARCHAR(5), '' )          
          , 'CVOpcCod'             = CONVERT( VARCHAR(3), '' )          
          , 'CompraVentaOpcDsc'    = CONVERT( VARCHAR(6), '' )          
          , 'FechaContrato'        = CONVERT( DATETIME, '' , 112 )           
          , 'Mon1Cod'              = CONVERT( NUMERIC(5), 0 )          
          , 'Mon1Dsc'              = CONVERT( CHAR(35), ''  )          
          , 'EstiloOpcionCod'      = CONVERT( VARCHAR(1),  '' )           
          , 'EstiloOpcionDsc'      = CONVERT( VARCHAR(10), '' )          
          , 'MonExtRef'            = CONVERT( CHAR(35), ''  )          
          , 'MontoMon1'            = CONVERT( NUMERIC(21,6), 0 )          
          , 'MontoMon2'            = CONVERT( NUMERIC(21,6), 0 )          
          , 'MontoMon1Strangle'    = CONVERT( NUMERIC(21,6), 0 )          
          , 'MontoMon2Straddle'    = CONVERT( NUMERIC(21,6), 0 )          
          , 'RutCompradorOpc'      = CONVERT( NUMERIC(13), 0 )          
          , 'RutVendedorOpc'       = CONVERT( NUMERIC(13), 0 )          
          , 'ModalidadCumpl'       = CONVERT( VARCHAR(20), '' )          
          , 'FechaEjercicio'       = CONVERT( DATETIME, '' , 112 )          
          , 'FechaPago'            = CONVERT( DATETIME, '' , 112 )          
          , 'TipCamEjer'           = CONVERT( FLOAT, 0.0 )          
          , 'ParidadEjer'          = 'No Aplica'          
          , 'PrecioEjer'           = CONVERT( FLOAT, 0.0 )          
          , 'HoraEjer'             = CONVERT( VARCHAR(8), '00:00:00' )           
          , 'TipCamRef'            = CONVERT( VARCHAR(40),'' )          
          , 'ParidadRef'           = 'No Aplica'           
          , 'PrimaOpcion'          = CONVERT( FLOAT, 0.0 )            
          , 'CodMonPagPrimaCod'    =  CONVERT( NUMERIC(5), 0 )          
          , 'CodMonPagPrimaDsc'    = CONVERT( VARCHAR(35), isnull('', 'Moneda Pag. Prima no existe' ) )          
          , 'FecPagPrima'          = CONVERT( DATETIME, '', 112 )          
          , 'FormaPagoCod'         = CONVERT( NUMERIC(3), 0 )          
          , 'FormaPagoDsc'         = CONVERT( VARCHAR(30), '' )          
          , 'LugarPago'            = 'Santiago.'          
          , 'Observaciones'        = ''          
          , 'FechaProceso'         = CONVERT( DATETIME, '' , 112 )           
, 'Usuario'     = CONVERT( VARCHAR(15), '' )          
          , 'FaxCliente'           = CONVERT( VARCHAR(40), '' )            
          , 'FaxBanco'             = CONVERT( VARCHAR(40), '' )                               
          , 'Modalidad'            = CONVERT( VARCHAR(1), '' )          
          , 'CodMdaComp'           = CONVERT( NUMERIC(5), 0 )              
          , 'GlosaMdaComp'         = CONVERT( CHAR(35), ''  )              
          , 'CodMda1EF'            = CONVERT( NUMERIC(5), 0 )              
          , 'GlosaMda1EF'          = CONVERT( VARCHAR(35), ''  )        
          , 'CodMda2EF'            = CONVERT( NUMERIC(5), 0 )              
          , 'GlosaMda2EF'    = CONVERT( VARCHAR(35), ''  )              
          
          , 'CodForPagComp'        = CONVERT( NUMERIC(3), 0 )          
          , 'DescForPagComp'       = CONVERT( VARCHAR(30), ''  )              
          , 'CodForPag1EF'         = CONVERT( NUMERIC(3), 0 )          
          , 'DescForPag1EF'        = CONVERT( VARCHAR(30), ''  )              
          , 'CodForPag2EF'         = CONVERT( NUMERIC(3), 0 )          
          , 'DescForPag2EF'        = CONVERT( VARCHAR(30), ''  )              
          , 'PrecioSuperior'       = CONVERT( numeric(12,4), 0.0 )           -- MAP 20091221          
          , 'PrecioPiso'           = CONVERT( numeric(12,4), 0.0 )           -- MAP 20091221          
          , 'PrecioMedio'          = CONVERT( numeric(12,4), 0.0 )           -- MAP 20091221          
          , 'PagadorPrima'         = CONVERT( VARCHAR(100) , '' )    -- MAP 20091221          
          , 'GlosaSegunCliente'    = CONVERT( VARCHAR(30)  , '' )    -- MAP 20091221             
          , 'CondicionesPrecio'    = CONVERT( VARCHAR(200) , '' )    -- MAP 20091221          
          , 'CaCVEstructura'       = Convert( VARCHAR(1), '' )  -- MAP 20091221          
          , 'PlazoDias'            = CONVERT( NUMERIC(6), 0 ) --ASVG_20110225 Plazo en días          
          , 'NumeroComponentes'    = CONVERT( NUMERIC(6), 0 ) --PROD-13828 Plazo en días        
          , 'EntradaSalida'        = convert( varchar(21), 0 ) -- MAP 20130212   
          , 'Puntos'               = convert( float, 0 )      -- MAP 20130212 
          , 'PrecioTope'           = CONVERT( FLOAT, 0.0 )    --PRD20559  
          , 'MtoPrecioTope'         = CONVERT( FLOAT, 0.0 )
          , 'MtoPrecioSuperior'     = CONVERT( FLOAT, 0.0 )
          , 'MtoPrecioMedio'        = CONVERT( FLOAT, 0.0 )
          , 'MtoPrecioPiso'         = CONVERT( FLOAT, 0.0 )                                                               
          
       into #Result_Sin_Datos          
          
          
     SELECT DISTINCT          
            'CaNumContrato'        = CONVERT( NUMERIC(8), Fix.CaNumContrato )          
          , 'CaNumEstructura'      = CONVERT( NUMERIC(6), Fix.CaNumEstructura )           
          , 'TipoTransaccion'      = CONVERT( VARCHAR(10), Enc.CaTipoTransaccion )          
          , 'CaFixFecha'           = CONVERT( DATETIME, Fix.CaFixFecha, 112 )                            
          , 'CaFixNumero'          = CONVERT( NUMERIC(6), Fix.CaFixNumero )          
          , 'CaPesoFij'            = CONVERT( FLOAT, Fix.CaPesoFij )          
          , 'CaVolFij'             = CONVERT( FLOAT, Fix.CaVolFij )          
          , 'CaFijacion'           = CONVERT( FLOAT, Fix.CaFijacion )          
          , 'CaFixBenchComp'       = CONVERT( NUMERIC(5), Fix.CaFixBenchComp )          
          , 'CaFixParBench'        = CONVERT( VARCHAR(7), Fix.CaFixParBench )          
          , 'CaFixEstado'          = CONVERT( VARCHAR(1), Fix.CaFixEstado )             
          , 'FixEstadoBenchDsc'    = CONVERT( VARCHAR(12), CASE WHEN CaFixEstado = 'F' THEN 'Fijado' ELSE 'No Fijado' END )          
          
          , 'OperadorCont'         = CONVERT( VARCHAR(100), ISNULL(Op_Cli.OperadorNom, '' ) )             
          
         , 'CliRut'                = CONVERT( NUMERIC(13), Enc.CaRutCliente )          
         , 'CliCod' = CONVERT( NUMERIC(5), Enc.CaCodigo )          
         , 'CliDv'                 = CONVERT( CHAR(1), isnull( Cliente.ClDv, '' )   )          
         , 'CliNom'       = CONVERT( VARCHAR(100), isnull( Cliente.ClNombre, 'Cliente no esta en BAC' ) )          
         , 'Operador'              = CASE WHEN CHARINDEX( '-', USR.nombre, 0 ) > 0           
                                          THEN CONVERT( VARCHAR(100) , SUBSTRING(USR.nombre, 0, CHARINDEX( '-', USR.nombre, 0 ) ) )          
         ELSE CONVERT( VARCHAR(100) , USR.nombre )           
                                  END          
         , 'OpcEstCod'             = CONVERT( VARCHAR(2)  , Enc.CaCodEstructura )          
         , 'OpcEstDsc'             = CASE WHEN Enc.CaCodEstructura = '0' AND Det.CaTipoPayOff = '02'           
                                          THEN 'Asiatica'          
                                        ELSE CONVERT( VARCHAR(30) , ISNULL(  Estructura.OpcEstDsc  , 'Estructura no Existe'  ) )          
                                     END          
         , 'OpcCompraEstrucutura'  = CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre ELSE Cliente.ClNombre END )          
         , 'OpcVendeEstrucutura'   = CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre END )          
         , 'NumComponente'         = CONVERT( NUMERIC(6), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0 ELSE Fix.CaNumEstructura END )          
          
         , 'PayOffTipCod'          = CONVERT( VARCHAR(2), Det.CaTipoPayOff )           
         , 'PayOffTipDsc'          = CONVERT( VARCHAR(20), UPPER( PayOffTipo.PayOffTipDsc ) )                    
         , 'CallPut'               = CONVERT( VARCHAR(5), UPPER( CASE WHEN Det.CaVinculacion = 'Estructura' THEN '   ' ELSE Det.CaCallPut END ) )          
         , 'CVOpcCod'              = CONVERT( VARCHAR(3), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 'N/A' ELSE Det.CaCVOpc END )          
         , 'CompraVentaOpcDsc'     = CONVERT( VARCHAR(6), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 'N/A'          
                                                               WHEN Det.CaCVOpc = 'C'                THEN 'Compra'           
                                                               ELSE 'Venta'           
                                                          END )          
          
          
          
          
          
         , 'FechaContrato'         = CONVERT( DATETIME, Enc.CaFechacontrato , 112 )           
          
         , 'Mon1Cod'               = CONVERT( NUMERIC(5), Det.CaCodMon1 )          
         , 'Mon1Dsc'               = CONVERT( VARCHAR(35), isnull( MonedaM1.MnGlosa, 'Moneda M1 no existe' )  )          
         , 'EstiloOpcionCod'       = CONVERT( CHAR(1),  CaTipoEjercicio )           
         , 'EstiloOpcionDsc'       = CONVERT( VARCHAR(10), Case when CaTipoEjercicio = 'E' then  'EUROPEA' else 'AMERICANA' end  )          
         , 'MonExtRef'             = CONVERT( VARCHAR(35), isnull( MonedaM1.MnGlosa, 'Moneda M1 no existe' )  )          
         , 'MontoMon1'             = CONVERT( NUMERIC(21,6), Det.CaMontoMon1 )          
         , 'MontoMon2'             = CONVERT( NUMERIC(21,6), Det.CaMontoMon2 )          
         , 'MontoMon1Strangle'     = CONVERT( NUMERIC(21,6), 0 )          
         , 'MontoMon2Straddle'     = CONVERT( NUMERIC(21,6), 0 )          
         , 'RutCompradorOpc'       = CONVERT( NUMERIC(13), CASE WHEN Enc.CaCVEstructura = 'C' THEN @Rut ELSE Enc.CaRutCliente END )          
         , 'RutVendedorOpc'        = CONVERT( NUMERIC(13), CASE WHEN Enc.CaCVEstructura = 'C' THEN Enc.CaRutCliente ELSE @Rut END )          
         , 'ModalidadCumpl'        = CONVERT( VARCHAR(20), CASE WHEN Det.CaModalidad = 'C' THEN 'Compensación' ELSE 'Entrega Física' END )          
         , 'FechaEjercicio'        = CONVERT( DATETIME, Det.CaFechaPagoEjer , 112 )          
         , 'FechaPago'             = CONVERT( DATETIME, Det.CaFechaPagoEjer , 112 )          
         , 'TipCamEjer'   = CONVERT( FLOAT, CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0.0 ELSE Det.CaStrike END )          
          
         , 'ParidadEjer'           = 'No Aplica'          
         --STRIP           
         , 'PrecioEjer'            = CONVERT( FLOAT, CASE WHEN Enc.CaCodEstructura in (9,10,14) THEN Det.CaStrike              
                                    ELSE              
                                         CONVERT( FLOAT, CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0.0 ELSE Det.CaStrike END )          
                                     END           
                                     )              
        
                  
        
         , 'HoraEjer'              = CONVERT( VARCHAR(8), BenchFix.BenchMarkHora, 108 )          
         , 'TipCamRef'             = CONVERT( VARCHAR(40), BenchFix.BenchMarkDescripcion )          
         , 'ParidadRef'            = 'No Aplica'          
         , 'PrimaOpcion'           = Enc.CaPrimaInicial          
         , 'CodMonPagPrimaCod'     =  CONVERT( NUMERIC(5), Enc.CaCodMonPagPrima )          
         , 'CodMonPagPrimaDsc'     = CONVERT( VARCHAR(35), ISNULL( MonedaPrima.mnglosa, 'Moneda Pag. Prima no existe' ) )          
         , 'FecPagPrima'           = CONVERT( DATETIME, Enc.CaFechaPagoPrima, 112 )          
         , 'FormaPagoCod'          = CONVERT( NUMERIC(3), CafPagoPrima )          
         , 'FormaPagoDsc'          = CONVERT( VARCHAR(30), ISNULL( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )          
         , 'LugarPago'             = 'Santiago.'        
         , 'Observaciones'         = ''          
         , 'FechaProceso'          = CONVERT( DATETIME, @FechaProceso, 112 )          
         , 'Usuario'               = CONVERT( VARCHAR(15), @Usuario )          
         , 'FaxCliente'            = CONVERT( VARCHAR(40), isnull(Cliente.ClFax,'Fax Cliente no existe' ) )          
         , 'FaxBanco'              = CONVERT( VARCHAR(40), @Fax )          
         , 'Modalidad'             = CONVERT( VARCHAR(1), Det.CaModalidad )          
         , 'CodMdaComp'            = CONVERT( NUMERIC(5), ISNULL(Det.CaMdaCompensacion, 0 ) )          
         , 'GlosaMdaComp'          = CONVERT( VARCHAR(35), ISNULL(MdaComp.MnGlosa, '' ) )          
         , 'CodMda1EF'             = CONVERT( NUMERIC(5), ISNULL(Det.CaCodMon1, 0 ) )          
         , 'GlosaMda1EF'           = CONVERT( VARCHAR(35), ISNULL(MonedaM1.MnGlosa, '' ) )          
         , 'CodMda2EF'             = CONVERT( NUMERIC(5), ISNULL(Det.CaCodMon2, 0 ) )          
         , 'GlosaMda2EF'           = CONVERT( VARCHAR(35), ISNULL(MonedaM2.MnGlosa, '' ) )          
         , 'CodForPagComp'         = CONVERT( NUMERIC(3), ISNULL(Det.CaFormaPagoComp, 0 ) )          
         , 'DescForPagComp'        = CONVERT( VARCHAR(30), ISNULL(FormaPagoComp.Glosa, '' ) )          
         , 'CodForPag1EF'          = CONVERT( NUMERIC(3), ISNULL(Det.CaFormaPagoMon1, 0 ) )          
         , 'DescForPag1EF'         = CONVERT( VARCHAR(30), ISNULL(FormaPagoEF1.Glosa, '' ) )          
         , 'CodForPag2EF'          = CONVERT( NUMERIC(3), ISNULL(Det.CaFormaPagoMon2, 0 ) )          
         , 'DescForPag2EF'         = CONVERT( VARCHAR(30), ISNULL(FormaPagoEF2.Glosa, '' ) )          
         , 'PrecioSuperior'        = CONVERT( numeric(12,4), case when Det.CaVinculacion = 'Estructura' then 0.0 else caStrike end )    -- MAP 20091221          
         , 'PrecioPiso'            = CONVERT( numeric(12,4), case when Det.CaVinculacion = 'Estructura' then 0.0 else caStrike end )    -- MAP 20091221          
         , 'PrecioMedio'           = CONVERT( numeric(12,4), case when Det.CaVinculacion = 'Estructura' then 0.0 else caStrike end )    -- MAP 20091221          
         , 'PagadorPrima'          = CONVERT( VARCHAR(100), '' )                                                                -- MAP 20091221               
         , 'GlosaSegunCliente'     = Convert( VARCHAR(30), '' )                                                                 -- MAP 20091221          
         , 'CondicionesPrecio'     = Convert( VARCHAR(200), '')                                                                 -- MAP 20091221          
         , 'CaCVEstructura'        = Convert( VARCHAR(1), CaCVEstructura )                                                      -- MAP 20091221          
         , 'PlazoDias'             = CONVERT( NUMERIC(6), DATEDIFF(day,Det.CaFechaInicioOpc,Det.CaFechaVcto) ) --ASVG_20110225 Plazo en días          
         , 'NumeroComponentes'     = CONVERT( NUMERIC(6), 0 ) -- PROD-13828        
         , 'EntradaSalida'         = convert( varchar(21), case when Det.CaTipoPayOff = '02'  then  CASE WHEN Fix.CaPesoFij > 0 THEN 'Fijaciones de Salida' ELSE 'Fijaciones de Entrada' END  
                                             else '' end      
                                                           ) -- MAP 20130212    
         , 'Puntos'                = convert( float, case when Enc.CaCodEstructura in (13) then CaPorcStrike else 0 end )        
         , 'PrecioTope'            = CONVERT( numeric(12,4), case when Det.CaVinculacion = 'Estructura' then 0.0 else caStrike end )     --PRD20559  
         , 'MtoPrecioTope'         = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioSuperior'     = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioMedio'        = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioPiso'         = CONVERT( FLOAT, 0.0 )
      INTO #Fixing          
      FROM dbo.CaFixing  Fix               
           LEFT JOIN   Benchmark                           BenchFix       ON BenchFix.BenchMarkCod        = Fix.CaFixBenchComp               
           LEFT JOIN   BacParamSudaValor_Moneda            DefectoBench   ON Fix.cafixFecha               = DefectoBench.VmFecha          
                                                                         AND BenchFix.BenchMdaCodValorDef = DefectoBench.vmcodigo          
         , dbo.IMPRESION                                   IMP          
         , dbo.CaDetContrato                               Det          
           LEFT JOIN PayOffTipo                                           ON PayOffTipo.PayOffTipCod      = Det.CaTipoPayOff           
           -- POR HACER: cambiar a BDOpciones.BacParamMoneda          
           LEFT JOIN LnkBac.BacParamSuda.dbo.Moneda        MonedaM1       ON MonedaM1.MnCodMon            = Det.CaCodMon1          
           LEFT JOIN LnkBac.BacParamSuda.dbo.Moneda        MonedaM2       ON MonedaM2.MnCodMon            = Det.CaCodMon2          
           LEFT JOIN  LnkBac.BacParamSuda.dbo.Moneda       MdaComp        ON MdaComp.MnCodMon             = Det.CaMdaCompensacion          
           LEFT JOIN LnkBac.BacParamSuda.dbo.Forma_de_Pago FormaPagoComp  ON FormaPagoComp.Codigo         = Det.CaFormaPagoComp          
           LEFT JOIN LnkBac.BacParamSuda.dbo.Forma_de_Pago FormaPagoEF1   ON FormaPagoEF1.Codigo          = Det.CaFormaPagoMon1          
           LEFT JOIN LnkBac.BacParamSuda.dbo.Forma_de_Pago FormaPagoEF2   ON FormaPagoEF2.Codigo          = Det.CaFormaPagoMon2          
         , dbo.CaEncContrato                               Enc          
           LEFT JOIN #Cliente                              Cliente        ON Cliente.ClRut                = Enc.CaRutCliente          
                      AND Cliente.ClCodigo             = Enc.CaCodigo           
           LEFT JOIN OpcionEstructura                      Estructura     ON Estructura.OpcEstCod         = Enc.CaCodEstructura           
           LEFT JOIN LnkBac.BacParamSuda.dbo.Forma_de_Pago FormaPagoPrima ON FormaPagoPrima.Codigo        = Enc.CafPagoPrima          
           LEFT JOIN LnkBac.BacParamSuda.dbo.Moneda        MonedaPrima    ON MonedaPrima.MnCodMon         = Enc.CaCodMonPagPrima          
           LEFT JOIN #Operador_Cliente                     Op_Cli         ON  Enc.CaRutCliente            = Op_Cli.ClienteRut          
                                                                         AND Enc.CaCodigo                 = Op_Cli.ClienteCod          
           LEFT JOIN LNKBAC.bacparamsuda.dbo.USUARIO       USR            ON  USR.usuario                 = Enc.CaOperador          
     WHERE IMP.IMPGRUPO        = @Grupo          
       and Det.CaNumContrato   = Fix.CaNumContrato          
       and Det.CaNumEstructura = Fix.CaNumEstructura           
       -- Forward Asiatico debe mostrar una sola tabla de Fixing          
       and Det.CaNumEstructura = (CASE WHEN PayOffTipo.PayOffTipCod = '02' AND Estructura.OpcEstCod in ('6','13') THEN  1 ELSE Fix.CaNumEstructura END)  -- MAP 20130212      
       and Enc.CaNumContrato   = Det.CaNumContrato          
       and Enc.CanumContrato   = IMP.ImpNumContrato          
          
          
      select CanumContrato, CaStrike, Cnt = count(1)           
      into #Precios           
      from Dbo.CaDetContrato           
           INNER JOIN Impresion          
           ON   CaNumContrato = ImpNumContrato          
            and ImpGrupo = @Grupo          
      group by CaNumContrato, CaStrike            
          
          
          
          
      UPDATE #Fixing          
      SET MontoMon1Strangle = isnull(  (SELECT DISTINCT MontoMon1           
                                    FROM #Fixing          
                                   WHERE OpcEstCod              = '3'          
                                     AND #Fixing.CaNumContrato  = Det.CaNumContrato          
                                     AND CaNumEstructura       in ( 3, 4 )) , MontoMon1Strangle )          
           , MontoMon2Straddle = isnull( (SELECT DISTINCT MontoMon1          
                                    FROM #Fixing          
                                   WHERE OpcEstCod              = '3'          
                                     AND #Fixing.CaNumContrato  = Det.CaNumContrato          
                                     AND CaNumEstructura       in ( 1, 2 )), MontoMon2Straddle ) 
                                     
		   , PrecioTope        = isnull(CASE WHEN OpcEstCod = 14                                 
									    THEN ( SELECT ROUND( CaStrike, 2 ) FROM CaDetContrato Dx WHERE CaNumContrato = #Fixing.CaNumContrato AND Dx.CaNumEstructura = 4 ) -- Precio Strike4									
                                        ELSE ( SELECT MAX( CaStrike ) FROM CaDetContrato Dx WHERE CanumContrato = #Fixing.CaNumContrato)                            
									    END		,PrecioTope)         
           , PrecioSuperior    = isnull(CASE WHEN OpcEstCod in ( 4, 5)            
                                        THEN ( SELECT CaStrike FROM #Precios WHERE #Precios.CaNumContrato = #Fixing.CaNumContrato AND cnt = 2 ) -- Precio Forward          
                                        WHEN OpcEstCod = 14
												  THEN ( SELECT ROUND( CaStrike, 2 ) FROM CaDetContrato Dx WHERE CaNumContrato = #Fixing.CaNumContrato AND Dx.CaNumEstructura = 3 ) -- Precio Strike3
                                                  ELSE ( SELECT MAX( Dx.CaStrike ) FROM CaDetContrato Dx WHERE Dx.CanumContrato = #Fixing.CaNumContrato )                                                   
										END		, PrecioSuperior )  
           , PrecioMedio      =  isnull(CASE WHEN OpcEstCod = 14
                                        THEN ( SELECT ROUND( CaStrike, 2 ) FROM CaDetContrato Dx WHERE CaNumContrato =#Fixing.CaNumContrato AND Dx.CaNumEstructura = 2 ) -- Precio Strike2
                                        ELSE ( CONVERT( FLOAT, 0.0 ) )--Dejamos el Default, se setea más abajo en sección "Calculo del Precio Medio"
           END		,PrecioMedio )                                                   
           , PrecioPiso        = isnull(CASE WHEN OpcEstCod in ( 4, 5)       
                                        THEN ( SELECT CaStrike FROM #Precios WHERE #Precios.CaNumContrato = #Fixing.CaNumContrato AND cnt = 1 ) -- Precio Cota          
                                        ELSE ( SELECT MIN( CaStrike ) FROM CaDetContrato Dx WHERE Dx.CanumContrato = #Fixing.CaNumContrato )          
										END   , PrecioPiso )           
        FROM dbo.CaDetContrato  Det               
       WHERE #Fixing.CaNumContrato = Det.CaNumContrato  
       
       

		UPDATE #Fixing          
		SET MtoPrecioTope                  = CONVERT( FLOAT, round( MontoMon1 * PrecioTope		, 0 ) ) --PRD_20975 ASVG_20140730 Para Strike4
		,	MtoPrecioSuperior              = CONVERT( FLOAT, round( MontoMon1 * PrecioSuperior	, 0 ) ) 
		,	MtoPrecioMedio                 = CONVERT( FLOAT, round( MontoMon1 * PrecioMedio		, 0 ) )          
		,	MtoPrecioPiso                  = CONVERT( FLOAT, round( MontoMon1 * PrecioPiso		, 0 ) )         

       

               
          
     -- PROD 13828    
     select PlNumContrato = CaNumcontrato, PlPlazo = max( PlazoDias ), PlNroComponentes = max(CaNumEstructura)    
        into #Plazos    
       from #Fixing    
       Group by CaNumContrato    
    
     update  #Fixing            
   set PlazoDias = PlPlazo, NumeroComponentes = PlNroComponentes    
       from #Plazos    
      where #Fixing.CaNumContrato = #Plazos.PlNumContrato      
     -- PROD 13828        
          
      update #Fixing          
         SET PrecioMedio            = ISNULL( ( SELECT MAX( CaStrike )          
                                                  FROM CaDetContrato Dx          
                                                 WHERE Dx.CaStrike      > PrecioPiso          
                                                   AND Dx.CaStrike      < PrecioSuperior          
                                                   AND Dx.Canumcontrato = #Fixing.CaNumContrato          
               ), 0)              
             , GlosaSegunCliente    = case when OpcEstCod in (4) -- Utilidad Acotada          
                                                then 'Forward Perdida Acotada'          
                                           when OpcEstCod in (5) -- Peridida Acotada          
                                                then 'Forward Utilidad Acotada'          
                                       else OpcEstDsc end          
             , PagadorPrima         = convert( Varchar( 100) ,           
                                               CASE WHEN  PrimaOpcion < 0 THEN  'PRIMA A SER PAGADA POR ' +  @Nombre             
                                                    WHEN  PrimaOpcion = 0 THEN  'SIN PRIMA'          
                                                    ELSE 'PRIMA A SER PAGADA POR ' +  CliNom  END  )          
             , PrimaOpcion          = abs( PrimaOpcion )          
             , CondicionesPrecio   =            
                                   Case when OpcEstCod in ( 0, 1 )        Then 'PRECIO EJERCICIO '  +  ':  '  + Convert( varchar(10), PrecioSuperior  )       else '' end         
         +  Case when OpcEstCod in ( 2, 7, 11, 12 )  Then 'PRECIO PISO : '     + Convert( varchar(10),   PrecioPiso )       else '' end         
                                +  Case when OpcEstCod in ( 4, 5, 6 )  Then 'PRECIO FORWARD '  + ':  '  + Convert( varchar(10),   PrecioSuperior ) else '' end          
    +  Case when OpcEstCod in ( 2, 7, 11, 12 ) Then ' - PRECIO TECHO : ' + Convert( varchar(10),  PrecioSuperior ) else '' end         
                                +  Case when OpcEstCod in ( 4, 5 )     Then ' - COTA : '           + Convert( varchar(10),  PrecioPiso     ) else '' end            
 -- Se agregran en OpcEstCod Call Spread y Put Spread (11 y 12) para que salgan los strikes correspondientes.      
          
      -- Solo para ButterFly , OpcEstCod in ( 3 )          
      update #Fixing          
             set CondicionesPrecio   =            
                                       'PRECIO PISO :'     + Convert( varchar(10),   PrecioPiso     )           
                                +      ' - PRECIO MEDIO :'    + Convert( varchar(10),  PrecioMedio    )           
                                +      ' - PRECIO SUPERIOR :' + Convert( varchar(10),  PrecioSuperior )           
      where OpcEstCod in ( 3 )          
                                             
      -- MAP 20130212   
      update #Fixing        
             set CondicionesPrecio   =          
                                      -- 'PUNTOS' + space(118) +': '     + Convert( varchar(10),   Puntos     )      
									     'PUNTOS : ' +  Convert( varchar(10),   Puntos     )      
      where OpcEstCod in ( 13)        
  
                                           
          
      IF EXISTS( SELECT (1) FROM #Fixing )           
      BEGIN          
         SELECT 
		 * 
		,   'firmabanco'   = (select firma from lnkbac.bacparamsuda.dbo.reportes_firma where nombre_usuario = @Usuario)  

		, 'Usuario_Banco'		= (SELECT nombre FROM lnkbac.bacparamsuda.dbo.USUARIO WHERE USUARIO = @Usuario)
		, 'BannerLargo' = (SELECT BannerLargo FROM lnkbac.bacparamsuda.dbo.Contratos_ParametrosGenerales) 
		 FROM #Fixing  order by CaNumContrato, CanumEstructura, CaFixNUmero      
      END ELSE          
          
      BEGIN          
         SELECT * 
		 ,   'firmabanco'   = ''

		, 'Usuario_Banco'		= ''
		, 'BannerLargo' = (SELECT BannerLargo FROM lnkbac.bacparamsuda.dbo.Contratos_ParametrosGenerales) 
		 FROM #Result_Sin_Datos          
          
      END          
          
          
END

GO
