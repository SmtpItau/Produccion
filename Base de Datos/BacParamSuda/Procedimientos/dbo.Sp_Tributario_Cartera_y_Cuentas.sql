USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tributario_Cartera_y_Cuentas]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Tributario_Cartera_y_Cuentas]
	( @dFechaAnalisis Datetime )
AS 
BEGIN 
      SET NOCOUNT ON  


      -->     [0.0] Prueba Interna
      /*   
      Exec SP_TRIBUTARIO_Cartera_y_Cuentas '20120420'
      */
      -->     [0.3] -- Definicion de Variables con Respecto al Periodo de la Selección de Datos
      DECLARE @dFechaCierrePeriodo DATETIME   --> Fecha de Cierre. Para leer la Cartera [freeze]
      DECLARE @dFechaInicioPeriodo DATETIME   --> Para leer los Vencimientos entre el Periodo
      DECLARE @dFechaCierreMes           DATETIME


      -->     [0.4] -- Proceso que Retorna las fechas de: Cierre del Periodo Anterior e Inicio de Lectura de Datos      

      EXECUTE BacParamSuda.dbo.SP_Tributarios_fechaCierrePeriodo @dFechaAnalisis
                                                                                        ,      @dFechaCierrePeriodo    OUTPUT
                                                                                        ,      @dFechaInicioPeriodo    OUTPUT
                                                                                        ,      @dFechaCierreMes        OUTPUT
 
     
  
      -- Eliminar despues solo para pruebas !!! esta asignacion
     /*
      select @dFechaCierrePeriodo = '20111230' --> Fecha de Cierre. Para leer la Cartera [freeze]
      ,     @dFechaInicioPeriodo  = '20120102'  --> Para leer los Vencimientos entre el Periodo
      ,     @dFechaCierreMes      = '20120131'   
       ,    @dFechaAnalisis      = '20120106'
     */

      -- BACFORWARD -----------------------------------------------------------------
      -- BacForward Vigente a @dFechaCierreMes
      select   Id_Sistema = 'BFW'
       , CaNumoper = C.CaNumoper 
       , CaCodPos1 = convert( varchar(5), C.CaCodPos1 )
       , CaTipOper = C.CaTipOper
       , CaCodMon1 = C.CaCodMon1
       , CaCodMon2 = C.CaCodMon2
       , CaCartera_normativa = C.CaCartera_normativa 
       , CaSubCartera_Normativa = C.CaSubCartera_Normativa    
       , CaMtoMon1 = 0
       , CaCallPut = '    '   
      into #MFCA 
     from BacFwdSuda..MFCARES C where cafechaProceso = @dFechaCierreMes
      union -- BacForward VIgentes al  @dFechaCierrePeriodo 
      select   Id_Sistema = 'BFW'
       , CaNumoper = C.CaNumoper 
       , CaCodPos1 = convert( varchar(5), C.CaCodPos1 )
       , CaTipOper = C.CaTipOper
       , CaCodMon1 = C.CaCodMon1
       , CaCodMon2 = C.CaCodMon2
       , CaCartera_normativa = C.CaCartera_normativa 
       , CaSubCartera_Normativa = C.CaSubCartera_Normativa    
       , CaMtoMon1 = 0
       , CaCallPut = '    '   
    from BacFwdSuda..MFCARES C where CafechaProceso = @dFechaCierrePeriodo
      union -- BacForward Vencido entre  @dFechaInicioPeriodo and @dFechaCierreMes
      select   Id_Sistema = 'BFW'
       , CaNumoper = C.CaNumoper 
       , CaCodPos1 = convert( varchar(5), C.CaCodPos1 )
       , CaTipOper = C.CaTipOper
       , CaCodMon1 = C.CaCodMon1
       , CaCodMon2 = C.CaCodMon2
       , CaCartera_normativa = C.CaCartera_normativa 
       , CaSubCartera_Normativa = C.CaSubCartera_Normativa    
       , CaMtoMon1 = 0
       , CaCallPut = '    '   
    from BacFwdSuda..MFCAh C where CaFecvcto between @dFechaInicioPeriodo and @dFechaCierreMes

      -- ASIATICO y AMERICANO ----------------------------------------------------------
      union -- SAO FOrward Americano y Asiático Vigentes al @dFechaCierreMes
      select distinct          
         Id_Sistema = 'BFW'  
       , CaNumoper = C.CaNumContrato 
       , CaCodPos1 = case when CaCodEstructura = '6' then '17' else '15' end 
       , CaTipOper = C.CaCVEstructura 
       , CaCodMon1 = Det.CaCodMon1 
       , CaCodMon2 = Det.CaCodMon2
       , CaCartera_normativa = C.CaCarNormativa
       , CaSubCartera_Normativa = C.CaSubCarNormativa    
       , CaMtoMon1 = 0 --Det.CaMontoMon1  
       , CaCallPut = '    '   
      from Lnkopc.CbMdbOpc.dbo.CaRESEncContrato C
        ,  Lnkopc.CbMdbOpc.dbo.CaRESDetContrato Det
         where C.CaNumContrato = Det.CaNumCOntrato
          and CaCodEstructura in ( 6, 8 ) -- Asiaticos y Amerciano
          and C.CaEncFechaRespaldo = @dFechaCierreMes
          and Det.CaDetFechaRespaldo = @dFechaCierreMes
      union -- SAO FOrward Americano y Asiático Vigentes al @dFechaCierrePeriodo
      select distinct          
         Id_Sistema = 'BFW'  
       , CaNumoper = C.CaNumContrato 
       , CaCodPos1 = case when CaCodEstructura = '6' then '17' else '15' end 
       , CaTipOper = C.CaCVEstructura 
       , CaCodMon1 = Det.CaCodMon1 
       , CaCodMon2 = Det.CaCodMon2
       , CaCartera_normativa = C.CaCarNormativa
       , CaSubCartera_Normativa = C.CaSubCarNormativa    
       , CaMtoMon1 = 0 --Det.CaMontoMon1  
       , CaCallPut = '    '   
      from Lnkopc.CbMdbOpc.dbo.CaRESEncContrato C
      ,  Lnkopc.CbMdbOpc.dbo.CaRESDetContrato Det
         where C.CaNumContrato = Det.CaNumCOntrato
          and CaCodEstructura in ( 6, 8 ) -- Asiaticos y Amerciano
          and C.CaEncFechaRespaldo = @dFechaCierrePeriodo
          and Det.CaDetFechaRespaldo = @dFechaCierrePeriodo
      union -- SAO FOrward Americano y AsiáticoVencidos entre @dFechaCierrePeriodo y @dFechaCierreMes
      select distinct          
         Id_Sistema = 'BFW'  
       , CaNumoper = C.CaNumContrato 
       , CaCodPos1 = case when CaCodEstructura = '6' then '17' else '15' end 
       , CaTipOper = C.CaCVEstructura 
       , CaCodMon1 = Det.CaCodMon1 
       , CaCodMon2 = Det.CaCodMon2
       , CaCartera_normativa = C.CaCarNormativa
       , CaSubCartera_Normativa = C.CaSubCarNormativa    
       , CaMtoMon1 = 0 --Det.CaMontoMon1  
       , CaCallPut = '    '   
      from Lnkopc.CbMdbOpc.dbo.CaVenEncContrato C
        ,  Lnkopc.CbMdbOpc.dbo.CaVenDetContrato Det
         where C.CaNumContrato = Det.CaNumCOntrato
          and CaCodEstructura in ( 6, 8 ) -- Asiaticos y Amerciano
          and Det.CaFechaVcto between @dFechaCierrePeriodo and @dFechaCierreMes

      -- OPCIONES no Forward Americano ni Asiatico -----------------------------------------------------------------
      -- Opciones vigentes al @dFechaCierreMes
      union -- SAO no FOrward Americano y Asiático
      select   Id_Sistema = 'OPT'
       , CaNumoper = C.CaNumContrato* 100 + Det.CaNumEstructura
       , CaCodPos1 = ''
       , CaTipOper = Det.CaCVOpc -- CaCVOpc, CaTipoOpc
       , CaCodMon1 = Det.CaCodMon1 -- select * from CbMdbOpc.dbo.CaDetContrato
       , CaCodMon2 = Det.CaCodMon2
       , CaCartera_normativa = C.CaCarNormativa
       , CaSubCartera_Normativa = C.CaSubCarNormativa    
       , CaMtoMon1 = 0 --Det.CaMontoMon1  
       , CaCallPut = CaCallPut   
      from Lnkopc.CbMdbOpc.dbo.CaRESEncContrato C
        ,  Lnkopc.CbMdbOpc.dbo.CaRESDetContrato Det
         where C.CaNumContrato = Det.CaNumCOntrato
          and CaCodEstructura not in ( 6, 8 ) -- Asiaticos y Amerciano
          and CaEstado <> 'C'  
          and CaEncFechaRespaldo = @dFechaCierreMes
          and CaDetFechaRespaldo = @dFechaCierreMes 
      -- -- SAO no FOrward Americano y Asiático al @dFechaCierrePeriodo
      union -- SAO no FOrward Americano y Asiático
      select   Id_Sistema = 'OPT'
       , CaNumoper = C.CaNumContrato* 100 + Det.CaNumEstructura
       , CaCodPos1 = ''
       , CaTipOper = Det.CaCVOpc 
       , CaCodMon1 = Det.CaCodMon1 -- select * from CbMdbOpc.dbo.CaDetContrato
       , CaCodMon2 = Det.CaCodMon2
       , CaCartera_normativa = C.CaCarNormativa
       , CaSubCartera_Normativa = C.CaSubCarNormativa    
       , CaMtoMon1 = 0 --Det.CaMontoMon1  
       , CaCallPut = CaCallPut   
      from Lnkopc.CbMdbOpc.dbo.CaRESEncContrato C
        ,  Lnkopc.CbMdbOpc.dbo.CaRESDetContrato Det
       where C.CaNumContrato = Det.CaNumCOntrato
          and CaCodEstructura not in ( 6, 8 ) -- Asiaticos y Amerciano
          and CaEncFechaRespaldo = @dFechaCierrePeriodo
          and CaDetFechaRespaldo = @dFechaCierrePeriodo 
          and CaEstado <> 'C'  
      -- -- SAO no FOrward Americano y Asiático vencidos entre  @dFechaCierrePeriodo y @dFechaCierreMes
      union -- SAO no FOrward Americano y Asiático
      select   Id_Sistema = 'OPT'
       , CaNumoper = C.CaNumContrato* 100 + Det.CaNumEstructura
       , CaCodPos1 = ''
       , CaTipOper = Det.CaCVOpc 
       , CaCodMon1 = Det.CaCodMon1 -- select * from CbMdbOpc.dbo.CaDetContrato
       , CaCodMon2 = Det.CaCodMon2
       , CaCartera_normativa = C.CaCarNormativa
       , CaSubCartera_Normativa = C.CaSubCarNormativa    
       , CaMtoMon1 = 0 --Det.CaMontoMon1  
       , CaCallPut = CaCallPut   
      from Lnkopc.CbMdbOpc.dbo.CaVenEncContrato C
        ,  Lnkopc.CbMdbOpc.dbo.CaVenDetContrato Det
         where C.CaNumContrato = Det.CaNumCOntrato
          and CaCodEstructura not in ( 6, 8 ) -- Asiaticos y Amerciano
          and CaFechaVcto between @dFechaCierrePeriodo and @dFechaCierreMes 
          and CaEstado <> 'C'  

      -- SWAP -----------------------------------------------------------------
      union -- SWAP Vigentes a @dFechaCierreMes
      select  DIstinct  Id_Sistema = 'PCS'
       , CaNumoper = C.Numero_Operacion
       , CaCodPos1 = convert( varchar(5), C.Tipo_Swap )
       , CaTipOper = ''
       , CaCodMon1 = C.Compra_moneda 
       , CaCodMon2 = 0
       , CaCartera_normativa = C.cre_Cartera_Normativa
       , CaSubCartera_Normativa = C.cre_SubCartera_Normativa    
       , CaMtoMon1 = 0 --C.Compra_Capital  
       , CaCallPut = ''   
      from BacSwapSuda..CarteraRES C  
         where C.estado <> 'C' and Tipo_Flujo = 1 and Fecha_Proceso = @dFechaCierreMes 
      union -- SWAP Vigentes a @dFechaCierrePeriodo
      select  DIstinct  Id_Sistema = 'PCS'
       , CaNumoper = C.Numero_Operacion
       , CaCodPos1 = convert( varchar(5), C.Tipo_Swap )
       , CaTipOper = ''
       , CaCodMon1 = C.Compra_moneda 
       , CaCodMon2 = 0
       , CaCartera_normativa = C.cre_Cartera_Normativa
       , CaSubCartera_Normativa = C.cre_SubCartera_Normativa    
       , CaMtoMon1 = 0 --C.Compra_Capital  
       , CaCallPut = ''   
      from BacSwapSuda..CarteraRES C  
         where C.estado <> 'C' and Tipo_Flujo = 1 and Fecha_Proceso = @dFechaCierrePeriodo 
      union -- SWAP Flujos Vencidos
      select  DIstinct  Id_Sistema = 'PCS'
       , CaNumoper = C.Numero_Operacion
       , CaCodPos1 = convert( varchar(5), C.Tipo_Swap )
       , CaTipOper = ''
       , CaCodMon1 = C.Compra_moneda 
       , CaCodMon2 = 0
       , CaCartera_normativa = C.chi_Cartera_Normativa  -- select * from BacSwapSuda..Carterahis
       , CaSubCartera_Normativa = C.chi_SubCartera_Normativa    
       , CaMtoMon1 = 0 --C.Compra_Capital  
       , CaCallPut = ''   
      from BacSwapSuda..Carterahis C  
         where C.estado <> 'C' and Tipo_Flujo = 1 and Fechaliquidacion between @dFechaCierrePeriodo and @dFechaCierreMes --ACA
      select 
      		Id_Sistema = '   '
	      ,	Producto   = '   '
      	,	Abr_X_Producto = ' '
      	,	CV                 = ' '
      	,	Abre_X_CV          = ' '
      	,	CallPut            = '    '
      	,	Abre_X_CallPut     = ' '
      	,	Mda1               = 0
      	,	Abre_X_Mda1        = ' ' 
      	,	Mda2               = 0
      	,	Abre_X_Mda2        = ' '
      	,	Cartera_Normativa  = ' '
      	,	Abre_X_Cartera_Normativa = ' '
      	,	SubCartera_Normativa     = ' '
      	,	Abre_X_SubCartera_Normativa = ' '
          ,   Cuenta_AVR_Activo = 1000000000*0
          ,	Utilidad_AVR	  = 1000000000*0
          ,   Cuenta_AVR_Pasivo = 1000000000*0
          ,	Perdida_AVR	      = 1000000000*0
          ,   Perdida_Real	  = 1000000000*0
          ,   Utilidad_Real     = 1000000000*0

     /* Parece que faltan algunas otras (patrimonio) */
     into #ModProdCtas

      -- Todo esto viene de una Excel.
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 5, 'S', 0, 'N', '', 'N', '', 'N', 212801039, 760701078, 412801040, 560701075, 760701077, 560701076
		Insert into #ModProdCtas select 'BFW', '2', 'S', 'C', 'S', '', 'N', 6, 'S', 0, 'N', '', 'N', '', 'N', 212801016, 760701016, 412801016, 560701016, 760701038, 560701038
		Insert into #ModProdCtas select 'BFW', '2', 'S', 'V', 'S', '', 'N', 6, 'S', 0, 'N', '', 'N', '', 'N', 212801042, 760701085, 412801043, 560701083, 760701084, 560701082
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 82, 'S', 0, 'N', '', 'N', '', 'N', 212801043, 760701087, 412801044, 560701085, 760701086, 560701084
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 129, 'S', 0, 'N', '', 'N', '', 'N', 212801046, 760701093, 412801047, 560701091, 560701090, 760701092
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 51, 'S', 0, 'N', '', 'N', '', 'N', 212801033, 760701060, 412801034, 560701058, 760701061, 560701059
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 142, 'S', 0, 'N', '', 'N', '', 'N', 212801013, 760701013, 412801013, 560701013, 760701035, 560701035
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 102, 'S', 0, 'N', '', 'N', '', 'N', 212801014, 760701014, 412801014, 560701014, 760701036, 560701036
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 127, 'S', 0, 'N', '', 'N', '', 'N', 212801047, 760701094, 412801048, 560701092, 760701095, 560701093
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 72, 'S', 0, 'N', '', 'N', '', 'N', 212801015, 760701015, 412801015, 560701015, 760701037, 560701037
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 132, 'S', 0, 'N', '', 'N', '', 'N', 212801044, 760701089, 412801045, 560701087, 760701088, 560701086
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 96, 'S', 0, 'N', '', 'N', '', 'N', 212801032, 760701063, 412801033, 560701061, 760701066, 560701064
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 24, 'S', 0, 'N', '', 'N', '', 'N', 212801045, 760701091, 412801046, 560701089, 760701090, 560701088
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 113, 'S', 0, 'N', '', 'N', '', 'N', 212801031, 760701062, 412801032, 560701060, 760701065, 560701063
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 144, 'S', 0, 'N', '', 'N', '', 'N', 212801024, 760701048, 412801025, 560701047, 760701049, 560701048
		Insert into #ModProdCtas select 'BFW', '2', 'S', '', 'N', '', 'N', 48, 'S', 0, 'N', '', 'N', '', 'N', 212801036, 760701070, 412801037, 560701068, 560701069, 760701071
		Insert into #ModProdCtas select 'OPT', '', 'N', 'C', 'S', 'Call', 'S', 0, 'N', 0, 'N', '', 'N', '', 'N', 212801034, 760701068, 0, 560701066, 560701070, 760701072
		Insert into #ModProdCtas select 'OPT', '', 'N', 'C', 'S', 'Put', 'S', 0, 'N', 0, 'N', '', 'N', '', 'N', 212801035, 760701068, 0, 560701066, 560701070, 760701072
		Insert into #ModProdCtas select 'OPT', '', 'N', 'V', 'S', 'Call', 'S', 0, 'N', 0, 'N', '', 'N', '', 'N', 0, 760701069, 412801035, 560701067, 560701071, 760701073
		Insert into #ModProdCtas select 'OPT', '', 'N', 'V', 'S', 'Put', 'S', 0, 'N', 0, 'N', '', 'N', '', 'N', 0, 760701069, 412801036, 560701067, 560701071, 760701073
		Insert into #ModProdCtas select 'BFW', '3', 'S', '', 'N', '', 'N', 0, 'N', 0, 'N', 'T', 'S', '', 'N', 212801019, 760701019, 412801019, 560701019, 760701041, 560701041
		Insert into #ModProdCtas select 'BFW', '3', 'S', '', 'N', '', 'N', 0, 'N', 0, 'N', 'C', 'S', '', 'N', 212801030, 760701064, 412801031, 560701065, 760701067, 560701052
		Insert into #ModProdCtas select 'BFW', '10', 'S', '', 'N', '', 'N', 999, 'S', 0, 'N', '', 'N', '', 'N', 212801001, 760701001, 412801001, 560701001, 760701023, 560701023
		Insert into #ModProdCtas select 'BFW', '10', 'S', '', 'N', '', 'N', 998, 'S', 0, 'N', '', 'N', '', 'N', 212801002, 760701002, 412801002, 560701002, 560701024, 760701024
		Insert into #ModProdCtas select 'BFW', '14', 'S', '', 'N', '', 'N', 0, 'N', 999, 'S', '', 'N', '', 'N', 212801038, 760701075, 412801039, 560701073, 760701076, 560701074
		Insert into #ModProdCtas select 'BFW', '1', 'S', '', 'N', '', 'N', 0, 'N', 999, 'S', '', 'N', '', 'N', 212801017, 760701017, 412801017, 560701017, 560701039, 760701039
		Insert into #ModProdCtas select 'BFW', '1', 'S', '', 'N', '', 'N', 0, 'N', 998, 'S', '', 'N', '', 'N', 212801018, 760701018, 412801018, 560701018, 760701040, 560701040
		Insert into #ModProdCtas select 'BFW', '17', 'S', '', 'N', '', 'N', 0, 'N', 0, 'N', '', 'N', '', 'N', 212801005, 760701005, 412801005, 560701005, 760701027, 560701027
		Insert into #ModProdCtas select 'BFW', '15', 'S', '', 'N', '', 'N', 0, 'N', 0, 'N', '', 'N', '', 'N', 212801011, 760701033, 412801011, 560701033, 760701074, 560701072
		Insert into #ModProdCtas select 'BFW', '13', 'S', '', 'N', '', 'N', 0, 'N', 0, 'N', '', 'N', '', 'N', 212801028, 760701055, 412801029, 560701054, 760701056, 560701055
		Insert into #ModProdCtas select 'PCS', '2', 'S', '', 'N', '', 'N', 0, 'N', 0, 'N', 'T', 'S', '', 'N', 212801006, 760701006, 412801006, 560701006, 760701028, 560701028
		Insert into #ModProdCtas select 'PCS', '2', 'S', '', 'N', '', 'N', 0, 'N', 0, 'N', 'C', 'S', '', 'N', 212801041, 760701081, 412801042, 560701079, 760701082, 560701080
		Insert into #ModProdCtas select 'PCS', '1', 'S', '', 'N', '', 'N', 999, 'S', 0, 'N', '', 'N', '', 'N', 212801007, 760701007, 412801007, 560701007, 760701029, 560701029
		Insert into #ModProdCtas select 'PCS', '1', 'S', '', 'N', '', 'N', 13, 'S', 0, 'N', '', 'N', '', 'N', 212801008, 760701008, 412801008, 560701008, 760701030, 560701030
		Insert into #ModProdCtas select 'PCS', '1', 'S', '', 'N', '', 'N', 998, 'S', 0, 'N', '', 'N', '', 'N', 212801012, 760701012, 412801012, 560701012, 760701034, 560701034
		Insert into #ModProdCtas select 'PCS', '4', 'S', '', 'N', '', 'N', 999, 'S', 0, 'N', 'T', 'S', '', 'N', 212801009, 760701009, 412801009, 560701009, 760701031, 560701031
		Insert into #ModProdCtas select 'PCS', '4', 'S', '', 'N', '', 'N', 999, 'S', 0, 'N', 'C', 'S', '', 'N', 212801029, 760701011, 412801030, 560701011, 560701056, 760701057
		Insert into #ModProdCtas select 'PCS', '4', 'S', '', 'N', '', 'N', 998, 'S', 0, 'N', 'T', 'S', '', 'N', 212801010, 760701010, 412801010, 560701010, 760701032, 560701032
		Insert into #ModProdCtas select 'PCS', '4', 'S', '', 'N', '', 'N', 998, 'S', 0, 'N', 'C', 'S', '', 'N', 212801020, 760701020, 412801020, 560701020, 760701042, 560701042


      select Car.Id_Sistema, Canumoper, CaCodPos1, CaMtoMon1, CaCodMon1, CaCodMon2,
       Cuenta_AVR_Activo	, Utilidad_AVR	, Cuenta_AVR_Pasivo	, Perdida_AVR	, Perdida_Real	, Utilidad_Real

      into #Resultado_Cruce
      from   #MFCA Car  
      	,  #ModProdCtas     ProCta
      where  ProCta.Id_Sistema = Car.Id_sistema
         and (  ProCta.Producto   = Car.CaCodPos1  and ProCta.Abr_X_Producto = 'S' 
	      or Abr_X_Producto = 'N' )
         and (  ProCta.CV = Car.CaTipOper          and ProCta.Abre_X_CV = 'S'
          or ProCta.Abre_X_CV = 'N' )
         and (  ProCta.CallPut = Car.CaCallPut     and ProCta.Abre_X_CallPut = 'S'
          or ProCta.Abre_X_CallPut = 'N' )
         and (  ProCta.Mda1 = Car.CaCodMon1            and ProCta.Abre_X_Mda1 = 'S' 
          or ProCta.Abre_X_Mda1 = 'N' )
         and (  ProCta.Mda2 = CaCodMon2            and ProCta.Abre_X_Mda2 = 'S' 
          or ProCta.Abre_X_Mda2 = 'N' )
         and  ( ProCta.Cartera_Normativa = car.CaCartera_normativa and ProCta.Abre_X_Cartera_Normativa = 'S'
          or ProCta.Abre_X_Cartera_Normativa = 'N' )
         and  ( ProCta.SubCartera_Normativa = car.casubcartera_normativa and ProCta.Abre_X_SubCartera_Normativa = 'S'
          or ProCta.Abre_X_SubCartera_Normativa = 'N' )
      order by Car.Id_Sistema, Car.Canumoper
        
      select * from #Resultado_Cruce   -- where  canumoper in ( 8801, 8802 )-- where CaCodPos1 = 15 -- por mientras

      drop table #ModProdCtas  
      drop table #Resultado_Cruce
      drop table #MFCA
END
GO
