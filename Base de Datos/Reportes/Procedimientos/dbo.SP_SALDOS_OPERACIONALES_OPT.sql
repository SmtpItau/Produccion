USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_OPERACIONALES_OPT]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_SALDOS_OPERACIONALES_OPT 
CREATE PROCEDURE [dbo].[SP_SALDOS_OPERACIONALES_OPT]
(
	@FECHA DATE = NULL	
)
AS 
BEGIN
/*
	INTERFAZ SALDOS OPERACIONALES OPCIONES
	RSILVA.
*/
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ SALDOS OPERACIONES OPCIONES
--MODIFICACION	: 10-04-2019
--MODIFICACION	: 26-04-2019

SET NOCOUNT ON
SET DATEFORMAT YMD

   DECLARE @dFechaProceso   DATETIME  
   
   SET @dFechaProceso=@FECHA	
   IF @dFechaProceso IS NULL
   BEGIN
	   SELECT  @dFechaProceso   = fechaproc   -- Prueba NEOSOFT  
	   FROM    CbMdbOpc..OpcionesGeneral with (Nolock)  
   END
  
   SELECT vmcodigo, vmfecha, vmvalor INTO #VM   
   FROM CbMdbOpc..bacparamsudaValor_moneda with (nolock) WHERE vmfecha = @dFechaProceso AND vmcodigo not in(999,998)  
   INSERT INTO #VM SELECT  999, @dFechaProceso,  1.0   
   INSERT INTO #VM SELECT  998, @dFechaProceso, 1.0   
  
   SELECT vmcodigo      = Codigo_Moneda  
   ,      vmfecha       = Fecha  
   ,      vmvalor       = Tipo_Cambio  
   INTO   #VALOR_TC_CONTABLE  
   FROM   CbMdbOpc..bacparamsudaVALOR_MONEDA_CONTABLE with (nolock)  
   WHERE  Fecha         = @dFechaProceso  
   AND    Codigo_Moneda NOT IN(998,999)  
  
   INSERT INTO #VALOR_TC_CONTABLE  
        SELECT 999 , @dFechaProceso , 1.0  
  
   -- RESCATE CONCEPTOS DE PERFILES DE SAO

   -- 1.0 Rescate de Conceptos fr los perfiles  
	select   C.Id_Sistema  
         ,  TipPErfil = 'PERFIL'
         ,  P.Folio_Perfil  
         ,  P.correlativo_perfil  
         ,  C.Nombre_Campo_tabla   
         ,  C.tipo_operacion   
         ,  C.Codigo_campo  
         ,  codigo_campo_variable = 0  
         ,  valor_dato_campo = 0  
         ,  codigo_cuenta   
         ,  C.tipo_movimiento  
	INTO #PERFIL_CONCEPTO  
	from	CbMdbOpc..BacParamSudaPERFIL_DETALLE_CNT P   
	,		CbMdbOpc..BacParamSudaPERFIL_CNT E  
	,		CbMdbOpc..bacparamSudaCampo_Cnt  C  
	where C.id_sistema = 'OPT'  
	and C.tipo_movimiento in ( 'MOV', 'AVR'  )  -- LIQ se toma para tener un ejemplo variable  
	and C.Codigo_campo in (   305 -- NN Dif. AVR Pos. ML   
                          ,  303 -- NN Dif. AVR Neg. ML
                          ,  300 -- NN Valor Strike  
                          ,  310 -- NN Valor Subyacente                                                           
                    )    
	and C.Codigo_campo = p.Codigo_Campo  
	and C.Id_sistema   = E.Id_sistema  
	and E.Folio_perfil = P.Folio_Perfil  
	and E.tipo_operacion = C.tipo_operacion  
	and E.Tipo_movimiento = C.tipo_Movimiento  
	and P.Codigo_Cuenta <> ''  
	and E.tipo_movimiento = C.tipo_movimiento    
	and substring( P.Codigo_Cuenta , 1, 1 ) in ( 1, 2, 3, 4 , 9  ) -- Cuentas 1 y 2 : Activo 3 y 4 Pasivo  
	UNION  
	select C.id_sistema
        , TipPErfil = 'PERFILVARIABLE'
        , P.Folio_Perfil    
        , P.correlativo_perfil  
        , C.Nombre_Campo_tabla   
        , C.tipo_operacion  
        , C.Codigo_campo  
        , P.codigo_campo_variable   
        , V.valor_dato_campo  
        , V.codigo_cuenta   
        , C.tipo_movimiento  
	from	CbMdbOpc..BacParamSudaPERFIL_DETALLE_CNT P   
	,		CbMdbOpc..BacParamSudaPERFIL_Variable_CNT V   
    ,		CbMdbOpc..BacParamSudaPERFIL_CNT E  
	,		CbMdbOpc..bacparamSudaCampo_Cnt  C  
	where C.id_sistema = 'OPT'  
	and C.tipo_movimiento in ( 'MOV', 'AVR' )  -- LIQ se toma para tener un ejemplo variable  
	and C.Codigo_campo in (   305 -- NN Dif. AVR Pos. ML     
                          ,  303 -- NN Dif. AVR Neg. ML
                          ,  300 -- NN Valor Strike  
                          ,  310 -- NN Valor Subyacente     
                    )    
	and C.Codigo_campo       = p.Codigo_Campo  
	and C.Id_sistema         = E.Id_sistema  
	and E.Folio_perfil       = P.Folio_Perfil  
	and E.tipo_operacion     = C.tipo_operacion  
	and E.Tipo_movimiento    = C.tipo_Movimiento  
	and V.Folio_Perfil       = E.Folio_Perfil  
	and V.Correlativo_perfil = P.correlativo_perfil   
	and substring( V.Codigo_Cuenta , 1, 1 ) in ( 1, 2, 3, 4 , 9  ) -- Cuentas 1 y 2 : Activo 3 y 4 Pasivo  
  
   -- PROD 13028 Se agregan los perfiles de productos con contabilida Externa al SAO.
	UNION
	select   C.Id_Sistema  
         ,  TipPErfil = 'PERFIL'
         ,  P.Folio_Perfil
         ,  P.correlativo_perfil
         ,  C.Nombre_Campo_tabla 
         ,  C.tipo_operacion 
         ,  C.Codigo_campo
         ,  codigo_campo_variable = 0
         ,  valor_dato_campo = 0
         ,  codigo_cuenta 
         ,  C.tipo_movimiento         
	from	BacParamSuda.dbo.PERFIL_DETALLE_CNT P 
	,		BacParamSuda.dbo.PERFIL_CNT E
    ,		BacParamSuda.dbo.Campo_Cnt  C
	where C.id_sistema = 'BFW'  
	and C.tipo_movimiento in ( 'MOV', 'DEV'  )  
	and C.Codigo_campo in (   300 -- NN Capital Moneda Origen                                    
                          ,  301 -- NN Capital en ML  
                          ,  311 -- NN Capital Conversión en ML                                          
                          ,  304 -- NN Utilidad Real del FW.                                    
                          ,  305 -- NN Perdida Real del FW.                                                                                              
                    )  
	and C.Codigo_campo = p.Codigo_Campo
	and C.Id_sistema   = E.Id_sistema
	and E.Folio_perfil = P.Folio_Perfil
	and E.tipo_operacion = C.tipo_operacion
	and E.Tipo_movimiento = C.tipo_Movimiento
	and P.Codigo_Cuenta <> ''
	and E.tipo_movimiento = C.tipo_movimiento  
	and substring( P.Codigo_Cuenta , 1, 1 ) in ( 1, 2, 3, 4 , 9  ) -- Cuentas 1 y 2 : Activo 3 y 4 Pasivo
	and ( E.tipo_operacion like '%15%' or E.tipo_operacion like '%17%' )
	and ( E.tipo_operacion not like 'V15%' and E.tipo_operacion not like 'V17%' )
	UNION
	select C.id_sistema
        , TipPErfil = 'PERFILVARIABLE'
        , P.Folio_Perfil  
        , P.correlativo_perfil
        , C.Nombre_Campo_tabla 
        , C.tipo_operacion
        , C.Codigo_campo
        , P.codigo_campo_variable 
        , V.valor_dato_campo
        , V.codigo_cuenta 
        , C.tipo_movimiento
	from	BacParamSuda.dbo.PERFIL_DETALLE_CNT P 
    ,		BacParamSuda.dbo.PERFIL_Variable_CNT V 
    ,		BacParamSuda.dbo.PERFIL_CNT E
    ,		BacParamSuda.dbo.Campo_Cnt  C
	where C.id_sistema = 'BFW'
	and C.tipo_movimiento in ( 'MOV', 'DEV' )  
	and C.Codigo_campo in (    300 -- NN Capital Moneda Origen                                    
                          ,  301 -- NN Capital en ML  
                          ,  311 -- NN Capital Conversión en ML                                          
                          ,  304 -- NN Utilidad Real del FW.                                    
                          ,  305 -- NN Perdida Real del FW.                                                                                             
                    )  
	and C.Codigo_campo       = p.Codigo_Campo
	and C.Id_sistema         = E.Id_sistema
	and E.Folio_perfil       = P.Folio_Perfil
	and E.tipo_operacion     = C.tipo_operacion
	and E.Tipo_movimiento    = C.tipo_Movimiento
	and V.Folio_Perfil       = E.Folio_Perfil
	and V.Correlativo_perfil = P.correlativo_perfil 
	and substring( V.Codigo_Cuenta , 1, 1 ) in ( 1, 2, 3, 4 , 9  ) -- Cuentas 1 y 2 : Activo 3 y 4 Pasivo
	and ( E.tipo_operacion like '%15%' or E.tipo_operacion like '%17%' )
	and ( E.tipo_operacion not like 'V15%' and E.tipo_operacion not like 'V17%' )
   -- PROD 13028
  
   -- 2.0 Cartera y Cartera Clasificacion Contable  
	select  Origen = 'CARTERA_CLASIFCTB'   
      , CodigoCarteraCtble = Clasif.CodigoCartera   
      , ClienteExtInt =( Case when C.ClPais = 6 then 2 else 1 end )  
      , Tipo_movimiento = 'MOV'
      , tipo_operacion = ltrim( rtrim( D.CaSubyacente ) ) + ltrim( rtrim( D.CaCVOpc ) )  + substring( D.CaCallPut, 1, 1 )   
      , E.CaCarNormativa   
      , E.CaSubCarNormativa  
	  , D.CaNumcontrato  
      , D.CaNumEstructura  
      , D.CaSubyacente        
      , D.CaCVOpc  
      , D.CaCallPut  
      , CaVrDetML = 0 --D.CaVrDetML 
      , D.CaCodMon1  
      , D.CaMontoMon1  
      , D.CaMontoMon2  
      , D.CaCodMon2    
      , E.CaCodEstructura
	into #Cartera_ClasifCTB  
	from CbMdbOpc..CaDetContrato D   
	,	 CbMdbOpc..CaEncContrato E  
	,	 CbMdbOpc..OpcionEstructura Estruc  
	,    BacParamSuda.dbo.Cliente C  
    ,	 CbMdbOpc..BacParamSudaTBL_CLASIFICACION_CARTERA Clasif  
	where     D.CaNumContrato = E.CaNumContrato  
	and E.CaRutCliente  = C.ClRut  
	and E.CaCodigo      = C.ClCodigo  
	and Estruc.OpcEstCod = E.CaCodEstructura
    and Estruc.OpcContabExterna = 'N'
    and ( Case when C.ClPais = 6 then 2 else 1 end ) =  Clasif.Contraparte  
    and E.CaCarNormativa = Clasif.CarteraNormativa
    and E.CaSubCarNormativa = Clasif.SubCarteraNormativa 
    and D.CaFechaPagoEjer   > @dFechaProceso
    and E.CaEstado <> 'C'
	UNION
	select  Origen = 'CARTERA_CLASIFCTB' 
      , CodigoCarteraCtble = Clasif.CodigoCartera 
      , ClienteExtInt =( Case when C.ClPais = 6 then 2 else 1 end )
      , Tipo_movimiento = 'AVR'
      , tipo_operacion = ltrim( rtrim( D.CaSubyacente ) ) + ltrim( rtrim( D.CaCVOpc ) )  + substring( D.CaCallPut, 1, 1 ) 
      , E.CaCarNormativa 
      , E.CaSubCarNormativa
      , D.CaNumcontrato
      , D.CaNumEstructura
      , D.CaSubyacente      
      , D.CaCVOpc
      , D.CaCallPut
      , CaVrDetML  = D.CaVrDetML 
      , D.CaCodMon1
      , CaMontoMon1 = 0 --D.CaMontoMon1
      , CaMontoMon2 = 0 --D.CaMontoMon2
      , D.CaCodMon2     
      , E.CaCodEstructura
	from	CbMdbOpc..CaDetContrato D 
	,		CbMdbOpc..CaEncContrato E
	,		CbMdbOpc..OpcionEstructura Estruc  -- select * from OpcionEstructura 
	,		BacParamSuda.dbo.Cliente C
    ,		CbMdbOpc..BacParamSudaTBL_CLASIFICACION_CARTERA Clasif -- select * from BacParamSudaTBL_CLASIFICACION_CARTERA
	where     D.CaNumContrato = E.CaNumContrato
	and E.CaRutCliente  = C.ClRut
    and E.CaCodigo      = C.ClCodigo
       -- PROD-13028
    and Estruc.OpcEstCod = E.CaCodEstructura
    and Estruc.OpcContabExterna = 'N'
    and ( Case when C.ClPais = 6 then 2 else 1 end ) =  Clasif.Contraparte
    and E.CaCarNormativa = Clasif.CarteraNormativa
    and E.CaSubCarNormativa = Clasif.SubCarteraNormativa 
    and D.CaFechaPagoEjer   > @dFechaProceso
    and E.CaEstado <> 'C'
	UNION   
	select Distinct Origen = 'CARTERA_CLASIFCTB' 
      , CodigoCarteraCtble = Clasif.CodigoCartera 
      , ClienteExtInt =( Case when C.ClPais = 6 then 2 else 1 end )
      , Tipo_Movimiento = 'MOV'
      , tipo_operacion = ltrim( rtrim( Estruc.OpcContabExternaProd ) ) + ltrim( rtrim( E.CaCVEstructura ) )  + '' --substring( D.CaCallPut, 1, 1 ) 
      , E.CaCarNormativa 
      , E.CaSubCarNormativa
      , D.CaNumcontrato
      , CaNumEstructura = 1
      , D.CaSubyacente      
      , E.CaCVEstructura 
      , CaCallPut = 'NA'
      , CaVrDetML = 0 -- E.CaVr
      , D.CaCodMon1
      , D.CaMontoMon1
      , D.CaMontoMon2
      , D.CaCodMon2  
      , E.CaCodEstructura
	from	CbMdbOpc..CaDetContrato D 
	,		CbMdbOpc..CaEncContrato E
	,		CbMdbOpc..OpcionEstructura Estruc                -- select * from OpcionEstructura
	,		BacParamSuda.dbo.Cliente C       
    ,		CbMdbOpc..BacParamSudaTBL_CLASIFICACION_CARTERA Clasif -- select * from BacParamSudaTBL_CLASIFICACION_CARTERA
	where     D.CaNumContrato = E.CaNumContrato
    and E.CaRutCliente  = C.ClRut
    and E.CaCodigo      = C.ClCodigo
       -- PROD-13028
    and Estruc.OpcEstCod = E.CaCodEstructura
    and Estruc.OpcContabExterna = 'S'
    and ( Case when C.ClPais = 6 then 2 else 1 end ) =  Clasif.Contraparte
    and E.CaCarNormativa = Clasif.CarteraNormativa
    and E.CaSubCarNormativa = Clasif.SubCarteraNormativa 
    and D.CaFechaPagoEjer   > @dFechaProceso 
    and E.CaEstado <> 'C'
	UNION
	select Distinct Origen = 'CARTERA_CLASIFCTB' 
      , CodigoCarteraCtble = Clasif.CodigoCartera 
      , ClienteExtInt =( Case when C.ClPais = 6 then 2 else 1 end )
      , Tipo_Movimiento = 'DEV'
      , tipo_operacion = 'D' + ltrim( rtrim( Estruc.OpcContabExternaProd ) ) + ltrim( rtrim( E.CaCVEstructura ) )  + '' --substring( D.CaCallPut, 1, 1 ) 
      , E.CaCarNormativa 
      , E.CaSubCarNormativa
      , D.CaNumcontrato
      , CaNumEstructura = 1
      , D.CaSubyacente      
      , E.CaCVEstructura 
      , CaCallPut = 'NA'
      , CaVrDetML = E.CaVr
      , D.CaCodMon1
      , CaMontoMon1 = 0
      , CaMontoMon2 = 0
      , D.CaCodMon2  
      , E.CaCodEstructura
	from	CbMdbOpc..CaDetContrato D 
	,		CbMdbOpc..CaEncContrato E
	,		CbMdbOpc..OpcionEstructura Estruc                -- select * from OpcionEstructura
	,		BacParamSuda.dbo.Cliente C       
    ,		CbMdbOpc..BacParamSudaTBL_CLASIFICACION_CARTERA Clasif -- select * from BacParamSudaTBL_CLASIFICACION_CARTERA
    where     D.CaNumContrato = E.CaNumContrato
    and E.CaRutCliente  = C.ClRut
    and E.CaCodigo      = C.ClCodigo
    and Estruc.OpcEstCod = E.CaCodEstructura
    and Estruc.OpcContabExterna = 'S'
    and ( Case when C.ClPais = 6 then 2 else 1 end ) =  Clasif.Contraparte
    and E.CaCarNormativa = Clasif.CarteraNormativa
    and E.CaSubCarNormativa = Clasif.SubCarteraNormativa 
    and D.CaFechaPagoEjer   > @dFechaProceso 
    and E.CaEstado <> 'C'
  
   CREATE TABLE #InterfazBalanceOpc  
   (   Documento		NUMERIC(9)  
   ,   Correlativo		NUMERIC(4)  
   ,   Producto			VARCHAR(5)  
   ,   Fecha			DATE 
   ,   Cuenta			VARCHAR(20)  
   ,   Monto			NUMERIC(21,4)  
   ,   Moneda			INTEGER  
   ,   TipCta			integer  
   ,   CodEstructura    varchar(10)  
   ,   TipSdo			varchar(2)  
   ,   ClsSdo			varchar(1)  
   )  

   CREATE INDEX #_ippo_InterfazBalanceOpc ON #InterfazBalanceOpc (Documento, Correlativo, Cuenta, Moneda, Fecha)  
   --> (1.0) Valorizacion de Cartera  
   INSERT INTO #InterfazBalanceOpc  
   SELECT Documento   = CarClasificada.CaNumContrato
   ,	  Correlativo = CarClasificada.CaNumEstructura
   ,      Producto    = CarClasificada.tipo_operacion  
   ,      Fecha       = @dFechaProceso   
   ,      Cuenta      = Perfil.Codigo_cuenta  
   ,      Monto       = case when codigo_campo = 300 then CaMontoMon2   
                             when Codigo_Campo = 310 then CaMontoMon1  
                             when Codigo_campo = 305 then case when CarClasificada.CaVrDetML > 0 then CarClasificada.CaVrDetML else 0 end
                             when Codigo_campo = 303 then case when CarClasificada.CaVrDetML < 0 then -CarClasificada.CaVrDetML else 0 end
                             else CarClasificada.CaVrDetML end  
   ,      Moneda      = case when codigo_campo = 300 then CaCodMon2   
                             when codigo_campo = 310 then CaCodMon1   
                             else 999 end  
   ,      TipCta      = case when substring( Perfil.Codigo_cuenta , 1, 1 ) in ( 1,2,3,4)   
                                  then substring( Perfil.Codigo_cuenta , 1, 1 )  
                             else substring( Perfil.Codigo_cuenta , 1, 2 ) end  
   ,      CarClasificada.CaCodEstructura  
   ,      t2.COD_T_SALDO  
   ,      t2.COD_CLS_SALDO  
   FROM		#Cartera_ClasifCTB CarClasificada   
    ,		#PERFIL_CONCEPTO   Perfil                  
	,		REPORTES.DBO.RNT_INT_MTX_CONTABLE T2
   WHERE     Perfil.tipo_Operacion = CarClasificada.Tipo_Operacion  
         and ( Perfil.Codigo_campo_Variable = 0    
               or     Perfil.Codigo_campo_Variable <> 0   
                  and CarClasificada.CodigoCarteraCtble = Perfil.valor_dato_campo   
              )  
         and  Perfil.Tipo_movimiento = CarClasificada.Tipo_movimiento
         and  Perfil.Id_Sistema = 'OPT'
		 and CONVERT(NUMERIC,T2.CUENTA) = Perfil.Codigo_cuenta
		 and t2.INTERFAZ='SALDO'
   ORDER BY CarClasificada.CanumContrato * 100 + CarClasificada.CaNumEstructura , Perfil.Codigo_cuenta

   INSERT INTO #InterfazBalanceOpc
   SELECT Documento   = CarClasificada.CaNumContrato
   ,	  Correlativo = CarClasificada.CaNumEstructura
   ,      Producto    = CarClasificada.tipo_operacion
   ,      Fecha       = @dFechaProceso 
   ,      Cuenta      = Perfil.Codigo_cuenta
   ,      Monto = case when codigo_campo = 300 then CaMontoMon1 
                             when Codigo_Campo = 301 then CaMontoMon2 * isnull( (select vmvalor from #VALOR_TC_CONTABLE where vmcodigo = CaCodMon1) , 1 )
                             when Codigo_Campo = 310 then CaMontoMon2
                             when Codigo_Campo = 311 then CaMontoMon2 * isnull( (select vmvalor from #VALOR_TC_CONTABLE where vmcodigo = CaCodMon1) , 1 )
                             when Codigo_Campo = 305 then case when CarClasificada.CaVrDetML < 0 then -CarClasificada.CaVrDetML else 0 end
                             when Codigo_Campo = 304 then case when CarClasificada.CaVrDetML > 0 then CarClasificada.CaVrDetML else 0 end 
                             else CaMontoMon1 end
   ,      Moneda      = case when codigo_campo = 300 then CaCodMon1 
                             when codigo_campo = 301 then CaCodMon2                            
                             else 999 end
   ,      TipCta      = case when substring( Perfil.Codigo_cuenta , 1, 1 ) in ( 1,2,3,4) 
                                  then substring( Perfil.Codigo_cuenta , 1, 1 )
                             else substring( Perfil.Codigo_cuenta , 1, 2 ) end
   ,      CarClasificada.CaCodEstructura  
   ,      t2.COD_T_SALDO  
   ,      t2.COD_CLS_SALDO  
	FROM    #Cartera_ClasifCTB CarClasificada 
    ,		#PERFIL_CONCEPTO   Perfil                
	,		REPORTES.DBO.RNT_INT_MTX_CONTABLE T2
    WHERE     Perfil.tipo_Operacion = CarClasificada.Tipo_Operacion
         and ( Perfil.Codigo_campo_Variable = 0  
               or     Perfil.Codigo_campo_Variable <> 0 
                  and CarClasificada.CodigoCarteraCtble = Perfil.valor_dato_campo 
              )
         and  Perfil.Tipo_movimiento = CarClasificada.Tipo_movimiento
         and  Perfil.Id_Sistema = 'BFW'
		 and CONVERT(NUMERIC,T2.CUENTA) = Perfil.Codigo_cuenta
		 and t2.INTERFAZ='SALDO'
   ORDER BY CarClasificada.CanumContrato * 100 + CarClasificada.CaNumEstructura , Perfil.Codigo_cuenta  

   SELECT 'NRO_OPERACION'        = Documento
   ,      'NRO_DOCUMENTO'        = 0
   ,      'NRO_CORRELATIVO'      = Correlativo
   ,      'COD_CTA_CONT'         = LTRIM(RTRIM(Cuenta))
   ,      'TIP_SDO'		         = TipSdo  
   ,	  'COD_EST_SDO'			 = 1
   ,      'COD_DIVISA'           = mnnemo
   ,      'FEC_DATA'             = CONVERT(CHAR(8),Fecha ,112)  
   ,      'CLS_SDO'              = isnull(ClsSdo,'')  
   ,      'COD_ENTIDAD'          = '1769' 
   ,      'COD_PRODUCTO'         = 'OPT'
   ,      'COD_SUBPRODU'         = CodEstructura
   ,      'IMP_SDO_CONT_MO'      = case when Moneda <>999 then round(Monto,2) else round(Monto/isnull(vmvalor,1),2) end    
   ,      'IMP_SDO_CONT_ML'      = case when Moneda = 999 then round(Monto,0) else round(Monto*isnull(vmvalor,1),0) end    
   ,	  'COD_CENTRO_CONT'		 = 2230
   ,      'T_FLUJO'              = 0--mncodfox  
   FROM   #InterfazBalanceOpc  
          LEFT JOIN BacParamSuda.dbo.MONEDA with (nolock) ON mncodmon = Moneda  
          LEFT JOIN #VALOR_TC_CONTABLE                 ON vmcodigo = CASE WHEN Moneda = 13 THEN 994 ELSE Moneda END  
          where Monto <> 0 
   ORDER BY Documento , Producto   
  
  
   DROP TABLE #InterfazBalanceOpc  
   DROP TABLE #PERFIL_CONCEPTO  
   DROP TABLE #Cartera_ClasifCTB  





END
GO
