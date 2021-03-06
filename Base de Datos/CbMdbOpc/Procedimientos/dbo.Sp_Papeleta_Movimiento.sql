USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Papeleta_Movimiento]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Papeleta_Movimiento]

       (  

         @Usuario Varchar(15)             

       , @NumGrupo numeric(8)  

       )  

AS  

BEGIN              

  

    SET NOCOUNT ON  

               

    -- MAP 23 Octubre 2009 Inclusión de Concepto de Tipo de Cambio implícito en la prima    

    -- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente     

    -- ASVG 25 Febrero 2011 Se agrega plazo restante de la opción, calculado en días, para reporte/papeleta  

 -- ASVG 03 Marzo 2011 Se obtiene fecha de inicio/vencimiento desde cartera, ya que en movimiento se van pisando.  

 -- ASVG 15 Marzo 2011 Se agrega valor dolar observado para cálculo de monto a pagar por compensación.  

 -- ASVG 17 Marzo 2011 Se obtiene fecha de inicio/vencimiento desde histórico, ya que en movimiento se van pisando.  

      

    DECLARE @Nombre       VARCHAR(120)  

    DECLARE @Dv           CHAR(1)  

    DECLARE @FechaProceso DATETIME  

    DECLARE @NombreBanco  VARCHAR(60)  

    DECLARE @FaxBanco     VARCHAR(30)  

 DECLARE @ValorDO    NUMERIC(21,6)  

 DECLARE @FechaAnterior DATETIME  

  

    -- sp_papeleta_movimiento 11 , 'MMMM'     

    -- sp_papeleta_movimiento 780 , 'MMMM'    select * from MoEncContrato  

    SELECT @NombreBanco  = nombre  

         , @FaxBanco     = fax  

         , @FechaProceso = fechaproc  

  , @FechaAnterior = fechaant  

      FROM dbo.Opcionesgeneral  

  

    SELECT *  

      INTO #Moneda  

      FROM bacparamsuda.dbo.Moneda  

  

    SELECT DISTINCT  

           ClRut  

         , ClCodigo  

         , ClDv  

         , ClNombre  

         , ClFax  

      INTO #Cliente  

      FROM bacparamsuda.dbo.View_ClienteParaOpc  

         , MoEncContrato   

     WHERE Clrut         = MoEncContrato.MoRutCliente   

       AND ClCodigo      = MoEncContrato.MoCodigo   

  

 SELECT @ValorDO = vmvalor  

 from bacparamsuda.dbo.VALOR_MONEDA --ASVG_20110317 se usa linkserver.  

 where vmcodigo = 994 AND vmfecha = @FechaProceso  

  

    --ASVG_20110317 comentado. SET @FechaProceso = ''  

  

    SELECT *  

      INTO #Formas_Pago  

      FROM bacparamsuda.dbo.Forma_de_Pago   

  

    SELECT *  

      INTO #Tabla_General_Detalle  

      FROM bacparamsuda.dbo.Tabla_general_detalle   

     WHERE tbcateg IN ( 204, 1111, 1552, 1553, 1554 )  

  

    SELECT *  

      INTO #GEN_SISTEMAS  

      FROM BacParamSuda.dbo.SISTEMA_CNT   

  

    -- 1. Se asume que no hay registros, se crea la tabla y se llena con el registro de "NO HAY DATOS"  

    Select 'Producto'                = 'PAPELETA CONTRATO OPCIONES'  

         , 'NumContrato'             = CONVERT( NUMERIC(8), 0 )  

         , 'NumFolio'                = CONVERT( NUMERIC(8), 0 )  

         , 'TipoTransaccion'         = CONVERT( VARCHAR(10), 'SIN DATOS' )  

         , 'FechaContrato'           = CONVERT( DATETIME, '',112)  

         , 'ConOpcEstCod'             = CONVERT( CHAR(1), '' )  

         , 'ConOpcEstDsc'            = CONVERT( VARCHAR(30), '' )  

         , 'CliRut'                   = CONVERT( NUMERIC(13), 0 )  

         , 'CliCod'                  = CONVERT( NUMERIC(5), 0 )  

         , 'CliDv'                   = CONVERT( CHAR(1), ''   )  

         , 'CliNom'                   = CONVERT( VARCHAR(100), '' )  

         , 'Operador'                = CONVERT( VARCHAR(15), '' )  

         , 'OpcEstCod'               = CONVERT( VARCHAR(2), '' )  

         , 'OpcEstDsc'               = CONVERT( VARCHAR(40), '' )    

         , 'Contrapartida'           = CONVERT( VARCHAR(8), '' )  

         , 'CVEstructura'            = CONVERT( CHAR(1), '' )  

         , 'CompraVentaEstructura'   = CONVERT( VARCHAR(6), '' )  

         , 'MonPagPrimaCod'          = CONVERT( NUMERIC(5), 0 )  

         , 'MonPagPrimaDsc'          = CONVERT( CHAR(35), '' )  

         , 'fPagoPrimaCod'           = CONVERT( NUMERIC(3), 0 )  

         , 'fPagoPrimaDsc'           = CONVERT( CHAR(30), '' )  

         , 'PrimaInicial'          = CONVERT( FLOAT, 0.0 )  

         , 'FechaPagoPrima'          = CONVERT( DATETIME, '' ,112)  

         , 'CarteraFinancieraCod'    = CONVERT( VARCHAR(6), '' )  

         , 'CarteraFinancieraDsc'    = CONVERT( CHAR(50), '' )  

         , 'CarteraNormativaCod'     = CONVERT( VARCHAR(6), '' )  

         , 'CarteraNormativaDsc'     = CONVERT( CHAR(50), '' )  

         , 'LibroCod'                = CONVERT( VARCHAR(6), '' )   

         , 'LibroDsc'                = CONVERT( CHAR(50), '' )  

         , 'AreaResponsalbleCod'     = CONVERT( VARCHAR(6), '' )     

         , 'AreaResponsalbleDsc'     = CONVERT( VARCHAR(50),'' )   

  

         , 'SubCarNormativaCod'      = CONVERT( VARCHAR(6), '' )  

         , 'SubCarNormativaDsc'      = CONVERT( VARCHAR(50), '' )  

  

         , 'MonPrimaTrfCod'          = CONVERT( NUMERIC(5), 0 )  

         , 'MonPrimaTrfDsc'  = CONVERT( VARCHAR(35), '' )    

         , 'PrimaTranferencia'       = CONVERT( FLOAT, 0.0 )  

         , 'PrimaTranferenciaML'     = CONVERT( FLOAT, 0.0 )  

  

         , 'MonPrimaCostoCod'        = CONVERT( NUMERIC(5), 0 )  

         , 'MonPrimaCostoDsc'        = CONVERT( VARCHAR(35), '' )  

         , 'PrimaCosto'              = CONVERT( FLOAT, 0.0 )  

         , 'PrimaCostoML'            = CONVERT( FLOAT, 0.0 )  

  

         , 'MonPrimaCarryCod'        = CONVERT( NUMERIC(5), 0 )  

         , 'MonPrimaCarryDsc'        = CONVERT( VARCHAR(35), '' )   

         , 'PrimaCarry'              = CONVERT( FLOAT, 0.0 )  

  

         , 'MonVrCod'                = CONVERT( NUMERIC(5), 0 )  

         , 'MonVrDsc'                = CONVERT( VARCHAR(35), '' )  

         , 'Vr'                      = CONVERT( FLOAT, 0.0 )  

         , 'Vr_Costo'                = CONVERT( FLOAT, 0.0 )  

  

         , 'FechaUnwind'             = CONVERT( DATETIME, '' , 112 )   

         , 'NominalUnwind'           = CONVERT( FLOAT,  0.0  )   

         , 'UnwindMonCod'            = CONVERT( NUMERIC(5), 0 )  

         , 'UnwindMonDsc'            = CONVERT( VARCHAR(35), '' )  

  

         , 'Unwind'                  = CONVERT( NUMERIC(21,4), 0.0 )  

         , 'UnwindML'                = CONVERT( NUMERIC(21,4), 0.0 )  

         , 'FormPagoUnwindCod'       = CONVERT( NUMERIC(3), 0 )  

         , 'FormPagoUnwindDsc'       = CONVERT( VARCHAR(30), '' )  

  

         , 'UnwindTransfMonCod'      = CONVERT( NUMERIC(5), 0 )   

         , 'UnwindTransfMonDsc'      = CONVERT( VARCHAR(35), '' )   

         , 'UnwindTransf'            = CONVERT( NUMERIC(21,4), 0.0 )  

         , 'UnwindTransfML'          = CONVERT( NUMERIC(21,4), 0.0 )  

  

         , 'Glosa'                   = CONVERT( VARCHAR(80), '' )  

         , 'Usuario'                 = CONVERT( VARCHAR(15), @Usuario )  

         , 'FechaProceso'            = CONVERT( DATETIME, 0, 112 ) --ASVG_20110317 comentado. CONVERT( DATETIME, @FechaProceso, 112 )  

         , 'FechaCreacionRegistro'   = CONVERT( DATETIME, '', 112 )  

         , 'CliFax'                  = CONVERT( VARCHAR(30), ' N/A ' )  

         , 'NombreBanco'             = CONVERT( VARCHAR(60), ISNULL( @NombreBanco, ' N/A ' ) )  

         , 'FaxBanco'                = CONVERT( VARCHAR(30), ISNULL( @FaxBanco, ' N/A ' ) )  

         , 'PrimaInicialML'          = CONVERT( FLOAT, 0.0  )  

         , 'TCM_Prima'               = CONVERT( FLOAT, 0.0  )  

         , 'ResultadoVta'            = CONVERT( FLOAT, 0.0 )  

         --PAE  

         , 'GlosaPAE'                   = CONVERT( VARCHAR(20),'')  

         -- Fin de datos que será leidos en el encabezado  

  

         , 'OpcTipCod'               = CONVERT( CHAR(1), '' )  

         , 'OpcTipDsc'               = CONVERT( VARCHAR(20), '' )  

         , 'SubyacenteCod'           = CONVERT( CHAR(3), '' )  

         , 'SubyacenteDsc'           = CONVERT( VARCHAR(40) , '' )  

         , 'NumEstructura'           = CONVERT( NUMERIC(6), 0 )  

         , 'PayOffTipCod'            = CONVERT( VARCHAR(2), '' )  

         , 'PayOffTipDsc'            = CONVERT( VARCHAR(20), '' )  

         , 'CallPut'                 = CONVERT( VARCHAR(5), '' )  

         , 'CVOpcCod'                = CONVERT( VARCHAR(3), '' )  

         , 'CompraVentaOpcDsc'       = CONVERT( VARCHAR(6), '' )  

         , 'TipoEmisionPTCod'        = CONVERT( VARCHAR(3), '' )  

   , 'TipoEmisionPTDsc'        = CONVERT( VARCHAR(8), '' )  

         , 'FechaInicioOpc'          = CONVERT( DATETIME, '', 112 )  

  

         , 'FechaFijacionOpc'        = CONVERT( DATETIME, '', 112 )  

         , 'FechaVcto'               = CONVERT( DATETIME, '', 112 )  

         , 'FechaPagoEjer'           = CONVERT( DATETIME, '', 112 )  

         , 'FechaPagMon1'            = CONVERT( DATETIME, '', 112 )  

         , 'FechaPagMon2'            = CONVERT( DATETIME, '', 112 )  

  

         , 'Mon1Cod'                 = CONVERT( NUMERIC(5), 0 )  

         , 'Mon1Dsc'                 = CONVERT( VARCHAR(35), ''  )  

         , 'MontoMon1'               = CONVERT( NUMERIC(21,6), 0 )  

  

         , 'FormaPagoMon1Cod'        = CONVERT( NUMERIC(3), 0 )  

         , 'FormaPagoMon1Dsc'    = CONVERT( VARCHAR(30), '' )  

  

  , 'MoFormaPagoComp'   = CONVERT( NUMERIC(3), 0 )    

         , 'MoFormaPagoCompDsc'   = CONVERT( VARCHAR(30), 0)     

    

         , 'Mon2Cod'                 = CONVERT( NUMERIC(5), 0 )  

         , 'Mon2Dsc'                 = CONVERT( VARCHAR(35), '' )  

         , 'MontoMon2'               = CONVERT( NUMERIC(21,6), 0 ) -- ASVG_20110324 Este campo debría tener el monto compensado, lo que ahorra la búsqueda del dolar observado. REVISAR  

         , 'FormaPagoMon2Cod'        = CONVERT( NUMERIC(3), 0 )  

         , 'FormaPagoMon2Dsc'        = CONVERT( VARCHAR(30), ''  )  

         , 'ModalidadCod'            = CONVERT( VARCHAR(1), ''  )  

         , 'ModalidadDsc'            = CONVERT( VARCHAR(15), ''  )  

  

         , 'MdaCompensacionCod'      = CONVERT( NUMERIC(5), 0 )  

         , 'MdaCompensacionDsc'      = CONVERT( VARCHAR(35), ''  )  

  

         , 'BenchCompCod'            = CONVERT( NUMERIC(5), 0 )  

         , 'BenchCompDsc'            = CONVERT( VARCHAR(40), ''  )  

  

         , 'ParStrike'               = CONVERT( VARCHAR(7), ''  )  

         , 'Strike'                  = CONVERT( FLOAT, 0.0 )  

         , 'PorcStrike'              = CONVERT( FLOAT, 0.0 )  

  

         , 'TipoEjercicioCod'        = CONVERT( CHAR(1), ''  )   

         , 'TipoEjercicioDsc'        = CONVERT( VARCHAR(10) , ''  )  

         , 'VrDet'                   = CONVERT( FLOAT, 0.0 )  

         , 'IteAsoSisCod'            = CONVERT( CHAR(3), '' )  

         , 'IteAsoSisDsc'            = CONVERT( VARCHAR(20), '' )  

         , 'IteAsoCon'               = CONVERT( NUMERIC(8), 0.0  )  

  

   -- Campos que involucran Cartera  

   , 'PlazoDiasRestantes'   = CONVERT( NUMERIC(6), 0 ) --ASVG_20110225_20110303 Plazo en días restantes  

   , 'FechaVencimiento'   = CONVERT( DATETIME, ' ', 112 ) --ASVG_20110302 Fecha de vencimiento desde cartera respaldo  

   , 'NocionalRemanente'   = CONVERT( NUMERIC(21,6), 0 ) --ASVG_20110317 Nocional remanente desde cartera respaldo  

   , 'FechaInicio'    = CONVERT( DATETIME, ' ', 112 ) --ASVG_20110303 Fecha de inicio/cierre/ingreso del contrato (primer movimiento de creación)  

   , 'ValorDO'     = CONVERT( NUMERIC(21,6), 0 ) -- ASVG_20110315 Valor DO  

  

         -- Fin de Datos que serán leidos desde Detalle  

  

         , 'FixFecha'                = CONVERT( DATETIME, ' ', 112 )  

         , 'FixNumero'               = CONVERT( NUMERIC(6), 0 )  

         , 'PesoFij'                 = CONVERT( FLOAT, 100.0 )  

         , 'VolFij'                  = CONVERT( FLOAT, 0.0 )  

         , 'Fijacion'                = CONVERT( FLOAT, 0.0 )  

         , 'FixBenchCompCod'         = CONVERT( NUMERIC(5), 0 )  

         , 'FixBenchCompDsc'         = CONVERT( VARCHAR(40), ' ' )  

         , 'FixParStrike'            = CONVERT( VARCHAR(7), ' ' )  

         , 'FixEstadoCod'            = CONVERT( CHAR(1), ' ' )  

         , 'FixEstadoDsc'            = CONVERT( VARCHAR(10) , 'No Fijado'  )  

         -- FIn de Datos que serán leidos desde Fixing  

  

       INTO #Resultado    

  

    -- 2. Se navega el encabezado y se lleva info a tabla #Encabezado  

    SELECT 'Producto'                = 'PAPELETA CONTRATO OPCIONES'  

         , 'NumContrato'             = CONVERT( NUMERIC(8), Movimiento.MoNumContrato )  

         , 'NumFolio'                = CONVERT( NUMERIC(8), Movimiento.MoNumFolio )  

         , 'TipoTransaccion'         = CONVERT( VARCHAR(10), Movimiento.MoTipoTransaccion )  

         , 'FechaContrato'           = CONVERT( DATETIME, Movimiento.MoFechaContrato,112)  

         , 'ConOpcEstCod'            = CONVERT( CHAR(1), Movimiento.MoEstado )  

         , 'ConOpcEstDsc'            = CONVERT( VARCHAR(30), ISNULL( Estado.ConOpcEstDsc,  'Estado no Existe' ) )  

         , 'CliRut'                  = CONVERT( NUMERIC(13), Movimiento.MoRutCliente )  

         , 'CliCod'                  = CONVERT( NUMERIC(5), Movimiento.MoCodigo )  

         , 'CliDv'                   = CONVERT( CHAR(1), ISNULL( Cliente.ClDv, ' '  ) )  

         , 'CliNom'                  = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )  

         , 'Operador'                = CONVERT( VARCHAR(15), Movimiento.MoOperador )  

         , 'OpcEstCod'               = CONVERT( VARCHAR(2), Movimiento.MoCodEstructura  )  

         , 'OpcEstDsc'               = CONVERT( VARCHAR(40), ISNULL( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )    

         , 'Contrapartida'           = CONVERT( VARCHAR(8), Movimiento.MoTipoContrapartida )  

         , 'CVEstructura'            = CONVERT( VARCHAR(1), Movimiento.MoCVEstructura )  

         , 'CompraVentaEstructura'   = CONVERT( VARCHAR(6), CASE WHEN Movimiento.MoCVEstructura = 'C' THEN 'COMPRA' ELSE 'VENTA' END )  

         , 'MonPagPrimaCod'          = CONVERT( NUMERIC(5), Movimiento.MoCodMonPagPrima )  

         , 'MonPagPrimaDsc'          = CONVERT( VARCHAR(35), ISNULL( MonedaPrima.MnGlosa, 'Moneda Prima no existe' ) )  

         , 'fPagoPrimaCod'           = CONVERT( NUMERIC(3), Movimiento.MofPagoPrima )  

         , 'fPagoPrimaDsc'           = CONVERT( VARCHAR(30), ISNULL( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )  

  

         , 'PrimaInicial'            = CONVERT( FLOAT, Movimiento.MoPrimaInicial )  

         , 'FechaPagoPrima'          = CONVERT( DATETIME, Movimiento.MoFechaPagoPrima,112)  

  

         , 'CarteraFinancieraCod'    = CONVERT( VARCHAR(6), Movimiento.MoCarteraFinanciera )  

         , 'CarteraFinancieraDsc'    = CONVERT( VARCHAR(50), ISNULL( Financiera.tbglosa, 'Cartera Fin. no exite' ) )  

         , 'CarteraNormativaCod'     = CONVERT( VARCHAR(6), Movimiento.MoCarNormativa )  

         , 'CarteraNormativaDsc'     = CONVERT( VARCHAR(50), ISNULL( Normativa.tbglosa, 'Catera Normativa no existe' ) )  

         , 'LibroCod'                = CONVERT( VARCHAR(6), Movimiento.MoLibro )   

         , 'LibroDsc'                = CONVERT( VARCHAR(50), ISNULL( Libro.tbglosa, 'Libro no existe' ) )  

         , 'AreaResponsalbleCod'     = CONVERT( VARCHAR(6), 6 )   -- Mesa de dinero siempre no tenemos el campo  

         , 'AreaResponsalbleDsc'     = CONVERT( VARCHAR(50), ISNULL( Responsable.tbglosa, 'No existe area responsable' )  )   -- Mesa de dinero siempre no tenemos el campo  

  

         , 'SubCarNormativaCod'      = CONVERT( VARCHAR(6), MoSubCarNormativa )  

         , 'SubCarNormativaDsc'      = CONVERT( VARCHAR(50), ISNULL( SubCartera.tbglosa,  'Falto SubCarNormatica'  ) )  

  

         , 'MonPrimaTrfCod'          = CONVERT( NUMERIC(5), Movimiento.MoMonPrimaTrf )  

         , 'MonPrimaTrfDsc'          = CONVERT( VARCHAR(35), ISNULL( MonedaPrimaTranf.MnGlosa, 'Moneda Prima Traf. no existe' ) )    

       , 'PrimaTranferencia'       = CONVERT( FLOAT, Movimiento.MoPrimaTrf )  

         , 'PrimaTranferenciaML'     = CONVERT( FLOAT, Movimiento.MoPrimaTrfML )  

  

         , 'MonPrimaCostoCod'        = CONVERT( NUMERIC(5), Movimiento.MoMonPrimaCosto )  

         , 'MonPrimaCostoDsc'        = CONVERT( VARCHAR(35), ISNULL( MonedaPrimaCosto.MnGlosa, 'Moneda Prima Costo. no existe' )  )  

         , 'PrimaCosto'              = CONVERT( FLOAT, Movimiento.MoPrimaCosto )  

         , 'PrimaCostoML'            = CONVERT( FLOAT, Movimiento.MoPrimaCostoML )  

  

         , 'MonPrimaCarryCod'        = CONVERT( NUMERIC(5), Movimiento.MoMonCarryPrima )  

         , 'MonPrimaCarryDsc'        = CONVERT( VARCHAR(35), ISNULL( MonedaPrimaCarry.MnGlosa, 'Moneda Prima Carry. no existe' ) )   

         , 'PrimaCarry'              = CONVERT( FLOAT, Movimiento.MoCarryPrima )  

  

         , 'MonVrCod'                = CONVERT( NUMERIC(5), Movimiento.MoMon_Vr )  

         , 'MonVrDsc'                = CONVERT( VARCHAR(35), ISNULL( MonedaVr.MnGlosa, 'Moneda Vr no existe' ) )  

         , 'Vr'                      = CONVERT( FLOAT, Movimiento.MoVr )  

         , 'Vr_Costo'                = CONVERT( FLOAT, Movimiento.MoVr_Costo )  

  

         , 'FechaUnwind'             = CONVERT( DATETIME, Movimiento.MoFechaUnwind , 112 )   

         , 'NominalUnwind'           = CONVERT( FLOAT, ISNULL( Movimiento.MoNominalUnwind    , 0.0 ) )   

         , 'UnwindMonCod'            = CONVERT( NUMERIC(5), ISNULL( MoUnwindMon, 0.0 ) )  

         , 'UnwindMonDsc'            = CONVERT( VARCHAR(35), ISNULL( MonedaUnwind.MnGlosa, 'Moneda Unwind no existe' ) )  

  

         , 'Unwind'                  = CONVERT( NUMERIC(21,4), ISNULL( Movimiento.MoUnwind, 0.0 ) )  

         , 'UnwindML'                = CONVERT( NUMERIC(21,4), ISNULL( Movimiento.MoUnwindML, 0.0 ) )  

         , 'FormPagoUnwindCod'       = CONVERT( NUMERIC(3), ISNULL( Movimiento.MoFormPagoUnwind, 0.0 ) )  

         , 'FormPagoUnwindDsc'       = CONVERT( VARCHAR(30), ISNULL( FormaPagoUnwind.glosa, 'Forma Pago Unwind no existe' ) )  

  

         , 'UnwindTransfMonCod'      = CONVERT( NUMERIC(5), ISNULL( Movimiento.MoUnwindTransfMon, 0.0 ) )   

         , 'UnwindTransfMonDsc'      = CONVERT( VARCHAR(35), ISNULL( MonedaUnwindTrf.MnGlosa, 'Moneda Traf. Unwind no existe' ) )   

         , 'UnwindTransf'            = CONVERT( NUMERIC(21,4) , ISNULL( Movimiento.MoUnwindTransf, 0.0 ) )  

         , 'UnwindTransfML'          = CONVERT( NUMERIC(21,4) , ISNULL( Movimiento.MoUnwindTransfML, 0.0 ) )  

  

         , 'Glosa'                   = CONVERT( VARCHAR(80), ISNULL( Movimiento.MoGlosa , ' ' ) )  

         , 'Usuario'                 = CONVERT( VARCHAR(15), @Usuario )  

         , 'FechaProceso'            = CONVERT( DATETIME, @FechaProceso, 112 )  

         , 'FechaCreacionRegistro'   = CONVERT( DATETIME , ISNULL( Movimiento.MoFechaCreacionRegistro, '' ) )  

         , 'CliFax'                  = CONVERT( CHAR(30) , ISNULL( Cliente.ClFax , ' N/A ' ) )  

         , 'NombreBanco'             = CONVERT( CHAR(60) , ISNULL( @NombreBanco , ' N/A ' ) )  

         , 'FaxBanco'                = CONVERT( CHAR(60) , ISNULL( @FaxBanco , ' N/A ' ) )  

  

         -- MAP 23 Octubre 2009 Inclusión de Concepto de Tipo de Cambio implícito en la prima  

         , 'PrimaInicialML'          = CONVERT( FLOAT, Movimiento.MoPrimaInicialML )  

         , 'TCM_Prima'               = CONVERT( FLOAT,  (CASE WHEN Movimiento.MoPrimaInicial = 0 THEN 0.0 ELSE Movimiento.MoPrimaInicialML END)  

                                                      / (CASE WHEN Movimiento.MoPrimaInicial = 0 THEN 1.0 ELSE Movimiento.MoPrimaInicial   END ) )  

         , 'ResultadoVta'            = CONVERT( FLOAT, Movimiento.MoResultadoVentasML )  

         --PAE  

         , 'GlosaPAE'                = CONVERT( VARCHAR(20) , CASE WHEN Movimiento.MoRelacionaPAE = 1 THEN 'PAE Estructurado' ELSE ' ' END )    

      INTO #Encabezado  

      FROM dbo.MoEncContrato                Movimiento  

           LEFT JOIN #Cliente               Cliente           ON Cliente.clRut             = Movimiento.MoRutCliente  

                                                             AND Cliente.clCodigo          = Movimiento.MoCodigo  

           LEFT JOIN #Moneda                MonedaUnwindTrf   ON MonedaUnwindTrf.MnCodMon  = Movimiento.MoUnwindTransfMon                 

           LEFT JOIN #Formas_Pago           FormaPagoUnwind   ON FormaPagoUnwind.Codigo    = Movimiento.MoFormPagoUnwind   

           LEFT JOIN #Formas_Pago           FormaPagoPrima    ON FormaPagoPrima.Codigo     = Movimiento.MofPagoPrima   

           LEFT JOIN #Moneda                MonedaUnwind      ON MonedaUnwind.MnCodMon     = Movimiento.MoUnwindMon  

           LEFT JOIN #Moneda         MonedaPrimaCosto  ON MonedaPrimaCosto.MnCodMon = Movimiento.MoMonPrimaCosto  

           LEFT JOIN #Moneda                MonedaPrimaCarry  ON MonedaPrimaCarry.MnCodMon = Movimiento.MoMonCarryPrima   

           LEFT JOIN #Moneda                MonedaPrima       ON MonedaPrima.MnCodMon      = Movimiento.MoCodMonPagPrima  

           LEFT JOIN #Moneda                MonedaPrimaTranf  ON MonedaPrimaTranf.MnCodMon = Movimiento.MoMonPrimaTrf  

           LEFT JOIN #Moneda                MonedaVr          ON MonedaVr.MnCodMon         = Movimiento.MoMon_Vr  

           LEFT JOIN ConOpcEstado           Estado            ON Estado.ConOpcEstCod       = Movimiento.MoEstado  

           LEFT JOIN OpcionEstructura       Estructura        ON Estructura.OpcEstCod      = Movimiento.MoCodEstructura  

           LEFT JOIN #TABLA_GENERAL_DETALLE Financiera        ON Financiera.tbcateg        = 204  

                                                             AND Financiera.tbcodigo1      = MoCarteraFinanciera  

           LEFT JOIN #TABLA_GENERAL_DETALLE Normativa         ON Normativa.tbcateg         = 1111  

                                                             AND Normativa.tbcodigo1       = MoCarNormativa  

           LEFT JOIN #TABLA_GENERAL_DETALLE Libro             ON Libro.tbcateg             = 1552  

                                                             AND Libro.tbcodigo1           = MoLibro  

           LEFT JOIN #TABLA_GENERAL_DETALLE Responsable       ON Responsable.tbcateg       = 1553  

                                                             AND Responsable.tbcodigo1     = 6 -- No tenemos area responsable !!!  

           LEFT JOIN #TABLA_GENERAL_DETALLE SubCartera        ON SubCartera.tbcateg        = 1554  

                          AND SubCartera.tbcodigo1      = MoSubCarNormativa    

           INNER JOIN dbo.Impresion         Imp               ON Imp.impgrupo              = @NumGrupo  

                                                             AND Imp.ImpFolio              = Movimiento.MoNumFolio  

  

    -- 3. Se navega el detalle y se genera #Detalle (se le adosó la información #Encabezado).  

    SELECT #Encabezado.*  

         , 'OpcTipCod'           = CONVERT( CHAR(1),  MovDet.MoTipoOpc )  

         , 'OpcTipDsc'           = CONVERT( VARCHAR(20), ISNULL( OpcionTipo.OpcTipDsc, 'No existe Tipo de Opción' ) )  

         , 'SubyacenteCod'       = CONVERT( CHAR(3), MovDet.MoSubyacente )  

         , 'SubyacenteDsc'       = CONVERT( VARCHAR(40), ISNULL( Subyacente.SubyacenteDescripcion, 'No existe Subyacente' ) )  

         , 'NumEstructura'       = CONVERT( NUMERIC(6), MovDet.MoNumEstructura )  

         , 'PayOffTipCod'        = CONVERT( VARCHAR(2), MovDet.MoTipoPayOff )  

         , 'PayOffTipDsc'        = CONVERT( VARCHAR(20), ISNULL( PayOffTipo.PayOffTipDsc, 'PayOff no existe' ) )  

         , 'CallPut'             = CONVERT( VARCHAR(5), MovDet.MoCallPut )  

         , 'CVOpcCod'            = CONVERT( VARCHAR(3), MovDet.MoCVOpc )  

         , 'CompraVentaOpcDsc'   = CONVERT( VARCHAR(6), CASE WHEN MovDet.MoCVOpc = 'C' THEN 'Compra' ELSE 'Venta' END )  

         , 'TipoEmisionPTCod'    = CONVERT( VARCHAR(3), MovDet.MoTipoEmisionPT )  

         , 'TipoEmisionPTDsc'    = CONVERT( VARCHAR(8), CASE WHEN MovDet.MoTipoEmisionPT = 'P' THEN 'Propia' ELSE 'Terceros' END  )  

         , 'FechaInicioOpc'      = CONVERT( DATETIME, MovDet.MoFechaInicioOpc, 112 )  

  

         , 'FechaFijacionOpc'    = CONVERT( DATETIME, MovDet.MoFechaFijacion, 112 )  

         , 'FechaVcto'           = CONVERT( DATETIME, MovDet.MoFechaVcto, 112 )  

         , 'FechaPagoEjer'       = CONVERT( DATETIME, MovDet.MoFechaPagoEjer, 112 )  

         , 'FechaPagMon1'        = CONVERT( DATETIME, MovDet.MoFechaPagMon1, 112 )  

         , 'FechaPagMon2'        = CONVERT( DATETIME, MovDet.MoFechaPagMon2, 112 )  

  

         , 'Mon1Cod'             = CONVERT( NUMERIC(5), MovDet.MoCodMon1 )  

         , 'Mon1Dsc'             = CONVERT( VARCHAR(35), ISNULL( MonedaM1.MnGlosa, 'Moneda M1 no existe' ) )  

         , 'MontoMon1'           = CONVERT( NUMERIC(21,6), MovDet.MoMontoMon1 )  

  

         , 'FormaPagoMon1Cod'    = CONVERT( NUMERIC(3), MovDet.MoFormaPagoMon1 )  

         , 'FormaPagoMon1Dsc'    = CONVERT( VARCHAR(30), FormaPagoM1.Glosa )  

  

 /*ecc*/  

  , 'MoFormaPagoComp'   = CONVERT( NUMERIC(3), MovDet.MoFormaPagoComp )    

         , 'MoFormaPagoCompDsc'   = CONVERT( VARCHAR(30), FormaPagoM3.Glosa )      

  

    

         , 'Mon2Cod'             = CONVERT( NUMERIC(5), MovDet.MoCodMon2 )  

         , 'Mon2Dsc'             = CONVERT( VARCHAR(35), ISNULL( MonedaM2.MnGlosa, 'Moneda M2 no existe' ) )  

         , 'MontoMon2'           = CONVERT( NUMERIC(21,6), MovDet.MoMontoMon2 )  

         , 'FormaPagoMon2Cod'    = CONVERT( NUMERIC(3), MovDet.MoFormaPagoMon2 )  

         , 'FormaPagoMon2Dsc'    = CONVERT( VARCHAR(30), FormaPagoM2.Glosa )  

         , 'ModalidadCod'        = CONVERT( VARCHAR(1), MoModalidad )  

         , 'ModalidadDsc'        = CONVERT( VARCHAR(15),  CASE WHEN MovDet.MoModalidad = 'C' THEN 'Compensación' ELSE 'Entrega Fisica' END )  

  

         , 'MdaCompensacionCod'  = CONVERT( NUMERIC(5), MovDet.MoMdaCompensacion )  

         , 'MdaCompensacionDsc'  = CONVERT( VARCHAR(35), ISNULL( MonedaCompensacion.MnGlosa, 'Moneda Compensación no existe' ) )  

  

         , 'BenchCompCod'        = CONVERT( NUMERIC(5), MovDet.MoBenchComp )  

         , 'BenchCompDsc'        = CONVERT( VARCHAR(40), ISNULL( BenchMark.BenchMarkDescripcion, 'No existe BechMark' ) )  

  

         , 'ParStrike'           = CONVERT( VARCHAR(7), MovDet.MoParStrike )  

         , 'Strike'              = CONVERT( FLOAT, MovDet.MoStrike )  

         , 'PorcStrike'          = CONVERT( FLOAT, MovDet.MoPorcStrike )  

  

         , 'TipoEjercicioCod'    = CONVERT( VARCHAR(1), MovDet.MoTipoEjercicio )   

         , 'TipoEjercicioDsc'    = CONVERT( VARCHAR(10) , CASE WHEN MovDet.MoTipoEjercicio = 'E' THEN 'EUROPEA' ELSE 'AMERICANA' END )  

         , 'VrDet'               = CONVERT( FLOAT, MovDet.MoVrDet )  

         , 'IteAsoSisCod'        = CONVERT( CHAR(3), MovDet.MoIteAsoSis )  

         , 'IteAsoSisDsc'        = CONVERT( VARCHAR(20), ISNULL( Sistema.nombre_sistema, 'N/A' ) )  

         , 'IteAsoCon'           = CONVERT( NUMERIC(8), ISNULL( MovDet.MoIteAsoCon, 0 )  )  

  

        , 'PlazoDiasRestantes'   = 1000 * 0  --ASVG_20110225_20110303 Plazo en días restantes    

        , 'FechaVencimiento'     = CONVERT( DATETIME, '19000101', 112 ) --ASVG_20110302 Fecha de vencimiento desde cartera    

        , 'NocionalRemanente'    = 1000000000.0 * 0                     --ASVG_20110302 Nocional remanente desde cartera respaldo    

        , 'FechaInicio'          = CONVERT( DATETIME, '19000101', 112 ) --ASVG_20110303 Fecha de inicio/cierre/ingreso del contrato (primer movimiento)    

        , 'ValorDO'    = CONVERT( NUMERIC(21,6), @ValorDO ) -- ASVG_20110315 Valor DO  

  

      INTO #Detalle  

      FROM #Encabezado  

         , MoDetContrato            MovDet  

 LEFT JOIN OpcionTipo                        ON Opciontipo.OpcTipCod        = MovDet.MoTipoOpc  

           LEFT JOIN Subyacente                        ON Subyacente.Subyacente       = MovDet.MoSubyacente   

           LEFT JOIN PayOffTipo                        ON PayOffTipo.PayOffTipCod     = MovDet.MoTipoPayOff   

           LEFT JOIN #Formas_Pago   FormaPagoM1        ON FormaPagoM1.Codigo          = MovDet.MoFormaPagoMon1  

           LEFT JOIN #Formas_Pago   FormaPagoM2        ON FormaPagoM2.Codigo          = MovDet.MoFormaPagoMon2  

           LEFT JOIN #Formas_Pago   FormaPagoM3        ON FormaPagoM3.Codigo          = MovDet.MoFormaPagoComp  

LEFT JOIN #Moneda        MonedaM1           ON MonedaM1.MnCodMon           = MovDet.MoCodMon1  

           LEFT JOIN #Moneda        MonedaM2           ON MonedaM2.MnCodMon           = MovDet.MoCodMon2  

           LEFT JOIN #Moneda        MonedaCompensacion ON MonedaCompensacion.MnCodMon = MovDet.MoMdaCompensacion  

           LEFT JOIN BenchMark                         ON  BenchMark.BenchMarkCod     = MovDet.MoBenchComp   

           LEFT JOIN #GEN_SISTEMAS  Sistema            ON  Sistema.Id_sistema         = MovDet.MoIteAsoSis  

     WHERE MovDet.MoNumFolio    = #Encabezado.NumFolio  

  

     Update #Detalle

        set PlazoDiasRestantes = CONVERT( NUMERIC(6), DATEDIFF(day, FechaInicioOpc, ( select CaFechaVcto from CaDetContrato 

                                                                                      where CaNumContrato = NumContrato 

                                                                                       and NumEstructura = CaNumEstructura ) ) ) --ASVG_20110225_20110303 Plazo en días restantes

          , FechaVencimiento   = CONVERT( DATETIME, ( select CaFechaVcto from CaDetContrato 

                                                      where CaNumContrato = NumContrato 

                                                      and   NumEstructura = CaNumEstructura ), 112 )       --ASVG_20110302 Fecha de vencimiento desde cartera

          , NocionalRemanente  = CONVERT( NUMERIC(21,6), ( select CaMontoMon1 from CaResDetContrato 

														   where CaNumContrato   = NumContrato 

                                                           and   NumEstructura   = CaNumEstructura 

														   AND   @FechaAnterior  = CaDetFechaRespaldo )) --ASVG_20110302 Nocional remanente desde cartera respaldo

          , FechaInicio        = CONVERT( DATETIME, ( select CaFechaInicioOpc from CaDetContrato

													  where CaNumContrato = NumContrato 

                                                      and   NumEstructura = CaNumEstructura ), 112 )     --ASVG_20110303 Fecha de inicio/cierre/ingreso del contrato (primer movimiento)    

  

  

    -- 3. Se navega tabla Fixing y se genera #resultado (se le adosó la información de #Detalle).    

    -- Todas las operaciones registran Fixing  

    IF EXISTS( SELECT (1)  

                 FROM dbo.MoFixing  Fix  

                    , dbo.Impresion Imp  

                WHERE Imp.impGrupo              = @NumGrupo  

         AND Imp.ImpFolio              = Fix.MoNumFolio  

             )  

    BEGIN  

        TRUNCATE TABLE #Resultado     

        INSERT INTO #Resultado   

               SELECT MovDet.*  

                    , 'FixFecha'        = CONVERT( DATETIME, MoFix.MoFixFecha, 112 )  

                    , 'FixNumero'       = CONVERT( NUMERIC(6), MoFixNumero )  

                    , 'PesoFij'         = CONVERT( FLOAT, MoFix.MoPesoFij )  

                    , 'VolFij'          = CONVERT( FLOAT, MoFix.MoVolFij )  

                    , 'Fijacion'        = CONVERT( FLOAT, MoFix.MoFijacion )  

                    , 'FixBenchCompCod' = CONVERT( NUMERIC(5), MoFix.MoFixBenchComp )  

                    , 'FixBenchCompDsc' = CONVERT( VARCHAR(40), ISNULL( BenchMarkDescripcion, 'NO existe Bench Mark' ) )  

                    , 'FixParStrike'    = CONVERT( VARCHAR(7) , MoFix.MoFixParBench )  

                    , 'FixEstadoCod'    = CONVERT( VARCHAR(1) , MoFix.MoFixEstado )  

                    , 'FixEstadoDsc'    = CONVERT( VARCHAR(10) , CASE WHEN MoFix.MoFixEstado = ' ' THEN 'No Fijado' ELSE 'Fijado' END )  

                     

                 FROM #detalle     MovDet  

  

--                       INNER JOIN dbo.IMPRESION  Imp    ON Imp.impGrupo              = @NumGrupo  

--                                                       AND Imp.ImpFolio              = MovDet.NumFolio  

                      INNER JOIN dbo.MoFixing  MoFix   ON MoFix.MoNumFolio         = MovDet.NumFolio  

                                                      AND MoFix.moNumEstructura    = MovDet.NumEstructura  

                      LEFT JOIN BenchMark              ON  BenchMark.BenchMarkCod   = MoFix.MoFixBenchComp   

                ORDER BY  

                      MovDet.NumEstructura  

  

    END  

  

    -- 4. Se despliega #resultado (#Encabezado + #Detalle + fixing).  

    SELECT *,	'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), 
				'Bannercorto' = (SELECT bannercorto FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), 
				'Bannerlargo' = (SELECT Bannerlargo FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
	FROM #Resultado ORDER BY NumContrato, NumFolio   

  

END

-- Reemplazo Base de datos --
 
GO
