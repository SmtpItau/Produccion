USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LIQUIDACION_OPCIONES]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_LIQUIDACION_OPCIONES]
       (  
         @Usuario         VARCHAR(15)  
       , @NumGrupo        NUMERIC(9)  
       , @FechaPagoDesde  DATETIME  
       , @FechaPagoHasta  DATETIME  
       )    
  
AS  
BEGIN              
-- MAP 20130227 Para Soportar Asiáticos Entrada Salida   
-- y corregir la construccion del registro "sin datos"  
  
    SET NOCOUNT ON  
  
    DECLARE @FechaProceso     DATETIME  
    DECLARE @RutEntidad       NUMERIC(9)  
    DECLARE @DvEntidad        CHAR(1)  
    DECLARE @NomEntidad       CHAR(45)  
    DECLARE @OperEntidad      CHAR(45)  
  
    SET @FechaProceso = ''  
  
     -- Solo se cargarán Clientes que alguna vez han tenido opciones  
     SELECT ClRut  
          , ClCodigo  
          , ClDv  
          , ClNombre  
       INTO #Cliente  
	   FROM bacparamsuda.dbo.VIEW_CLIENTEParaOpc  
  --     FROM LNKBAC.bacparamsuda.dbo.VIEW_CLIENTEParaOpc  
  
    SELECT @FechaProceso = fechaproc   
         , @RutEntidad   = ISNULL(Rut, 0)  
         , @DvEntidad    = ISNULL(ClDv,'')  
         , @NomEntidad   = ISNULL(ClNombre,'')   
         , @OperEntidad  = 'Sin operador'--ISNULL(opnombre,'')  
      FROM dbo.OpcionesGeneral    
         , #Cliente   
		 -- , bacparamsuda.dbo.CLIENTE_OPERADOR  
        -- ,  LNKBAC.bacparamsuda.dbo.CLIENTE_OPERADOR  
     WHERE Rut      = ClRut  
       AND ClCodigo = 1    
     --  AND Rut      = oprutcli  
      -- AND opcodcli = 1  
   
    SELECT *  
      INTO #Moneda  
	  from  bacparamsuda.dbo.Moneda  
     -- FROM LNKBAC.bacparamsuda.dbo.Moneda  
  
    SELECT *  
      INTO #Formas_Pago 
	   from  bacparamsuda.dbo.Forma_de_Pago   
   --   FROM LNKBAC.bacparamsuda.dbo.Forma_de_Pago   
  
    SELECT *  
      INTO #GEN_SISTEMAS  
	 FROM BacParamSuda.dbo.SISTEMA_CNT  
    --  FROM LNKBAC.BacParamSuda.dbo.SISTEMA_CNT  
  
    SELECT 'CaNumContrato'         = CONVERT( NUMERIC(8), 0 )  
         , 'CaNumEstructura'       = CONVERT( NUMERIC(6), 0 )  
         , 'CaCajFolio'            = CONVERT( NUMERIC(8), 0 )  
         , 'CaCajFechaGen'         = CONVERT( DATETIME, '',112)  
         , 'CaCajFecPago'          = CONVERT( DATETIME, '',112)  
         , 'CaCajFDeMon1'          = CONVERT( FLOAT, 0.0 )  
         , 'CaCajMtoMon1'          = CONVERT( FLOAT, 0.0 )  
         , 'CaCajFDeMon2'          = CONVERT( FLOAT, 0.0 )  
         , 'CaCajMtoMon2'          = CONVERT( FLOAT, 0.0 )  
         , 'CaCajEstado'           = CONVERT( CHAR(2), '' )  
         , 'CaMTMImplicito'        = CONVERT( FLOAT, 0.0 )  
         , 'CaCajFormaPagoMon1'    = CONVERT( NUMERIC(5), 0 )  
         , 'CaCajFormaPagoMon2'    = CONVERT( NUMERIC(5), 0 )  
         , 'CaCajMdaM1'            = CONVERT( NUMERIC(5), 0 )  
         , 'CaCajMdaM2'            = CONVERT( NUMERIC(5), 0 )  
         , 'CaCajOrigen'           = CONVERT( VARCHAR(2), '' )  
         , 'CaCajMotorPago'        = CONVERT( VARCHAR(2), '' )  
         , 'CaCajModalidad'        = CONVERT( CHAR(1), '' )  
         , 'CaCajFechaPagMon1'     = COnvert( DATETIME, '', 112)  -- MAP 20130227  
         , 'CaCajFechaPagMon2'     = COnvert( DATETIME, '', 112)  -- MAP 20130227  
         , 'CajForPagM1Desc'       = CONVERT( CHAR(30), '' )  
         , 'CajForPagM2Desc'       = CONVERT( CHAR(30), '' )  
         , 'CajMdaM1Desc'          = CONVERT( CHAR(8), '' )  
         , 'CajMdaM2Desc'          = CONVERT( CHAR(8), '' )  
         , 'OpcTipCod'             = CONVERT( CHAR(1), '' )  
         , 'OpcTipDsc'             = CONVERT( CHAR(20), '' )  
         , 'SubyacenteCod'         = CONVERT( CHAR(3), '' )  
         , 'SubyacenteDsc'         = CONVERT( VARCHAR(40), '' )  
         , 'NumEstructura'         = CONVERT( NUMERIC(6), 0 )  
         , 'PayOffTipCod'          = CONVERT( VARCHAR(2), '' )  
         , 'PayOffTipDsc'          = CONVERT( VARCHAR(20), '' )  
         , 'CallPut'               = CONVERT( VARCHAR(5), '' )  
         , 'CVOpcCod'              = CONVERT( VARCHAR(3), '' )  
         , 'CompraVentaOpcDsc'     = CONVERT( VARCHAR(6), '' )  
         , 'TipoEmisionPTCod'      = CONVERT( VARCHAR(3), '' )  
         , 'TipoEmisionPTDsc'	 = CONVERT( VARCHAR(8), '' )  
         , 'FechaInicioOpc'        = CONVERT( DATETIME, '', 112 )  
         , 'FechaFijacionOpc'      = CONVERT( DATETIME, '', 112 )  
         , 'FechaVcto'             = CONVERT( DATETIME, '', 112 )  
         , 'FechaPagoEjer'         = CONVERT( DATETIME, '', 112 )  
         , 'FechaPagMon1'          = CONVERT( DATETIME, '', 112 )  
         , 'FechaPagMon2'          = CONVERT( DATETIME, '', 112 )  
         , 'Mon1Cod'			   = CONVERT( NUMERIC(5), 0 )  
         , 'Mon1Dsc'               = CONVERT( CHAR(35), ''  )  
         , 'MontoMon1'             = CONVERT( NUMERIC(21,6) , 0 )  
         , 'FormaPagoMon1Cod'      = CONVERT( NUMERIC(3), 0 )  
         , 'FormaPagoMon1Dsc'      = CONVERT( CHAR(30), '' )  
         , 'Mon2Cod'               = CONVERT( NUMERIC(5), 0 )   
         , 'Mon2Dsc'               = CONVERT( CHAR(35), '' )  
         , 'MontoMon2'             = CONVERT( NUMERIC(21,6), 0 )  
         , 'FormaPagoMon2Cod'      = CONVERT( NUMERIC(3), 0 )  
         , 'FormaPagoMon2Dsc'      = CONVERT( CHAR(30), ''  )  
         , 'ModalidadCod'          = CONVERT( VARCHAR(1), ''  )  
         , 'ModalidadDsc'          = CONVERT( VARCHAR(15), ''  )  
         , 'MdaCompensacinCod'     = CONVERT( NUMERIC(5), 0 )  
         , 'MdaCompensacionDsc'    = CONVERT( CHAR(35), ''  )  
         , 'BenchCompCod'          = CONVERT( NUMERIC(5), 0 )  
         , 'BenchCompDsc'          = CONVERT( VARCHAR(40), ''  )  
         , 'ParStrike'             = CONVERT( VARCHAR(7), ''  )  
         , 'Strike'                = CONVERT( FLOAT, 0.0 )  
         , 'PorcStrike'            = CONVERT( FLOAT, 0.0 )  
         , 'TipoEjercicioCod'      = CONVERT( VARCHAR(1), ''  )   
         , 'TipoEjercicioDsc'      = CONVERT( VARCHAR(10) , ''  )  
         , 'VrDet'                 = CONVERT( FLOAT, 0.0 )  
         , 'IteAsoSisCod'          = CONVERT( CHAR(3), '' )  
         , 'IteAsoSisDsc'          = CONVERT( CHAR(20), '' )  
         , 'IteAsoCon'             = CONVERT( NUMERIC(8), 0.0  )  
         , 'CaFixFecha'            = CONVERT( DATETIME, '', 112 )  
         , 'CaFixNumero'           = CONVERT( NUMERIC(6), 0 )  
         , 'CaPesoFij'             = CONVERT( FLOAT, 0.0 )  
         , 'CaVolFij'              = CONVERT( FLOAT, 0.0 )  
         , 'CaFijacion'            = CONVERT( FLOAT, 0.0 )  
         , 'CaFixBenchComp'        = CONVERT( NUMERIC(5), 0 )  
         , 'CaFixParBench'         = CONVERT( VARCHAR(7), ''  )  
         , 'CaFixEstado'           = CONVERT( CHAR(1), ''  )  
         , 'Entrada_Salida'        = CONVERT( CHAR(7), '' )   
         , 'NumContrato'           = CONVERT( NUMERIC(8), 0 )  
         , 'FechaContrato'         = CONVERT( DATETIME, '', 112 )  
         , 'CliRut'                = CONVERT( NUMERIC(9), 0 )  
         , 'CliCod'                = CONVERT( NUMERIC(9), 0 )  
         , 'CliDv'                 = CONVERT( CHAR(1), ''  )  
         , 'CliNom'                = CONVERT( CHAR(70), '' )  
         , 'Operador'              = CONVERT( VARCHAR(15), '' )  
         , 'CVEstructura'          = CONVERT( VARCHAR(1), '' )  
         , 'CompraVentaEstructura' = CONVERT( VARCHAR(6), '' )  
         , 'Usuario'               = CONVERT( VARCHAR(15), '' )  
         , 'FechaProceso'          = CONVERT( DATETIME, '',112)  
         , 'FechaCreacionRegistro' = CONVERT( DATETIME, '',112)  
         , 'RutEntidad'            = CONVERT( NUMERIC(9), 0 )  
         , 'DvEntidad'             = CONVERT( CHAR(1), ''  )  
         , 'NomEntidad'            = CONVERT( CHAR(70), '' )  
         , 'OperEntidad'           = CONVERT( VARCHAR(15), '' )  
         , 'TipoTransaccion'	   = CONVERT(varchar(10),'') 
      INTO #ResultadoSinReg  
  
    SELECT CaCaja.*   
         , 'CajForPagM1Desc' = ISNULL( FormaPagoM1.glosa, '' )  
         , 'CajForPagM2Desc' = ISNULL( FormaPagoM2.glosa, '' )  
         , 'CajMdaM1Desc'    = ISNULL( MonedaM1.MnNemo, '' )  
         , 'CajMdaM2Desc'    = ISNULL( MonedaM2.MnNemo, '' )  
      INTO #CaCaja  
      FROM dbo.CaCaja   
           LEFT JOIN #Formas_Pago   FormaPagoM1  ON FormaPagoM1.Codigo = CaCaja.CaCajFormaPagoMon1  
           LEFT JOIN #Formas_Pago   FormaPagoM2  ON FormaPagoM2.Codigo = CaCaja.CaCajFormaPagoMon2  
           LEFT JOIN #Moneda        MonedaM1     ON MonedaM1.MnCodMon  = CaCaja.CaCajMdaM1  
           LEFT JOIN #Moneda        MonedaM2     ON MonedaM2.MnCodMon  = CaCaja.CaCajMdaM2  
           INNER JOIN dbo.IMPRESION IMP          ON IMP.ImpGrupo       = @NumGrupo  
                                                AND IMP.ImpNumContrato = CaNumContrato  
     WHERE CaCajOrigen in ( 'PV' , 'PA' )  
       AND CaCajFecPago  BETWEEN @FechaPagoDesde AND @FechaPagoHasta  
    UNION   
    SELECT CaVenCaja.*   
         , 'CajForPagM1Desc' = ISNULL( FormaPagoM1.glosa, '' )  
         , 'CajForPagM2Desc' = ISNULL( FormaPagoM2.glosa, '' )  
         , 'CajMdaM1Desc'    = ISNULL( MonedaM1.MnNemo, '' )  
         , 'CajMdaM2Desc'    = ISNULL( MonedaM2.MnNemo, '' )  
      FROM dbo.CaVenCaja   
           LEFT JOIN #Formas_Pago   FormaPagoM1  ON FormaPagoM1.Codigo = CaVenCaja.CaCajFormaPagoMon1  
           LEFT JOIN #Formas_Pago   FormaPagoM2  ON FormaPagoM2.Codigo = CaVenCaja.CaCajFormaPagoMon2  
           LEFT JOIN #Moneda        MonedaM1     ON MonedaM1.MnCodMon  = CaVenCaja.CaCajMdaM1  
           LEFT JOIN #Moneda        MonedaM2     ON MonedaM2.MnCodMon  = CaVenCaja.CaCajMdaM2  
           INNER JOIN dbo.IMPRESION IMP          ON IMP.ImpGrupo       = @NumGrupo  
                                                AND IMP.ImpNumContrato = CaNumContrato  
     WHERE CaCajOrigen   in ( 'PV', 'PA' )  
       AND CaCajFecPago  BETWEEN @FechaPagoDesde AND @FechaPagoHasta  
  
    SELECT Caja.*  
         , 'OpcTipCod'           = CONVERT( CHAR(1),  CarDet.CaTipoOpc )  
         , 'OpcTipDsc'           = CONVERT( CHAR(20), ISNULL( OpcionTipo.OpcTipDsc, 'No existe Tipo de Opción' ) )  
         , 'SubyacenteCod'       = CONVERT( CHAR(3), CarDet.CaSubyacente )  
         , 'SubyacenteDsc'       = CONVERT( VARCHAR(40), ISNULL( Subyacente.SubyacenteDescripcion, 'No existe Subyacente' ) )  
         , 'NumEstructura'       = CONVERT( NUMERIC(6), CarDet.CaNumEstructura )  
         , 'PayOffTipCod'        = CONVERT( VARCHAR(2), CarDet.CaTipoPayOff )  
         , 'PayOffTipDsc'        = CONVERT( VARCHAR(20), ISNULL( PayOffTipo.PayOffTipDsc, 'PayOff no existe' ) )  
         , 'CallPut'             = CONVERT( VARCHAR(5), CarDet.CaCallPut )  
         , 'CVOpcCod'            = CONVERT( VARCHAR(3), CarDet.CaCVOpc )  
         , 'CompraVentaOpcDsc'   = CONVERT( VARCHAR(6), Case when CarDet.CaCVOpc = 'C' then 'Compra' else 'Venta' end )  
         , 'TipoEmisionPTCod'    = CONVERT( VARCHAR(3), CarDet.CaTipoEmisionPT )  
         , 'TipoEmisionPTDsc'    = CONVERT( VARCHAR(8), Case when CarDet.CaTipoEmisionPT = 'P' then 'Propia' else 'Terceros' end )  
         , 'FechaInicioOpc'      = CONVERT( DATETIME, CarDet.CaFechaInicioOpc, 112 )  
  
         , 'FechaFijacionOpc'    = CONVERT( DATETIME, CarDet.CaFechaFijacion, 112 )  
         , 'FechaVcto'           = CONVERT( DATETIME, CarDet.CaFechaVcto, 112 )  
         , 'FechaPagoEjer'       = CONVERT( DATETIME, CarDet.CaFechaPagoEjer, 112 )  
         , 'FechaPagMon1'        = CONVERT( DATETIME, CarDet.CaFechaPagMon1, 112 )  
         , 'FechaPagMon2'        = CONVERT( DATETIME, CarDet.CaFechaPagMon2, 112 )  
  
  
         , 'Mon1Cod'             = CONVERT( NUMERIC(5), CarDet.CaCodMon1 )  
         , 'Mon1Dsc'             = CONVERT( CHAR(35), ISNULL( MonedaM1.MnNemo, 'Moneda M1 no existe' ) )  
         , 'MontoMon1'           = CONVERT( NUMERIC(21,6), CarDet.CaMontoMon1 )  
  
         , 'FormaPagoMon1Cod'    = CONVERT( NUMERIC(3), CarDet.CaFormaPagoMon1 )  
         , 'FormaPagoMon1Dsc'    = CONVERT( CHAR(30), FormaPagoM1.Glosa )  
  
         , 'Mon2Cod'             = CONVERT( NUMERIC(5), CarDet.CaCodMon2 )  
         , 'Mon2Dsc'             = CONVERT( CHAR(35), ISNULL( MonedaM2.MnNemo, 'Moneda M2 no existe' ) )  
         , 'MontoMon2'           = CONVERT( NUMERIC(21,6), CarDet.CaMontoMon2 )  
         , 'FormaPagoMon2Cod'    = CONVERT( NUMERIC(3), CarDet.CaFormaPagoMon2 )  
         , 'FormaPagoMon2Dsc'    = CONVERT( CHAR(30), FormaPagoM2.Glosa )  
         , 'ModalidadCod'        = CONVERT( VARCHAR(1), CarDet.CaModalidad )  
         , 'ModalidadDsc'        = CONVERT( VARCHAR(15),  Case when CarDet.CaModalidad = 'C' then 'Comp.' else 'E.Fisica.' end )  
  
         , 'MdaCompensacionCod'  = CONVERT( NUMERIC(5), CarDet.CaMdaCompensacion )  
         , 'MdaCompensacionDsc'  = CONVERT( CHAR(35), ISNULL( MonedaCompensacion.MnNemo, 'N/A' ) )  
  
         , 'BenchCompCod'        = CONVERT( NUMERIC(5), CarDet.CaBenchComp )  
         , 'BenchCompDsc'        = CONVERT( VARCHAR(40), ISNULL( BenchMark.BenchMarkDescripcion, 'No existe BenchMark' ) )  
  
         , 'ParStrike'           = CONVERT( VARCHAR(7), CarDet.CaParStrike )  
         , 'Strike'              = CONVERT( FLOAT, CarDet.CaStrike )  
         , 'PorcStrike'          = CONVERT( FLOAT, CarDet.CaPorcStrike )  
  
         , 'TipoEjercicioCod'    = CONVERT( VARCHAR(1), CarDet.CaTipoEjercicio )   
         , 'TipoEjercicioDsc'    = CONVERT( VARCHAR(10) , Case when CarDet.CaTipoEjercicio = 'E' then 'EUROPEA' else 'AMERICANA' end )  
         , 'VrDet'               = CONVERT( FLOAT, CarDet.CaVrDet )  
         , 'IteAsoSisCod'        = CONVERT( CHAR(3), CarDet.CaIteAsoSis )  
         , 'IteAsoSisDsc'        = CONVERT( CHAR(20), ISNULL( Sistema.Nombre_Sistema, 'N/A' ) )  
         , 'IteAsoCon'           = CONVERT( NUMERIC(8), ISNULL( CarDet.CaIteAsoCon, 0 )  )  
         , 'TipoTransaccion'	 = CONVERT(varchar(10),'')
      INTO #TempDetalle  
      FROM #CaCaja        Caja  
         , CaDetContrato  CarDet  
           LEFT JOIN OpcionTipo                 ON Opciontipo.OpcTipCod        = CarDet.CaTipoOpc  
           LEFT JOIN Subyacente                 ON Subyacente.Subyacente       = CarDet.CaSubyacente   
           LEFT JOIN PayOffTipo                 ON PayOffTipo.PayOffTipCod     = CarDet.CaTipoPayOff   
           LEFT JOIN #Formas_Pago FormaPagoM1   ON FormaPagoM1.Codigo          = CarDet.CaFormaPagoMon1  
           LEFT JOIN #Formas_Pago FormaPagoM2   ON FormaPagoM2.Codigo          = CarDet.CaFormaPagoMon2  
           LEFT JOIN #Moneda        MonedaM1    ON MonedaM1.MnCodMon           = CarDet.CaCodMon1  
           LEFT JOIN #Moneda        MonedaM2    ON MonedaM2.MnCodMon           = CarDet.CaCodMon2  
           LEFT JOIN #Moneda MonedaCompensacion ON MonedaCompensacion.MnCodMon = CarDet.CaMdaCompensacion  
           LEFT JOIN BenchMark                  ON  BenchMark.BenchMarkCod     = CarDet.CaBenchComp   
           LEFT JOIN #GEN_SISTEMAS Sistema      ON  Sistema.Id_sistema         = CarDet.CaIteAsoSis               
     WHERE CarDet.CaNumContrato    = Caja.CaNumContrato  
       AND CarDet.CaNumEstructura  = Caja.CaNumEstructura  
    UNION  
    SELECT Caja.*  
         , 'OpcTipCod'           = CONVERT( CHAR(1)     ,  CarVenDet.CaTipoOpc )  
         , 'OpcTipDsc'           = CONVERT( CHAR(20)    , ISNULL( OpcionTipo.OpcTipDsc, 'No existe Tipo de Opción' ) )  
         , 'SubyacenteCod'       = CONVERT( CHAR(3)     , CarVenDet.CaSubyacente )  
         , 'SubyacenteDsc'       = CONVERT( VARCHAR(40) , ISNULL( Subyacente.SubyacenteDescripcion, 'No existe Subyacente' ) )  
         , 'NumEstructura'       = CONVERT( NUMERIC(6)  , CarVenDet.CaNumEstructura )  
         , 'PayOffTipCod'        = CONVERT( VARCHAR(2)  , CarVenDet.CaTipoPayOff )  
         , 'PayOffTipDsc'        = CONVERT( VARCHAR(20) , ISNULL( PayOffTipo.PayOffTipDsc, 'PayOff no existe' ) )  
         , 'CallPut'             = CONVERT( VARCHAR(5)  , CarVenDet.CaCallPut )  
         , 'CVOpcCod'            = CONVERT( VARCHAR(3)  , CarVenDet.CaCVOpc )  
         , 'CompraVentaOpcDsc'   = CONVERT( VARCHAR(6)  , Case when CarVenDet.CaCVOpc = 'C' then 'Compra' else 'Venta' end )  
         , 'TipoEmisionPTCod'    = CONVERT( VARCHAR(3)  , CarVenDet.CaTipoEmisionPT )  
         , 'TipoEmisionPTDsc'    = CONVERT( VARCHAR(8)  , Case when CarVenDet.CaTipoEmisionPT = 'P' then 'Propia' else 'Terceros' end  )  
         , 'FechaInicioOpc'      = CONVERT( DATETIME, CarVenDet.CaFechaInicioOpc, 112 )  
  
         , 'FechaFijacionOpc'    = CONVERT( DATETIME, CarVenDet.CaFechaFijacion, 112 )  
         , 'FechaVcto'           = CONVERT( DATETIME, CarVenDet.CaFechaVcto, 112 )  
         , 'FechaPagoEjer'       = CONVERT( DATETIME, CarVenDet.CaFechaPagoEjer, 112 )  
         , 'FechaPagMon1'        = CONVERT( DATETIME, CarVenDet.CaFechaPagMon1, 112 )  
         , 'FechaPagMon2'        = CONVERT( DATETIME, CarVenDet.CaFechaPagMon2, 112 )  
  
         , 'Mon1Cod'             = CONVERT( NUMERIC(5)  , CarVenDet.CaCodMon1 )  
         , 'Mon1Dsc'             = CONVERT( CHAR(35)    , ISNULL( MonedaM1.MnNemo, 'Moneda M1 no existe' ) )  
         , 'MontoMon1'           = CONVERT( NUMERIC(21,6) , CarVenDet.CaMontoMon1 )  
  
         , 'FormaPagoMon1Cod'    = CONVERT( NUMERIC(3)  , CarVenDet.CaFormaPagoMon1 )  
         , 'FormaPagoMon1Dsc'    = CONVERT( CHAR(30)    , FormaPagoM1.Glosa )  
  
         , 'Mon2Cod'             = CONVERT( NUMERIC(5)  , CarVenDet.CaCodMon2 )  
         , 'Mon2Dsc'             = CONVERT( CHAR(35)    , ISNULL( MonedaM2.MnNemo, 'Moneda M2 no existe' ) )  
         , 'MontoMon2'           = CONVERT( NUMERIC(21,6) , CarVenDet.CaMontoMon2 )  
         , 'FormaPagoMon2Cod'    = CONVERT( NUMERIC(3)  , CarVenDet.CaFormaPagoMon2 )  
         , 'FormaPagoMon2Dsc'    = CONVERT( CHAR(30)    , FormaPagoM2.Glosa )  
         , 'ModalidadCod'        = CONVERT( VARCHAR(1)  , CarVenDet.CaModalidad )  
         , 'ModalidadDsc'        = CONVERT( VARCHAR(15) ,  Case when CarVenDet.CaModalidad = 'C' then 'Comp.' else 'E.Fisica.' end )  
  
         , 'MdaCompensacionCod'  = CONVERT( NUMERIC(5)  , CarVenDet.CaMdaCompensacion )  
         , 'MdaCompensacionDsc'  = CONVERT( CHAR(35)    , ISNULL( MonedaCompensacion.MnNemo, 'N/A' ) )  
  
         , 'BenchCompCod'        = CONVERT( NUMERIC(5)  , CarVenDet.CaBenchComp )  
         , 'BenchCompDsc'        = CONVERT( VARCHAR(40) , ISNULL( BenchMark.BenchMarkDescripcion, 'No existe BechMark' ) )  
  
         , 'ParStrike'           = CONVERT( VARCHAR(7), CarVenDet.CaParStrike )  
         , 'Strike'              = CONVERT( FLOAT, CarVenDet.CaStrike )  
         , 'PorcStrike'          = CONVERT( FLOAT, CarVenDet.CaPorcStrike )  
  
         , 'TipoEjercicioCod'    = CONVERT( VARCHAR(1), CarVenDet.CaTipoEjercicio )   
         , 'TipoEjercicioDsc'    = CONVERT( VARCHAR(10) , Case when CarVenDet.CaTipoEjercicio = 'E' then 'EUROPEA' else 'AMERICANA' end )  
         , 'VrDet'               = convert(float, CarVenDet.CaVrDet )  
         , 'IteAsoSisCod'        = CONVERT( CHAR(3), CarVenDet.CaIteAsoSis )  
         , 'IteAsoSisDsc'        = CONVERT( CHAR(20), ISNULL( Sistema.Nombre_Sistema, 'N/A' ) )  
         , 'IteAsoCon'           = CONVERT( NUMERIC(8), ISNULL( CarVenDet.CaIteAsoCon, 0 )  ) 
         , 'TipoTransaccion'	 = CONVERT(varchar(10),'') 
      FROM #CaCaja          Caja  
         , CaVenDetContrato CarVenDet  
           LEFT JOIN OpcionTipo                 ON Opciontipo.OpcTipCod        = CarVenDet.CaTipoOpc  
           LEFT JOIN Subyacente                 ON Subyacente.Subyacente       = CarVenDet.CaSubyacente   
           LEFT JOIN PayOffTipo                 ON PayOffTipo.PayOffTipCod     = CarVenDet.CaTipoPayOff   
           LEFT JOIN #Formas_Pago FormaPagoM1   ON FormaPagoM1.Codigo          = CarVenDet.CaFormaPagoMon1  
           LEFT JOIN #Formas_Pago FormaPagoM2   ON FormaPagoM2.Codigo          = CarVenDet.CaFormaPagoMon2  
           LEFT JOIN #Moneda        MonedaM1    ON MonedaM1.MnCodMon           = CarVenDet.CaCodMon1  
           LEFT JOIN #Moneda        MonedaM2    ON MonedaM2.MnCodMon           = CarVenDet.CaCodMon2  
           LEFT JOIN #Moneda MonedaCompensacion ON MonedaCompensacion.MnCodMon = CarVenDet.CaMdaCompensacion  
           LEFT JOIN BenchMark                  ON  BenchMark.BenchMarkCod     = CarVenDet.CaBenchComp   
           LEFT JOIN #GEN_SISTEMAS Sistema      ON  Sistema.Id_sistema         = CarVenDet.CaIteAsoSis  
     WHERE CarVenDet.CaNumContrato    = Caja.CaNumContrato  
       AND CarVenDet.CaNumEstructura  = Caja.CaNumEstructura  
  
    SELECT Det.*    
         , 'CaFixFecha'     = Fix.CaFixFecha                    
         , 'CaFixNumero'    = Fix.CaFixNumero   
         , 'CaPesoFij'      = Fix.CaPesoFij                                               
         , 'CaVolFij'       = Fix.CaVolFij                                                
         , 'CaFijacion'     = Fix.CaFijacion                                              
         , 'CaFixBenchComp' = Fix.CaFixBenchComp   
         , 'CaFixParBench'  = Fix.CaFixParBench   
         , 'CaFixEstado'    = Fix.CaFixEstado  
         , 'Entrada_Salida' = Case when Fix.CaPesoFij < 0 then 'Entrada' else 'Salida' end -- MAP 20130227  
      INTO #TempDet_Fix  
      FROM #TempDetalle  Det  
         , Cafixing      Fix  
     WHERE Det.CaNumContrato   = Fix.CaNumContrato  
       AND Det.CaNumEstructura = Fix.CaNumEstructura     
     UNION  
    SELECT Det.*    
         , 'CaFixFecha'     = Fix.CaFixFecha                    
         , 'CaFixNumero'    = Fix.CaFixNumero   
         , 'CaPesoFij'      = Fix.CaPesoFij                                               
         , 'CaVolFij'       = Fix.CaVolFij                                                
         , 'CaFijacion'     = Fix.CaFijacion                                              
         , 'CaFixBenchComp' = Fix.CaFixBenchComp   
         , 'CaFixParBench'  = Fix.CaFixParBench   
         , 'CaFixEstado'    = Fix.CaFixEstado   
         , 'Entrada_Salida' = Case when Fix.CaPesoFij < 0 then 'Entrada' else 'Salida' end  -- MAP 20130227  
      FROM #TempDetalle  Det  
         , CaVenFixing   Fix  
     WHERE Det.CaNumContrato   = Fix.CaNumContrato  
       AND Det.CaNumEstructura = Fix.CaNumEstructura     
  
  
  
  
    SELECT DetFix.*                        
         , 'NumContrato'           = CONVERT( NUMERIC(8)  , Cartera.CaNumContrato )  
         , 'FechaContrato'         = CONVERT( DATETIME, Cartera.CaFechaContrato,112)  
         , 'CliRut'                = CONVERT( NUMERIC(13) , Cartera.CaRutCliente )  
         , 'CliCod'                = CONVERT( NUMERIC(5)  , Cartera.CaCodigo )  
         , 'CliDv'                 = CONVERT( VARCHAR(1)  , ISNULL( Cliente.ClDv, ' '  ) )  
         , 'CliNom'                = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )  
         , 'Operador'              = CONVERT( VARCHAR(15) , Cartera.CaOperador )  
         , 'CVEstructura'          = CONVERT( VARCHAR(1)  , Cartera.CaCVEstructura )  
         , 'CompraVentaEstructura' = CONVERT( VARCHAR(6) , Case when Cartera.CaCVEstructura = 'C' then 'COMPRA' else 'VENTA' end )  
         , 'Usuario'               = CONVERT( VARCHAR(15) , @Usuario )  
         , 'FechaProceso'          = CONVERT( DATETIME, @FechaProceso, 112 )  
         , 'FechaCreacionRegistro' = CONVERT( DATETIME , ISNULL( Cartera.CaFechaCreacionRegistro, '' ) )  
         , 'RutEntidad'            = @RutEntidad   
         , 'DvEntidad'             = @DvEntidad    
         , 'NomEntidad'            = @NomEntidad   
         , 'OperEntidad'           = @OperEntidad  
      INTO #Resultado  
      FROM dbo.CaEncContrato  Cartera  
         , #TempDet_Fix       DetFix  
         , #Cliente       Cliente  
     WHERE Cartera.CaNumContrato = DetFix.CaNumContrato  
       AND Cartera.CaRutCliente  = Cliente.ClRut      
       AND Cartera.CaCodigo      = Cliente.ClCodigo   
  UNION  
    SELECT DetFix.*         
         , 'NumContrato'           = CONVERT( NUMERIC(8)  , CarteraVen.CaNumContrato )  
         , 'FechaContrato'         = CONVERT( DATETIME, CarteraVen.CaFechaContrato,112)  
         , 'CliRut'                = CONVERT( NUMERIC(13) , CarteraVen.CaRutCliente )  
         , 'CliCod'                = CONVERT( NUMERIC(5)  , CarteraVen.CaCodigo )  
         , 'CliDv'                 = CONVERT( VARCHAR(1)  , ISNULL( Cliente.ClDv, ' '  ) )  
         , 'CliNom'                = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )  
         , 'Operador'              = CONVERT( VARCHAR(15) , CarteraVen.CaOperador )  
         , 'CVEstructura'          = CONVERT( VARCHAR(1)  , CarteraVen.CaCVEstructura )  
         , 'CompraVentaEstructura' = CONVERT( VARCHAR(6) , Case when CarteraVen.CaCVEstructura = 'C' then 'COMPRA' else 'VENTA' end )  
         , 'Usuario'               = CONVERT( VARCHAR(15) , @Usuario )  
         , 'FechaProceso'          = CONVERT( DATETIME, @FechaProceso, 112 )  
         , 'FechaCreacionRegistro' = CONVERT( DATETIME , ISNULL( CarteraVen.CaFechaCreacionRegistro, '' ) )  
         , 'RutEntidad'            = @RutEntidad   
         , 'DvEntidad'             = @DvEntidad    
         , 'NomEntidad'			   = @NomEntidad   
         , 'OperEntidad'           = @OperEntidad  
      FROM dbo.CaVenEncContrato     CarteraVen  
         , #TempDet_Fix             DetFix  
         , #Cliente                 Cliente  
     WHERE CarteraVen.CaNumContrato = DetFix.CaNumContrato  
       AND CarteraVen.CaRutCliente  = Cliente.ClRut      
       AND CarteraVen.CaCodigo      = Cliente.ClCodigo   
  



    IF EXISTS( SELECT (1) FROM #Resultado  )  
    BEGIN  
    	--Modifica papeleta  Estructura Payoff asiaticos
    	DECLARE @CodEstructura	VARCHAR(10)
    	DECLARE @NumContrato	NUMERIC(8,0)
    	DECLARE @TipoTransaccion VARCHAR(10)
    	DECLARE @FechaPagoEjer DATETIME
    	DECLARE @Payoff	VARCHAR(2)
    	
    	SET @CodEstructura = ''
    	SET @NumContrato = 0
    	SET @TipoTransaccion = ''
      	SET @FechaPagoEjer = ''  
    	SET @Payoff = ''   
    	
    	SELECT @NumContrato = (select distinct NumContrato FROM #Resultado)
    	SELECT @Payoff		= (select distinct PayOffTipCod FROM #Resultado)
    	SELECT @FechaPagoEjer = (select distinct Convert(DATETIME, FechaPagoEjer,112) FROM #Resultado)
    	
    	--SELECT  @CodEstructura = CaCodEstructura  FROM CaResEncContrato  WHERE CaNumContrato = @NumContrato
    	SELECT @TipoTransaccion = (SELECT DISTINCT CaTipoTransaccion FROM CaResEncContrato  WHERE CaNumContrato = @NumContrato AND CaTipoTransaccion = 'ANTICIPA'
    							   UNION
    							   SELECT DISTINCT CaTipoTransaccion FROM CaEncContrato  WHERE CaNumContrato = @NumContrato AND CaTipoTransaccion = 'ANTICIPA')
    							      	    	    	
    	IF @Payoff = '02' AND @TipoTransaccion = 'ANTICIPA' --PRD_12567
    	BEGIN
    		
    		
    		
    		UPDATE #Resultado SET MontoMon2 = CaCajMtoMon1    		
    		,					  Strike = 0
    		,					  TipoTransaccion = @TipoTransaccion
    		    		    		   		
    		SELECT * FROM #Resultado  
    	END    
    	ELSE
		BEGIN
			 SELECT * FROM #Resultado  
		END	
    	      
    END ELSE  
    BEGIN  
        SELECT * FROM #ResultadoSinReg  
  
    END  
  
END
GO
