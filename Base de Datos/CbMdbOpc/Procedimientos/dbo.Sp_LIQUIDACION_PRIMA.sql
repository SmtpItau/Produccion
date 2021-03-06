USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LIQUIDACION_PRIMA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_LIQUIDACION_PRIMA]
       (
         @Usuario         VARCHAR(15)
       , @NumGrupo        NUMERIC(9)
       , @FechaPagoDesde  DATETIME
       , @FechaPagoHasta  DATETIME        
       )  
AS
BEGIN			 -- El nombre de columna 'CaCajFormaPagMon1' no es válido.

    SET NOCOUNT ON

    DECLARE @NombreBanco VARCHAR(45)
    DECLARE @RutBanco    NUMERIC(13)
    DECLARE @Fax         VARCHAR(30)
    DECLARE @Fono        VARCHAR(30)
   
    SELECT @NombreBanco = nombre 
         , @RutBanco    = rut  
         , @Fax         = Fax
         , @Fono        = telefono
      FROM dbo.opcionesgeneral

    SELECT *
      INTO #CaCaja
      FROM dbo.CaCaja 
           INNER JOIN dbo.IMPRESION IMP          ON IMP.ImpGrupo       = @NumGrupo
                                                AND IMP.ImpNumContrato = CaNumContrato
     WHERE CaCajOrigen   = 'PP'
       AND CaCajFecPago  BETWEEN @FechaPagoDesde AND @FechaPagoHasta
    UNION
    SELECT *
      FROM dbo.CaVenCaja
           INNER JOIN dbo.IMPRESION IMP          ON IMP.ImpGrupo       = @NumGrupo
                                                AND IMP.ImpNumContrato = CaNumContrato
     WHERE CaCajOrigen   = 'PP'
       AND CaCajFecPago  BETWEEN @FechaPagoDesde AND @FechaPagoHasta
   
    SELECT CaNumContrato
         , CaCajMdaM1
         , CaCajFormaPagoMon1
         , CaCajFecPago
         , CaMtoPrima = SUM( CaCajMtoMon1 )
      INTO #Base
      FROM #CaCaja 
     GROUP BY
           CaNumContrato
         , CaCajMdaM1
         , CaCajFormaPagoMon1
         , CaCajFecPago

    SELECT CaNumContrato
         , CaFechaPagoEjer 
      INTO #CaDetContrato
      FROM dbo.CaDetContrato
           INNER JOIN dbo.IMPRESION IMP          ON IMP.ImpGrupo       = @NumGrupo
                                                AND IMP.ImpNumContrato = CaNumContrato
    UNION
    SELECT CaNumContrato
         , CaFechaPagoEjer 
      FROM dbo.CaVenDetContrato
           INNER JOIN dbo.IMPRESION IMP          ON IMP.ImpGrupo       = @NumGrupo
                                                AND IMP.ImpNumContrato = CaNumContrato

    SELECT Enc.CaNumContrato 
         , Enc.CaFechaContrato
         , Enc.CaRutCliente
         , Enc.CaCodigo
         , Enc.CaCVEstructura
         , Enc.CaCodEstructura
      INTO #CaEncContrato
      FROM dbo.CaEncContrato Enc
           INNER JOIN dbo.IMPRESION IMP          ON IMP.ImpGrupo       = @NumGrupo
                                                AND IMP.ImpNumContrato = CaNumContrato
     UNION
    SELECT Enc.CaNumContrato 
         , Enc.CaFechaContrato
         , Enc.CaRutCliente
         , Enc.CaCodigo
         , Enc.CaCVEstructura
         , Enc.CaCodEstructura
      FROM dbo.CaVenEncContrato Enc
           INNER JOIN dbo.IMPRESION IMP          ON IMP.ImpGrupo       = @NumGrupo
                                                AND IMP.ImpNumContrato = CaNumContrato

    SELECT CaNumContrato             = CONVERT( NUMERIC(8), 0 )
         , CaFechaContrato           = CONVERT( DATETIME, '19000101' )
         , CaRutCliente              = CONVERT( NUMERIC(13), 0 )
         , CaDv                      = CONVERT( VARCHAR(1),  ' ' )
         , CaCliNombre               = CONVERT( VARCHAR(80), 'Sin Datos' )       
         , CaNomEntidad              = CONVERT( VARCHAR(80), 'Sin Datos' )       
         , CaCodigo                  = CONVERT( NUMERIC(1), 0 ) 
         , CaCVEstructuraCod         = CONVERT( VARCHAR(1), '' )
         , CaVCEstructuraDsc         = CONVERT( VARCHAR(10), '' )
         , CaCodEstructura           = CONVERT( VARCHAR(2), ' ' )
         , CaDscEstructura           = CONVERT( VARCHAR(30), ' ' )
         , CaCajMdaM1Cod             = CONVERT( NUMERIC(5), 0 ) 
         , CaCajMdaM1Dsc             = CONVERT( VARCHAR(35), '' )
         , CaMx                      = CONVERT( VARCHAR(2), '' )
         , CaCajFormaPagoMon1Cod = CONVERT( NUMERIC(5), 0 )
         , CaCajFormaPagoMon1Dsc     = CONVERT( VARCHAR(30), '' )
         , CaFecha                   = CONVERT( DATETIME, '19000101' )
         , CaMTMensaje               = CONVERT( VARCHAR(40), '' )
         , CaMTNombreEmisor          = CONVERT( VARCHAR(80), '' )
         , CaMTSwiftEmisor           = CONVERT( VARCHAR(30),  'No Hay Codigo Swift Emisor'  )
         , CaMTNombreReceptor        = CONVERT( VARCHAR(80),  '' )
         , CaMTSwiftReceptor         = CONVERT( VARCHAR(30), 'No Hay Codigo Swift Receptor'  )
         , CaMTReferenciaTransaccion = CONVERT( VARCHAR(80), 'OPTION FX PAGO INICIAL CONTRATO ' )
         , CaMTTipoSubmensaje        = CONVERT( VARCHAR(3), '   ' )
         , CaCampoL01                = CONVERT( VARCHAR(5), '     ')
         , CaCampoL02                = CONVERT( VARCHAR(5), '     ' )
         , CaCampoL03                = CONVERT( VARCHAR(5), '     ' )
         , CaMTNarrativa             = CONVERT( VARCHAR(80), ' ' )
         , CaMtoPrima                = CONVERT( NUMERIC(20,2), 0 )
         , CaAFavorDe                = CONVERT( VARCHAR(80), ' ' )
         , CaFax                     = CONVERT( VARCHAR(30), @Fax )
         , CaFono                    = CONVERT( VARCHAR(30), @Fono )  
         , CaFecVcto                 = CONVERT( DATETIME,  '19000101' ) 
         , CaTipCliente              = CONVERT( NUMERIC(05), 0 )
      INTO #Resultado

    INSERT INTO #Resultado
           SELECT CaNumContrato             = CONVERT( NUMERIC(8), Enc.CaNumContrato )
                , CaFechaContrato           = CONVERT( DATETIME, Enc.CaFechaContrato )
                , CaRutCliente              = CONVERT( NUMERIC(13), Enc.CaRutCliente )
                , CaDv                      = CONVERT( VARCHAR(1),  Cli.ClDv )
                , CaCliNombre               = CONVERT( VARCHAR(80), substring( Cli.ClNombre, 1, 80) )       
                , CaNomEntidad              = CONVERT( VARCHAR(80), @NombreBanco )
                , CaCodigo                  = CONVERT( NUMERIC(1), Enc.CaCodigo ) 
                , CaCVEstructuraCod         = CONVERT( VARCHAR(1), Enc.CaCVEstructura )
                , CaVCEstructuraDsc         = CONVERT( VARCHAR(10), CASE WHEN CaCVEstructura = 'C' THEN 'Compra' ELSE 'Venta' END )
                , CaCodEstructura           = CONVERT( VARCHAR(2) , Enc.CaCodEstructura )
                , CaDscEstructura           = CONVERT( VARCHAR(30), OpcEstDsc )
                , CaCajMdaM1Cod             = CONVERT( NUMERIC(5), CaCajMdaM1 ) 
                , CaCajMdaM1Dsc             = CONVERT( VARCHAR(35), Mda.MnGlosa )
                , CaMx                      = CONVERT( VARCHAR(2), Mda.MnMx )
                , CaCajFormaPagoMon1Cod     = CONVERT( NUMERIC(5), Base.CaCajFormaPagoMon1 )
                , CaCajFormaPagoMon1Dsc     = CONVERT( VARCHAR(30), FPago.Glosa )
                , CaFecha                   = CONVERT( DATETIME, Base.CaCajFecPago )
                , CaMTMensaje               = CONVERT( VARCHAR(40), CASE WHEN CaMtoPrima > 0 THEN 'MT 299' ELSE 'MT 298' END )
                , CaMTNombreEmisor          = CONVERT( VARCHAR(80), @NombreBanco )
                , CaMTSwiftEmisor           = CONVERT( VARCHAR(30) , ISNULL( ( SELECT MAX( codigo_swift ) 
                                                                                 FROM Bacparamsuda.dbo.CORRESPONSAL
                                                                                WHERE rut_cliente    = @RutBanco
                                                                                  AND Codigo_cliente = 1
                                                                                  AND Codigo_Moneda  = Base.CaCajMdaM1 
                                                                             )  , 'No Hay Codigo Swift Emisor' ) )
                , CaMTNombreReceptor        = CONVERT( VARCHAR(80), LEFT( ClNombre, 80 ) )
          , CaMTSwiftReceptor         = CONVERT( VARCHAR(30), ISNULL( ( SELECT MAX( codigo_swift ) 
          FROM Bacparamsuda.dbo.CORRESPONSAL 
                                                                               WHERE rut_cliente    = Enc.CaRutCliente 
                                                                                 AND Codigo_cliente = Enc.CaCodigo
                                                                                 AND Codigo_Moneda  = Base.CaCajMdaM1 
                                                                            ) , 'No Hay Codigo Swift Receptor' ) )
                , CaMTReferenciaTransaccion = CONVERT( VARCHAR(80), 'OPTION FX PAGO INICIAL CONTRATO ' + CONVERT( VARCHAR(10), Base.CaNumContrato ) )
                , CaMTTipoSubmensaje        = CONVERT( VARCHAR(3), CASE WHEN CaMtoPrima > 0 THEN '299' ELSE '202' END )
                , CaCampoL01                = CONVERT( VARCHAR(5), CASE WHEN CaMtoPrima > 0 THEN '20'  ELSE '20' END )
                , CaCampoL02                = CONVERT( VARCHAR(5), CASE WHEN CaMtoPrima > 0 THEN '21'  ELSE '12' END )
                , CaCampoL03                = CONVERT( VARCHAR(5), CASE WHEN CaMtoPrima > 0 THEN '79'  ELSE '77E' END )
                , CaMTNarrativa             = CONVERT( VARCHAR(80), CASE WHEN CaMtoPrima > 0 THEN  'Emisor Recibe Prima Contrato '
                                                                         WHEN CaMtoPrima = 0 THEN  'No hay Pago de Prima Contrato ' 
                                                                                             ELSE  'Emisor Paga   Prima Contrato '
                                                                    END )
                , CaMtoPrima                = CONVERT( NUMERIC(20,2), abs( CaMtoPrima ) )
                , CaAFavorDe                = CONVERT( VARCHAR(80), CASE WHEN CaMtoPrima > 0 THEN @NombreBanco 
                                                                         WHEN CaMtoPrima < 0 THEN substring( ClNombre, 1, 80 ) 
                                                                         ELSE ' SIN PRIMA '
                                                                    END )          
                , CaFax                     = CONVERT( VARCHAR(30), @Fax )
                , CaFono                    = CONVERT( VARCHAR(30), @Fono )  
                , CaFecVcto                 = CONVERT( DATETIME, ( SELECT MAX( CaFechaPagoEjer )
                                                                     FROM #CaDetContrato Det 
                                                                    WHERE Det.CaNumContrato = Enc.CaNumContrato )  )
                , CaTipCliente              = Cli.ClTipCli
             FROM #Base                                       Base
                , #CaEncContrato                              Enc
                , OpcionEstructura                            Est
                , BacParamSuda.dbo.VIEW_CLIENTEparaOPC Cli
                , bacparamsuda.dbo.Moneda              Mda
                , bacparamsuda.dbo.Forma_de_Pago       FPago
            WHERE Base.CaNumContrato      = Enc.CaNumContrato
              AND Est.OpcEstCod           = Enc.CaCodEstructura
              AND Cli.ClRut               = Enc.CaRutCliente
              AND Cli.ClCodigo            = Enc.CaCodigo
              AND Base.CaCajMdaM1         = Mda.MnCodMon
              AND Base.CaCajFormaPagoMon1 = FPago.Codigo

    IF @@ROWCOUNT <> 0 
    BEGIN
        DELETE #Resultado WHERE CaCliNombre LIKE '%Sin Datos%'    
    END

    SELECT *, 'RazonSocial'      = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales), 'BannerLargo' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #Resultado ORDER BY CaNumContrato

END
 

GO
