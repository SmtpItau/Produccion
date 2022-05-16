USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CaEncContrato]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--sp_helptext Sp_CaEncContrato
--Sp_CaEncContrato 1826358, 1, 0, '2014/04/08', '2900/01/01', '1900/01/01', '2900/01/01'
--Sp_CaEncContrato 99512770, 1, 0, '2014/04/08', '2900/01/01', '1900/01/01', '2900/01/01'
--Sp_CaEncContrato 97004000, 1, 0, '2014/04/02', '2900/01/01', '1900/01/01', '2900/01/01'
--Sp_CaEncContrato 0, 0, 0, '2014/04/02', '2900/01/01', '1900/01/01', '2900/01/01'



CREATE PROCEDURE [dbo].[Sp_CaEncContrato]    
     (    
       @CliRut         numeric(10)    
     , @CliCodigo      numeric(1)    
     , @Estado         int    
     , @fContratoIni   datetime    
     , @fContratoFin   datetime    
     , @fEjercicioIni  datetime    
     , @fEjercicioFin  datetime    
     )    
AS    
BEGIN    
    
    SET NOCOUNT ON    
    
    DECLARE @Nombre       Char(120)    
          , @Dv           Char(1)    
          , @FechaProceso datetime    
    
    
    -- Se Acopian todos los contratos   
    -- cursados en el sistema  
    select * into #CaEncContrato  
    from CBMDBOPC.DBO.CaVenEncContrato  
    update #CaEncContrato set CaEstado = 'V'  
    insert into #CaEncContrato  
    select * from CBMDBOPC.DBO.CaEnccontrato  


  
    select * into #CaDetContrato  
    from CBMDBOPC.DBO.CaDetContrato  
    union  
    select * from CBMDBOPC.DBO.CaVenDetContrato  
  
    Select *   
    into #ConOpcEstado  
    from CBMDBOPC.DBO.ConOpcEstado    
  
    insert into #ConOpcEstado  
    select 'V', 'Vencido'  
  
    -- Se Acopian todos los contratos  
    -- cursados en el sistema  
  
  
  --  SELECT * INTO #Moneda FROM LNKBAC.bacparamsuda.dbo.Moneda   
	SELECT * INTO #Moneda FROM bacparamsuda.dbo.Moneda       
    
    
    -- Reducir el contenido de la tabla Cliente    
    SELECT *  
      INTO #Cliente    
      FROM bacparamsuda.dbo.VIEW_CLIENTEParaOpc      
     WHERE ( @CliRut  = 0 AND ClRut IN ( SELECT CaRutCliente FROM #CaEncContrato )  )  
        OR ( @CliRut <> 0 AND ClRut = @CliRut AND ClCodigo = @CliCodigo )  
    
    update #Cliente     
 set ClNombre = substring( ClNOmbre, 1                              , PATINDEX('%&%', ClNombre ) - 1  )    
                               + substring( ClNOmbre, PATINDEX('%&%', ClNombre ) + 1 , len(ClNOmbre)                  )    
                              --, ClNOmbre from lnkbac.BacParamSuda.dbo.Cliente     
    
        where clnombre like ('%&%')    
    
       
    
    
    -- Validar si existe el cliente que viene del parámetro    
    SET @Nombre = ''    
    
    IF @CliRut <> 0  
    BEGIN    
        SET @Nombre = 'Cliente no existe, crear en BAC'    
    
    END    
    
    SELECT @Nombre = ClNOmbre    
      FROM #Cliente    
     WHERE @CliRut <> 0  
       AND ClRut    = @CliRut    
       AND ClCodigo = @CliCodigo     
    
    SELECT 'Objeto'          = convert( varchar(40) , 'CONSULTA CARTERA' )    
         , 'NumContrato'     = convert( numeric(8)  , Cartera.CaNumContrato )     
         , 'TipoTransaccion' = convert( Varchar(10) , Cartera.CaTipoTransaccion )    
         , 'NumFolio'        = convert( numeric(8)  , Cartera.CaNumFolio )    
         , 'FechaContrato'   = convert( datetime    , Cartera.CaFechaContrato,112)    
         , 'ConOpcEstCod'    = Convert( varchar(1)  , Cartera.CaEstado )    
         , 'ConOpcEstDsc'    = Convert( varchar(30) , isnull( Estado.ConOpcEstDsc,  'Preparacion' ) )    
         , 'CliRut'          = Convert( numeric(13) , Cartera.CaRutCliente )    
         , 'CliCod'          = convert( numeric(5)  , Cartera.CaCodigo )    
         , 'CliDv'           = Convert( varchar(1)  , isnull( Cliente.ClDv, ' '   ) )    
         , 'CliNom'          = Convert( varchar(100), isnull( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )    
         , 'Operador'        = Convert( varchar(15) , Cartera.CaOperador )    
         , 'OpcEstCod'       = Convert( varchar(2)  , Cartera.CaCodEstructura  )    
         , 'OpcEstDsc'       = COnvert( Varchar(20) , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )      
         , 'Contrapartida'   = Convert( varchar(8)  , Cartera.CaTipoContrapartida )    
         , 'Pay_OffCod'      = Convert( varchar(2)  , isnull( ( Select max( CaTipoPayOff )    
                                                                  from #cadetContrato Det   
                                                                 where Det.CaNumcontrato = Cartera.CaNumContrato )     
                                                    , 'NH' ) )    
         , 'Pay_OffDsc'      = Convert( varchar(20) , '' )   
		 ,		'Impreso'		= CbMdbOpc.dbo.Fn_Estatus_Impreso ('OPC', Cartera.CaNumContrato) 
		 

      INTO #Encabezado    
      FROM #CaEncContrato Cartera  
    LEFT JOIN #Cliente Cliente             ON Cartera.CaRutCliente = Cliente.ClRut    
                                                 AND Cartera.CaCodigo     = Cliente.ClCodigo    
           LEFT JOIN CbMdbOpc.dbo.OpcionEstructura Estructura  ON Estructura.OpcEstCod = Cartera.CaCodEstructura     
           LEFT JOIN #ConOpcEstado     Estado      ON Estado.ConOpcEstCod  = Cartera.CaEstado  -- select * from ConOpcEstado  
    -- Filtros del procedimiento    
     WHERE(( @CliRut                =      0   )    
        OR( @CliRut                <>      0  
       AND ClRut                    =      @CliRut    
       AND ClCodigo               = @CliCodigo ))    
       --AND Cartera.CaFechaContrato BETWEEN @fContratoIni AND @fContratoFin    
	    AND Cartera.CaFechaContrato = @fContratoIni   
       AND(@Estado                  = 1    
       AND CaTipoTransaccion        = 'ANTICIPA'    
        OR @Estado                  = 0    
       AND CaTipoTransaccion       <> 'ANTICIPA')  
    
    UPDATE #Encabezado     
       SET Pay_OffCod = ISNULL( ( SELECT 'VA'    
                                    FROM #CaDetContrato Det   
                                   WHERE Det.CanumCOntrato  = #Encabezado.NumCOntrato     
                              AND Det.CaTipoPayOff  <> Pay_OffCod )  
                              , Pay_OffCod )    
    
    UPDATE #Encabezado     
       SET Pay_OffDsc = ISNULL( ( SELECT PayOffTipDsc    
                                    FROM CBMDBOPC.DBO.PayOffTipo PO     
                                  WHERE PO.PayOffTipCod = #Encabezado.Pay_OffCod )    
                              , 'Varios Pay Off' )      
    
    -- select 'Debug', * from #Encabezado    
    IF EXISTS( SELECT (1) FROM #encabezado )    
    BEGIN    
         SELECT * FROM #encabezado order by  NumContrato Asc  --ConOpcEstDsc desc,
    
    END ELSE    
    BEGIN    
        SELECT 'Objeto'          = convert( varchar(40) , 'CONSULTA CARTERA SIN DATOS' )    
             , 'NumContrato'     = convert( numeric(8)  , 0 )     
             , 'TipoTransaccion' = convert( Varchar(10) , ' ' )    
             , 'NumFolio'        = convert( numeric(8)  , 0 )    
             , 'FechaContrato'   = convert( datetime    , '19000101' ,112)    
             , 'ConOpcEstCod'    = Convert( varchar(1)  , ' ' )    
             , 'ConOpcEstDsc'    = Convert( varchar(30) , ' ' )    
             , 'CliRut'          = Convert( numeric(13) , 0 )    
             , 'CliCod'          = convert( numeric(5)  , 0 )    
             , 'CliDv'           = Convert( varchar(1)  ,  ' '    )    
             , 'CliNom'          = Convert( varchar(100),  ' '    )    
             , 'Operador'        = Convert( varchar(15) , ' ' )    
             , 'OpcEstCod'       = Convert( varchar(2)  , '  '  )    
             , 'OpcEstDsc'       = COnvert( Varchar(20) , ' ' )      
             , 'Contrapartida'   = Convert( varchar(8)  , ' ' )    
             , 'Pay_OffCod'      = Convert( varchar(2)  , '  ' )    
             , 'Pay_OffDsc'      = Convert( varchar(20) , '' )    
			  ,		'Impreso'		= 0
    
    END    
    
END


GO
