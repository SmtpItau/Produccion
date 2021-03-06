USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CaNivContrato]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_CaNivContrato]    
       (    
         @fecha             DATETIME    
       , @Usuario           VARCHAR(15)    
       , @TipoTransaccion   INT    
       , @NumeroContrato INT = NULL --ASVG_20110330 Para no alterar invocación y funcionamiento    
       )    
AS    
BEGIN    
    
    SET NOCOUNT ON    
    -- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente    
    -- Sp_CaNivContrato '20081211', 'PP', '1'    
         
    DECLARE @Nombre        CHAR(120)    
    DECLARE @Dv            CHAR(1)    
    DECLARE @FechaProceso  DATETIME    
    
 --ASVG_20110425 Número de contrato null en CrystalReports ?    
 -- Se convierte a (int) 0    
    IF @NumeroContrato = 0 BEGIN    
        SET @NumeroContrato = NULL    
    END    
    
    -- Crea Tabla Temporal de Clientes    
    SELECT ClRut    
         , ClCodigo    
         , ClDv    
         , ClNombre     
      INTO #tmpCliente    
      FROM  bacparamsuda.dbo.VIew_ClienteParaOpc    
     WHERE Clrut IN ( SELECT MoRutCliente FROM MoEncContrato UNION SELECT MoRutCliente FROM MoHisEncContrato )    
    
    -- Crea Tabla Temporal de Moneda    
    SELECT mncodmon    
         , mnnemo    
         , mnsimbol    
         , mnglosa    
      INTO #tmpMoneda    
      FROM  bacparamsuda.dbo.Moneda    
    
    --  Crea Tabla Temporal Forma de Pago    
    SELECT codigo    
         , glosa    
         , perfil    
         , codgen glosa2    
      INTO #Formas_Pago    
      FROM  bacparamsuda.dbo.Forma_de_Pago     
    
    -- Crear Tabla Temporal de Tablas Generales    
    SELECT tbcateg    
         , tbcodigo1    
         , tbglosa    
      INTO #Tabla_General_Detalle    
      FROM  bacparamsuda.dbo.Tabla_general_detalle    
     WHERE tbcateg     IN ( 204, 1111, 1552, 1553, 1554 )    
    
    -- Fecha Proceso    
    SELECT @FechaProceso = fechaproc    
      FROM dbo.OpcionesGeneral    
    
    -- 0. Se asume que no hay registros, se crea la tabla y se llena con el registro de "NO HAY DATOS"(Tabla #Encabezado)    
    SELECT 'Reporte'                 = 'CARTERA A NIVEL CONTRATO'    
         , 'NumContrato'             = CONVERT( NUMERIC(8), 0 )    
         , 'NumFolio'                = CONVERT( NUMERIC(8), 0 )    
         , 'FechaContrato'           = CONVERT( DATETIME, '',112)    
         , 'ConOpcEstCod'            = CONVERT( VARCHAR(1), '' )    
         , 'ConOpcEstDsc'            = CONVERT( VARCHAR(30), '' )    
         , 'TipoTransaccion'         = @TipoTransaccion    
         , 'CliRut'                  = CONVERT( NUMERIC(13), 0 )    
         , 'CliCod'                  = CONVERT( NUMERIC(5), 0 )    
         , 'CliDv'                   = CONVERT( VARCHAR(1) , '' )    
         , 'CliNom'                  = CONVERT( VARCHAR(100), '' )    
         , 'Operador'                = CONVERT( VARCHAR(15), '' )    
         , 'OpcEstCod'               = CONVERT( VARCHAR(2), '' )    
         , 'OpcEstDsc'               = CONVERT( VARCHAR(30), '' )    
         , 'CVEstructura'            = CONVERT( VARCHAR(1), '' )    
         , 'CompraVentaEstructura'   = CONVERT( VARCHAR(6), '' )    
         , 'MonPagPrimaCod'          = CONVERT( NUMERIC(5), 0 )    
         , 'MonPagPrimaNemo'         = CONVERT( CHAR(8), '' )    
         , 'PrimaInicial'            = CONVERT( FLOAT, 0.0 )    
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
         , 'MonVrCod'      = CONVERT( NUMERIC(5), 0 )    
         , 'MonVrNemo'               = CONVERT( CHAR(8), '' )    
         , 'Vr'                      = CONVERT( FLOAT, 0.0 )    
         , 'DeltaSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'DeltaForwardCont'        = CONVERT( FLOAT, 0.0 )    
         , 'GammaSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'GammaFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'VegaCont'                = CONVERT( FLOAT, 0.0 )    
         , 'VannaSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'VannaFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'VolgaCont'               = CONVERT( FLOAT, 0.0 )    
         , 'ThetaCont'               = CONVERT( FLOAT, 0.0 )    
         , 'RhoDomCont'              = CONVERT( FLOAT, 0.0 )    
         , 'RhoForCont'              = CONVERT( FLOAT, 0.0 )    
         , 'CharmSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'CharmFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'ZommaSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'ZommaFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'SpeedSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'SpeedFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'Glosa'                   = CONVERT( VARCHAR(80), '' )    
         , 'Usuario'                 = CONVERT( VARCHAR(15), @Usuario )    
         , 'FechaProceso'            = CONVERT( DATETIME, @FechaProceso, 112 )    
         , 'FechaCreacionRegistro'   = CONVERT( DATETIME, '', 112 )    
         , 'CantidadComponentes'     = CONVERT( NUMERIC(3), 0 )    
      INTO #Encabezado    
    
    -- 1. Se asume que no hay registros, se crea la tabla y se llena con el registro de "NO HAY DATOS" (Tabla #Resultado)    
    SELECT 'Reporte'                 = 'CARTERA A NIVEL CONTRATO'    
         , 'NumContrato'             = CONVERT( NUMERIC(8), 0 )    
         , 'NumFolio'                = CONVERT( NUMERIC(8), 0 )    
         , 'FechaContrato'           = CONVERT( DATETIME, '',112)    
         , 'ConOpcEstCod'          = CONVERT( VARCHAR(1), '' )    
         , 'ConOpcEstDsc'            = CONVERT( VARCHAR(30), '' )    
         , 'TipoTransaccion'         = @TipoTransaccion    
         , 'CliRut'                = CONVERT( NUMERIC(13) , 0 )    
         , 'CliCod'                  = CONVERT( NUMERIC(5), 0 )    
         , 'CliDv'                   = CONVERT( VARCHAR(1), '' )    
         , 'CliNom'                = CONVERT( VARCHAR(100), '' )    
         , 'Operador'                = CONVERT( VARCHAR(15) , '' )    
         , 'OpcEstCod'               = CONVERT( VARCHAR(2), '' )    
         , 'OpcEstDsc'               = CONVERT( VARCHAR(30) , '' )    
         , 'CVEstructura'            = CONVERT( VARCHAR(1), '' )    
         , 'CompraVentaEstructura'   = CONVERT( VARCHAR(6), '' )    
         , 'MonPagPrimaCod'          = CONVERT( NUMERIC(5), 0 )    
         , 'MonPagPrimaNemo'         = CONVERT( CHAR(8), '' )    
         , 'PrimaInicial'            = CONVERT( FLOAT, 0.0 )    
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
         , 'MonVrCod'                = CONVERT( NUMERIC(5), 0 )    
         , 'MonVrNemo'               = CONVERT( CHAR(8), '' )    
         , 'Vr'                      = CONVERT( FLOAT, 0.0 )    
         , 'DeltaSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'DeltaForwardCont'        = CONVERT( FLOAT, 0.0 )    
         , 'GammaSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'GammaFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'VegaCont'                = CONVERT( FLOAT, 0.0 )    
         , 'VannaSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'VannaFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'VolgaCont'               = CONVERT( FLOAT, 0.0 )    
         , 'ThetaCont'               = CONVERT( FLOAT, 0.0 )    
         , 'RhoDomCont'              = CONVERT( FLOAT, 0.0 )    
         , 'RhoForCont'              = CONVERT( FLOAT, 0.0 )    
         , 'CharmSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'CharmFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'ZommaSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'ZommaFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'SpeedSpotCont'           = CONVERT( FLOAT, 0.0 )    
         , 'SpeedFwdCont'            = CONVERT( FLOAT, 0.0 )    
         , 'Glosa'                   = CONVERT( VARCHAR(80), '' )    
         , 'Usuario'                 = CONVERT( VARCHAR(15), @Usuario )    
         , 'FechaProceso'            = CONVERT( DATETIME, @FechaProceso, 112 )    
         , 'FechaCreacionRegistro'   = CONVERT( DATETIME, '', 112 )    
         , 'CantidadComponentes'     = CONVERT( NUMERIC(3), 0 )    
      INTO #Resultado    
    
    -- 2. Crear Tabla    
    CREATE TABLE #TempEncabezado    
           (    
             Reporte               VARCHAR(30)    NOT NULL    
           , NumContrato           NUMERIC(8)     NOT NULL    
           , NumFolio              NUMERIC(8)     NOT NULL    
           , FechaContrato         DATETIME       NOT NULL    
           , ConOpcEstCod        VARCHAR(1)     NOT NULL    
           , ConOpcEstDsc          VARCHAR(30)    NOT NULL    
           , TipoTransaccion       INT            NOT NULL    
           , CliRut              NUMERIC(13)    NOT NULL    
           , CliCod                NUMERIC(5)     NOT NULL    
           , CliDv                 VARCHAR(1)     NOT NULL    
           , CliNom              VARCHAR(100)   NOT NULL    
           , Operador              VARCHAR(15)    NOT NULL    
           , OpcEstCod             VARCHAR(2)     NOT NULL    
           , OpcEstDsc             VARCHAR(30)    NOT NULL    
           , CVEstructura          VARCHAR(1)     NOT NULL    
           , CompraVentaEstructura VARCHAR(6)     NOT NULL    
           , MonPagPrimaCod        NUMERIC(5)     NOT NULL    
           , MonPagPrimaNemo       CHAR(8)        NOT NULL    
           , PrimaInicial          FLOAT          NOT NULL    
           , CarteraFinancieraCod  VARCHAR(6)     NOT NULL    
           , CarteraFinancieraDsc  CHAR(50)       NOT NULL    
           , CarteraNormativaCod   VARCHAR(6)     NOT NULL    
           , CarteraNormativaDsc   CHAR(50)       NOT NULL    
           , LibroCod              VARCHAR(6)     NOT NULL    
           , LibroDsc              CHAR(50)       NOT NULL    
           , AreaResponsalbleCod   VARCHAR(6)     NOT NULL    
           , AreaResponsalbleDsc   VARCHAR(50)    NOT NULL    
           , SubCarNormativaCod    VARCHAR(6)     NOT NULL    
           , SubCarNormativaDsc    VARCHAR(50)    NOT NULL    
           , MonVrCod              NUMERIC(5)     NOT NULL    
           , MonVrNemo             CHAR(8)        NOT NULL    
           , Vr                    FLOAT          NOT NULL    
           , DeltaSpotCont         FLOAT          NOT NULL    
           , DeltaForwardCont      FLOAT          NOT NULL    
       , GammaSpotCont         FLOAT          NOT NULL    
           , GammaFwdCont          FLOAT          NOT NULL    
           , VegaCont              FLOAT          NOT NULL    
           , VannaSpotCont         FLOAT          NOT NULL    
           , VannaFwdCont          FLOAT          NOT NULL    
           , VolgaCont             FLOAT          NOT NULL    
           , ThetaCont             FLOAT       NOT NULL    
           , RhoDomCont            FLOAT          NOT NULL    
           , RhoForCont            FLOAT          NOT NULL    
           , CharmSpotCont         FLOAT          NOT NULL    
           , CharmFwdCont          FLOAT          NOT NULL    
           , ZommaSpotCont         FLOAT          NOT NULL    
           , ZommaFwdCont          FLOAT          NOT NULL    
           , SpeedSpotCont         FLOAT          NOT NULL    
           , SpeedFwdCont          FLOAT          NOT NULL    
           , Glosa                 VARCHAR(80)    NOT NULL    
           , Usuario               VARCHAR(15)    NOT NULL    
           , FechaProceso          DATETIME       NOT NULL    
           , FechaCreacionRegistro DATETIME       NOT NULL    
           )    
    
    -- 3. Se navega el encabezado y se lleva info a tabla #Encabezado    
    INSERT INTO #TempEncabezado    
           SELECT 'Reporte'               = 'CARTERA A NIVEL CONTRATO'    
                , 'NumContrato'           = CONVERT( NUMERIC(8), Cartera.CaNumContrato )    
                , 'NumFolio'              = CONVERT( NUMERIC(8), Cartera.CaNumFolio )    
                , 'FechaContrato'         = CONVERT( DATETIME, Cartera.CaFechaContrato, 112 )    
                , 'ConOpcEstCod'          = CONVERT( VARCHAR(1), Cartera.CaEstado )    
                , 'ConOpcEstDsc'          = CONVERT( VARCHAR(30) , ISNULL( Estado.ConOpcEstDsc,  'Estado no Existe' ) )    
                , 'TipoTransaccion'       = CASE WHEN Cartera.CaTipoTransaccion = 'ANTICIPA' THEN 2    
                                                 WHEN Cartera.CaTipoTransaccion = 'CREACION' THEN 1    
                                                 WHEN Cartera.CaTipoTransaccion = 'MODIFICA' THEN 1    
                                                                                             ELSE 3    
                                            END    
                , 'CliRut'                = CONVERT( NUMERIC(13) , Cartera.CaRutCliente )    
                , 'CliCod'                = CONVERT( NUMERIC(5), Cartera.CaCodigo )    
                , 'CliDv'                 = CONVERT( VARCHAR(1), ISNULL( Cliente.ClDv, ' '  ) )    
                , 'CliNom'                = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )    
                , 'Operador'              = CONVERT( VARCHAR(15), Cartera.CaOperador )    
                , 'OpcEstCod'             = CONVERT( VARCHAR(2), Cartera.CaCodEstructura  )    
                --PRD10449 PAE  
                , 'OpcEstDsc'             = CASE WHEN Cartera.CaCodEstructura = 0 AND Cartera.CaRelacionaPAE = 1   
             THEN CONVERT( VARCHAR(30),Estructura.OpcEstDsc + ' - PAE ESTRUCTURADO')  
                ELSE CONVERT( VARCHAR(30), ISNULL( Estructura.OpcEstDsc, 'Estructura no Existe'  ) ) END  
                , 'CVEstructura'          = CONVERT( VARCHAR(1), Cartera.CaCVEstructura )    
                , 'CompraVentaEstructura' = CONVERT( VARCHAR(6), CASE WHEN Cartera.CaCVEstructura = 'C' THEN 'COMPRA' ELSE 'VENTA' END )    
                , 'MonPagPrimaCod'        = CONVERT( NUMERIC(5), Cartera.CaCodMonPagPrima )    
                , 'MonPagPrimaNemo'       = CONVERT( CHAR(8), ISNULL( MonedaPrima.MnNemo, 'Moneda Prima no existe' ) )      
                , 'PrimaInicial'          = CONVERT( FLOAT, Cartera.CaPrimaInicial )    
                , 'CarteraFinancieraCod'  = CONVERT( VARCHAR(6), Cartera.CaCarteraFinanciera )    
                , 'CarteraFinancieraDsc'  = CONVERT( CHAR(50), ISNULL( Financiera.tbglosa, 'Cartera Fin. no exite' ) )    
                , 'CarteraNormativaCod'   = CONVERT( VARCHAR(6), Cartera.CaCarNormativa )    
                , 'CarteraNormativaDsc'   = CONVERT( CHAR(50), ISNULL( Normativa.tbglosa, 'Catera Normativa no existe' ) )    
                , 'LibroCod'              = CONVERT( VARCHAR(6), Cartera.CaLibro )    
                , 'LibroDsc'              = CONVERT( CHAR(50), ISNULL( Libro.tbglosa, 'Libro no existe' ) )    
                , 'AreaResponsalbleCod'   = CONVERT( VARCHAR(6), 6 )                                                               -- Mesa de dinero siempre no tenemos el campo    
                , 'AreaResponsalbleDsc'   = CONVERT( VARCHAR(50), ISNULL( Responsable.tbglosa, 'No existe area responsable' )  )   -- Mesa de dinero siempre no tenemos el campo    
                , 'SubCarNormativaCod'    = CONVERT( VARCHAR(6), Cartera.CaSubCarNormativa )    
                , 'SubCarNormativaDsc'    = CONVERT( VARCHAR(50), ISNULL( SubCartera.tbglosa,  'Falto SubCarNormatica'  ) )    
                , 'MonVrCod'              = CONVERT( NUMERIC(5), Cartera.CaMon_Vr )    
                , 'MonVrNemo'             = CONVERT( CHAR(8), ISNULL( MonedaVr.MnNemo, 'Moneda Vr no existe' ) )    
                , 'Vr'                    = CONVERT( FLOAT, Cartera.CaVr )    
                , 'DeltaSpotCont'         = CONVERT( FLOAT, ISNULL( Cartera.CaDeltaSpotCont, 0.0 ) )    
                , 'DeltaForwardCont'      = CONVERT( FLOAT, ISNULL( Cartera.CaDeltaForwardCont, 0.0 ) )    
                , 'GammaSpotCont'         = CONVERT( FLOAT, ISNULL( Cartera.CaGammaSpotCont, 0.0 ) )    
                , 'GammaFwdCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaGammaFwdCont, 0.0 ) )    
                , 'VegaCont'              = CONVERT( FLOAT, ISNULL( Cartera.CaVegaCont, 0.0 ) )    
                , 'VannaSpotCont'         = CONVERT( FLOAT, ISNULL( Cartera.CaVannaSpotCont, 0.0 ) )    
                , 'VannaFwdCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaVannaFwdCont, 0.0 ) )    
                , 'VolgaCont'             = CONVERT( FLOAT, ISNULL( Cartera.CaVolgaCont, 0.0 ) )    
                , 'ThetaCont'             = CONVERT( FLOAT, ISNULL( Cartera.CaThetaCont, 0.0 ) )    
                , 'RhoDomCont'            = CONVERT( FLOAT, ISNULL( Cartera.CaRhoDomCont, 0.0 ) )    
                , 'RhoForCont'            = CONVERT( FLOAT, ISNULL( Cartera.CaRhoForCont, 0.0 ) )    
                , 'CharmSpotCont'         = CONVERT( FLOAT, ISNULL( Cartera.CaCharmSpotCont, 0.0 ) )    
                , 'CharmFwdCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaCharmFwdCont, 0.0 ) )    
                , 'ZommaSpotCont'         = CONVERT( FLOAT, ISNULL( Cartera.CaZommaspotCont, 0.0 ) )    
                , 'ZommaFwdCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaZommaFwdCont, 0.0 ) )    
                , 'SpeedSpotCont'         = CONVERT( FLOAT, ISNULL( Cartera.CaSpeedSpotCont, 0.0 ) )    
                , 'SpeedFwdCont'          = CONVERT( FLOAT, ISNULL( Cartera.CaSpeedFwdCont, 0.0 ) )    
                , 'Glosa'                 = CONVERT( VARCHAR(80), ISNULL( Cartera.CaGlosa , ' ' ) )    
                , 'Usuario'               = CONVERT( VARCHAR(15), @Usuario )    
                , 'FechaProceso'          = CONVERT( DATETIME, @FechaProceso, 112 )    
                , 'FechaCreacionRegistro' = CONVERT( DATETIME, ISNULL( Cartera.CaFechaCreacionRegistro, '' ) )    
             FROM dbo.CaEncContrato                   Cartera    
                  LEFT JOIN #tmpCliente               Cliente           ON Cliente.ClRut             = Cartera.CaRutCliente    
                                                                       AND Cliente.ClCodigo          = Cartera.CaCodigo    
                  LEFT JOIN #tmpMoneda                MonedaUnwindTrf   ON MonedaUnwindTrf.MnCodMon  = Cartera.CaUnwindTransfMon    
                  LEFT JOIN #Formas_Pago              FormaPagoUnwind   ON FormaPagoUnwind.Codigo    = Cartera.CaFormPagoUnwind    
                  LEFT JOIN #Formas_Pago              FormaPagoPrima    ON FormaPagoPrima.Codigo     = Cartera.CafPagoPrima     
                  LEFT JOIN #tmpMoneda                MonedaUnwind      ON MonedaUnwind.MnCodMon     = Cartera.CaUnwindMon    
                  LEFT JOIN #tmpMoneda                MonedaSpeed       ON MonedaSpeed.MnCodMon      = Cartera.CaMon_Speed    
LEFT JOIN #tmpMoneda          MonedaZomma       ON MonedaZomma.MnCodMon      = Cartera.CaMon_Zomma    
                  LEFT JOIN #tmpMoneda                MonedaCharm       ON MonedaCharm.MnCodMon      = Cartera.CaMon_Charm    
                  LEFT JOIN #tmpMoneda                MonedaRhof        ON MonedaRhof.MnCodMon       = Cartera.CaMon_Rhof    
                  LEFT JOIN #tmpMoneda                MonedaRho         ON MonedaRho.MnCodMon        = Cartera.CaMon_Rho    
                  LEFT JOIN #tmpMoneda                MonedaVolga       ON MonedaVolga.MnCodMon      = Cartera.CaMon_Volga    
                  LEFT JOIN #tmpMoneda                MonedaVanna       ON MonedaVanna.MnCodMon      = Cartera.CaMon_Vanna    
                  LEFT JOIN #tmpMoneda                MonedaVega        ON MonedaVega.MnCodMon       = Cartera.CaMon_Vega    
                  LEFT JOIN #tmpMoneda                MonedaGamma       ON MonedaGamma.MnCodMon      = Cartera.CaMon_Gamma    
                  LEFT JOIN #tmpMoneda                MonedaDelta       ON MonedaDelta.MnCodMon      = Cartera.CaMonDelta    
                  LEFT JOIN #tmpMoneda                MonedaPrima       ON MonedaPrima.MnCodMon      = Cartera.CaCodMonPagPrima    
                  LEFT JOIN #tmpMoneda                MonedaPrimaTranf  ON MonedaPrimaTranf.MnCodMon = Cartera.CaMonPrimaTrf    
                  LEFT JOIN #tmpMoneda                MonedaPrimaCosto  ON MonedaPrimaCosto.MnCodMon = Cartera.CaMonPrimaCosto    
                  LEFT JOIN #tmpMoneda                MonedaPrimaCarry  ON MonedaPrimaCarry.MnCodMon = Cartera.CaMonCarryPrima    
                  LEFT JOIN #tmpMoneda                MonedaVr          ON MonedaVr.MnCodMon         = Cartera.CaMon_Vr    
                  LEFT JOIN dbo.ConOpcEstado          Estado            ON Estado.ConOpcEstCod       = Cartera.CaEstado    
                  LEFT JOIN dbo.OpcionEstructura      Estructura        ON Estructura.OpcEstCod      = Cartera.CaCodEstructura    
                  LEFT JOIN #Tabla_General_Detalle    Financiera        ON Financiera.tbcateg        = 204    
                                                                       AND Financiera.tbcodigo1      = Cartera.CaCarteraFinanciera    
                  LEFT JOIN #Tabla_General_Detalle    Normativa         ON Normativa.tbcateg         = 1111    
                                                                       AND Normativa.tbcodigo1       = Cartera.CaCarNormativa    
                  LEFT JOIN #Tabla_General_Detalle    Libro             ON Libro.tbcateg             = 1552    
                                                                       AND Libro.tbcodigo1           = Cartera.CaLibro    
                  LEFT JOIN #Tabla_General_Detalle    Responsable       ON Responsable.tbcateg       = 1553    
                                                                       AND Responsable.tbcodigo1     = 6         -- No tenemos area responsable !!!    
                  LEFT JOIN #Tabla_General_Detalle    SubCartera        ON SubCartera.tbcateg        = 1554    
                                                                       AND SubCartera.tbcodigo1      = Cartera.CaSubCarNormativa    
            WHERE Cartera.CaEstado <> 'C'    
     AND (Cartera.CaNumContrato = @NumeroContrato OR @NumeroContrato IS NULL) --ASVG_20110330 Filtrado por número de contrato    
    
    -- 4. Se navega el encabezadoRes y se lleva info a tabla #EncabezadoRes    
    INSERT INTO #TempEncabezado    
           SELECT 'Reporte'               = 'CARTERA A NIVEL CONTRATO'    
                , 'NumContrato'           = CONVERT( NUMERIC(8), CarteraRes.CaNumContrato )    
                , 'NumFolio'              = CONVERT( NUMERIC(8), CarteraRes.CaNumFolio )    
                , 'FechaContrato'         = CONVERT( DATETIME, CarteraRes.CaFechaContrato,112)    
                , 'ConOpcEstCod'          = CONVERT( VARCHAR(1), CarteraRes.CaEstado )    
                , 'ConOpcEstDsc'          = CONVERT( VARCHAR(30), ISNULL( Estado.ConOpcEstDsc,  'Estado no Existe' ) )    
                , 'TipoTransaccion'       = CASE CarteraRes.CaTipoTransaccion WHEN 'ANTICIPA' THEN 2    
                                                                              WHEN 'CREACION' THEN 1    
                                                                              WHEN 'MODIFICA' THEN 1    
                                                                                              ELSE 3    
                                            END    
                , 'CliRut'                = CONVERT( NUMERIC(13), CarteraRes.CaRutCliente )    
                , 'CliCod'                = CONVERT( NUMERIC(5), CarteraRes.CaCodigo )    
                , 'CliDv'                 = CONVERT( VARCHAR(1), ISNULL( Cliente.ClDv, ' '  ) )    
                , 'CliNom'                = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )    
                , 'Operador'              = CONVERT( VARCHAR(15), CarteraRes.CaOperador )    
                , 'OpcEstCod'             = CONVERT( VARCHAR(2), CarteraRes.CaCodEstructura  )    
                --PRD10449 PAE  
                , 'OpcEstDsc'             = CASE WHEN CarteraRes.CaCodEstructura = 0 AND CarteraRes.CaRelacionaPAE = 1   
             THEN CONVERT( VARCHAR(30),Estructura.OpcEstDsc + ' - PAE ESTRUCTURADO')  
                ELSE CONVERT( VARCHAR(30), ISNULL( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )    END  
                , 'CVEstructura'          = CONVERT( VARCHAR(1), CarteraRes.CaCVEstructura )    
                , 'CompraVentaEstructura' = CONVERT( VARCHAR(6), CASE WHEN CarteraRes.CaCVEstructura = 'C' THEN 'COMPRA' ELSE 'VENTA' END )    
                , 'MonPagPrimaCod'        = CONVERT( NUMERIC(5), CarteraRes.CaCodMonPagPrima )    
                , 'MonPagPrimaNemo'       = CONVERT( CHAR(8), ISNULL( MonedaPrima.MnNemo, 'Moneda Prima no existe' ) )    
                , 'PrimaInicial'          = CONVERT( FLOAT, CarteraRes.CaPrimaInicial )    
                , 'CarteraFinancieraCod'  = CONVERT( VARCHAR(6), CarteraRes.CaCarteraFinanciera )    
                , 'CarteraFinancieraDsc'  = CONVERT( CHAR(50), ISNULL( Financiera.tbglosa, 'Cartera Fin. no exite' ) )    
                , 'CarteraNormativaCod'   = CONVERT( VARCHAR(6), CarteraRes.CaCarNormativa )    
                , 'CarteraNormativaDsc'   = CONVERT( CHAR(50), ISNULL( Normativa.tbglosa, 'Catera Normativa no existe' ) )    
                , 'LibroCod'              = CONVERT( VARCHAR(6), CarteraRes.CaLibro )     
                , 'LibroDsc'              = CONVERT( CHAR(50), ISNULL( Libro.tbglosa, 'Libro no existe' ) )    
                , 'AreaResponsalbleCod'   = CONVERT( VARCHAR(6), 6 )                                                               -- Mesa de dinero siempre no tenemos el campo    
                , 'AreaResponsalbleDsc'   = CONVERT( VARCHAR(50), ISNULL( Responsable.tbglosa, 'No existe area responsable' )  )   -- Mesa de dinero siempre no tenemos el campo    
                , 'SubCarNormativaCod'    = CONVERT( VARCHAR(6), CarteraRes.CaSubCarNormativa )    
                , 'SubCarNormativaDsc'    = CONVERT( VARCHAR(50), ISNULL( SubCartera.tbglosa,  'Falto SubCarNormatica'  ) )    
               , 'MonVrCod'              = CONVERT( NUMERIC(5), CarteraRes.CaMon_Vr )    
                , 'MonVrNemo'             = CONVERT( CHAR(8), ISNULL( MonedaVr.MnNemo, 'Moneda Vr no existe' ) )    
                , 'Vr'                    = CONVERT( FLOAT, CarteraRes.CaVr )    
                , 'DeltaSpotCont'         = CONVERT( FLOAT, ISNULL( CarteraRes.CaDeltaSpotCont, 0.0 ) )    
                , 'DeltaForwardCont'      = CONVERT( FLOAT, ISNULL( CarteraRes.CaDeltaForwardCont, 0.0 ) )    
                , 'GammaSpotCont'         = CONVERT( FLOAT, ISNULL( CarteraRes.CaGammaSpotCont, 0.0 ) )    
                , 'GammaFwdCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaGammaFwdCont, 0.0 ) )    
    , 'VegaCont'              = CONVERT( FLOAT, ISNULL( CarteraRes.CaVegaCont, 0.0 ) )    
                , 'VannaSpotCont'         = CONVERT( FLOAT, ISNULL( CarteraRes.CaVannaSpotCont, 0.0 ) )    
                , 'VannaFwdCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaVannaFwdCont, 0.0 ) )    
                , 'VolgaCont'             = CONVERT( FLOAT, ISNULL( CarteraRes.CaVolgaCont, 0.0 ) )    
                , 'ThetaCont'             = CONVERT( FLOAT, ISNULL( CarteraRes.CaThetaCont, 0.0 ) )    
                , 'RhoDomCont'            = CONVERT( FLOAT, ISNULL( CarteraRes.CaRhoDomCont, 0.0 ) )    
                , 'RhoForCont'            = CONVERT( FLOAT, ISNULL( CarteraRes.CaRhoForCont, 0.0 ) )    
                , 'CharmSpotCont'         = CONVERT( FLOAT, ISNULL( CarteraRes.CaCharmSpotCont, 0.0 ) )    
                , 'CharmFwdCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaCharmFwdCont, 0.0 ) )    
                , 'ZommaSpotCont'         = CONVERT( FLOAT, ISNULL( CarteraRes.CaZommaspotCont, 0.0 ) )    
                , 'ZommaFwdCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaZommaFwdCont, 0.0 ) )    
                , 'SpeedSpotCont'         = CONVERT( FLOAT, ISNULL( CarteraRes.CaSpeedSpotCont, 0.0 ) )    
                , 'SpeedFwdCont'          = CONVERT( FLOAT, ISNULL( CarteraRes.CaSpeedFwdCont, 0.0 ) )    
                , 'Glosa'                 = CONVERT( VARCHAR(80), ISNULL( CarteraRes.CaGlosa , ' ' ) )    
                , 'Usuario'               = CONVERT( VARCHAR(15), @Usuario )    
                , 'FechaProceso'          = CONVERT( DATETIME, @FechaProceso, 112 )    
                , 'FechaCreacionRegistro' = CONVERT( DATETIME, ISNULL( CarteraRes.CaFechaCreacionRegistro, '' ) )    
             FROM dbo.CaResEncContrato                CarteraRes    
                  LEFT JOIN #tmpCliente               Cliente           ON Cliente.ClRut             = CarteraRes.CaRutCliente    
                                                                       AND Cliente.ClCodigo          = CarteraRes.CaCodigo    
                  LEFT JOIN #tmpMoneda                MonedaUnwindTrf   ON MonedaUnwindTrf.MnCodMon  = CarteraRes.CaUnwindTransfMon    
                  LEFT JOIN #Formas_Pago              FormaPagoUnwind   ON FormaPagoUnwind.Codigo    = CarteraRes.CaFormPagoUnwind    
                  LEFT JOIN #Formas_Pago              FormaPagoPrima    ON FormaPagoPrima.Codigo     = CarteraRes.CafPagoPrima     
                  LEFT JOIN #tmpMoneda                MonedaUnwind      ON MonedaUnwind.MnCodMon     = CarteraRes.CaUnwindMon    
                  LEFT JOIN #tmpMoneda                MonedaSpeed       ON MonedaSpeed.MnCodMon      = CarteraRes.CaMon_Speed    
                  LEFT JOIN #tmpMoneda                MonedaZomma       ON MonedaZomma.MnCodMon      = CarteraRes.CaMon_Zomma    
                  LEFT JOIN #tmpMoneda                MonedaCharm       ON MonedaCharm.MnCodMon      = CarteraRes.CaMon_Charm    
                  LEFT JOIN #tmpMoneda                MonedaRhof        ON MonedaRhof.MnCodMon       = CarteraRes.CaMon_Rhof    
                  LEFT JOIN #tmpMoneda                MonedaRho         ON MonedaRho.MnCodMon  = CarteraRes.CaMon_Rho    
                  LEFT JOIN #tmpMoneda                MonedaVolga       ON MonedaVolga.MnCodMon      = CarteraRes.CaMon_Volga    
                  LEFT JOIN #tmpMoneda                MonedaVanna       ON MonedaVanna.MnCodMon      = CarteraRes.CaMon_Vanna    
                  LEFT JOIN #tmpMoneda                MonedaVega        ON MonedaVega.MnCodMon       = CarteraRes.CaMon_Vega    
                  LEFT JOIN #tmpMoneda                MonedaGamma       ON MonedaGamma.MnCodMon      = CarteraRes.CaMon_Gamma    
                  LEFT JOIN #tmpMoneda                MonedaDelta       ON MonedaDelta.MnCodMon      = CarteraRes.CaMonDelta    
                  LEFT JOIN #tmpMoneda                MonedaPrima       ON MonedaPrima.MnCodMon      = CarteraRes.CaCodMonPagPrima    
                  LEFT JOIN #tmpMoneda                MonedaPrimaTranf  ON MonedaPrimaTranf.MnCodMon = CarteraRes.CaMonPrimaTrf    
                  LEFT JOIN #tmpMoneda                MonedaPrimaCosto  ON MonedaPrimaCosto.MnCodMon = CarteraRes.CaMonPrimaCosto    
                  LEFT JOIN #tmpMoneda                MonedaPrimaCarry  ON MonedaPrimaCarry.MnCodMon = CarteraRes.CaMonCarryPrima    
                  LEFT JOIN #tmpMoneda                MonedaVr          ON MonedaVr.MnCodMon         = CarteraRes.CaMon_Vr    
                  LEFT JOIN ConOpcEstado              Estado            ON Estado.ConOpcEstCod       = CarteraRes.CaEstado    
                  LEFT JOIN OpcionEstructura          Estructura        ON Estructura.OpcEstCod      = CarteraRes.CaCodEstructura    
                  LEFT JOIN #Tabla_General_Detalle    Financiera        ON Financiera.tbcateg        = 204    
                                                                       AND Financiera.tbcodigo1      = CarteraRes.CaCarteraFinanciera    
                  LEFT JOIN #Tabla_General_Detalle    Normativa         ON Normativa.tbcateg         = 1111    
                                                                       AND Normativa.tbcodigo1       = CarteraRes.CaCarNormativa    
                  LEFT JOIN #Tabla_General_Detalle    Libro             ON Libro.tbcateg             = 1552    
                                                                       AND Libro.tbcodigo1           = CarteraRes.CaLibro    
                  LEFT JOIN #Tabla_General_Detalle    Responsable       ON Responsable.tbcateg       = 1553    
                                                                       AND Responsable.tbcodigo1     = 6         -- No tenemos area responsable !!!    
                  LEFT JOIN #Tabla_General_Detalle    SubCartera        ON SubCartera.tbcateg        = 1554    
                                                         AND SubCartera.tbcodigo1      = CarteraRes.CaSubCarNormativa    
            WHERE CarteraRes.CaEncFechaRespaldo  = @fecha    
              AND CarteraRes.CaEncFechaRespaldo  < @FechaProceso    
              AND CarteraRes.CaEstado           <> 'C'    
     AND (CarteraRes.CaNumContrato = @NumeroContrato OR @NumeroContrato IS NULL) --ASVG_20110330 Filtrado por número de contrato    
    
--           TRUNCATE TABLE #Encabezado     
--           INSERT INTO #Encabezado    
--                  SELECT * FROM #TempEncabezado    
          
      SELECT 'NumContrato'   = A.NumContrato    
           , 'CaFechaVcto'   = max(B.CaFechaVcto)  
           , 'CantComp'      = count(*)     
        INTO #ComponentesXContrato    
        FROM #TempEncabezado  A    
           , CaDetContrato    B          
       WHERE A.NumContrato = B.CaNumContrato    
       GROUP BY    
             A.NumContrato    
--           , B.CaFechaVcto    
        
      INSERT INTO #ComponentesXContrato  
      SELECT 'NumContrato'   = A.NumContrato    
           , 'CaFechaVcto'   = max(B.CaFechaVcto)  
           , 'CantComp'      = count(*)             
        FROM #TempEncabezado  A    
    , CaResDetContrato    B          
       WHERE A.NumContrato = B.CaNumContrato   
              AND B.CaDetFechaRespaldo  = @fecha    
              AND B.CaDetFechaRespaldo  < @FechaProceso     
               
       GROUP BY    
             A.NumContrato      
  
  
  
        
      TRUNCATE TABLE #Encabezado    -- Cuando termine desarrollo borrar esto     
    
      INSERT INTO #Encabezado       -- y mostrar desde MovEnc y no desde resultado    
             SELECT MovEnc.Reporte    
                  , MovEnc.NumContrato    
                  , MovEnc.NumFolio    
                  , MovEnc.FechaContrato    
                  , MovEnc.ConOpcEstCod    
                  , MovEnc.ConOpcEstDsc    
                  , CASE WHEN Comp.CaFechaVcto = @fecha THEN 3 ELSE MovEnc.TipoTransaccion END    
                  , MovEnc.CliRut    
                  , MovEnc.CliCod    
    , MovEnc.CliDv    
                  , MovEnc.CliNom    
                  , MovEnc.Operador    
                  , MovEnc.OpcEstCod    
                  , MovEnc.OpcEstDsc    
                  , MovEnc.CVEstructura    
                  , MovEnc.CompraVentaEstructura    
                  , MovEnc.MonPagPrimaCod    
                  , MovEnc.MonPagPrimaNemo    
                  , MovEnc.PrimaInicial    
                  , MovEnc.CarteraFinancieraCod    
                  , MovEnc.CarteraFinancieraDsc    
                  , MovEnc.CarteraNormativaCod    
                  , MovEnc.CarteraNormativaDsc    
                  , MovEnc.LibroCod    
                  , MovEnc.LibroDsc    
                  , MovEnc.AreaResponsalbleCod    
                  , MovEnc.AreaResponsalbleDsc    
                  , MovEnc.SubCarNormativaCod    
                  , MovEnc.SubCarNormativaDsc    
                  , MovEnc.MonVrCod    
                  , MovEnc.MonVrNemo    
                  , MovEnc.Vr    
                  , MovEnc.DeltaSpotCont    
                  , MovEnc.DeltaForwardCont    
                  , MovEnc.GammaSpotCont    
                  , MovEnc.GammaFwdCont    
                  , MovEnc.VegaCont    
                  , MovEnc.VannaSpotCont    
                  , MovEnc.VannaFwdCont    
                  , MovEnc.VolgaCont    
                  , MovEnc.ThetaCont    
                  , MovEnc.RhoDomCont    
                  , MovEnc.RhoForCont    
                  , MovEnc.CharmSpotCont    
                  , MovEnc.CharmFwdCont    
                  , MovEnc.ZommaSpotCont    
                  , MovEnc.ZommaFwdCont    
                  , MovEnc.SpeedSpotCont    
                  , MovEnc.SpeedFwdCont    
                  , MovEnc.Glosa    
                  , MovEnc.Usuario    
                  , MovEnc.FechaProceso    
                  , MovEnc.FechaCreacionRegistro    
                  , Comp.CantComp         
    FROM #TempEncabezado       MovEnc    
                  , #ComponentesXContrato Comp    
              WHERE MovEnc.NumContrato     = Comp.NumContrato    
      
    DELETE #Encabezado WHERE TipoTransaccion <> @TipoTransaccion    
    
    IF EXISTS( SELECT (1) FROM #Encabezado)    
    BEGIN    
        SELECT *, 'BannerLargo'      = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)       
          FROM #Encabezado     
        
    END ELSE    
    BEGIN    
         -- Se despliega el registro Sin Datos.    
         SELECT *, 'BannerLargo'      = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)     
           FROM #Resultado    
    
    END    
    
END
GO
