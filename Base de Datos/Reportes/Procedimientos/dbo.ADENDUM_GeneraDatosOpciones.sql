USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ADENDUM_GeneraDatosOpciones]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--sp_helptext ADENDUM_GeneraDatosOpciones
--ADENDUM_GeneraDatosOpciones 1745, 'Modifica', '2012-05-23', 2085, 13842499, 13671071
--ADENDUM_GeneraDatosOpciones 861, 'Modifica', '13-02-2013', 1066, 13842499, 13671071
--ADENDUM_GeneraDatosOpciones 861, 'Modifica', '2013-02-13', 1066, 13842499, 13671071

--select * from ADENDUM_informacionopciones  

--sp_helptext ADENDUM_ObtieneModificacionesOpciones 861
--sp_helptext ADENDUM_ObtieneModificacionesOpciones 804

--select * from baclineas..detalle_aprobaciones

  -- select * from CbMdbOpc.DBO.MoHisEncContrato where monumcontrato = @nContrato  

--sp_helptext ADENDUM_ObtieneModificacionesOpciones 861

--ADENDUM_GeneraDatosOpciones 1745, 'Modifica', '2012-05-23', 2085, 13842499, 13671071

--sp_helptext ADENDUM_GeneraDatosOpciones 861, 'Modifica', '13-02-2013', 1066, 13842499, 13671071

--ADENDUM_GeneraDatosOpciones 1745, 'Modifica', '2012-05-23', 2085, 13842499, 13671071  


--SELECT * FROM baclineas..DETALLE_APROBACIONES 
--WHERE ID_SISTEMA = 'OPT' AND ESTADO = 'A'




  
CREATE PROCEDURE [dbo].[ADENDUM_GeneraDatosOpciones]  
(  
		@numoper   NUMERIC (10)  
	,	@SeModifico   varchar(25) = 'No Modificada'  
	,	@dFecha    varchar(10)  
	,	@FolioModificacion NUMERIC(10)   
	,	@RutApoderado1  numeric(10)  
	,	@RutApoderado2  numeric(10)   
	,	@RUTAPODERADOCLI1 numeric(10)  
	,	@RUTAPODERADOCLI2  numeric(10)


)  
  
AS  
BEGIN  
SET NOCOUNT ON  
  
  
Declare @FolioCreacion as int  
  
set @FolioCreacion = (select Monumfolio from CbMdbopc.dbo.MoHisEncContrato where monumcontrato = @numoper and MotipoTransaccion in ('CREACION') )  
  

DECLARE @Nombre       VARCHAR(120)        
DECLARE @Rut          NUMERIC(9)        
DECLARE @Dv           CHAR(1)        
DECLARE @FechaProceso DATETIME        
DECLARE @Domicilio    VARCHAR(50)        
DECLARE @Fax          VARCHAR(100)        
DECLARE @Fono         VARCHAR(100)        
DECLARE @Codigo       NUMERIC(2) 

SELECT @FechaProceso = FechaProc        
         , @Nombre       = nombre        
         , @Rut          = rut        
         , @Domicilio    = direccion        
         , @Fono         = telefono        
         , @Fax          = Fax        
         , @Codigo       = 1        
FROM CbMdbopc.dbo.OpcionesGeneral    

DECLARE @cNom_Apoderado_Cliente_1	VARCHAR(40)
DECLARE @cRut_Apoderado_Cliente_1	VARCHAR(40)
DECLARE @cNom_Apoderado_Cliente_2	VARCHAR(40)
DECLARE @cRut_Apoderado_Cliente_2	VARCHAR(40)

SET @cNom_Apoderado_Cliente_1 = (select DISTINCT(apnombre) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo = @RUTAPODERADOCLI1) 

SET @cRut_Apoderado_Cliente_1 = (select LTRIM(RTRIM(aprutcli)) + '-' + LTRIM(RTRIM(apdvcli)) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo =  @RUTAPODERADOCLI1) 

SET @cNom_Apoderado_Cliente_2 = (select DISTINCT(apnombre) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo = @RUTAPODERADOCLI2) 

SET @cRut_Apoderado_Cliente_2 = (select LTRIM(RTRIM(aprutcli)) + '-' + LTRIM(RTRIM(apdvcli)) FROM	
									BacParamSuda.dbo.CLIENTE_APODERADO where aprutapo =  @RUTAPODERADOCLI2) 


--declare @fechaDefinitiva as DATETIME

declare @dia as varchar(2)
 declare @mes as varchar(20)
 declare @año as varchar(10)
 declare @fecha_Contrato as varchar(50)


 /*Format fecha contrato*************************************************************/
   SELECT @dia  = SUBSTRING(@dFecha,1,2)
   select @mes  = SUBSTRING(@dFecha,4,2)
   SELECT @año	= SUBSTRING(@dFecha,7,4) 
 /* pasa mes de numero a palabra ******************************************/        
    IF (@mes='01')        select @mes = 'ENERO'
    IF (@mes='02')        select @mes = 'FEBRERO'
    IF (@mes='03')        select @mes = 'MARZO'
    IF (@mes='04')        select @mes = 'ABRIL'
    IF (@mes='05')        select @mes = 'MAYO'
    IF (@mes='06')        select @mes = 'JUNIO'
    IF (@mes='07')        select @mes = 'JULIO'
    IF (@mes='08')        select @mes = 'AGOSTO'
    IF (@mes='09')        select @mes = 'SEPTIEMBRE'
    IF (@mes='10')        select @mes = 'OCTUBRE'
    IF (@mes='11')        select @mes = 'NOVIEMBRE'
    IF (@mes='12')        select @mes = 'DICIEMBRE'
      
    Set @fecha_Contrato = @dia + ' de '+   @mes + ' de ' +   @año


  
DELETE FROM DBO.ADENDUM_InformacionOPCIONES  
  
INSERT INTO ADENDUM_InformacionOPCIONES  


  
/***** ENCABEZADO *****/  
      SELECT TOP 1  
        'ID'						= 0  
      ,  'Contrato'					= @numoper  
      ,  'Folio'					= mec.MoNumFolio  
      ,  'Estado'					= 'ENCABEZADO'  
      ,  'Estructura'				=  0  
      ,  'Fecha_Modif_Contrato'		=  @fecha_Contrato
                 /*  
                 = (select  convert(char(2), @fechaDefinitiva, 23) + ' de '  
                 +     case  when datepart( month, @fechaDefinitiva) = 1  then 'Enero'  
                  when datepart( month, @fechaDefinitiva) = 2  then 'Febrero'  
                  when datepart( month, @fechaDefinitiva) = 3  then 'Marzo'  
                  when datepart( month, @fechaDefinitiva) = 4  then 'Abril'  
                  when datepart( month, @fechaDefinitiva) = 5  then 'Mayo'  
                  when datepart( month, @fechaDefinitiva) = 6  then 'Junio'  
                  when datepart( month, @fechaDefinitiva) = 7  then 'Julio'  
                  when datepart( month, @fechaDefinitiva) = 8  then 'Agosto'  
                  when datepart( month, @fechaDefinitiva) = 9  then 'Septiembre'  
           when datepart( month, @fechaDefinitiva) = 10 then 'Octubre'  
                  when datepart( month, @fechaDefinitiva) = 11 then 'Noviembre'  
                  when datepart( month, @fechaDefinitiva) = 12 then 'Diciembre'  
                     end + ' de '   
                  +     ltrim(rtrim( datepart(year, @fechaDefinitiva) )))  
                 */  
  
        
      --,  'Fecha_Modif_Contrato'   = (select MOfecValorizacion from MoHisEncContrato where MotipoTransaccion <> 'CREACION' AND MONUMCONTRATO = @numoper )  
         ,  'Fecha_Contrato'    --= --convert(char(10),MoFechaContrato,105)  
								= dbo.Fx_Retorna_Mes( MoFechaContrato )	
								/*
                 = (select  convert(char(2), MoFechaContrato, 103) + ' de '  
                 +     case  when datepart( month, MoFechaContrato) = 1  then 'Enero'  
                  when datepart( month, MoFechaContrato) = 2  then 'Febrero'  
                  when datepart( month, MoFechaContrato) = 3  then 'Marzo'  
                  when datepart( month, MoFechaContrato) = 4  then 'Abril'  
                  when datepart( month, MoFechaContrato) = 5  then 'Mayo'  
                  when datepart( month, MoFechaContrato) = 6  then 'Junio'  
                  when datepart( month, MoFechaContrato) = 7  then 'Julio'  
                  when datepart( month, MoFechaContrato) = 8  then 'Agosto'  
                  when datepart( month, MoFechaContrato) = 9  then 'Septiembre'  
                  when datepart( month, MoFechaContrato) = 10 then 'Octubre'  
                  when datepart( month, MoFechaContrato) = 11 then 'Noviembre'  
                  when datepart( month, MoFechaContrato) = 12 then 'Diciembre'  
                     end + ' de '   
                  +     ltrim(rtrim( datepart(year, MoFechaContrato) )))  
				  */
      ,  'Tipo_Operacion'				= MoCallPut  

      ,  'Estilo_Opcion'				=  CASE WHEN Motipoejercicio = 'E' THEN  'EUROPEA' ELSE 'AMERICANA' END 

      ,  'Cantidad_Moneda_Extranjera'	= MoMontoMon1  
      ,  'Moneda_Liquidacion'			= mnglosa   
      ,  'Comprador_Opcion'				=  CONVERT( VARCHAR(100), CASE WHEN  MOCVopc = 'C' THEN @Nombre          ELSE Cliente.ClNombre END )        --'CORPBANCA' --> revisar  
      ,  'Vendedor_Opcion'				= CONVERT( VARCHAR(100), CASE WHEN MOCVopc = 'C' THEN Cliente.ClNombre ELSE @Nombre          END )  --clnombre  
      ,  'Rut_Cliente'					= convert(char(8),clrut) + '-' + cldv  
      ,  'Modalidad_Cumplimiento'		= CASE WHEN MoModalidad = 'E' THEN 'Entrega Fisica'  
												ELSE 'Compensación' END  
      ,  'Domicilio_Cliente'			= cliente.cldirecc  
      ,  'Fono_Cliente'					= cliente.clfono    
      ,  'Fax_Cliente'					= cliente.clfax  

      ,  'Nombre_Apoderado_uno'			= apoderado1.apnombre  
      ,	 'Rut_Apoderado_Uno'			= rtrim(ltrim(convert(char(10),apoderado1.aprutapo))) + '-' + apoderado1.apdvapo  
      ,	 'Apoderado_Dos'				= apoderado2.apnombre   
      ,  'Rut_Apoderado_Dos'			= rtrim(ltrim(convert(char(10),apoderado2.aprutapo))) + '-' + apoderado2.apdvapo  

	  ,	'Nombre_Apoderado_Cli_uno'		= @cNom_Apoderado_Cliente_1 
	  ,  'Rut_Apoderado_Cli_Uno'		= @cRut_Apoderado_Cliente_1
	  ,	'Nombre_Apoderado_Cli_dos'		= @cNom_Apoderado_Cliente_2
	  ,  'Rut_Apoderado_Cli_dos'		= @cRut_Apoderado_Cliente_2

	  ,	'Fecha_Firma_CCG'				= dbo.Fx_Retorna_Mes( Cliente.FECHA_FIRMA_NUEVO_CCG )	

      --,  Modalidad_Cumplimiento_ANTICI  
      --,  ANTICIPA.MoFwd_teo  
      --,  ANTICIPA.MoDelta_spot  
      FROM CbMdbopc.dbo.MOHISDETCONTRATO  MDC  
        INNER JOIN CbMdbopc.dbo.MOHISENCCONTRATO MEC ON MEC.MONUMFOLIO = @FolioCreacion  
        INNER JOIN ( select mncodmon, mnglosa   
             --from LNKBAC.BacParamsuda.dbo.moneda  
            from  BacParamsuda.dbo.moneda    
           ) moneda on moneda.mncodmon = MDC.MoCodMon2  
        INNER JOIN ( select clrut, clnombre, cldirecc, clfono, clfax, cldv, FECHA_FIRMA_NUEVO_CCG  
             from BacParamsuda.dbo.cliente      
           ) cliente on cliente.clrut = MEC.MoRutCliente  
        INNER JOIN bacparamsuda.dbo.CLIENTE_APODERADO apoderado1 with(nolock) On apoderado1.aprutapo = @RutApoderado1  
        INNER JOIN bacparamsuda.dbo.CLIENTE_APODERADO apoderado2 with(nolock) On apoderado2.aprutapo = @RutApoderado2  
      WHERE MDC.monumfolio = @FolioCreacion  

union   
--/***** MOVIMIENTOS ORIGINALES *****/  
--      SELECT   
--        'ID'       = 1  
--        ,  'Contrato'      = @numoper  
--      ,  'Folio'       = mec.MoNumFolio  
--      ,  'Estado'      = mec.MoTipoTransaccion  
--      ,  'Fecha_Modif_Contrato'   = ''  
--      ,  'Fecha_Contrato'    =   ''  
--      ,  'Tipo_Operacion'    = MoCallPut  
--      ,  'Estilo_Opcion'     = 'EUROPEA'  
--      ,  'Cantidad_Moneda_Extranjera' = MoMontoMon1  
--      ,  'Moneda_Liquidacion'   = mnglosa   
--      ,  'Comprador_Opcion'    = 'CORPBANCA'  
--      ,  'Vendedor_Opcion'    = clnombre  
--      ,  'Modalidad_Cumplimiento'  = CASE WHEN MoModalidad = 'E' THEN 'Entrega Fisica'  
--                   ELSE 'Compensación' END  
--      ,  'Domicilio_Cliente'    = ''  
--      ,  'Fono_Cliente'     = ''    
--      ,  'Fax_Cliente'     = ''  
--      ,  'Nombre_Apoderado_uno'   = ''  
--      ,      'Rut_Apoderado_Uno'    = ''  
--      ,  'Apoderado_Dos'     =   ''  
--      ,  'Rut_Apoderado_Dos'    = ''  
--      --,  Modalidad_Cumplimiento_ANTICI  
--      --,  ANTICIPA.MoFwd_teo  
--      --,  ANTICIPA.MoDelta_spot  
--      FROM MOHISDETCONTRATO  MDC  
--        INNER JOIN MOHISENCCONTRATO MEC ON MEC.MONUMFOLIO = @FolioCreacion  
--        INNER JOIN ( select mncodmon, mnglosa   
--             from LNKBAC.BacParamsuda.dbo.moneda      
--           ) moneda on moneda.mncodmon = MDC.MoCodMon2  
--        INNER JOIN ( select clrut, clnombre , cldirecc, clfono, clfax  
--             from LNKBAC.BacParamsuda.dbo.cliente      
--           ) cliente on cliente.clrut = MEC.MoRutCliente  
--        INNER JOIN bacparamsuda.dbo.CLIENTE_APODERADO apoderado1 with(nolock) On apoderado1.aprutapo = @RutApoderado1  
--        INNER JOIN bacparamsuda.dbo.CLIENTE_APODERADO apoderado2 with(nolock) On apoderado2.aprutapo = @RutApoderado2  
--      WHERE MDC.monumfolio = @FolioCreacion  
--UNION  
/***** MOVIMIENTOS MODIFICADOS *****/  
      SELECT   
			'ID'					= 1  
        ,	'Contrato'				= @numoper  
        ,	'Folio'					= mec.MoNumFolio  
        ,	'Estado'				= mec.MoTipoTransaccion  
        ,	'Estructura'			=   mdc.MoNumEstructura  
		,	'Fecha_Modif_Contrato'	= @fecha_Contrato --''  
    /*
									= (select  convert(char(2), @fechaDefinitiva, 23) + ' de '  
                 +     case  when datepart( month, @fechaDefinitiva) = 1  then 'Enero'  
                  when datepart( month, @fechaDefinitiva) = 2  then 'Febrero'  
                  when datepart( month, @fechaDefinitiva) = 3  then 'Marzo'  
                  when datepart( month, @fechaDefinitiva) = 4  then 'Abril'  
                  when datepart( month, @fechaDefinitiva) = 5  then 'Mayo'  
                  when datepart( month, @fechaDefinitiva) = 6  then 'Junio'  
                  when datepart( month, @fechaDefinitiva) = 7  then 'Julio'  
                  when datepart( month, @fechaDefinitiva) = 8  then 'Agosto'  
                  when datepart( month, @fechaDefinitiva) = 9  then 'Septiembre'  
                  when datepart( month, @fechaDefinitiva) = 10 then 'Octubre'  
                  when datepart( month, @fechaDefinitiva) = 11 then 'Noviembre'  
                  when datepart( month, @fechaDefinitiva) = 12 then 'Diciembre'  
                     end + ' de '   
                  +     ltrim(rtrim( datepart(year, @fechaDefinitiva ) )))  
      
      */
      
      
      ,  'Fecha_Contrato'				= dbo.Fx_Retorna_Mes( MoFechaContrato )	 -- MoFechaContrato --''  


      ,  'Tipo_Operacion'				= MoCallPut  
      ,  'Estilo_Opcion'				= CASE WHEN Motipoejercicio = 'E' THEN  'EUROPEA' ELSE 'AMERICANA' END  --'EUROPEA'  
      ,  'Cantidad_Moneda_Extranjera'	= MoMontoMon1  
      ,  'Moneda_Liquidacion'			= mnglosa   
      ,  'Comprador_Opcion'				= CONVERT( VARCHAR(100), CASE WHEN  MOCVopc = 'C' THEN @Nombre          ELSE Cliente.ClNombre END )  --'CORPBANCA'  
      ,  'Vendedor_Opcion'				= CONVERT( VARCHAR(100), CASE WHEN MOCVopc = 'C' THEN Cliente.ClNombre ELSE @Nombre          END )  --clnombre   
      ,  'Rut_Cliente'					= convert(char(8),clrut) + '-' + cldv  
      ,  'Modalidad_Cumplimiento'		= CASE WHEN MoModalidad = 'E' THEN 'Entrega Fisica'  
											ELSE 'Compensación' END  
      ,  'Domicilio_Cliente'			= cliente.cldirecc  --''  
      ,  'Fono_Cliente'					= cliente.clfono    
      ,  'Fax_Cliente'					= cliente.clfax   
      ,  'Nombre_Apoderado_uno'			= apoderado1.apnombre   
      ,  'Rut_Apoderado_Uno'			= rtrim(ltrim(convert(char(10),apoderado1.aprutapo))) + '-' + apoderado1.apdvapo  
	  ,  'Apoderado_Dos'				= apoderado2.apnombre     
      ,  'Rut_Apoderado_Dos'			= rtrim(ltrim(convert(char(10),apoderado2.aprutapo))) + '-' + apoderado2.apdvapo  

	  	  ,	'Nombre_Apoderado_Cli_uno'		= @cNom_Apoderado_Cliente_1 
	  ,  'Rut_Apoderado_Cli_Uno'		= @cRut_Apoderado_Cliente_1
	  ,	'Nombre_Apoderado_Cli_dos'		= @cNom_Apoderado_Cliente_2
	  ,  'Rut_Apoderado_Cli_dos'		= @cRut_Apoderado_Cliente_2

	  ,	'Fecha_Firma_CCG'				= dbo.Fx_Retorna_Mes( Cliente.FECHA_FIRMA_NUEVO_CCG )	

      --,  Modalidad_Cumplimiento_ANTICI  
      --,  ANTICIPA.MoFwd_teo  
      --,  ANTICIPA.MoDelta_spot  
      FROM CbMdbopc.dbo.MOHISDETCONTRATO  MDC  
        INNER JOIN CbMdbopc.dbo.MOHISENCCONTRATO MEC ON MEC.MONUMFOLIO = @FolioModificacion  
        INNER JOIN ( select mncodmon, mnglosa   
             from BacParamsuda.dbo.moneda      
           ) moneda on moneda.mncodmon = MDC.MoCodMon2  
        INNER JOIN ( select clrut, clnombre , cldirecc, clfono, clfax, cldv, FECHA_FIRMA_NUEVO_CCG
             from BacParamsuda.dbo.cliente      
           ) cliente on cliente.clrut = MEC.MoRutCliente  
        INNER JOIN bacparamsuda.dbo.CLIENTE_APODERADO apoderado1 with(nolock) On apoderado1.aprutapo = @RutApoderado1  
        INNER JOIN bacparamsuda.dbo.CLIENTE_APODERADO apoderado2 with(nolock) On apoderado2.aprutapo = @RutApoderado2  
      WHERE MDC.monumfolio = @FolioModificacion  
        
        
  
  --SELECT * FROM ADENDUM_InformacionOPCIONES  
END


--select * from bacparamsuda..cliente where clrut = 2595635 -4

GO
