USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_Contrato_Legal_OpcionesTMP]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- select * from impresion where impnumcontrato = 105

CREATE PROCEDURE [dbo].[SP_Contrato_Legal_OpcionesTMP]
       (
         @Usuario     VARCHAR(15)
       , @RutRepCli01 NUMERIC(9) = 0
       , @RutRepCli02 NUMERIC(9) = 0
       , @RutRepBan01 NUMERIC(9) = 0
       , @RutRepBan02 NUMERIC(9) = 0
       , @Grupo       NUMERIC(8)
       )
AS
BEGIN

    -- INSTRUCCIONES GENERALES DE MANTENCION
    -- @RutRep01 numeric(9) , @RutRep02 numeric(9) corresponden a los rut de rep legales
    -- que puede que no haya.
    -- Idea: utilizar distinct y tablas verticales ( si existen )
    SET NOCOUNT ON

    -- Pora hacer por elegancia: generalizar con @@DATEFIRST cualquiera
    -- MAP 20091216 Faltaba condcion ImpGrupo            = @Grupo
    SET DATEFIRST 7

    DECLARE @Nombre       VARCHAR(120)
    DECLARE @Rut          NUMERIC(9)
    DECLARE @Dv           CHAR(1)
    DECLARE @FechaProceso DATETIME
    DECLARE @Domicilio    VARCHAR(50)
    DECLARE @Fax          VARCHAR(100)
    DECLARE @Fono         VARCHAR(100)
    DECLARE @Codigo       NUMERIC(2)
    DECLARE @FechaDefault DATETIME

    SELECT @FechaProceso = FechaProc
         , @Nombre       = nombre
         , @Rut          = rut
         , @Domicilio    = direccion
         , @Fono         = telefono
         , @Fax          = Fax
         , @Codigo       = 1
      FROM dbo.OpcionesGeneral

    SELECT @Dv   = ClDv
         , @Fax  = ClFax
      FROM LnkBac.BacParamSuda.dbo.View_CLIENTEParaOpc
     WHERE clrut = @Rut 
    -- MAP 14 Nov. 2009 desvio por prob lnkServer

    SET @FechaDefault = '19000101'

     -- Sección que genera el registro vacío.
    SELECT 'Reporte'                       = CONVERT( VARCHAR(40), 'CONTRATO LEGAL' )
         , 'TipReg'                        = CONVERT( VARCHAR(10), 'VACIO'  )
         , 'NumContrato'                   = CONVERT( NUMERIC(8), 0 )
         , 'CaNumEstructura'               = CONVERT( NUMERIC(6), 0 ) 
         , 'CliRut'                        = CONVERT( NUMERIC(13), 0 )
         , 'CliCod'                        = CONVERT( NUMERIC(5), 0 )
         , 'CliDv'                         = CONVERT( VARCHAR(1), '' )
         , 'CliNom'                        = CONVERT( VARCHAR(100), 'NO HAY DATOS' )
         , 'Operador'                      = CONVERT( VARCHAR(15), '' )
         , 'OpcEstCod'                     = CONVERT( VARCHAR(2), '' )
         , 'OpcEstDsc'                     = CONVERT( VARCHAR(30), '' )  
         , 'OpcCompraEstrucutura'          = CONVERT( VARCHAR(100),  '' )
         , 'OpcVENDeEstrucutura'           = CONVERT( VARCHAR(100),  '' )
         , 'NumComponente'                 = CONVERT( NUMERIC(6), 0 )
         , 'PayOffTipCod'                  = CONVERT( VARCHAR(2), '' )
         , 'PayOffTipDsc'                  = CONVERT( VARCHAR(20), '' )
         , 'CallPut'                       = CONVERT( VARCHAR(5), '' )
         , 'CVOpcCod'                      = CONVERT( VARCHAR(3), '' )
         , 'CompraVentaOpcDsc'             = CONVERT( VARCHAR(6), '' )
         , 'FechaContrato'                 = @FechaDefault
         , 'FechaPagoEjer'                 = @FechaDefault
         , 'FechaVcto'                     = @FechaDefault
         , 'FechaCG'                       = @FechaDefault
         , 'ChkFechaCG'                    = CONVERT( CHAR(1), 'N')
         , 'FechaCGComp'                   = @FechaDefault
         , 'ChkFechaCGComp'                = CONVERT( NUMERIC(1), 0)
         , 'FechaCGSup'                    = @FechaDefault
         , 'ChkFechaCGSup'                 = CONVERT( NUMERIC(1), 0)
         , 'Mon1Cod'                       = CONVERT( NUMERIC(5), 0 )
         , 'Mon1Dsc'                       = CONVERT( VARCHAR(35), '' )
         , 'MontoMon1'                     = CONVERT( NUMERIC(21,6), 0 )
         , 'MontoMon1Strangle'             = CONVERT( NUMERIC(21,6), 0 )
         , 'MontoMon2Straddle'             = CONVERT( NUMERIC(21,6), 0 )
         , 'Mon2Cod'    = CONVERT( NUMERIC(5), 0 )
         , 'Mon2Dsc'         = CONVERT( VARCHAR(35), '' )
         , 'MontoMon2'                     = CONVERT( NUMERIC(21,6), 0 )
         , 'ModalidadCod'                  = CONVERT( VARCHAR(1), ''  )
         , 'ModalidadDsc'                  = CONVERT( VARCHAR(15), ''  )
         , 'MdaCompensacionCod'            = CONVERT( NUMERIC(5), 0 )
         , 'MdaCompensacionDsc'            = CONVERT( VARCHAR(35), ''  )
         , 'Strike'                        = CONVERT( FLOAT, 0.0 )
         , 'NumeroFijacion'                = CONVERT( NUMERIC(6), 0 )
         , 'FechaFijacion'                 = @FechaDefault
         , 'PesoFijacion'                  = CONVERT( FLOAT, 0.0 )
         , 'FixBenchCompCod'               = CONVERT( NUMERIC(5), 0 )
         , 'FixBenchCompDsc'               = CONVERT( VARCHAR(40), '' )
         , 'FixBenchCompHora'              = CONVERT( VARCHAR(8), '00:00:00' )
         , 'FixBenchEsEditable'            = CONVERT( VARCHAR(1), '' ) 
         , 'FixBenchMdaCodValorDef'        = CONVERT( NUMERIC(5), 0 )
         , 'FixBenchMdaCodValorDefValor'   = CONVERT( FLOAT, 0 )  
         , 'FixParBench'                   = CONVERT( VARCHAR(7), '' )
         , 'FixEstado'                     = CONVERT( VARCHAR(1), '' )
         , 'FixValorFijacion'              = CONVERT( FLOAT, 0.0 )
         , 'EstadoEjercicioCod'            = CONVERT( VARCHAR(2), '' )
         , 'EstadoEjercicioDsc'            = CONVERT( VARCHAR(20), '' )
         , 'EstadoMotorPagoCod'            = CONVERT( VARCHAR(2), '' )
         , 'EstadoMotorPagoDsc'            = CONVERT( VARCHAR(20), '' ) 
         , 'Refijable'                     = CONVERT( VARCHAR(10), 'RE-FIJABLE' )
         , 'Usuario'                       = CONVERT( VARCHAR(15), '' )
         , 'Anno'                          = CONVERT( VARCHAR(4), '2000' )
         , 'Banco'                         = CONVERT( VARCHAR(16), LEFT( @Nombre, 16 ) )
         , 'Rut'                           = CONVERT( NUMERIC(9), @Rut )
         , 'Dv'                            = CONVERT( VARCHAR(1), @Dv )
         , 'FechaContratoLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )
         , 'FechaCondGeneLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )
         , 'FechaCondGeneOpcLarga'         = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )
         , 'FechaCondGeneOpcSupLarga'      = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )
         , 'TipoEjercicioCod'              = CONVERT( CHAR(1),  ' ' )
         , 'TipoEjercicioDsc'              = CONVERT( VARCHAR(10), 'AMERICANA' )
         , 'PrecioSuperior'                = CONVERT( FLOAT, 0.0 )
         , 'PrecioMedio'                   = CONVERT( FLOAT, 0.0 )
         , 'PrecioPiso'                    = CONVERT( FLOAT, 0.0 )
         , 'MtoPrima'                      = CONVERT( FLOAT, 0.0 )
         , 'FormaPagoPrimaCod'             = CONVERT( NUMERIC(3), 0 )
         , 'FormaPagoPrimaDsc'             = CONVERT( VARCHAR(30), '' )
         , 'MdaPagoPrimaCod'               = CONVERT( NUMERIC(5), 0 ) 
         , 'MdaPagoPrimaDsc'               = CONVERT( VARCHAR(35), '' )
         , 'FechaPagoPrima'                = @FechaDefault
         , 'ApoderadoClienteRut01'         = CONVERT( NUMERIC(9), 0 )
         , 'ApoderadoClienteDv01'          = CONVERT( CHAR(1), 0 )
         , 'ApoderadoClienteNombre01'      = CONVERT( VARCHAR(100), '' )
         , 'ApoderadoClienteDomicilio01'   = CONVERT( VARCHAR(100), '' )
         , 'ApoderadoClienteFax01'         = CONVERT( VARCHAR(50), '' ) 
         , 'ApoderadoClienteFono01'        = CONVERT( VARCHAR(50), '' )
         , 'ApoderadoBancoRut01'           = CONVERT( NUMERIC(9), 0 )
         , 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' )
         , 'ApoderadoBancoNombre01'        = CONVERT( VARCHAR(100), '' )
         , 'ApoderadoBancoDomicilio01'     = CONVERT( VARCHAR(100), '' )
       , 'ApoderadoBancoFax01'          = CONVERT( VARCHAR(50), '' )
         , 'ApoderadoBancoFono01'          = CONVERT( VARCHAR(50), '' )
         , 'MtoPrecioSuperior'             = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioMedio'                = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioPiso'                 = CONVERT( FLOAT, 0.0 )
         , 'ReceptorPrima'                 = CONVERT( VARCHAR(100), '' )
         , 'PagadorPrima'                  = CONVERT( VARCHAR(100), '' )
         , 'Control'                       = CONVERT( VARCHAR(250), '' )
      INTO #Resultado -- Genera tabla con el registro vacío

    CREATE INDEX INumContrato ON #Resultado(NumContrato,NumComponente )

    -- Estrategria
    -- Cargar tabla con los datos Fixing por fecha
    -- mediante update aplicar los datos de:
    -- CaEncContrato, CaDetContrato, CaVenEncContrato y CaVenEncContrato
    -- por ahora tratar de mantener información historica junto con 
    -- la vigente, si el desempeño no mejora separamos la cosa.
    SELECT DISTINCT
           'Reporte'                       = CONVERT( VARCHAR(40), 'CONTRATO LEGAL' )
         , 'TipReg'                        = CONVERT( VARCHAR(10), 'CONTRATO'  )
         , 'NumContrato'                   = CONVERT( NUMERIC(8), Fix.CaNumContrato )
         , 'CaNumEstructura'               = CONVERT( NUMERIC(6), Fix.CaNumEstructura )
         , 'CliRut'                        = CONVERT( NUMERIC(13), Enc.CaRutCliente )
         , 'CliCod'                        = CONVERT( NUMERIC(5), Enc.CaCodigo )
         , 'CliDv'                         = CONVERT( CHAR(1), ISNULL( Cliente.ClDv, '' )   )
         , 'CliNom'                        = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no esta en BAC' ) )
         , 'Operador'                      = CONVERT( VARCHAR(15), Enc.CaOperador )
         , 'OpcEstCod'                     = CONVERT( VARCHAR(2), Enc.CaCodEstructura )
         , 'OpcEstDsc'                     = CONVERT( VARCHAR(30), ISNULL(  Estructura.OpcEstDsc  , 'Estructura no Existe'  ) )  
         , 'OpcCompraEstrucutura'          = CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre          ELSE Cliente.ClNombre END )
         , 'OpcVENDeEstrucutura'           = CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre          END )
         , 'NumComponente'                 = CONVERT( NUMERIC(6), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0 ELSE Fix.CaNumEstructura END )
         , 'PayOffTipCod'                  = CONVERT( VARCHAR(2), Det.CaTipoPayOff ) 
         , 'PayOffTipDsc'                  = CONVERT( VARCHAR(20), upper( PayOffTipo.PayOffTipDsc ) ) 
         , 'CallPut'                       = CONVERT( VARCHAR(5), UPPER( CASE WHEN Det.CaVinculacion = 'Estructura' THEN 'N/A' ELSE Det.CaCallPut END ) )
         , 'CVOpcCod'                      = CONVERT( VARCHAR(3), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 'N/A' ELSE Det.CaCVOpc END )
         , 'CompraVentaOpcDsc'             = CONVERT( VARCHAR(6), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 'N/A' WHEN Det.CaCVOpc = 'C' THEN 'Compra' ELSE 'Venta' END )
         , 'FechaContrato'                 = Enc.CaFechacontrato    -- FECHA
         , 'FechaPagoEjer'                 = Det.CaFechaPagoEjer    -- FECHA
         , 'FechaVcto'                     = Det.CaFechaVcto        -- FECHA
         , 'FechaCG'                       = ISNULL( Cliente.FECHA_FIRMA_NUEVO_CCG, @FechaDefault ) -- FECHA select * from lnkbac.BacParamSuda.dbo.cliente
         , 'ChkFechaCG'                    = CONVERT( CHAR(1), ISNULL( Cliente.NUEVO_CCG_FIRMADO, 'N' ) )
         , 'FechaCGComp'                   = ISNULL( clFechaFirma_cond_Opc, @FechaDefault )  -- FECHA
         , 'ChkFechaCGComp'                = CONVERT( NUMERIC(1), ISNULL( clFechaFirma_cond_OpcChk, 0 ) )
         , 'FechaCGSup'                    = ISNULL( clFechaFirma_Supl_Opc, @FechaDefault )  -- FECHA
         , 'ChkFechaCGSup'          = CONVERT( NUMERIC(1), clFechaFirma_Supl_OpcChk, 0 )
         , 'Mon1Cod'                       = CONVERT( NUMERIC(5), Det.CaCodMon1 )
         , 'Mon1Dsc'                       = CONVERT( CHAR(35), ISNULL( MonedaM1.MnGlosa, 'Moneda M1 no existe' )  )
         , 'MontoMon1'                     = CONVERT( NUMERIC(21,6), Det.CaMontoMon1 )
         , 'MontoMon1Strangle'             = CONVERT( NUMERIC(21,6), 0 )
         , 'MontoMon2Straddle'             = CONVERT( NUMERIC(21,6), 0 )
         , 'Mon2Cod'                       = CONVERT( NUMERIC(5), Det.CaCodMon2 )
         , 'Mon2Dsc'                       = CONVERT( CHAR(35), ISNULL( MonedaM2.MnGlosa, 'Moneda M2 no existe' ) )
         , 'MontoMon2'                     = CONVERT( NUMERIC(21,6), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0 ELSE Det.CaMontoMon2 END )
         , 'ModalidadCod'                  = CONVERT( VARCHAR(1), Det.CaModalidad  )
         , 'ModalidadDsc'                  = CONVERT( VARCHAR(15), CASE WHEN Det.CaModalidad  = 'E' THEN 'Entrega Fis.' ELSE 'Compensación' END  )
         , 'MdaCompensacionCod'            = CONVERT( NUMERIC(5), CaMdaCompensacion ) 
         , 'MdaCompensacionDsc'            = CONVERT( VARCHAR(35), ISNULL( MdaComp.MnGlosa, 'Moneda Comp. no existe' )  )
         , 'Strike'                        = CONVERT( FLOAT, CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0.0 ELSE  Det.CaStrike END )
         , 'NumeroFijacion'                = CONVERT( NUMERIC(6), Fix.CaFixNumero )
         , 'FechaFijacion'                 = Fix.cafixFecha -- FECHA
         , 'PesoFijacion'                  = CONVERT( FLOAT, Fix.CaPesoFij )
         , 'FixBenchCompCod'               = CONVERT( NUMERIC(5), Fix.CaFixBenchComp )
         , 'FixBenchCompDsc'               = CONVERT( VARCHAR(40),BenchFix.BenchMarkDescripcion )
         , 'FixBenchCompHora'              = CONVERT( VARCHAR(8), BenchFix.BenchMarkHora, 108 ) 
         , 'FixBenchEsEditable'            = CONVERT( VARCHAR(1), BenchFix.BenchEditable ) 
         , 'FixBenchMdaCodValorDef'        = CONVERT( NUMERIC(5), BenchFix.BenchMdaCodValorDef )
         , 'FixBenchMdaCodValorDefValor'   = CONVERT( FLOAT, ISNULL(  DefectoBench.vmvalor, 0 ) )  
         , 'FixParBench'                   = CONVERT( VARCHAR(7), Fix.CaFixParBench ) 
         , 'FixEstado'                     = CONVERT( VARCHAR(1), Fix.CaFixEstado ) 
         , 'FixValorFijacion'              = CONVERT( FLOAT, Fix.CaFijacion )
         , 'EstadoEjercicioCod'            = CONVERT( VARCHAR(2), ISNULL( CaCajEstado, 'NE' ) )
         , 'EstadoEjercicioDsc'            = CONVERT( VARCHAR(20), '' )
         , 'EstadoMotorPagoCod'            = CONVERT( VARCHAR(2), ISNULL( CaCajMotorPago, 'NE' ) )
         , 'EstadoMotorPagoDsc'            = CONVERT( VARCHAR(20), '' )
         , 'Refijable'                     = CONVERT( VARCHAR(10), 'RE-FIJABLE' )
         , 'Usuario'                       = CONVERT( VARCHAR(15), @Usuario )
         , 'Anno'                          = CONVERT( VARCHAR(4), '2000' )
         , 'Banco'                         = CONVERT( VARCHAR(16), substring( @Nombre, 1, 16 ) )            
         , 'Rut'                           = CONVERT( NUMERIC(9), @Rut )
         , 'Dv'                            = CONVERT( VARCHAR(1), @Dv )
         , 'FechaContratoLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )   
         , 'FechaCondGeneLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )
         , 'FechaCondGeneOpcLarga'         = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )   
         , 'FechaCondGeneOpcSupLarga'      = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )   
         , 'TipoEjercicioCod'              = CONVERT( VARCHAR(1),  CaTipoEjercicio ) 
         , 'TipoEjercicioDsc'              = CONVERT( VARCHAR(10), CASE WHEN CaTipoEjercicio = 'E' THEN  'EUROPEA' ELSE 'AMERICANA' END  )
         , 'PrecioSuperior'                = CONVERT( FLOAT, 0.0 )
 , 'PrecioMedio'                   = CONVERT( FLOAT, 0.0 )
         , 'PrecioPiso'                    = CONVERT( FLOAT, 0.0 )
         , 'MtoPrima'                      = CONVERT( FLOAT, CaPrimaInicial )  
         , 'FormaPagoPrimaCod'             = CONVERT( NUMERIC(3), CafPagoPrima )   
         , 'FormaPagoPrimaDsc'             = CONVERT( VARCHAR(30), ISNULL( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )
         , 'MdaPagoPrimaCod'               = CONVERT( NUMERIC(5) , CaCodMonPagPrima ) 
         , 'MdaPagoPrimaDsc'               = CONVERT( VARCHAR(35), ISNULL( MonedaPrima.MnGlosa, 'Moneda Prima no existe' )  )  
         , 'FechaPagoPrima'                = CaFechaPagoPrima
         , 'ApoderadoClienteRut01'         = CONVERT( NUMERIC(9), 0 )
         , 'ApoderadoClienteDv01'          = CONVERT( VARCHAR(1), 0 )
         , 'ApoderadoClienteNombre01'      = CONVERT( VARCHAR(100), '' )
         , 'ApoderadoClienteDomicilio01'   = CONVERT( VARCHAR(100), '' )
         , 'ApoderadoClienteFax01'         = CONVERT( VARCHAR(50), '' ) 
         , 'ApoderadoClienteFono01'        = CONVERT( VARCHAR(50), '' )
         , 'ApoderadoBancoRut01'           = CONVERT( NUMERIC(9), 0 )
         , 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' )
         , 'ApoderadoBancoNombre01'        = CONVERT( VARCHAR(100), '' )
         , 'ApoderadoBancoDomicilio01'     = CONVERT( VARCHAR(100), '' )
         , 'ApoderadoBancoFax01'           = CONVERT( VARCHAR(50), '' ) 
         , 'ApoderadoBancoFono01'          = CONVERT( VARCHAR(50), '' )
         , 'MtoPrecioSuperior'             = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioMedio'                = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioPiso'                 = CONVERT( FLOAT, 0.0 )
         , 'ReceptorPrima'                 = CONVERT( VARCHAR(100), CASE WHEN CaPrimaInicial > 0
                                                                         THEN @Nombre
                                                                         ELSE LEFT( ISNULL( Cliente.ClNombre, 'Cliente no esta en BAC' ), 100 ) 
                                                                    END  )
         , 'PagadorPrima'                  = CONVERT( VARCHAR(100), CASE WHEN CaPrimaInicial <= 0
                                                                         THEN @Nombre
                                                                         ELSE LEFT( ISNULL( Cliente.ClNombre, 'Cliente no esta en BAC' ), 100 )
                                                                    END  )
         , 'Control'                       = CONVERT( VARCHAR(250), '' )
      into #Fixing
      from CaVenFixing                             Fix 
           LEFT JOIN dbo.Benchmark                 BenchFix         ON BenchFix.BenchMarkCod         = Fix.CaFixBenchComp     
           LEFT JOIN BacParamSudaValor_Moneda      DefectoBench     ON Fix.cafixFecha                = DefectoBench.VmFecha
                                                                   AND BenchFix.BenchMdaCodValorDef  = DefectoBench.vmcodigo
           LEFT JOIN dbo.CaVenCaja                    Caj              ON Caj.CanumContrato             = Fix.CaNumContrato
                                                                   AND Caj.CaNumEstructura           = Fix.CaNumEstructura
                                                                   AND Caj.CaCajOrigen              <> 'PP'
         , dbo.CaVenDetContrato                        Det
           LEFT JOIN PayOffTipo                                     ON PayOffTipo.PayOffTipCod       = Det.CaTipoPayOff 
           -- POR HACER: cambiar a BDOpciones.BacParamMoneda
           LEFT JOIN LnkBac.BacParamSuda.dbo.Moneda MonedaM1        ON MonedaM1.MnCodMon             = Det.CaCodMon1
           LEFT JOIN LnkBac.BacParamSuda.dbo.Moneda MonedaM2        ON MonedaM2.MnCodMon             = Det.CaCodMon2
           LEFT JOIN LnkBac.BacParamSuda.dbo.Moneda MdaComp         ON MdaComp.MnCodMon              = Det.CaMdaCompensacion
         , CaVenEncContrato                            Enc
           LEFT JOIN lnkbac.BacParamSuda.dbo.cliente Cliente         ON Cliente.ClRut                 = Enc.CaRutCliente
                                                                    AND Cliente.ClCodigo              = Enc.CaCodigo 
           LEFT JOIN OpcionEstructura               Estructura      ON Estructura.OpcEstCod          = Enc.CaCodEstructura 
           LEFT JOIN LnkBac.BacParamSuda.dbo.Forma_de_Pago
                                                    FormaPagoPrima  ON FormaPagoPrima.Codigo         = Enc.CafPagoPrima
           LEFT JOIN LnkBac.BacParamSuda.dbo.Moneda MonedaPrima     ON MonedaPrima.MnCodMon          = Enc.CaCodMonPagPrima
           LEFT JOIN breakBacParamSudaCLIENTE       CGOp            ON CGOp.ClRut                    = Cliente.ClRut 
                                                                   AND CGOp.ClCodigo                 = Cliente.ClCodigo
         , IMPRESION IMP
     WHERE Det.CaNumContrato   = Fix.CaNumContrato
       AND Det.CaNumEstructura = Fix.CaNumEstructura 
       AND Enc.CaNumContrato   = Det.CaNumContrato
       AND Enc.CanumContrato   = IMP.ImpNumContrato
       AND ImpGrupo            = @Grupo

    SELECT CaNumContrato
         , CaStrike
         , Cnt = count(1)
      INTO #Precios 
      FROM dbo.CaVenDetContrato 
           INNER JOIN IMPRESION ON caNumCOntrato = ImpNumContrato AND ImpGrupo            = @Grupo  -- MAP 20091216 
     GROUP BY CaNumContrato , CaStrike

    IF EXISTS( SELECT (1) FROM #Fixing  )
    BEGIN
        UPDATE #Fixing 
           SET EstadoEjercicioDsc          = CASE WHEN EstadoEjercicioCod = 'NE' THEN 'No hay' 
                                                  WHEN EstadoEjercicioCod = 'E'  THEN 'Ejercido'
                                                  WHEN EstadoEjercicioCod = 'N'  THEN 'Cancelado'
                                                  WHEN EstadoEjercicioCod = 'P'  THEN 'Decisión PENDiente'
                                                                                 ELSE 'ERROR'
                                             END
            -- Motor de pagos es solo informativo
            ,  EstadoMotorPagoDsc          = CASE WHEN EstadoMotorPagoCod = 'P'  THEN 'PENDiente'
                                                  WHEN EstadoMotorPagoCod = 'G'  THEN 'Generado en BAC'
                                                  WHEN EstadoMotorPagoCod = 'NE' THEN 'No hay'
                                                                                 ELSE 'ERROR'
                                             END
            -- Se puede fijar si la fecha fijacion es futura 
            -- y  CaCaja esta con estado 'P' o no existe 
            ,  Refijable                   = CASE WHEN FechaFijacion <= @FechaProceso AND EstadoEjercicioCod in ( 'P', 'NE' )
                                                  THEN 'FIJABLE' 
                                                  ELSE 'NO-FIJABLE'
                                             END   
            , FechaContratoLarga           = dbo.FormatFecha( FechaContrato )
            , FechaCondGeneLarga           = dbo.FormatFecha( FechaCG )
            , FechaCondGeneOpcLarga        = dbo.FormatFecha( FechaCGComp )
            , FechaCondGeneOpcSupLarga     = dbo.FormatFecha( FechaCGSup )
            , PrecioSuperior               = CASE WHEN OpcEstCod in ( 4, 5) 
                                                  THEN ( SELECT CaStrike FROM #Precios WHERE #Precios.CaNumContrato = #Fixing.NumContrato AND cnt = 2 ) -- Precio Forward
                                                  ELSE ( SELECT MAX( CaStrike ) FROM CaVenDetContrato Dx WHERE CanumContrato = NumContrato )                                         
   END                                         
       , PrecioPiso       = CASE WHEN OpcEstCod in ( 4, 5)
                                                  THEN ( SELECT CaStrike FROM #Precios WHERE #Precios.CaNumContrato = #Fixing.NumContrato AND cnt = 1 ) -- Precio Cota
                                                  ELSE ( SELECT MIN( CaStrike ) FROM CaVenDetContrato Dx WHERE CanumContrato = NumContrato )
                                             END     
            , ApoderadoClienteRut01        = CONVERT( NUMERIC(9), ISNULL( ( SELECT TOP 1 aprutapo
                                                                              FROM lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                              WHERE aprutcli = #Fixing.CLIRUT
                                                                                AND ApCodCli = #Fixing.CLICOD 
                                                                                AND ( aprutapo = @RutRepCli01 or @RutRepCli01 = 0 )
                                                                          ), 0 ) )
            , ApoderadoClienteDv01         = CONVERT( VARCHAR(1), ISNULL( ( SELECT TOP 1 apdvapo
                                                                              FROM lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                             WHERE aprutcli = #Fixing.CLIRUT
                                                                               AND ApCodCli = #Fixing.CLICOD 
                                                                               AND ( aprutapo = @RutRepCli01 or @RutRepCli01 = 0 )
                                                                          ), 0 ) ) 
            , ApoderadoClienteNombre01     = CONVERT( VARCHAR(100), ISNULL( ( SELECT TOP 1 apNombre
                                                                                FROM lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                               WHERE aprutcli = #Fixing.CLIRUT
                                                                                 and ApCodCli = #Fixing.CLICOD 
                                                                                 AND ( aprutapo = @RutRepCli01 or @RutRepCli01 = 0 )
                                                                            ), 'No hay apoderados definidos' ) )
            , ApoderadoClienteDomicilio01  = CONVERT( VARCHAR(100), ISNULL( ( SELECT TOP 1 cldirecc
                                                                                FROM BacParamSudaCliente C
                                                                               WHERE C.clrut    = #Fixing.CLIRUT
                                                                                 AND C.clcodigo = #Fixing.CLICOD), '' ) )
            , ApoderadoClienteFax01        = CONVERT( VARCHAR(50), ISNULL( ( SELECT TOP 1 ClFax
                                                                               FROM BacParamSudaCliente C
                                                                              WHERE C.clrut    = #Fixing.CLIRUT
                                                                                AND C.clcodigo = #Fixing.CLICOD), '' ) ) 
            , ApoderadoClienteFono01       = CONVERT( VARCHAR(50), ISNULL( ( SELECT TOP 1 ClFono
                                                                               FROM BacParamSudaCliente C
                                                                              WHERE C.clrut    = #Fixing.CLIRUT
                                                                                AND C.clcodigo = #Fixing.CLICOD), '' ) )
            , ApoderadoBancoRut01          = CONVERT( NUMERIC(9), ISNULL( ( SELECT TOP 1 aprutapo
               FROM lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                        WHERE aprutcli      = @Rut 
                                                                               AND ApCodCli      = @Codigo
                                                                               AND @RutRepBan01 in ( aprutapo, 0 )
                                                                          ), 0 ) )
            , ApoderadoBancoDv01          = CONVERT( VARCHAR(1), ISNULL( ( SELECT TOP 1 apdvapo
                                                                             FROM lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                            WHERE aprutcli       = @Rut 
                                                                              AND ApCodCli       = @Codigo 
                                                                              AND @RutRepBan01  in ( aprutapo, 0 )
                                                                         ), 0 ) )
            , ApoderadoBancoNombre01      = CONVERT( VARCHAR(100), ISNULL( ( SELECT TOP 1 apNombre
                                                                               FROM lnkbac.bacparamsuda.dbo.Cliente_Apoderado
                                                                              WHERE aprutcli       = @Rut 
                                                                                AND ApCodCli       = @Codigo 
                                                                                AND @RutRepBan01  in ( aprutapo, 0 )
                                                                           ), 'No hay apoderados definidos'  ) )
            , ApoderadoBancoDomicilio01   = CONVERT( VARCHAR(100), @Domicilio )
            , ApoderadoBancoFax01         = CONVERT( VARCHAR(50), @Fax ) 
            , ApoderadoBancoFono01        = CONVERT( VARCHAR(50), @Fono )
            , Control                     = CASE WHEN FechaCG = '19000101' THEN '- FECHA CONDICIONES GENERALES '  ELSE '' END
                                          + CASE WHEN ChkFechaCG = 'N' THEN '- FIRMA CONDICIONES GENERALES ' ELSE '' END
                                          + CASE WHEN FechaCGComp = '19000101' THEN '- COMPLEMENTO ' ELSE '' END 
                                          + CASE WHEN ChkFechaCGComp = 0 THEN '- FIRMA COMPLEMENTO ' ELSE '' END  
                                          + CASE WHEN FechaCGSup = '19000101' THEN '- SUPLEMENTO '  ELSE '' END   -- MAP 12 Nov. FechaCGSup
                                          + CASE WHEN ChkFechaCGSup = 0 THEN '- FIRMA SUPLEMENTO '  ELSE '' END   -- MAP 12 NOv. FechaCGSup

        -- Calculo del Precio Medio
        UPDATE #Fixing
           SET PrecioMedio                    = ISNULL( ( SELECT MAX( CaStrike )
                                                            FROM CaVenDetContrato Dx
                                                           WHERE Dx.CaStrike      > PrecioPiso
                                                             AND Dx.CaStrike      < PrecioSuperior
                                                             AND Dx.Canumcontrato = NumContrato
                                                        ), 0)    

             , Control                        = CASE WHEN  Control <> '' THEN 'CONTRATO NO VÁLIDO.  FALTA : ' + Control  ELSE '' END


        UPDATE #Fixing
           SET MtoPrecioSuperior              = CONVERT( FLOAT, round( MontoMon1 * PrecioSuperior, 0 ) )
             , MtoPrecioMedio                 = CONVERT( FLOAT, round( MontoMon1 * PrecioMedio   , 0 ) )
             , MtoPrecioPiso                  = CONVERT( FLOAT, round( MontoMon1 * PrecioPiso    , 0 ) )

        UPDATE #Fixing
           SET MontoMon1Strangle              = ( SELECT DISTINCT MontoMon1
                                                    FROM #Fixing
                                                   WHERE OpcEstCod  = '3'
                   AND #Fixing.NumContrato  = Det.CaNumContrato
                                                     AND CaNumEstructura     in ( 3, 4 ) ) 
             , MontoMon2Straddle              = ( SELECT DISTINCT MontoMon1
                                                    FROM #Fixing
                                                   WHERE OpcEstCod            = '3'
                                                     AND #Fixing.NumContrato  = Det.CaNumContrato
                                                     AND CaNumEstructura     in ( 1, 2 ) ) 
          FROM dbo.CaVenDetContrato  Det
         WHERE OpcEstCod           = '3'
           AND #Fixing.NumContrato = Det.CaNumContrato


        DELETE #resultado
        INSERT INTO #resultado
               SELECT *
                 FROM #fixing
                ORDER BY NumCOntrato, NumComponente

    END

    -- Se despliega el registro Sin Datos.
    SELECT Reporte
         , TipReg
         , NumContrato
         , CaNumEstructura
         , CliRut
         , CliCod
         , CliDv
         , CliNom
         , Operador
         , OpcEstCod
         , OpcEstDsc
         , OpcCompraEstrucutura
         , OpcVENDeEstrucutura
         , NumComponente
         , PayOffTipCod
         , PayOffTipDsc
         , CallPut
         , CVOpcCod
         , CompraVentaOpcDsc
         , 'FechaContrato'                 = CONVERT( VARCHAR(10), FechaContrato, 103 )
         , 'FechaPagoEjer'                 = CONVERT( VARCHAR(10), FechaPagoEjer, 103 )
         , 'FechaVcto'                     = CONVERT( VARCHAR(10), FechaVcto, 103 )
         , 'FechaCG'                       = CONVERT( VARCHAR(10), FechaCG, 103 )
         , ChkFechaCG
         , 'FechaCGComp'                   = CONVERT( VARCHAR(10), FechaCGComp, 103 ) 
         , ChkFechaCGComp
         , 'FechaCGSup'                    = CONVERT( VARCHAR(10), FechaCGSup, 103 ) 
         , ChkFechaCGSup
         , Mon1Cod
         , Mon1Dsc
         , MontoMon1
         , MontoMon1Strangle
         , MontoMon2Straddle
         , Mon2Cod
         , Mon2Dsc
         , MontoMon2
         , ModalidadCod
         , ModalidadDsc
         , MdaCompensacionCod
         , MdaCompensacionDsc
         , Strike
         , NumeroFijacion
         , 'FechaFijacion'                 = CONVERT( VARCHAR(10), FechaFijacion, 103 )    
         , PesoFijacion
         , FixBenchCompCod
         , FixBenchCompDsc
         , FixBenchCompHora
         , FixBenchEsEditable
         , FixBenchMdaCodValorDef
         , FixBenchMdaCodValorDefValor
         , FixParBench
         , FixEstado
         , FixValorFijacion
         , EstadoEjercicioCod
         , EstadoEjercicioDsc
         , EstadoMotorPagoCod
         , EstadoMotorPagoDsc
         , Refijable
         , Usuario
         , Anno
         , Banco
         , Rut
         , Dv
         , FechaContratoLarga
         , FechaCondGeneLarga
         , FechaCondGeneOpcLarga
         , FechaCondGeneOpcSupLarga
         , TipoEjercicioCod
         , TipoEjercicioDsc
         , PrecioSuperior
         , PrecioMedio
         , PrecioPiso
         , MtoPrima
         , FormaPagoPrimaCod
         , FormaPagoPrimaDsc
         , MdaPagoPrimaCod
         , MdaPagoPrimaDsc
         , 'FechaPagoPrima'                = CONVERT( VARCHAR(10), FechaPagoPrima, 103 )                
         , ApoderadoClienteRut01
         , ApoderadoClienteDv01
         , ApoderadoClienteNombre01
         , ApoderadoClienteDomicilio01
         , ApoderadoClienteFax01
         , ApoderadoClienteFono01
         , ApoderadoBancoRut01
         , ApoderadoBancoDv01
         , ApoderadoBancoNombre01
         , ApoderadoBancoDomicilio01
         , ApoderadoBancoFax01
         , ApoderadoBancoFono01
         , MtoPrecioSuperior
         , MtoPrecioMedio
         , MtoPrecioPiso
         , ReceptorPrima
         , PagadorPrima
       , Control



      FROM #Resultado

END
GO
