USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_CARTERA_OPCIONES]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_CARTERA_OPCIONES]   
(   @FechaParMuerto DATETIME  
  , @Rut   Numeric(13) = 0  
  , @Codigo Numeric(3) = 0 )  
  
AS  
BEGIN -- select * from lnkOpc.CbMdbOpc.dbo.caenccontrato  
-- SP_RIEFIN_CONSULTA_CARTERA_OPCIONES '20110322'  
-- SP_RIEFIN_CONSULTA_CARTERA_OPCIONES '20110311', 0, 0   
-- ojo no hay RES en este dia de prueba  
-- SP_RIEFIN_CONSULTA_CARTERA_OPCIONES '20081121', 96568370, 1  
-- SP_RIEFIN_CONSULTA_CARTERA_OPCIONES '20110313', 96364000, 1  
-- SP_RIEFIN_CONSULTA_CARTERA_OPCIONES '20110313' , 4531443, 1  

-- SP_RIEFIN_CONSULTA_CARTERA_OPCIONES '20140804', 76035555, 1

-- dbo.SP_RIEFIN_CONSULTA_CARTERA_OPCIONES '20110311', 453183276, 1   -- Sin familia select * from lnkOpc.cbmdbOpc.dbo.caEncContrato

-- POR HACER: parámetros MONEDA, CURVAS, Etc.  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements. 
 -- select * from LNKOPC.CbMdbOpc.dbo.OpcionesGeneral  
 SET NOCOUNT ON;  
 DECLARE @fecha  Datetime
 DECLARE @Fecha_Prox DATETIME  
 SELECT  @Fecha_Prox = fechaprox  
       , @Fecha      = fechaproc
   FROM  
    LNKOPC.CbMdbOpc.dbo.OpcionesGeneral  
--   WHERE  
--    fechaproc = @Fecha  


   /************* Mantención ********************************
    Procedimiento debe agregar:
	   + Registros de la tabla BacSwapNY.dbo.Cartera_Eval (1)
	   + Registros de la tabla BacSwapSuda.dbo.Cartera_Eval (2)
	   + Registros de la tabla BacSwapNY.dbo.Cartera (3)
    Debido a PRDXXXXX
	Proyecto Turing del año 2012 no agregó tabla (2).  
	Banco soportará las lineas de clientes NY por esto se
	agregan tablas (1) y (3).
   **********************************************************/
   -- Chequeo existencia Base de datos.
   declare @BaseNYActiva varchar(1)
   declare @ComandoRescateCartera Varchar(1000)
   select @BaseNYActiva = 'N'
	if exists( select (1) from master.dbo.sysdatabases where name = 'BacFWDNY' ) -- Es más rápido checar este base
	begin
	select @BaseNYActiva = 'S'
	end
	select caNumContrato
		   ,	CaCVEstructura
		   ,	CaFechaContrato
		   ,	CaRutCliente
		   ,    CaCodigo
		   ,    CaCarteraFinanciera
		   ,    CaEstado
		   ,    CaCodEstructura
		   ,    PosibleAplicacionET = 'N' 
		   ,    CaTipoTransaccion
		   ,    CaVr
		   into #Cartera from lnkOpc.CbMdbOpc.dbo.CaEncContrato where 1 = 2		 
	select @ComandoRescateCartera = ''
	select @ComandoRescateCartera = @ComandoRescateCartera + ' select caNumContrato
		   ,	CaCVEstructura
		   ,	CaFechaContrato
		   ,	CaRutCliente
		   ,    CaCodigo
		   ,    CaCarteraFinanciera
		   ,    CaEstado
		   ,    CaCodEstructura
		   ,    PosibleAplicacionET = ''N''
		   ,    CaTipoTransaccion
		   ,    CaVr
		    from LnkOpc.CbMdbOpc.dbo.CaEncContrato  ' -- 573339
	if @BaseNYActiva = 'S'
	select @ComandoRescateCartera = @ComandoRescateCartera + ' union select caNumContrato
		   ,	CaCVEstructura
		   ,	CaFechaContrato
		   ,	CaRutCliente
		   ,    CaCodigo
		   ,    CaCarteraFinanciera
		   ,    CaEstado
		   ,    CaCodEstructura
		   ,    PosibleAplicacionET = ''N''
		   ,    CaTipoTransaccion
		   ,    CaVr
		    from LnkOpc.CbMdbOpcNY.dbo.CaEncContrato  '
    -- Crear la tabla y unirla al exec
    insert into #Cartera
    exec (@ComandoRescateCartera)    

	select    CanumContrato
		          , CaModalidad
		          ,	CaFechaVcto
		          , CaVrDet 
		          ,	CaCodMon1
		          ,	CaCodMon2 
				  , CaMontoMon1
				  , CaMontoMon2
				  , CaParStrike				  
				  , CaVinculacion
				  , CaCallPut
				  , CaTipoPayOff
				  , CaCVOpc
				  , CaStrike
				  , CaVrDetML
				  , CaNumEstructura
				  , CaBenchComp
				   into #CarteraDet from lnkOpc.CbMdbOpc.dbo.CaDetContrato where 1 = 2		 
	select @ComandoRescateCartera = ''
	select @ComandoRescateCartera = @ComandoRescateCartera + ' select    CanumContrato
		          , CaModalidad
		          ,	CaFechaVcto
		          , CaVrDet 
		          ,	CaCodMon1
		          ,	CaCodMon2 
				  , CaMontoMon1
				  , CaMontoMon2 
				  , CaParStrike				  
				  , CaVinculacion
				  , CaCallPut
				  , CaTipoPayOff
				  , CaCVOpc
				  , CaStrike
				  , CaVrDetML
				  , CaNumEstructura
				  , CaBenchComp
				  from LnkOpc.CbMdbOpc.dbo.CaDetContrato  ' -- 573339
	if @BaseNYActiva = 'S'
	select @ComandoRescateCartera = @ComandoRescateCartera + ' union select    CanumContrato
		          , CaModalidad
		          ,	CaFechaVcto
		          , CaVrDet 
		          ,	CaCodMon1
		          ,	CaCodMon2 
				  , CaMontoMon1
				  , CaMontoMon2
				  , CaParStrike				  
				  , CaVinculacion
				  , CaCallPut
				  , CaTipoPayOff
				  , CaCVOpc
				  , CaStrike
				  , CaVrDetML
				  , CaNumEstructura
				  , CaBenchComp
				   from LnkOpc.CbMdbOpcNY.dbo.CaDetContrato  '
    -- Crear la tabla y unirla al exec
    insert into #CarteraDet
    exec (@ComandoRescateCartera)    
    
 IF @Rut = 0  
 BEGIN   
  -- Insert statements for procedure here  
  SELECT  
   Numero_Contrato = CARTERA.CaNumContrato  
  , Cartera = PARAMETRIZA_CARTERA.Codigo  
  , Estructura = CARTERA.CaVinculacion  
  , Numero_Componente = CARTERA.CaNumEstructura  
  , CallPut = CARTERA.CaCallPut  
  , PayOff = CARTERA.CaTipoPayOff  
  , Sentido = CARTERA.CaCVOpc  
  , Fecha_Vencimiento = CARTERA.CaFechaVcto  
  , Nocional = CARTERA.CaMontoMon1  
  , Strike = CARTERA.CaStrike  
  , Codigo_Strike = PARAMETRIZA_STRIKE.Codigo  
  , Moneda_Valorizacion = PARAMETRIZA_MONEDA.Codigo  
  , Curva_1 = PARAMETRIZA_CURVA_1.Codigo  
  , Curva_2 = PARAMETRIZA_CURVA_2.Codigo  
  , 'VolSfce' = PARAMETRIZA.Codigo_vol  
  , MtM = CARTERA.CaVrDetML   
  , Rut = GENERAL.CaRutCliente  
  ,   Codigo = GENERAL.CaCodigo    
        ,   PosibleAplicacionET = case when isnull( MID.MddNumOpe, 0 ) = GENERAL.CanumContrato  and GENERAL.CaVr < 0 then 'S' else 'N' end     
  , Moneda_1_BAC = CARTERA.CaCodMon1  
  , Moneda_2_BAC = CARTERA.CaCodMon2  
        ,   Plazo        = datediff( dd, @Fecha, CARTERA.CaFechaVcto )    
        ,   Duration     = datediff( dd, @Fecha, CARTERA.CaFechaVcto ) / 365.0          
  FROM  
    LNKOPC.CbMdbOpc.dbo.CaResDetContrato CARTERA   --- select '*'+Caestado+'*' from LNKOPC.CbMdbOpc.dbo.OpcionesGeneral CARTERA
  , LNKOPC.CbMdbOpc.dbo.CaResEncContrato GENERAL  
            LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID   
                      ON MddMod = 'OPT' and MddNumOpe = GENERAL.CaNumContrato       
  , ParametrosdboParametrizacion_Opciones_FX PARAMETRIZA  
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_STRIKE  -- select distinct producto from BacLineas.dbo.ParametrosdboParametrizacion_Curvas where producto = 'Opciones' 
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVA_1  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVA_2  
  , ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA  -- select * from ParametrosdboParametrizacion_Carteras  
--  , BacLineas.dbo.linea_general BANCOS -- Threshold  
  WHERE  
   GENERAL.CaEncFechaRespaldo = @Fecha  
  AND PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = GENERAL.CaCarteraFinanciera  
  AND GENERAL.CaEncFechaRespaldo = CARTERA.CaDetFechaRespaldo  
  AND GENERAL.CaEstado in ( '' , 'P' )   -- select '*'+CaTipoTransaccion+'*' from lnkopc.CbMdbOpc.dbo.caencContrato where canumcontrato = 167
  AND GENERAL.CaNumContrato = CARTERA.CaNumContrato  
  AND CARTERA.CaParStrike = PARAMETRIZA.Par_monedas  
  AND PARAMETRIZA_STRIKE.Codigo_BAC = PARAMETRIZA.Tipo_Cambio  
  AND PARAMETRIZA_MONEDA.Codigo_BAC = PARAMETRIZA.Moneda_Valorizacion  
  AND PARAMETRIZA_CURVA_1.Producto = 'Opciones'  
  AND PARAMETRIZA_CURVA_2.Producto = 'Opciones'  
  AND PARAMETRIZA_CURVA_1.Curva = PARAMETRIZA.Curva_1  
  AND PARAMETRIZA_CURVA_2.Curva = PARAMETRIZA.Curva_2  
  AND GENERAL.CaTipoTransaccion <> 'ANTICIPA'  
  AND (  
    (  
     CARTERA.CaModalidad = 'C'  
    AND CARTERA.CaBenchComp = 994  
    AND CARTERA.CaFechaVcto > @Fecha_Prox  
    )  
    OR  
    (  
     CARTERA.CaModalidad = 'E'  
    AND CARTERA.CaFechaVcto > @Fecha  
    )  
   )  
--  AND BANCOS.rut_Cliente = GENERAL.CaRutCliente  
--  AND BANCOS.Codigo_cliente = GENERAL.CaCodigo    
  ORDER BY  
   CARTERA.CaNumContrato  
  , CARTERA.CaNumEstructura  
 END -- @Rut = 0  
 ELSE  
 BEGIN  
    
  DECLARE @Existe AS INT  
  SET @Existe = 0  
  
        CREATE TABLE #FAMILIA  
           (  
             Id                 VARCHAR(19) ,  
             ClRut              numeric(13),  
             ClCodigo           numeric(5),  
             Afecta_Lineas_Hijo numeric(1)  
           )  
  
        INSERT INTO #FAMILIA  
            EXECUTE BacLineas..SP_RIEFIN_FAMILIAS @Rut, @Codigo  
        -- and #Familia.Afecta_Lineas_Hijo = 0 -- colocar al cruzar con Cartera  
   
  
   
  SELECT @Existe=1  
  FROM  #Familia  
        , #Cartera GENERAL  
  WHERE GENERAL.CaRutCliente = ClRut  
         and  CaCodigo = ClCodigo  
          and #Familia.Afecta_Lineas_Hijo = 0  
   
  IF @Existe =0   
  BEGIN  
  SELECT 'Consulta'= -1,'Rut'= 'Rut no existe en Cartera'  
  RETURN  
  END  
    
    
  -- Insert statements for procedure here  
  SELECT  
   Numero_Contrato = CARTERA.CaNumContrato  
  , Cartera = PARAMETRIZA_CARTERA.Codigo  
  , Estructura = CARTERA.CaVinculacion  
  , Numero_Componente = CARTERA.CaNumEstructura  
  , CallPut = CARTERA.CaCallPut  
  , PayOff = CARTERA.CaTipoPayOff  
  , Sentido = CARTERA.CaCVOpc  
  , Fecha_Vencimiento = CARTERA.CaFechaVcto  
  , Nocional = CARTERA.CaMontoMon1  
  , Strike = CARTERA.CaStrike  
  , Codigo_Strike = PARAMETRIZA_STRIKE.Codigo  
  , Moneda_Valorizacion = PARAMETRIZA_MONEDA.Codigo  
  , Curva_1 = PARAMETRIZA_CURVA_1.Codigo  
  , Curva_2 = PARAMETRIZA_CURVA_2.Codigo  
  , 'VolSfce' = PARAMETRIZA.Codigo_vol  
  , MtM = CARTERA.CaVrDetML  
  , Rut = GENERAL.CaRutCliente  
  ,   Codigo = GENERAL.CaCodigo    
        ,   PosibleAplicacionET = case when isnull( MID.MddNumOpe, 0 ) = GENERAL.CanumContrato  and GENERAL.CaVr < 0 then 'S' else 'N' end     
  , Moneda_1_BAC = CARTERA.CaCodMon1  
  , Moneda_2_BAC = CARTERA.CaCodMon2  
        ,   Plazo        = datediff( dd, @Fecha, CARTERA.CaFechaVcto )  
        ,   Duration     = datediff( dd, @Fecha, CARTERA.CaFechaVcto ) / 365.0          
  FROM  
   #CarteraDet CARTERA   --- select * from LNKOPC.CbMdbOpc.dbo.CaResEncContrato CARTERA  
  , #Cartera GENERAL   -- select * from LNKOPC.CbMdbOpc.dbo.CaEncContrato  
            LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID ON MddMod = 'OPT' and MddNumOpe = GENERAL.CaNumContrato       
  , ParametrosdboParametrizacion_Opciones_FX PARAMETRIZA   -- select * from ParametrosdboParametrizacion_Opciones_FX  
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_STRIKE  
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVA_1  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVA_2  
  , ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA  
--  , BacLineas.dbo.linea_general BANCOS -- Threshold  --- select * from BacLineas.dbo.linea_general where rut_cliente in ( 96364000, 59029940 )  
        ,   #Familia Fam  
  WHERE  
   PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = GENERAL.CaCarteraFinanciera  
  AND	GENERAL.CaEstado in ( '' , 'P' )
  AND GENERAL.CaCodEstructura not in (8,9)            -- Forward Americano entra en estructura FWD.
  AND GENERAL.CaNumContrato = CARTERA.CaNumContrato  
  AND CARTERA.CaParStrike = PARAMETRIZA.Par_monedas   -- select  * from LNKOPC.CbMdbOpc.dbo.CaEncContrato  
  AND PARAMETRIZA_STRIKE.Codigo_BAC = PARAMETRIZA.Tipo_Cambio  
  AND PARAMETRIZA_MONEDA.Codigo_BAC = PARAMETRIZA.Moneda_Valorizacion  
  AND PARAMETRIZA_CURVA_1.Producto = 'Opciones'  
  AND PARAMETRIZA_CURVA_2.Producto = 'Opciones'  
  AND PARAMETRIZA_CURVA_1.Curva = PARAMETRIZA.Curva_1  
  AND PARAMETRIZA_CURVA_2.Curva = PARAMETRIZA.Curva_2  
  AND GENERAL.CaTipoTransaccion <> 'ANTICIPA'  
  AND (  
    (  
     CARTERA.CaModalidad = 'C'  
    AND CARTERA.CaBenchComp = 994  
    AND CARTERA.CaFechaVcto > @Fecha_Prox  -- por minetras  
    )  
    OR  
    (  
     CARTERA.CaModalidad = 'E'  
       AND CARTERA.CaFechaVcto > @Fecha       -- por mientras  
    )  
   )  
        AND GENERAL.CaRutCliente = Fam.Clrut   
        AND GENERAL.CaCodigo= Fam.ClCodigo   
  
--  AND GENERAL.CaRutCliente = @Rut  
--  AND GENERAL.CaCodigo     = @Codigo  
--  AND BANCOS.rut_Cliente = GENERAL.CaRutCliente  
--  AND BANCOS.Codigo_cliente = GENERAL.CaCodigo    
  ORDER BY  
   CARTERA.CaNumContrato  
  , CARTERA.CaNumEstructura  
 END  
END 

GO
