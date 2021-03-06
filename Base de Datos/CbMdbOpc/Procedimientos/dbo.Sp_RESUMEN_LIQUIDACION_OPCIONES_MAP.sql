USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_RESUMEN_LIQUIDACION_OPCIONES_MAP]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- Compilado  Sp_RESUMEN_LIQUIDACION_OPCIONES_MAP 23, '20100820', 'LGUERRA'
CREATE PROCEDURE [dbo].[Sp_RESUMEN_LIQUIDACION_OPCIONES_MAP]
              ( @NumContrato     numeric(9), 
                @FechaPago       datetime,
                @Usuario Varchar(15)  )  

AS BEGIN			
   SET NOCOUNT ON

DECLARE  @FechaProceso Datetime
       , @RutEntidad   Numeric(9)
       , @DvEntidad    Char(1) 
       , @NomEntidad   char (45)
       , @OperEntidad  char (45)
       , @RutCli       Numeric(9)
       , @DvCli        Char(1) 
       , @NomCli   char (45)

     -- MAP 06 Octubre: contingencia, para evitar división por cero en liquidacion


     select @FechaProceso = ''               

     -- Solo se cargarán Clientes que alguna vez han tenido opciones
     select ClRut, ClCodigo, ClDv, ClNombre 
     into #Cliente from lnkBac.BacParamSuda.dbo.CLIENTE  -- MAP Contingencia


    -- Contingencia: Manejo de Fecha: Mes y Año
    -- por mientras se solicita arreglo definitivo
    select CaNumContrato
      into #CaCajaVerifica
    from CaCaja 
    where CaNumContrato = @NumContrato
                          and CaCajFecPago  = @FechaPago
                          and CaCajOrigen  in ( 'PV', 'PA' )
    union select CaNumContrato from   CaVenCaja where
                          CaNumContrato = @NumContrato
                          and CaCajFecPago  = @FechaPago
                          and CaCajOrigen  in ( 'PV', 'PA' )
    
    declare @Cta numeric(3)
    select  @Cta = 0
    select  @Cta = count(*) from #CaCajaVerifica
    if @Cta = 0 begin
       declare @InvierteFecha Varchar(1)
       select @InvierteFecha = 'N'
       select @InvierteFecha =  Case when tbvalor = 1 then 'S' else 'N' end  from lnkbac.bacparamsuda.dbo.tabla_general_detalle where tbcateg = 2551 

       if @InvierteFecha = 'S' and day( @FechaPago ) < 10
       select @FechaPago = convert( varchar(4), year(@FechaPago) ) 
                         + case when day( @FechaPago ) > 9 then  convert( varchar(2), day( @FechaPago ))
                                else '0' + convert( varchar(1), day( @FechaPago )) end
                         + case when month( @FechaPago ) > 9 then convert( varchar(2), month( @FechaPago ))
                                else '0' + convert( varchar(1), month( @FechaPago )) end                        

     end
     -- Fin Contingencia



     select @FechaProceso = fechaproc 
          , @RutEntidad   = isnull(Rut, 0)
          , @DvEntidad    = isnull(ClDv,'')
          , @NomEntidad   = isnull(nombre,'') 
          , @OperEntidad  = ' N/A '
     from   OpcionesGeneral    
          , #Cliente           
--          , LNKBAC.bacparamsuda.dbo.CLIENTE_OPERADOR   
     where Rut      = ClRut
     and   ClCodigo = 1  
--     and   Rut      = oprutcli
--     and   opcodcli = 1
 

      select * into #Moneda  from LNKBAC.bacparamsuda.dbo.Moneda

      select * into #Formas_Pago  from LNKBAC.bacparamsuda.dbo.Forma_de_Pago 

      select * into #GEN_SISTEMAS from LNKBAC.BacParamSuda.dbo.SISTEMA_CNT



      select 'ResCaNumContrato'     = convert( numeric(8)  , 0 )
           , 'ResCaNumEstructura'   = convert( numeric(6)  , 0 )
           , 'ResCaCajFolio'        = convert( numeric(8)  , 0 )
           , 'ResCaCajFechaGen'     = convert( datetime    , '',112)
           , 'ResCaCajFecPago'      = convert( datetime    , '',112)
           , 'ResCaCajFDeMon1'      = convert( float, 0.0 )
           , 'ResCaCajMtoMon1'      = convert( float, 0.0000001 )
           , 'ResCaCajFDeMon2'      = convert( float, 0.0 )
           , 'ResCaCajMtoMon2'      = convert( float, 0.0 )
           , 'ResCaCajEstado'       = Convert( Char(2)  , '' )
           , 'ResCaMTMImplicito'    = convert( float, 0.0 )
           , 'ResCaCajFormaPagoMon1'= convert( numeric(5)  , 0 )
           , 'ResCaCajFormaPagoMon2'= convert( numeric(5)  , 0 )
           , 'ResCaCajMdaM1'        = convert( numeric(5)  , 0 )
           , 'ResCaCajMdaM2'        = convert( numeric(5)  , 0 )
           , 'ResCaCajOrigen'       = Convert( Varchar(2), '' )
         , 'ResCaCajMotorPago'    = Convert( Varchar(2), '' )
           , 'ResCaCajModalidad'    = Convert( Char(1)  , '' )
           , 'ResCajForPagM1Desc'   = Convert( Char(30)  , '' )
           , 'ResCajForPagM2Desc'   = Convert( Char(30)  , '' )
           , 'ResCajMdaM1Desc'      = Convert( Char(8)  , '' )
           , 'ResCajMdaM2Desc'      = Convert( Char(8)  , '' )
           , 'ResRutCli'            = convert( numeric(9)  , 0 )
           , 'ResCodCli'            = convert( numeric(9)  , 0 )
           , 'ResDvCli'             = Convert( Char(1)  , '' )
           , 'ResNomCli'            = Convert( Char(70)  , '' )
           , 'ResRutEnt'            = convert( numeric(9)  , 0 )
           , 'ResDvEnt'             = Convert( Char(1)  , '' )
           , 'ResNomEnt'            = Convert( Char(70)  , '' )
      into #Resultado

      select 'NumCont' = Cartera.CaNumContrato
           , 'RutCli'  = Cartera.CaRutCliente           
           , 'CodCli'  = Cartera.CaCodigo
           , 'DvCli'   = Cli.ClDv
           , 'NomCli'  = Cli.ClNombre 
      into  #TempCli
      from   CaEncContrato Cartera
           , #Cliente  Cli
      where  Cartera.CaNumContrato = @NumContrato
      and    Cartera.CaRutCliente  = Cli.ClRut
      and    Cartera.CaCodigo      = Cli.ClCodigo

      Union
      select 'NumCont' = CarteraVen.CaNumContrato 
           , 'RutCli'  = CarteraVen.CaRutCliente           
           , 'CodCli'  = CarteraVen.CaCodigo
           , 'DvCli'   = Cli.ClDv
           , 'NomCli'  = Cli.ClNombre 
      from   CaVenEncContrato CarteraVen
           , #Cliente   Cli
      where   CarteraVen.CaNumContrato = @NumContrato
        and   CarteraVen.CaRutCliente  = Cli.ClRut    
        and   CarteraVen.CaCodigo      = Cli.ClCodigo 


      select --CaCaja.* 
             'ResCaNumContrato'     = CaNumContrato
           , 'ResCaNumEstructura'   = CaNumEstructura
           , 'ResCaCajFolio'        = CaCajFolio
           , 'ResCaCajFechaGen'     = CaCajFechaGen
           , 'ResCaCajFecPago'      = CaCajFecPago
           , 'ResCaCajFDeMon1'      = CaCajFDeMon1
           , 'ResCaCajMtoMon1'      = case when CaCajMtoMon1 = 0 then 0.0000001 else CaCajMtoMon1 end
           , 'ResCaCajFDeMon2'      = CaCajFDeMon2
           , 'ResCaCajMtoMon2'      = CaCajMtoMon2
           , 'ResCaCajEstado'       = CaCajEstado
           , 'ResCaMTMImplicito'    = CaMTMImplicito
           , 'ResCaCajFormaPagoMon1'= CaCajFormaPagoMon1
           , 'ResCaCajFormaPagoMon2'= CaCajFormaPagoMon2
           , 'ResCaCajMdaM1'        = CaCajMdaM1
           , 'ResCaCajMdaM2'        = CaCajMdaM2
           , 'ResCaCajOrigen'       = CaCajOrigen
           , 'ResCaCajMotorPago'    = CaCajMotorPago
           , 'ResCaCajModalidad'    = CaCajModalidad
           , 'ResCajForPagM1Desc'   = isnull(FormaPagoM1.glosa , '')
           , 'ResCajForPagM2Desc'   = isnull(FormaPagoM2.glosa , '')
           , 'ResCajMdaM1Desc'      = isnull(MonedaM1.MnNemo   , '')
           , 'ResCajMdaM2Desc'      = isnull(MonedaM2.MnNemo   , '')
           , 'ResRutCli'            = isnull(Cliente.RutCli    , 0)
           , 'ResCodCli'            = isnull(Cliente.CodCli    , 0)
           , 'ResDvCli'             = isnull(Cliente.DvCli    , '')
           , 'ResNomCli'            = isnull(Cliente.NomCli    , '')
           , 'ResRutEnt'            = @RutEntidad 
           , 'ResDvEnt'             = @DvEntidad
           , 'ResNomEnt'            = @NomEntidad

      into #CaCaja

      from CaCaja 

           LEFT JOIN     #Formas_Pago FormaPagoM1 ON FormaPagoM1.Codigo = CaCaja.CaCajFormaPagoMon1
           LEFT JOIN     #Formas_Pago FormaPagoM2 ON FormaPagoM2.Codigo = CaCaja.CaCajFormaPagoMon2
           LEFT JOIN     #Moneda      MonedaM1    ON MonedaM1.MnCodMon  = CaCaja.CaCajMdaM1
           LEFT JOIN     #Moneda      MonedaM2    ON MonedaM2.MnCodMon  = CaCaja.CaCajMdaM2
        LEFT JOIN     #TempCli     Cliente     ON Cliente.NumCont  = CaCaja.CaNumContrato
      where CaNumContrato = @NumContrato
      and   CaCajFecPago  = @FechaPago
      and   CaCajOrigen  IN ( 'PV', 'PA' )
      union 
      select -- CaVenCaja.* 
             'ResCaNumContrato'     = CaNumContrato
           , 'ResCaNumEstructura'   = CaNumEstructura
           , 'ResCaCajFolio'        = CaCajFolio
           , 'ResCaCajFechaGen'     = CaCajFechaGen
           , 'ResCaCajFecPago'      = CaCajFecPago
           , 'ResCaCajFDeMon1'      = CaCajFDeMon1
           , 'ResCaCajMtoMon1'      = case when CaCajMtoMon1 = 0 then 0.0000001 else CaCajMtoMon1 end -- CaCajMtoMon1  
           , 'ResCaCajFDeMon2'      = CaCajFDeMon2
           , 'ResCaCajMtoMon2'      = CaCajMtoMon2
           , 'ResCaCajEstado'       = CaCajEstado
           , 'ResCaMTMImplicito'    = CaMTMImplicito
           , 'ResCaCajFormaPagoMon1'= CaCajFormaPagoMon1
           , 'ResCaCajFormaPagoMon2'= CaCajFormaPagoMon2
           , 'ResCaCajMdaM1'        = CaCajMdaM1
           , 'ResCaCajMdaM2'        = CaCajMdaM2
           , 'ResCaCajOrigen'       = CaCajOrigen
           , 'ResCaCajMotorPago'    = CaCajMotorPago
           , 'ResCaCajModalidad'    = CaCajModalidad
           , 'ResCajForPagM1Desc'   = isnull(FormaPagoM1.glosa , '')
           , 'ResCajForPagM2Desc'   = isnull(FormaPagoM2.glosa , '')
           , 'ResCajMdaM1Desc'      = isnull(MonedaM1.MnNemo   , '')
           , 'ResCajMdaM2Desc'      = isnull(MonedaM2.MnNemo   , '')
           , 'ResRutCli'            = isnull(Cliente.RutCli    , 0)
           , 'ResCodCli'            = isnull(Cliente.CodCli    , 0)
           , 'ResDvCli'             = isnull(Cliente.DvCli     , '')
           , 'ResNomCli'            = isnull(Cliente.NomCli    , '')
           , 'ResRutEnt'            = @RutEntidad 
           , 'ResDvEnt'             = @DvEntidad
           , 'ResNomEnt'            = @NomEntidad
      from CaVenCaja 
           LEFT JOIN     #Formas_Pago FormaPagoM1 ON FormaPagoM1.Codigo = CaVenCaja.CaCajFormaPagoMon1
           LEFT JOIN     #Formas_Pago FormaPagoM2 ON FormaPagoM2.Codigo = CaVenCaja.CaCajFormaPagoMon2
           LEFT JOIN     #Moneda      MonedaM1    ON MonedaM1.MnCodMon  = CaVenCaja.CaCajMdaM1
           LEFT JOIN     #Moneda      MonedaM2    ON MonedaM2.MnCodMon  = CaVenCaja.CaCajMdaM2
           LEFT JOIN     #TempCli     Cliente     ON Cliente.NumCont  = CaVenCaja.CaNumContrato
      where CaNumContrato = @NumContrato
      and   CaCajFecPago  = @FechaPago
      and   CaCajOrigen  in ( 'PV', 'PA' )


   IF exists( select (1) from #CaCaja  ) BEGIN
          select Caja.* 
          from #CaCaja Caja

     END
     ELSE
         -- Se despliega el registro Sin Datos.
         select * from   #Resultado        			

END
GO
