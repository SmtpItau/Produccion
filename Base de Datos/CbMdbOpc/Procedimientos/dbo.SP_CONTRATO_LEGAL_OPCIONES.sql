USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTRATO_LEGAL_OPCIONES]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- SP_CONTRATO_LEGAL_OPCIONES 'ecastillo', 0, 0, 0, 0, 11287 


CREATE PROCEDURE [dbo].[SP_CONTRATO_LEGAL_OPCIONES]
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

    SET NOCOUNT ON          
          
    -- Pora hacer por elegancia: generalizar con @@DATEFIRST cualquiera          
    -- MAP 20091216 Faltaba condcion ImpGrupo            = @Grupo          
          
 -- ASVG 17 Marzo 2011 Se agregan campos y procedimiento para generar montos escritos.          
 -- ASVG 30 Marzo 2011 Ahora que no hay linkservers se podría aprovechar el SP_MONTOESCRITO directamente desde Bac.          
 -- ASVG 29 Abril 2011 Se agrega campo comuna del cliente para contrato Forward Americano.          
          
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
          
 DECLARE @MM1    NUMERIC(21,6)  --ASVG_20110317          
 DECLARE @MM2    NUMERIC(21,6)  --ASVG_20110317          
 DECLARE @MontoMon1Escrito VARCHAR(170)  --ASVG_20110317          
 DECLARE @MontoMon2Escrito VARCHAR(170)  --ASVG_20110317          

  DECLARE @DvEntidad		VARCHAR(1)  
 DECLARE @CodEntidad	VARCHAR(2)
 DECLARE @ComunaEntidad	VARCHAR(30)
 DECLARE @CiudadEntidad	VARCHAR(30)
 --DECLARE @LOGOBANCO IMAGE



          
    SELECT @FechaProceso = FechaProc          
      --   , @Nombre       = nombre          
      --   , @Rut          = rut          
      --   , @Domicilio    = direccion          
      --   , @Fono         = telefono          
         , @Fax          = Fax          
     , @Codigo       = 1          
      FROM dbo.OpcionesGeneral          

   	SELECT 
			@Nombre			=	RazonSocial	
	,		@Rut			=	RutEntidad	
	,		@Dv				=	DigitoVerificador
	,		@CodEntidad		=   CodigoEntidad
	,		@Domicilio		=	DireccionLegal + ', ' + Comuna + ', ' + Ciudad
	,		@Fono			=	TelefonoLegal
	,		@ComunaEntidad  =	Comuna
	,		@CiudadEntidad  =	Ciudad
	--,		@LOGOBANCO		=	BannerLargoContrato
	FROM bacparamsuda.dbo.Contratos_ParametrosGenerales



 -- Obtener Nombre y rut de Apoderados ---
 --DECLARE @cNom_Apoderado_Banco_1		VARCHAR(40);	SET @cNom_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( 97023000, 1, 13842499, 2)
 --print @cNom_Apoderado_Banco_1
 -- 13842499-5
 --select * FROM BacParamSuda.dbo.View_CLIENTEParaOpc 

 DECLARE @Num_Oper NUMERIC(20) 
 DECLARE @RUT_CLIENTE NUMERIC(11)
 DECLARE @COD_CLIENTE NUMERIC(5)

SET @Num_Oper = (select impNumContrato from IMPRESION where ImpGrupo = @Grupo)



SET @RUT_CLIENTE = (select CaRutCliente from CaEncContrato where CaNumContrato = @Num_Oper
				  union
					select CaRutCliente from CaVenEnccontrato  where CaNumContrato = @Num_Oper)

SET @COD_CLIENTE = (select CaCodigo from CaEncContrato where CaNumContrato = @Num_Oper
				  union
					select CaCodigo from CaVenEnccontrato  where CaNumContrato = @Num_Oper)


	--DECLARE @cNom_Apoderado_Banco_1		VARCHAR(40);	SET @cNom_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RutRepBan01, 1)
	--DECLARE @cRut_Apoderado_Banco_1		VARCHAR(40);	SET	@cRut_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RutRepBan01, 2)
	--DECLARE @cNom_Apoderado_Banco_2		VARCHAR(40);	SET @cNom_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RutRepBan02, 1)
	--DECLARE @cRut_Apoderado_Banco_2		VARCHAR(40);	SET	@cRut_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( 97023000, 1, @RutRepBan02, 2)
	DECLARE @cNom_Apoderado_Banco_1		VARCHAR(40);	SET @cNom_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( @Rut, @CodEntidad, @RutRepBan01, 1)
	DECLARE @cRut_Apoderado_Banco_1		VARCHAR(40);	SET	@cRut_Apoderado_Banco_1		= dbo.Fx_Retorna_Apoderados( @Rut, @CodEntidad, @RutRepBan01, 2)
	DECLARE @cNom_Apoderado_Banco_2		VARCHAR(40);	SET @cNom_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( @Rut, @CodEntidad, @RutRepBan02, 1)
	DECLARE @cRut_Apoderado_Banco_2		VARCHAR(40);	SET	@cRut_Apoderado_Banco_2		= dbo.Fx_Retorna_Apoderados( @Rut, @CodEntidad, @RutRepBan02, 2)
	DECLARE @cNom_Apoderado_Cliente_1	VARCHAR(40);	SET @cNom_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RutRepCli01, 1)
	DECLARE @cRut_Apoderado_Cliente_1	VARCHAR(40);	SET @cRut_Apoderado_Cliente_1	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RutRepCli01, 2)
	DECLARE @cNom_Apoderado_Cliente_2	VARCHAR(40);	SET @cNom_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RutRepCli02, 1)
	DECLARE @cRut_Apoderado_Cliente_2	VARCHAR(40);	SET @cRut_Apoderado_Cliente_2	= dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RutRepCli02, 2)

	          
	declare @dvb1 varchar(2)
	declare @dvb2 varchar(2)
	declare @dvc1 varchar(2)
	declare @dvc2 varchar(2)
	set @dvb1 = ''
	set @dvb2 = ''
	set @dvc1 = ''
	set @dvc2 = ''

	if @cRut_Apoderado_Banco_1 <> ''
	begin
		set @dvb1 = SUBSTRING(@cRut_Apoderado_Banco_1,len(@cRut_Apoderado_Banco_1),+1)
		set @cRut_Apoderado_Banco_1 = SUBSTRING(@cRut_Apoderado_Banco_1,1,CHARINDEX('-',@cRut_Apoderado_Banco_1)-1)  
		set	@cRut_Apoderado_Banco_1	=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Banco_1))) ), 1), '.00', ''), ',','.'))
	end
	if @cRut_Apoderado_Banco_2 <> ''
	begin
		set @dvb2 = SUBSTRING(@cRut_Apoderado_Banco_2,len(@cRut_Apoderado_Banco_2),+1)
		set @cRut_Apoderado_Banco_2 = SUBSTRING(@cRut_Apoderado_Banco_2,1,CHARINDEX('-',@cRut_Apoderado_Banco_2)-1)  
		set	@cRut_Apoderado_Banco_2	=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Banco_2))) ), 1), '.00', ''), ',','.'))
	end
		if @cRut_Apoderado_Cliente_1 <> ''
	begin
		set @dvc1 = SUBSTRING(@cRut_Apoderado_Cliente_1,len(@cRut_Apoderado_Cliente_1),+1)
		set @cRut_Apoderado_Cliente_1 = SUBSTRING(@cRut_Apoderado_Cliente_1,1,CHARINDEX('-',@cRut_Apoderado_Cliente_1)-1)  
		set	@cRut_Apoderado_Cliente_1	=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Cliente_1))) ), 1), '.00', ''), ',','.'))
	end
	
	if @cRut_Apoderado_Cliente_2 <> ''
	begin
		set @dvc2 = SUBSTRING(@cRut_Apoderado_Cliente_2,len(@cRut_Apoderado_Cliente_2),+1)
		set @cRut_Apoderado_Cliente_2 = SUBSTRING(@cRut_Apoderado_Cliente_2,1,CHARINDEX('-',@cRut_Apoderado_Cliente_2)-1)  
		set	@cRut_Apoderado_Cliente_2	=  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Cliente_2))) ), 1), '.00', ''), ',','.'))
	end

    --SELECT @FechaProceso = FechaProc          
    --     , @Nombre       = nombre          
    --     , @Rut          = rut          
    --     , @Domicilio    = direccion          
    --     , @Fono         = telefono          
    --     , @Fax          = Fax          
    --     , @Codigo       = 1          
    --  FROM dbo.OpcionesGeneral    
	             
          
    --SELECT @Dv   = ClDv          
    --     , @Fax  = ClFax          
    --     , @Fono = Clfono       
    --  FROM BacParamSuda.dbo.View_CLIENTEParaOpc          
    -- WHERE clrut = @Rut           
    -- AND  Clcodigo =1       
    -- MAP 14 Nov. 2009 desvio por prob lnkServer        
      
              
          
    SET @FechaDefault = '19000101'          
          
    -- Sección que genera el registro vacóo.          
    SELECT 'Reporte'                       = CONVERT( VARCHAR(40), 'CONTRATO LEGAL' )          
         , 'TipReg'                        = CONVERT( VARCHAR(10), 'VACIO'  )          
         , 'NumContrato'                   = CONVERT( NUMERIC(8), 0 )          
         , 'CaNumEstructura'               = CONVERT( NUMERIC(6), 0 )           
         , 'CliRut'                        = CONVERT( NUMERIC(13), 0 )          
         , 'CliCod'                        = CONVERT( NUMERIC(5), 0 )          
         , 'CliDv'                         = CONVERT( VARCHAR(1), '' )  
		 , 'CliNom'           = CONVERT( VARCHAR(100), 'NO HAY DATOS' )  
         , 'Operador'                      = CONVERT( VARCHAR(15), '' )          
		 , 'OpcEstCod'                     = CONVERT( VARCHAR(2), '' )          
         , 'OpcEstDsc'                     = CONVERT( VARCHAR(30), '' ) -->   
         , 'OpcCompraEstrucutura'          = CONVERT( VARCHAR(100),  '' )          
		 , 'OpcVENDeEstrucutura'           = CONVERT( VARCHAR(100),  '' )          
         , 'NumComponente'                 = CONVERT( NUMERIC(6), 0 )          
         , 'PayOffTipCod'       = CONVERT( VARCHAR(2), '' )          
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
         , 'Mon2Cod'        = CONVERT( NUMERIC(5), 0 )          
         , 'Mon2Dsc'        = CONVERT( VARCHAR(35), '' )          
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
         , 'EstadoMotorPagoDsc'      = CONVERT( VARCHAR(20), '' )           
         , 'Refijable'                     = CONVERT( VARCHAR(10), 'RE-FIJABLE' )          
         , 'Usuario'                    = CONVERT( VARCHAR(15), '' )          
         , 'Anno'                          = CONVERT( VARCHAR(4), '2000' )          
         , 'Banco'                         = CONVERT( VARCHAR(16), LEFT( @Nombre, 16 ) )          
         , 'Rut'                  = CONVERT( NUMERIC(9), @Rut )          
         , 'Dv'                            = CONVERT( VARCHAR(1), @Dv )          
         , 'FechaContratoLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )          
         , 'FechaCondGeneLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )          
         , 'FechaCondGeneOpcLarga'         = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )          
         , 'FechaCondGeneOpcSupLarga'      = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )          
         , 'TipoEjercicioCod'              = CONVERT( CHAR(1),  ' ' )          
         , 'TipoEjercicioDsc'              = CONVERT( VARCHAR(10), 'AMERICANA' )          
         , 'PrecioTope'                    = CONVERT( FLOAT, 0.0 )        --PRD_20975 ASVG_20140730 Para Strike4
         , 'PrecioSuperior'                = CONVERT( FLOAT, 0.0 )          
         , 'PrecioMedio'                   = CONVERT( FLOAT, 0.0 )          
         , 'PrecioPiso'                    = CONVERT( FLOAT, 0.0 )          
         , 'MtoPrima'                      = CONVERT( FLOAT, 0.0 )          
         , 'FormaPagoPrimaCod'             = CONVERT( NUMERIC(3), 0 )          
         , 'FormaPagoPrimaDsc'             = CONVERT( VARCHAR(30), '' )          
         , 'MdaPagoPrimaCod'               = CONVERT( NUMERIC(5), 0 )           
         , 'MdaPagoPrimaDsc'               = CONVERT( VARCHAR(35), '' )          
         , 'FechaPagoPrima'                = @FechaDefault          
        -- , 'ApoderadoClienteRut01'         = CONVERT( NUMERIC(9), 0 )   
		 , 'ApoderadoClienteRut01'         = @cRut_Apoderado_Cliente_1       --> PRD-21658 
         , 'ApoderadoClienteDv01'          = CONVERT( CHAR(1), 0 )          
         , 'ApoderadoClienteNombre01'      = CONVERT( VARCHAR(100), '' )          
         , 'ApoderadoClienteDomicilio01'   = CONVERT( VARCHAR(100), '' )          
         , 'ApoderadoClienteFax01'         = CONVERT( VARCHAR(50), '' )           
		 , 'ApoderadoClienteFono01'        = CONVERT( VARCHAR(50), '' )          
         --, 'ApoderadoBancoRut01'           = CONVERT( NUMERIC(9), 0 )          
         --, 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' )   
		 , 'ApoderadoBancoRut01'           = @cRut_Apoderado_Banco_1       --> PRD-21658 
         , 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' )         
		 , 'ApoderadoBancoNombre01'        = CONVERT( VARCHAR(100), '' )        
         , 'ApoderadoBancoDomicilio01'     = CONVERT( VARCHAR(100), '' )          
		 , 'ApoderadoBancoFax01'           = CONVERT( VARCHAR(50), '' )          
         , 'ApoderadoBancoFono01'          = CONVERT( VARCHAR(50), '' )     
		      
         --, 'ApoderadoBancoRut02'           = CONVERT( NUMERIC(9), 0 )        
         --, 'ApoderadoBancoDv02'            = CONVERT( VARCHAR(1), '' )    
		 , 'ApoderadoBancoRut02'           = @cRut_Apoderado_Banco_2      
         , 'ApoderadoBancoDv02'            = CONVERT( VARCHAR(1), '' )        

         , 'ApoderadoBancoNombre02'        = CONVERT( VARCHAR(100), '' )        
         , 'ApoderadoBancoDomicilio02'     = CONVERT( VARCHAR(100), '' )        
         , 'ApoderadoBancoFax02'           = CONVERT( VARCHAR(50), '' )        
         , 'ApoderadoBancoFono02'          = CONVERT( VARCHAR(50), '' )  
         , 'MtoPrecioTope'                 = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioSuperior'             = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioMedio'                = CONVERT( FLOAT, 0.0 )
         , 'MtoPrecioPiso'                 = CONVERT( FLOAT, 0.0 )
         , 'ReceptorPrima'                 = CONVERT( VARCHAR(100), '' )          
         , 'PagadorPrima'                  = CONVERT( VARCHAR(100), '' )          
         , 'Control'                       = CONVERT( VARCHAR(250), '' )          
		 , 'MontoMon1Escrito'      = CONVERT( VARCHAR(250), '' )  --ASVG_20110317  
		 , 'MontoMon2Escrito'      = CONVERT( VARCHAR(250), '' )  --ASVG_20110317  
		 , 'FechaVctoLarga'       = CONVERT( VARCHAR(30), '' )   --ASVG_20110317  
		 , 'ApoderadoClienteComuna01'    = CONVERT( VARCHAR(50), '' )   --ASVG_20110429  
		 , 'FechasVencimiento'             = CONVERT( VARCHAR(3000), '' )  --PRD_7274 STRIP  
         , 'FechasPago'                    = CONVERT( VARCHAR(3000), '' )  --PRD_7274 STRIP  
         , 'FechasVctoFinal'               = CONVERT( VARCHAR(10), '' )      --PRD_7274 STRIP  
         , 'RelacionaPAE'                  = CONVERT( CHAR(1), 0 )           --PRD_13085 PAE Bonificado  
         , 'CliDireccion'       = CONVERT( VARCHAR(40), '' )      --PRD_13085 PAE Bonificado  
		 , 'CliCiudad'              = CONVERT( VARCHAR(40), '' )      --PRD_13085 PAE Bonificado  

   		 , 'ApoderadoClienteRut02'         = @cRut_Apoderado_Cliente_2       
         , 'ApoderadoClienteDv02'          = CONVERT( CHAR(1), 0 )          
         , 'ApoderadoClienteNombre02'      = CONVERT( VARCHAR(100), '' )   
		 , 'LogoBanco'						= CONVERT (IMAGE, '')
          
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
	
	-- SELECT DISTINCT   --> SE SACO EL DISTINCT PORQUE NO TRABAJA CON EL CAMPO LOGOBANCO, SE DEBE REVISAR SI NO PERJUDICA LA QUERY     
    SELECT           
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
  
         , 'OpcEstDsc'  = CONVERT( VARCHAR(30), ISNULL(  Estructura.OpcEstDsc  , 'Estructura no Existe'  ) )            
  
         , 'OpcCompraEstrucutura'          = CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre          ELSE Cliente.ClNombre END )          
           -- Se realizo cambio, sin embargo se esta solicitando al usuario formalizar. Por mientras se deja el codigo e comentario    
           /*  
           CASE WHEN Enc.CaCodEstructura = 4 THEN CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre  END )  
                    WHEN Enc.CaCodEstructura = 5 THEN CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre  END )  
                    ELSE         CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre ELSE Cliente.ClNombre  END )  
                   END  
           */  
         , 'OpcVENDeEstrucutura'           = CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre          END )          
           /*  
           -- Se realizo cambio, sin embargo se esta solicitando al usuario formalizar. Por mientras se deja el codigo e comentario  
           CASE WHEN Enc.CaCodEstructura = 4 THEN CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre  ELSE Cliente.ClNombre END )  
                    WHEN Enc.CaCodEstructura = 5 THEN CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre  ELSE Cliente.ClNombre END )  
                    ELSE         CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre  END )  
                   END  
           */  
         , 'NumComponente'                 = CONVERT( NUMERIC(6), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0 ELSE Fix.CaNumEstructura END )          
         , 'PayOffTipCod'                  = CONVERT( VARCHAR(2), Det.CaTipoPayOff )           
         , 'PayOffTipDsc'                  = CONVERT( VARCHAR(20), upper( PayOffTipo.PayOffTipDsc ) )           
         -- PRD_7274 STRIP        
         , 'CallPut'                       = CONVERT( VARCHAR(5), UPPER( CASE WHEN Enc.CaCodEstructura in (9,10) THEN Det.CaCallPut            
                     ELSE CASE WHEN Det.CaVinculacion = 'Estructura' THEN 'N/A' ELSE Det.CaCallPut END  
                    END ))  
  
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
         , 'ModalidadDsc'				   = CONVERT( VARCHAR(15), CASE WHEN Det.CaModalidad  = 'E' THEN 'Entrega Fis.' ELSE 'Compensación' END  )          
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
         -- PRD_7274 STRIP        
         , 'TipoEjercicioDsc'              = CONVERT( VARCHAR(10), UPPER( CASE WHEN Enc.CaCodEstructura in (9,10) THEN UPPER(OT.OpcTipDsc)            
                   ELSE            
                   CONVERT( VARCHAR(10), CASE WHEN CaTipoEjercicio = 'E' THEN  'EUROPEA' ELSE 'AMERICANA' END  )            
                   END             
                  ))            
         , 'PrecioTope'                    = CONVERT( FLOAT, 0.0 )        --PRD_20975 ASVG_20140730 Para Strike4
         , 'PrecioSuperior'                = CONVERT( FLOAT, 0.0 )          
         , 'PrecioMedio'                   = CONVERT( FLOAT, 0.0 )          
         , 'PrecioPiso'                    = CONVERT( FLOAT, 0.0 )          
         , 'MtoPrima'                      = CONVERT( FLOAT, CaPrimaInicial )            
         , 'FormaPagoPrimaCod'             = CONVERT( NUMERIC(3), CafPagoPrima )             
         , 'FormaPagoPrimaDsc'             = CONVERT( VARCHAR(30), ISNULL( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )          
         , 'MdaPagoPrimaCod'               = CONVERT( NUMERIC(5) , CaCodMonPagPrima )           
         , 'MdaPagoPrimaDsc'               = CONVERT( VARCHAR(35), ISNULL( MonedaPrima.MnGlosa, 'Moneda Prima no existe' )  )            
         , 'FechaPagoPrima'                = CaFechaPagoPrima          
         --, 'ApoderadoClienteRut01'         = CONVERT( NUMERIC(9), 0 )  
		 , 'ApoderadoClienteRut01'         =  @cRut_Apoderado_Cliente_1   
         , 'ApoderadoClienteDv01'          = CONVERT( VARCHAR(1), 0 )          
         , 'ApoderadoClienteNombre01'      = CONVERT( VARCHAR(100), '' )          
         , 'ApoderadoClienteDomicilio01'   = CONVERT( VARCHAR(100), '' )          
         , 'ApoderadoClienteFax01'         = CONVERT( VARCHAR(50), '' )           
         , 'ApoderadoClienteFono01'        = CONVERT( VARCHAR(50), '' )          
         --, 'ApoderadoBancoRut01'           = CONVERT( NUMERIC(9), 0 )          
         --, 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' )   
		 , 'ApoderadoBancoRut01'           = @cRut_Apoderado_Banco_1   
		   , 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' ) 
		        
         , 'ApoderadoBancoNombre01'        = CONVERT( VARCHAR(100), '' )          
         , 'ApoderadoBancoDomicilio01'     = CONVERT( VARCHAR(100), '' )          
         , 'ApoderadoBancoFax01'           = CONVERT( VARCHAR(50), '' )           
         , 'ApoderadoBancoFono01'          = CONVERT( VARCHAR(50), '' )          
             
         --, 'ApoderadoBancoRut02'           = CONVERT( NUMERIC(9), 0 )        
         --, 'ApoderadoBancoDv02'            = CONVERT( VARCHAR(1), '' )        
		 , 'ApoderadoBancoRut02'           = @cRut_Apoderado_Banco_2        
         , 'ApoderadoBancoDv02'            = CONVERT( VARCHAR(1), '' )   


         , 'ApoderadoBancoNombre02'        = CONVERT( VARCHAR(100), '' )        
         , 'ApoderadoBancoDomicilio02'     = CONVERT( VARCHAR(100), '' )        
         , 'ApoderadoBancoFax02'           = CONVERT( VARCHAR(50), '' )         
         , 'ApoderadoBancoFono02'          = CONVERT( VARCHAR(50), '' )     
                         
         , 'MtoPrecioTope'                 = CONVERT( FLOAT, 0.0 )
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
		 , 'MontoMon1Escrito'      = CONVERT( VARCHAR(250), '' ) --ASVG_20110317          
		 , 'MontoMon2Escrito'      = CONVERT( VARCHAR(250), '' ) --ASVG_20110317          
		 , 'FechaVctoLarga'       = CONVERT( VARCHAR(30), '' ) --ASVG_20110317          
		 , 'ApoderadoClienteComuna01'    = CONVERT( VARCHAR(50), '' )   --ASVG_20110429          
         , 'FechasVencimiento'             = CONVERT( VARCHAR(3000), '' )     --PRD_7274 STRIP            
         , 'FechasPago'                    = CONVERT( VARCHAR(3000), '' )     --PRD_7274 STRIP            
         , 'FechasVctoFinal'               = CONVERT( VARCHAR(10), '' )     --PRD_7274 STRIP            
         , 'RelacionaPAE'                  = CONVERT( CHAR(1), Enc.CaRelacionaPAE )  --PRD_13085 PAE Bonificado                   
		 , 'CliDireccion'       = CONVERT( VARCHAR(40), Cliente.Cldirecc ) --PRD_13085 PAE Bonificado      
		 , 'CliCiudad'           = CONVERT( VARCHAR(40), Ciudad.Nombre ) --PRD_13085 PAE Bonificado    
   
      		 , 'ApoderadoClienteRut02'         = @cRut_Apoderado_Cliente_2       
         , 'ApoderadoClienteDv02'          = CONVERT( CHAR(1), 0 )          
         , 'ApoderadoClienteNombre02'      = CONVERT( VARCHAR(100), '' )    
		 , 'LogoBanco'						= CONVERT(IMAGE,'')
          
      into #Fixing          
      from #CaFixing                                Fix             
    LEFT JOIN dbo.Benchmark                 BenchFix         ON BenchFix.BenchMarkCod         = Fix.CaFixBenchComp               
           LEFT JOIN BacParamSudaValor_Moneda      DefectoBench     ON Fix.cafixFecha                = DefectoBench.VmFecha          
                                                                   AND BenchFix.BenchMdaCodValorDef  = DefectoBench.vmcodigo          
           LEFT JOIN #CaCaja        Caj              ON Caj.CanumContrato             = Fix.CaNumContrato            
                                                                   AND Caj.CaNumEstructura           = Fix.CaNumEstructura          
                                                       AND Caj.CaCajOrigen              <> 'PP'          
         , #CaDetContrato                        Det            
           LEFT JOIN PayOffTipo                                     ON PayOffTipo.PayOffTipCod       = Det.CaTipoPayOff           
           -- POR HACER: cambiar a BDOpciones.BacParamMoneda          
           LEFT JOIN BacParamSuda.dbo.Moneda MonedaM1        ON MonedaM1.MnCodMon             = Det.CaCodMon1          
           LEFT JOIN BacParamSuda.dbo.Moneda MonedaM2        ON MonedaM2.MnCodMon             = Det.CaCodMon2          
           LEFT JOIN BacParamSuda.dbo.Moneda MdaComp         ON MdaComp.MnCodMon              = Det.CaMdaCompensacion          
         , #CaEncContrato                            Enc            
           LEFT JOIN BacParamSuda.dbo.cliente Cliente         ON Cliente.ClRut                 = Enc.CaRutCliente          
                                                                    AND Cliente.ClCodigo              = Enc.CaCodigo           

		   -->   Se cambio de Orden y se agrego un LEFT
		   LEFT JOIN BacParamSuda.dbo.Ciudad	 Ciudad On Ciudad.codigo_ciudad = Cliente.Clciudad
		   -->   Se cambio de Orden y se agrego un LEFT

		   -- Para el cambio de un conepto a nivel de contrato se invierte la seleccion de la estructura para las Fwd Acotados  
           LEFT JOIN OpcionEstructura               Estructura      ON Estructura.OpcEstCod          = case when Enc.CaCodEstructura = 4 then 5   
                           when Enc.CaCodEstructura = 5 THEN 4  
                           else Enc.CaCodEstructura  
                                                                                                       end  
           -- Para el cambio de un conepto a nivel de contrato se invierte la seleccion de la estructura para las Fwd Acotados  
  
           LEFT JOIN BacParamSuda.dbo.Forma_de_Pago          
                                                    FormaPagoPrima  ON FormaPagoPrima.Codigo         = Enc.CafPagoPrima          
           LEFT JOIN BacParamSuda.dbo.Moneda MonedaPrima     ON MonedaPrima.MnCodMon          = Enc.CaCodMonPagPrima          
           LEFT JOIN breakBacParamSudaCLIENTE       CGOp            ON CGOp.ClRut                    = Cliente.ClRut           
                                                                   AND CGOp.ClCodigo                 = Cliente.ClCodigo          
         , IMPRESION IMP          
         , OpcionTipo OT     --PRD_7274 STRIP          
--         , BacParamSuda.dbo.Ciudad Ciudad               
     WHERE Det.CaNumContrato   = Fix.CaNumContrato          
       AND Det.CaNumEstructura = Fix.CaNumEstructura           
       AND Enc.CaNumContrato   = Det.CaNumContrato          
  
       AND Enc.CanumContrato   = IMP.ImpNumContrato          
       AND ImpGrupo            = @Grupo          
            
       AND Det.CaTipoOpc       = OT.OpcTipCod    --PRD_7274 STRIP          
--    AND Cliente.Clciudad    = Ciudad.codigo_ciudad    
         

     /****** FECHAS VENCIMIENTO (begin)*****/
                
    SELECT *, puntero = Identity(int) INTO #paso2                 
      FROM #Fixing                
     WHERE NumeroFijacion = 1                
      
   DECLARE @irow numeric(9)                
       SET @irow  = 1                
                
   DECLARE @irows NUMERIC(9)                
    SELECT @irows = (select max(puntero) from #paso2 )                
                 
   DECLARE @cCadena  VARCHAR(1000)            
   DECLARE @cCadena2 VARCHAR(1000)            
   DECLARE @cCadena3 VARCHAR(10)                
       SET @cCadena  = ''            
       SET @cCadena2 = ''                
       SET @cCadena3 = ''             
                
     WHILE @irows >= @irow                
     BEGIN                
       SET @cCadena  = @cCadena  + (SELECT convert(char(10), FechaVcto, 103)     FROM #paso2 WHERE Puntero = @irow)                
       SET @cCadena2 = @cCadena2 + (SELECT convert(char(10), FechaPagoEjer, 103) FROM #paso2 WHERE Puntero = @irow)        
       SET @cCadena3 = (SELECT convert(char(10), FechaPagoEjer, 103) FROM #paso2 WHERE Puntero = @irow)        
                  
        IF @irows > @irow                
           SET @cCadena  = @cCadena  + ', ' -- + CHAR(13)            
           SET @cCadena2 = @cCadena2 + ', ' -- + CHAR(13)                           
                
           SET @irow = @irow + 1                
      END  
	  
	
         
                
   UPDATE #Fixing                
      SET    FechasVencimiento = @cCadena              
      ,      FechasPago        = @cCadena2            
      ,      FechasVctoFinal   = @cCadena3            
                
                 
    /****** FECHAS VENCIMIENTO (end)*****/
          
    SELECT CaNumContrato          
         , CaStrike          
         , Cnt = count(1)          
      INTO #Precios           
      FROM #CaDetContrato             
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

			--PRD_20975 ASVG_20140730 Para Strike4
            , PrecioTope                   = CASE WHEN OpcEstCod = 14
                                                  --ASVG por el momento esto es redundante.
                                                  --THEN ( SELECT ROUND( CaStrike, 2 ) FROM #Precios WHERE #Precios.CaNumContrato = #Fixing.NumContrato AND cnt = 4 ) -- Precio Strike4
												  THEN ( SELECT ROUND( CaStrike, 2 ) FROM #CaDetContrato Dx WHERE CaNumContrato = NumContrato AND Dx.CaNumEstructura = 4 ) -- Precio Strike4
												  --#CaDetContrato Dx WHERE CanumContrato = NumContrato
                                                  ELSE ( SELECT MAX( CaStrike ) FROM #CaDetContrato Dx WHERE CanumContrato = NumContrato )                           
                                             END

            , PrecioSuperior               = CASE WHEN OpcEstCod in ( 4, 5)  
                                                  --THEN ( SELECT CaStrike FROM #Precios WHERE #Precios.CaNumContrato = #Fixing.NumContrato AND cnt = 2 ) -- Precio Forward  
                                                  --ASVG_20130322 a veces el precio queda grabado con todos los decimales.  
                                                  THEN ( SELECT ROUND( CaStrike, 2 ) FROM #Precios WHERE #Precios.CaNumContrato = #Fixing.NumContrato AND cnt = 2 ) -- Precio Forward
												  --PRD_20975 ASVG_20140730 Para Strike3
												  WHEN OpcEstCod = 14
												  THEN ( SELECT ROUND( CaStrike, 2 ) FROM #CaDetContrato Dx WHERE CaNumContrato = NumContrato AND Dx.CaNumEstructura = 3 ) -- Precio Strike3
                                                  ELSE ( SELECT MAX( CaStrike ) FROM #CaDetContrato Dx WHERE CanumContrato = NumContrato )
                                             END
            --PRD_20975 ASVG_20140730 Para Strike2
            , PrecioMedio                  = CASE WHEN OpcEstCod = 14
                                                  THEN ( SELECT ROUND( CaStrike, 2 ) FROM #CaDetContrato Dx WHERE CaNumContrato = NumContrato AND Dx.CaNumEstructura = 2 ) -- Precio Strike2
                                                  ELSE ( CONVERT( FLOAT, 0.0 ) )--Dejamos el Default, se setea más abajo en sección "Calculo del Precio Medio"
                                             END
            , PrecioPiso       = CASE WHEN OpcEstCod in ( 4, 5)
                                                  THEN ( SELECT CaStrike FROM #Precios WHERE #Precios.CaNumContrato = #Fixing.NumContrato AND cnt = 1 ) -- Precio Cota
                                                  ELSE ( SELECT MIN( CaStrike ) FROM #CaDetContrato Dx WHERE CanumContrato = NumContrato )
                                             END


			 , ApoderadoClienteRut01        = CASE WHEN @cRut_Apoderado_Cliente_1 <> '' THEN @cRut_Apoderado_Cliente_1	+ '-' + @dvc1	ELSE '' END	--> PRD-21658				 

												 
			, ApoderadoClienteDv01         = @dvc1		--> PRD-21658	
															 
 
			 , ApoderadoClienteNombre01     = isnull(@cNom_Apoderado_Cliente_1, 'No hay apoderados definidos')																	
																			
																			        
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


			, ApoderadoBancoRut01          = CASE WHEN @cRut_Apoderado_Banco_1 <> '' THEN @cRut_Apoderado_Banco_1 + '-' + @dvb1 ELSE '' END--> 21658


																		 
			, ApoderadoBancoDv01          = 	@dvb1												 
																		        

																		     
			 , ApoderadoBancoNombre01      = isnull(@cNom_Apoderado_Banco_1, 'No hay apoderados definidos')												   
																		   
																		         
            , ApoderadoBancoDomicilio01   = CONVERT( VARCHAR(100), @Domicilio )          
            , ApoderadoBancoFax01         = CONVERT( VARCHAR(50), @Fax )           
            , ApoderadoBancoFono01        = CONVERT( VARCHAR(50), @Fono )          

   
			, ApoderadoBancoRut02          = CASE WHEN @cRut_Apoderado_Banco_2 <> '' THEN @cRut_Apoderado_Banco_2 + '-' + @dvb2 ELSE '' END--> 21658
													
													   
    
			 , ApoderadoBancoDv02          = @dvb2											    
																		   

			 , ApoderadoBancoNombre02      = isnull(@cNom_Apoderado_Banco_2, 'No hay apoderados definidos')	 													   
																		         
            , ApoderadoBancoDomicilio02   = CONVERT( VARCHAR(100), @Domicilio )        
            , ApoderadoBancoFax02         = CONVERT( VARCHAR(50), @Fax)         
            , ApoderadoBancoFono02        = CONVERT( VARCHAR(50), @Fono )        
                
                
                         
                  
            , Control                     = CASE WHEN FechaCG = '19000101' THEN '- FECHA CONDICIONES GENERALES '  ELSE '' END          
                                          + CASE WHEN ChkFechaCG = 'N' THEN '- FIRMA CONDICIONES GENERALES ' ELSE '' END          
                                          + CASE WHEN FechaCGComp = '19000101' THEN '- COMPLEMENTO ' ELSE '' END           
                                          + CASE WHEN ChkFechaCGComp = 0 THEN '- FIRMA COMPLEMENTO ' ELSE '' END            
                                          + CASE WHEN FechaCGSup = '19000101' THEN '- SUPLEMENTO '  ELSE '' END   -- MAP 12 Nov. FechaCGSup          
                                          + CASE WHEN ChkFechaCGSup = 0 THEN '- FIRMA SUPLEMENTO '  ELSE '' END   -- MAP 12 NOv. FechaCGSup          
			, FechaVctoLarga     = dbo.FormatFecha( FechaVcto ) --ASVG_20110317          
            , ApoderadoClienteComuna01   = CONVERT( VARCHAR(50), ISNULL( ( SELECT TOP 1 Comuna.nombre          
                                                                                FROM BacParamSudaCliente AS C          
                    LEFT JOIN BacParamSuda.dbo.comuna Comuna ON C.ClComuna = Comuna.codigo_comuna          
                                                                               WHERE C.clrut    = #Fixing.CLIRUT          
                                                                                 AND C.clcodigo = #Fixing.CLICOD), '' ) ) --ASVG_20110429          
          


			, ApoderadoClienteRut02        = CASE WHEN @cRut_Apoderado_Cliente_2 <> '' THEN @cRut_Apoderado_Cliente_2 + '-' + @dvc2 ELSE '' END --> 21658							 								 
			, ApoderadoClienteDv02         = @dvc2
			, ApoderadoClienteNombre02     = isnull(@cNom_Apoderado_Cliente_2, 'No hay apoderados definidos')		
			, LogoBanco						= (select BannerLargoContrato from bacparamsuda..Contratos_ParametrosGenerales)
          
        -- Calculo del Precio Medio          
        UPDATE #Fixing          
           SET PrecioMedio                    = ISNULL( ( SELECT MAX( CaStrike )          
                                                            FROM #CaDetContrato Dx            
                                                           WHERE Dx.CaStrike      > PrecioPiso          
                                                             AND Dx.CaStrike      < PrecioSuperior          
                                                             AND Dx.Canumcontrato = NumContrato          
                        ), 0)              
             , Control                     = CASE WHEN  Control <> '' THEN 'CONTRATO NO VÁLIDO.  FALTA : ' + Control  ELSE '' END          
          
          
        UPDATE #Fixing          
           SET MtoPrecioTope                  = CONVERT( FLOAT, round( MontoMon1 * PrecioTope    , 0 ) ) --PRD_20975 ASVG_20140730 Para Strike4
             , MtoPrecioSuperior              = CONVERT( FLOAT, round( MontoMon1 * PrecioSuperior, 0 ) ) 
             , MtoPrecioMedio                 = CONVERT( FLOAT, round( MontoMon1 * PrecioMedio   , 0 ) )          
             , MtoPrecioPiso                  = CONVERT( FLOAT, round( MontoMon1 * PrecioPiso    , 0 ) )          
          
        UPDATE #Fixing          
           SET MontoMon1Strangle   = ( SELECT DISTINCT MontoMon1          
                                                    FROM #Fixing          
                                                   WHERE OpcEstCod  = '3'          
AND #Fixing.NumContrato  = Det.CaNumContrato          
                                                     AND CaNumEstructura     in ( 3, 4 ) )           
             , MontoMon2Straddle              = ( SELECT DISTINCT MontoMon1          
                                                    FROM #Fixing          
                                                   WHERE OpcEstCod        = '3'          
                                        AND #Fixing.NumContrato  = Det.CaNumContrato          
                                                     AND CaNumEstructura     in ( 1, 2 ) )           
          FROM #CaDetContrato  Det            
         WHERE OpcEstCod           = '3'          
           AND #Fixing.NumContrato = Det.CaNumContrato          
          
--ASVG_20110317 Mejorar, obtengo monto escrito          
select @MM1 = MontoMon1, @MM2 = MontoMon2 from #Fixing          
EXECUTE dbo.SP_MONTOESCRITO @MM1, @mtoesc = @MontoMon1Escrito OUTPUT          
EXECUTE dbo.SP_MONTOESCRITO @MM2, @mtoesc = @MontoMon2Escrito OUTPUT          
update #Fixing set MontoMon1Escrito = @MontoMon1Escrito, MontoMon2Escrito = @MontoMon2Escrito          
          
        DELETE #resultado          
  INSERT INTO #resultado          
               SELECT *          
                 FROM #fixing          
                ORDER BY NumCOntrato, NumComponente          
          
    END          
          
		--    set @cCadena2 = (SELECT REPLACE(@cCadena2, SUBSTRING(@cCadena2, LEN(@cCadena2), LEN(@cCadena2)), ''))

update #Resultado 
set FechasPago = (SELECT fecha = case when SUBSTRING(FechasPago, LEN(FechasPago), LEN(FechasPago)) = ',' then 
						SUBSTRING(FechasPago, 1, LEN(FechasPago)-1)  
					else FechasPago end )


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
         , PrecioTope				--PRD_20975 ASVG_20140730 Para Strike4
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
         , ApoderadoBancoRut02        
         , ApoderadoBancoDv02        
         , ApoderadoBancoNombre02        
         , ApoderadoBancoDomicilio02        
         , ApoderadoBancoFax02        
         , ApoderadoBancoFono02     
         , MtoPrecioTope
         , MtoPrecioSuperior          
         , MtoPrecioMedio          
         , MtoPrecioPiso          
         , ReceptorPrima          
         , PagadorPrima          
         , Control          
         , MontoMon1Escrito          --ASVG_20110317          
         , MontoMon2Escrito          --ASVG_20110317          
         , FechaVctoLarga            --ASVG_20110317          
         , ApoderadoClienteComuna01  --ASVG_20110429          
         , FechasVencimiento         --PRD_7274 STRIP          
         , FechasPago                --PRD_7274 STRIP          
         , FechasVctoFinal           --PRD_7274 STRIP          
         , RelacionaPAE              --PRD_13085 PAE Bonificado        
         , CliDireccion              --PRD_13085 PAE Bonificado      
         , CliCiudad                 --PRD_13085 PAE Bonificado     
		 
		 , ApoderadoClienteRut02        = case when @cRut_Apoderado_Cliente_2 <> '' then @cRut_Apoderado_Cliente_2 + '-' + @dvc2 else ''	end						 								 
		, ApoderadoClienteDv02         = @dvc2
		, ApoderadoClienteNombre02     = isnull(@cNom_Apoderado_Cliente_2, 'No hay apoderados definidos')	 
		, LogoBanco						= (select BannerLargoContrato from bacparamsuda..Contratos_ParametrosGenerales)

      FROM #Resultado    ORDER BY CaNumEstructura      
          
END


-- Reemplazo Base de datos --




GO
