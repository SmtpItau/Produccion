USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MoControlPrecios]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_MoControlPrecios] 
(    @Tipo varchar(40)
  ,  @FechaDesde datetime 
  ,  @FechaHasta  datetime 
  ,  @Usuario Varchar(15) 
)    AS BEGIN			
     SET NOCOUNT ON 	
   
     -- MAP 29 Octubre 2009 Corrección de fórmula de control de precios.
     -- Se debe usar el valor de la prima en CLP y AVR en CLP
     -- dbo.Sp_MoControlPrecios '', '20090907', '20090907', 'MMM'


     Declare  @Nombre Char(120)
            , @Dv     Char(1)
            , @FechaProceso datetime
            , @CotaInferior  float
            , @CotaSuperior  float
            , @Observacion   varchar(15)


     select   MoNumContrato 
            , MoNumFolio 
            , MoFechaContrato
            , MoEstado 
            , MoRutCliente 
            , MoCodigo 
            , MoOperador 
            , MoCodEstructura  
            , MoCVEstructura 
            , MoCodMonPagPrima 
            , MoPrimaInicialML    -- MAP Octubre 2009 Se aplica prima en CLP
            , MoCarteraFinanciera 
            , MoCarNormativa 
            , MoLibro  
            , MoSubCarNormativa 
            , MoMon_Vr 
            , MoVr               -- MAP Avr siempre estara en CLP
            , MoGlosa 
            , MoFechaCreacionRegistro 
            , MoTipoTransaccion         
    into #MoEncContrato  
     from MoEncContrato where MoFechaContrato between @FechaDesde and @FechaHasta 
          and MoTipoTransaccion not in ( 'ANULA' )
          and MoNUmContrato not in ( select MoNumContrato from MoEncContrato where MoTipoTransaccion in ( 'ANULA' ) )
          and MoEstado <> 'C'
    union
     select     MoNumContrato 
            , MoNumFolio 
            , MoFechaContrato
            , MoEstado 
            , MoRutCliente 
            , MoCodigo 
            , MoOperador 
            , MoCodEstructura  
            , MoCVEstructura 
            , MoCodMonPagPrima 
            , MoPrimaInicialML  -- MAP Octubre 2009 Se aplica prima en CLP
            , MoCarteraFinanciera 
            , MoCarNormativa 
            , MoLibro  
            , MoSubCarNormativa 
            , MoMon_Vr 
            , MoVr 
            , MoGlosa 
            , MoFechaCreacionRegistro 
            , MoTipoTransaccion  
      from MoHisEncContrato where MoFechaContrato between @FechaDesde and @FechaHasta
          and MoTipoTransaccion not in ( 'ANULA' )
          and MoNUmContrato not in ( select MoNumContrato from MoEncContrato where MoTipoTransaccion in ( 'ANULA' ) )
          and MoNUmContrato not in ( select MoNumContrato from MohisEncContrato where MoTipoTransaccion in ( 'ANULA' ) )
          and MoEstado <> 'C'

     select MoNumFolio, MoNumestructura, MoMontoMon1, MoMontoMon2 
     into #MoDetContrato
      from MoDetContrato where MoNumFolio in ( select MoNumFolio from #MoEncContrato)  
     union
      select MoNumFolio, MoNumestructura, MoMontoMon1, MoMontoMon2 
      from MoHisDetContrato where MoNumFolio in ( select MoNumFolio from #MoEncContrato)  

     select * into #Moneda  from bacparamsuda.dbo.Moneda



     select ClRut, ClCodigo, ClDv, ClNombre 
     into #Cliente from BacParamSudaCLIENTE


     select @FechaProceso = ''
     select @FechaProceso = fechaproc from opcionesGeneral

     if ( select count(1) from #CLiente ) = 0 
        insert into #Cliente
	select ClRut = 0, ClCodigo = 0, ClDv = '', ClNombre = 'CLIENTE NO EXISTE EN BAC'

     select * into #Formas_Pago  from bacparamsuda.dbo.Forma_de_Pago 

     select * into #Tabla_General_Detalle  from bacparamsuda.dbo.Tabla_general_detalle 
     where tbcateg in ( 204, 1111, 1552, 1553, 1554 , 2550 )
     -- 2550: corresponde a las cotas de R para el control de precios

     select @CotaInferior = 0
     select @CotaInferior = tbvalor 
        from bacparamsuda.dbo.Tabla_general_detalle 
         where tbcateg = 2550 and tbcodigo1 = 1

     select @CotaSuperior = 0
    select @CotaSuperior = tbvalor 
        from bacparamsuda.dbo.Tabla_general_detalle 
         where tbcateg = 2550 and tbcodigo1 = 2

     if @@rowcount = 0  
         select @Observacion = 'Falta Cat. 2550'
     else Select @Observacion = ''

     select * into #GEN_SISTEMAS from BacParamSuda.dbo.SISTEMA_CNT

    -- 0. Se asume que no hay registros, se crea la tabla y se llena con el registro de "NO HAY DATOS"(Tabla #Encabezado)
     Select   'Reporte'         = convert( varchar(50),  'CONTROL DE PRECIO NIVEL CONTRATO' )
            , 'NumContrato'     = convert( numeric(8)  , 0 )
            , 'NumFolio'        = convert( numeric(8)  , 0 )
            , 'TipoTransaccion' = Convert( varchar(10) , '' )
            , 'FechaContrato'   = convert( datetime    , '',112)
            , 'ConOpcEstCod'	= Convert( varchar(1)  , '' )
            , 'ConOpcEstDsc'   = Convert( varchar(30) , '' )
            , 'CliRut'  	= Convert( numeric(13) , 0 )
            , 'CliCod'          = convert( numeric(5)  , 0 )
            , 'CliDv'           = Convert( varchar(1)  , ''   )
            , 'CliNom'  	= Convert( varchar(100), '' )
            , 'Operador'        = Convert( varchar(15) , '' )
            , 'OpcEstCod'       = Convert( varchar(2)  , '' )
            , 'OpcEstDsc'       = COnvert( Varchar(30) , '' )  
            , 'CVEstructura'    = convert( varchar(1)  , '' )
            , 'CompraVentaEstructura'    = Convert( varchar(6), '' )
            , 'MonPagPrimaCod'  = Convert( numeric(5)  , 0 )
            , 'MonPagPrimaNemo' = Convert( char(8)    , '' )
            , 'PrimaInicial'    = convert( float, 0.0 )
            , 'CarteraFinancieraCod'   = Convert( Varchar(6), '' )
            , 'CarteraFinancieraDsc'   = Convert( Char(50)  , '' )
            , 'CarteraNormativaCod'    = Convert( Varchar(6), '' )
            , 'CarteraNormativaDsc'    = Convert( Char(50)  , '' )
            , 'LibroCod'               = Convert( Varchar(6), '' ) 
            , 'LibroDsc'               = Convert( Char(50)  , '' )
            , 'AreaResponsalbleCod'    = Convert( VarChar(6), '' )   
            , 'AreaResponsalbleDsc'    = Convert( VarChar(50),'' ) 

            , 'SubCarNormativaCod'     = Convert( VarChar(6), '' )
            , 'SubCarNormativaDsc'     = Convert( Varchar(50), '' )
            , 'MonVrCod'          = Convert( numeric(5)  , 0 )
            , 'MonVrNemo'         = Convert( Char(8)    , '' )
            , 'Vr'                = convert( float       , 0.0 )
            , 'Nocional'          = convert( numeric(20,4), 0.0 )
            , 'Glosa'                 = convert( Varchar(80) , '' )
            , 'Usuario'               = convert( VarChar(15) , @Usuario )
            , 'FechaProceso'          = convert( datetime , @FechaProceso, 112 )
            , 'FechaCreacionRegistro' = convert( Datetime , '', 112 ) 
            , 'CotaInferior'          = convert( float    , @CotaInferior )   
            , 'CotaSuperior'          = convert( float    , @CotaSuperior )   
            , 'Control'               = convert( Varchar(60), '' )
            , 'R'                     = convert( float    , 0.0 ) 

            INTO #Encabezado
--     


            Select   
              'Reporte'         = convert( varchar(50),  'CONTROL DE PRECIO NIVEL CONTRATO' )
            , 'NumContrato'     = convert( numeric(8)  , Cartera.MoNumContrato )
            , 'NumFolio'        = convert( numeric(8)  , Cartera.MoNumFolio )
            , 'TipoTransaccion' = Convert( varchar(10) , Cartera.MoTipoTransaccion )
            , 'FechaContrato'   = convert( datetime    , Cartera.MoFechaContrato,112)
            , 'ConOpcEstCod'	= Convert( varchar(1)  , Cartera.MoEstado )
            , 'ConOpcEstDsc'    = Convert( varchar(30) , isnull( Estado.ConOpcEstDsc,  'Estado no Existe' ) )
            , 'CliRut'  	= Convert( numeric(13) , Cartera.MoRutCliente )
            , 'CliCod'        = convert( numeric(5)  , Cartera.MoCodigo )
            , 'CliDv'           = Convert( varchar(1)  , isnull( Cliente.ClDv, ' '  ) )
            , 'CliNom'  	= Convert( varchar(100), isnull( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )
            , 'Operador'        = Convert( varchar(15) , Cartera.MoOperador )
            , 'OpcEstCod'       = Convert( varchar(2)  , Cartera.MoCodEstructura  )
            , 'OpcEstDsc'       = COnvert( Varchar(30) , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )  
            , 'CVEstructura'    = convert( varchar(1)  , Cartera.MoCVEstructura )
            , 'CompraVentaEstructura'    = convert( varchar(6) , Case when Cartera.MoCVEstructura = 'C' then 'COMPRA' else 'VENTA' end )
            , 'MonPagPrimaCod'  = Convert( numeric(5)  , Cartera.MoCodMonPagPrima )
            , 'MonPagPrimaNemo' = convert( char(8)    , isnull( MonedaPrima.MnNemo, 'Moneda Prima no existe' ) )  
            , 'PrimaInicial'    = convert( float, Cartera.MoPrimaInicialML  ) -- MAP 29 Octubre 2009
            , 'CarteraFinancieraCod'   = Convert( Varchar(6), Cartera.MoCarteraFinanciera )
            , 'CarteraFinancieraDsc'   = Convert( Char(50)  , isnull( Financiera.tbglosa, 'Cartera Fin. no exite' ) )
            , 'CarteraNormativaCod'    = Convert( Varchar(6), Cartera.MoCarNormativa )
            , 'CarteraNormativaDsc'    = Convert( Char(50)  , isnull( Normativa.tbglosa, 'Catera Normativa no existe' ) )
            , 'LibroCod'               = Convert( Varchar(6), Cartera.MoLibro ) 
            , 'LibroDsc'               = Convert( Char(50)  , isnull( Libro.tbglosa, 'Libro no existe' ) )
            , 'AreaResponsalbleCod'    = Convert( VarChar(6), 6 )   -- Mesa de dinero siempre no tenemos el campo
            , 'AreaResponsalbleDsc'    = Convert( VarChar(50), isnull( Responsable.tbglosa, 'No existe area responsable' )  )   -- Mesa de dinero siempre no tenemos el campo

            , 'SubCarNormativaCod'     = Convert( VarChar(6), Cartera.MoSubCarNormativa )
            , 'SubCarNormativaDsc'     = Convert( Varchar(50), isnull( SubCartera.tbglosa,  'Falto SubCarNormatica'  ) )

            , 'MonVrCod'          = Convert( numeric(5)  , Cartera.MoMon_Vr )
            , 'MonVrNemo'         = Convert( Char(8)    , isnull( MonedaVr.MnNemo, 'Moneda Vr no existe' ) )
            , 'Vr'                = convert( float       , Cartera.MoVr )
            , 'Nocional'          = convert( numeric(20,4), ( select sum( MoMontoMon2 ) / count(1)      -- Se usará la pata en CLP como Nocional D.Contreras Vi 30 Oct.
                                                                   from #MoDetContrato M 
                                                            where M.MoNumFolio = Cartera.MoNumFolio   ) )                                                             
                                                                  
            , 'Glosa'                 = convert( Varchar(80)   , isnull( Cartera.MoGlosa , ' ' ) )
            , 'Usuario'               = convert( VarChar(15) , @Usuario )
            , 'FechaProceso'          = convert( datetime, @FechaProceso, 112 )
            , 'FechaCreacionRegistro' = convert( Datetime , isnull( Cartera.MoFechaCreacionRegistro, '' ) )      
            , 'CotaInferior'          = convert( float    , @CotaInferior )   
            , 'CotaSuperior'          = convert( float    , @CotaSuperior )   
            , 'Control'               = convert( Varchar(60), ' ' )
            , 'R'                     = convert( float    , 0.0 )
        into   #TempEncabezado 

        from   #MoEncContrato As Cartera
               LEFT JOIN #Cliente               Cliente 	 ON Cliente.ClRut            = Cartera.MoRutCliente and Cartera.MoCodigo = Cliente.ClCodigo 
--               LEFT JOIN #Moneda                MonedaUnwindTrf  ON MonedaUnwindTrf.MnCodMon = Cartera.MoUnwindTransfMon               
--               LEFT JOIN #Formas_Pago           FormaPagoUnwind  ON FormaPagoUnwind.Codigo = Cartera.MoFormPagoUnwind 
--               LEFT JOIN #Formas_Pago           FormaPagoPrima   ON FormaPagoPrima.Codigo = Cartera.MofPagoPrima 
--               LEFT JOIN #Moneda                MonedaUnwind     ON MonedaUnwind.MnCodMon = Cartera.MoUnwindMon
--               LEFT JOIN #Moneda                MonedaSpeed      ON MonedaSpeed.MnCodMon = Cartera.MoMon_Speed
--               LEFT JOIN #Moneda                MonedaZomma      ON MonedaZomma.MnCodMon = Cartera.MoMon_Zomma
--               LEFT JOIN #Moneda               MonedaCharm      ON MonedaCharm.MnCodMon = Cartera.MoMon_Charm
--               LEFT JOIN #Moneda                MonedaRhof       ON MonedaRhof.MnCodMon = Cartera.MoMon_Rhof
--               LEFT JOIN #Moneda                MonedaRho        ON MonedaRho.MnCodMon = Cartera.MoMon_Rho
--               LEFT JOIN #Moneda                MonedaVolga      ON MonedaVolga.MnCodMon = Cartera.MoMon_Volga
--               LEFT JOIN #Moneda                MonedaVanna      ON MonedaVanna.MnCodMon = Cartera.MoMon_Vanna
--               LEFT JOIN #Moneda                MonedaVega       ON MonedaVega.MnCodMon = Cartera.MoMon_Vega
--               LEFT JOIN #Moneda                MonedaGamma      ON MonedaGamma.MnCodMon = Cartera.MoMon_Gamma
--               LEFT JOIN #Moneda                MonedaDelta      ON MonedaDelta.MnCodMon = Cartera.MoMonDelta
               LEFT JOIN #Moneda                MonedaPrima      ON MonedaPrima.MnCodMon = Cartera.MoCodMonPagPrima
--               LEFT JOIN #Moneda                MonedaPrimaTranf ON MonedaPrimaTranf.MnCodMon = Cartera.MoMonPrimaTrf
--               LEFT JOIN #Moneda                MonedaPrimaCosto ON MonedaPrimaCosto.MnCodMon = Cartera.MoMonPrimaCosto
--               LEFT JOIN #Moneda                MonedaPrimaCarry ON MonedaPrimaCarry.MnCodMon = Cartera.MoMonCarryPrima
               LEFT JOIN #Moneda                MonedaVr         ON MonedaVr.MnCodMon = Cartera.MoMon_Vr
               LEFT JOIN ConOpcEstado  Estado           ON Estado.ConOpcEstCod = Cartera.MoEstado
               LEFT JOIN OpcionEstructura       Estructura       ON Estructura.OpcEstCod = Cartera.MoCodEstructura
               LEFT JOIN #TABLA_GENERAL_DETALLE Financiera  ON Financiera.tbcateg   = 204  AND Financiera.tbcodigo1  = Cartera.MoCarteraFinanciera
               LEFT JOIN #TABLA_GENERAL_DETALLE Normativa   ON Normativa.tbcateg    = 1111 AND Normativa.tbcodigo1   = Cartera.MoCarNormativa
               LEFT JOIN #TABLA_GENERAL_DETALLE Libro       ON Libro.tbcateg        = 1552 AND Libro.tbcodigo1 = Cartera.MoLibro
               LEFT JOIN #TABLA_GENERAL_DETALLE Responsable ON Responsable.tbcateg  = 1553 AND Responsable.tbcodigo1 = 6 -- No tenemos area responsable !!!
               LEFT JOIN #TABLA_GENERAL_DETALLE SubCartera  ON SubCartera.tbcateg   = 1554 AND SubCartera.tbcodigo1  = Cartera.MoSubCarNormativa  


      update #TempEncabezado
      set  R = abs( PrimaInicial + Vr ) / Nocional  * 100.0  -- MAP 29 Octubre modifica formula:  abs( PrimaInicial - Vr ) / Nocional

      update #TempEncabezado
      set  Control = rtrim( @Observacion ) + Case when R < CotaInferior then ' Rent. Instantánea bajo limite Inf.'  
                          when R > CotaSuperior  then ' Rent. Instantánea sobre limite Sup.'
                          else ' Rentabilidad Instantánea OK' end
      IF exists( select (1) from #TempEncabezado) BEGIN
          Truncate table #Encabezado 
          Insert Into #Encabezado
          Select *  from #TempEncabezado
     END
     select *,'BannerLargo' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales) from   #Encabezado        			

END
 

GO
