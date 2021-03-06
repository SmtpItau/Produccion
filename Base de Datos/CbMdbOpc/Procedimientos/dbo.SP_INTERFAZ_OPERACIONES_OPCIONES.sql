USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_OPERACIONES_OPCIONES]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_OPERACIONES_OPCIONES]
 --  (   @fechafinmeshabil   CHAR(8)
 --  ,   @fechafinmes        CHAR(8)
 --  )
AS 
BEGIN

   SET NOCOUNT ON
-- Documentacion: todos los Montos 18,2 deben ser multiplicados por 100 y redondeados en cero decimales
--                todos los Montos m,n deben ser multiplicados por power(10, n) y redondeados en cero decimales
-- Por Hacer:     aplicar los valores verdaderos de griegas, yo no he podido hacer valorizar en este PC.
-- PROD-14245:	  las operaciones con estructura OpcContabExternaTip = 'OTROS_FWD' deben generar un registro en OP49
              -- SP_INTERFAZ_OPERACIONES_OPCIONES
-- 20191023	RCHS  Se solicitó excluir aquellas operaciones donde las columnas mto_cap_origen y mto_cap_local 
--				  estém con valores negativos, los que generan problemas en SIGIR
				              
   DECLARE @FECHA 	      DATETIME
       SET @FECHA             =  (SELECT fechaproc FROM OpcionesGeneral with (nolock) ) -- Prueba NEOSOFT

   DECLARE @vDolar_obsFinMes  FLOAT
   DECLARE @vUF_FinMes        FLOAT

   DECLARE @max               INTEGER
       SET @max               = (SELECT COUNT(1) FROM CaEncContrato with (nolock) 
       WHERE cafechaContrato = @FECHA and CaEstado <> 'C' )

      SET @vDolar_obsFinMes   = 0.0
   SELECT @vDolar_obsFinMes   = ISNULL(vmvalor,0.0)     FROM BacParamSudaVALOR_MONEDA          with (nolock) WHERE vmcodigo      = 994 AND vmfecha = @FECHA

      SET @vDolar_obsFinMes   = 0.0
   SELECT @vDolar_obsFinMes   = ISNULL(Tipo_Cambio,0.0) FROM BacParamSudaVALOR_MONEDA_CONTABLE with (nolock) WHERE Codigo_Moneda = 994 AND Fecha   = @FECHA

--      SET @vUF_FinMes         = 0.0
--   SELECT @vUF_FinMes         = ISNULL(vmvalor,0.0)     FROM BacParamSudaVALOR_MONEDA          with (nolock) WHERE vmcodigo      = 998 AND vmfecha = @FECHAFINMES

   SELECT vmptacmp , mnrefusd , mncodmon , vmvalor
   INTO   #tipocambio 
   FROM   BacParamSudaVALOR_MONEDA      with (nolock)
          INNER JOIN BacParamSuda.dbo.MONEDA with (nolock) ON vmcodigo = mncodmon 
   WHERE  vmfecha     = @FECHA
   AND    vmcodigo    NOT IN(998,997)



   SELECT vmptacmp , mnrefusd , mncodmon , vmvalor = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSudaVALOR_MONEDA_CONTABLE   with (nolock)
          INNER JOIN BacParamSuda.dbo.MONEDA       with (nolock) ON Codigo_Moneda = mncodmon 
          INNER JOIN BacParamSudaVALOR_MONEDA with (nolock) ON Codigo_Moneda = vmcodigo and Fecha = vmfecha
   WHERE  Fecha         = @FECHA  
   AND    Codigo_Moneda NOT IN(998,997) 

   INSERT INTO #VALOR_TC_CONTABLE select vmptacmp , mnrefusd , 13 , vmvalor from #VALOR_TC_CONTABLE where mnCodMon = 994
   INSERT INTO #VALOR_TC_CONTABLE select vmptacmp = 1 , mnrefusd = 0 , 999 , 1 --from #VALOR_TC_CONTABLE

   --select 'debug', * from #VALOR_TC_CONTABLE

   CREATE TABLE #TEMPORAL
   (   fecha_contable    DATETIME					--1
   ,   status            CHAR(1)					--2
   ,   cod_producto      CHAR(4)					--3
   ,   T_producto        CHAR(4)					--4
   ,   rut               CHAR(9)					--5
   ,   dig               CHAR(1)					--6
   ,   costo             NUMERIC(1)					--7
   ,   n_operacion       CHAR(10) -- CHAR(5)		--8
   ,   fecha_inic        CHAR(8)					--9
   ,   fecha_vcto        DATETIME					--10
   ,   cod_inter_mda     NUMERIC(3)					--11
   ,   s_mto_cap_ori     CHAR(1)					--12
   ,   mto_cap_origen    FLOAT						--13
   ,   s_mto_cap_loc     CHAR(1)					--14
   ,   mto_cap_local     FLOAT						--15
   ,   s_reaj_mda_loc    CHAR(1)					--16
   ,   mto_reaj_loc      FLOAT						--17
   ,   s_int_mda_loc     CHAR(1)					--18
   ,   mto_int_mda_loc   FLOAT						--19
   ,   tasa_f_v          CHAR(1)					--20
   ,   spread            FLOAT						--21
   ,   valor_en_pesos    FLOAT						--22
   ,   nomin_en_pesos    FLOAT						--23
   ,   t_cartera         CHAR(10)					--24
   ,   mto_op_compra     FLOAT						--25
   ,   registros         NUMERIC(5)					--26
   ,   indicador         CHAR(1)					--27
   ,   colocacion        FLOAT						--28
   ,   destino           NUMERIC(5)					--29
   ,   TasaInteres       FLOAT						--30
   ,   MontoIniBFT       FLOAT						--31
   ,   n_Tipo_Contrato      VARCHAR(1)				--32
   ,   n_Tipo_Operacion     VARCHAR(1)				--33
   ,   n_Operacion_Original VARCHAR(10)				--34
   ,   Monto_Mora_4      varchar(18)            -- En Opciones se utilizaran para guardar las griegas	--35
   ,   Monto_Mora_5      varchar(18)				--36
   ,   Monto_Mora_6      varchar(18)				--37
   ,   c_riesgo          CHAR(3)			-->		38
   ,   fechaPrimerVencimiento   DATETIME			--39
   ,   tipoOtorgamiento			CHAR(1)				--40
   ,   precioVivienda			NUMERIC(19)			--41
   ,   tipoOperaconRenegociada  CHAR(1)				--42
   ,   montoPiePagado			NUMERIC(19)			--43
   ,   seguroRemate				CHAR(1)				--44
   ,   diasMorosidad			NUMERIC(8)			--45
   )
/* Sacar
   select 'Debug' , 
            CaNumContrato
          , CaNumEstructura
, CaDelta_spot
      , CaGamma_spot
          , CaVega
          , CaVol
          , CaPosDeltaSpot = round( CaDelta_spot *  ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = CaCodMon1 ) 
                                    , 2 )
          , CaRieGammaSpot = Round( power( ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = CaCodMon1 ) 
                                            * 8.0 , 2.0 ) 
                                    * CaGamma_spot / 200000.0 
                                    , 2 ) 
          , CaRieVega      = Round( 0.25 * CaVega * CaVol / 100.00 , 2.0 )  
          , Sxy = ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = CaCodMon1 )
   from CaDetContrato
        where CaFechaPagoEjer > @FECHA   
*/
   -- PENDIENTE: Crear campos físicos para registrar Posición Delta, Riesgo Gamma y 
   -- riesgo Vega por Operación.
   -- Esto debería ser un proceso ya que las monedas en un contrato podríasn ser muchas.
   -- Adicionalmente hay que usar el detalle para descartar operaciones, hay que contemplar
   -- esto en este proceso.
   select *     
          , CaPosDeltaSpot = convert( numeric(18),  round( case when CaDelta_spot = 0 
                                                                   then CaDelta_spot_Num 
                                                                else CaDelta_spot end
                                                            * 1.0 * ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = case when CaCodMon1 = 13 then 994 else CaCodMon1 end )  
                                       , 0 ) )
          , CaRieGammaSpot = convert( numeric(18), Round( power( 1.0 * ( select vmvalor from  #VALOR_TC_CONTABLE where mncodmon = case when CaCodMon1 = 13 then 994 else CaCodMon1 end ) 
                                            * 8.0 / 100.0 , 2.0 ) 
                                        *  case when CaGamma_spot = 0 
                                                                   then CaGamma_spot_Num 
                                                                else CaGamma_spot end / 2.0 
                                        , 0 ) )
          , CaRieVega      = convert( numeric(18), Round( 100.0 * 0.25 * Case when CaVega = 0.0 
                                                                              then CaVega_num
                                                                              else CaVega end * CaVol , 0 ) )  
          , CaFechaVctoAux = CaFechaPagoEjer
   into #CaDetContrato        
   from CaDetContrato
        where CaFechaPagoEjer > @FECHA   

--select 'debug', canumcontrato, canumestructura,  CaRieVega from #CaDetContrato

   Select *
           into #CaEncContrato 
   from CaEncContrato Enc 
   where Enc.CanumContrato in ( select canumContrato from #CaDetContrato ) 
--     and Enc.CaEstado <> 'C'

                         

   INSERT INTO #TEMPORAL
   SELECT 'fecha_contable'   = @fecha																																	--1
   ,      'status'           = 'A'																																		--2
   ,      'cod_producto'     = 'MD49'																																	--3
   ,      'T_producto'       = 'MDIR'																																	--4
   ,      'rut'              = CONVERT( CHAR(9), Enc.CaRutCliente )																										--5
   ,      'dig'              = ISNULL( Cli.ClDv , '0' )																													--6
   ,      'costo'            = 0           -- Antes era 5 !!!																											--7
   ,      'n_operacion'      = CONVERT( VARCHAR(20), rtrim( convert( varchar(20), Enc.CaNumContrato ) )																	--8
                                                   + rtrim( CONVERT( varchar(20), Det.CaNumEstructura  ) ) )															
   ,      'fecha_inic'       = CONVERT(CHAR(8), Enc.caFechaContrato ,112)																								--9
   ,      'fecha_vcto'       = CONVERT(Char(8), Det.CaFechaVctoAux, 112)																								--10
   ,      'cod_inter_mda'    = Det.CaCodMon1																															--11
   ,      's_mto_cap_ori'    = '+'																																		--12
   ,      'mto_cap_origen'   = round( Det.CaMontoMon1 * 100.0 , 0 )																										--13
   ,      's_mto_cap_loc'    = '+'																																			--14
   ,      'mto_cap_local'    = round( Det.CaMontoMon2 * 100.0 , 0 )																										--15
   ,      's_reaj_mda_loc'   = '+'																																		--16
   ,      'mto_reaj_loc'     = 0																																		--17
   ,      's_int_mda_loc'    = SPACE(1)																																	--18
   ,      'mto_int_mda_loc'  = 0																																		--19
   ,      'tasa_f_v'         = 'F'																																		--20
   ,      'spread'           = 0																																		--21
   ,      'valor_en_pesos'   = 0																																		--22
   ,      'nomin_en_pesos'   = 0																																		--23
   ,      't_cartera'        = rtrim( ISNULL((SELECT rtrim( ltrim( ccn_codigo_nuevo ) )																					--24
												FROM BacParamSuda.dbo.TBL_CODIFICACION_CARTERA_NORMATIVA with (nolock)											
												WHERE ccn_codigo_cartera = Enc.caCarNormativa),4) )																		
   ,      'mto_op_compra'    = 0 -- CASE WHEN cadiferen > 0 THEN cadiferen ELSE 0 END OJO se podría usar !!! Por hacer:  Poner Art 84 !!!								--26
   ,      'registros' 	     = @max																																		--27
   ,      'indicador'        = CASE WHEN Det.camodalidad = 'C'      THEN 'A'       ELSE 'P' END																			--28
   ,      'colocacion'       = 0																																		--29
   ,      'destino'        = CASE WHEN Enc.caRutCliente  = 97029000 THEN 211																							--30
                                    WHEN Enc.caRutCliente  = 97030000 THEN 212																							--31
                                    ELSE                           221																									--32
                               END																																		--33
   ,      'TasaInteres'      = 0.0																																		--34
   ,      'MontoIniBFT'      = 0.0
   ,      'n_Tipo_Contrato'  = '3'                                               -- Asignado por NEOSOFT para SIGIR
   ,      'n_Tipo_Operacion' = case when CaCVOpc = 'C' and CaCallPut = 'Call' then '1' 
                                    when CaCVOpc = 'C' and CaCallPut = 'Put'  then '2'
                                    when CaCVOpc = 'V' and CaCallPut = 'Call' then '3'
                                    when CaCVOpc = 'V' and CaCallPut = 'Put'  then '4' end
   ,      'n_Operacion_Original' = convert( varchar(20), Enc.CaNumContrato )
   ,      'Monto_Mora_4'         = case when CaPosDeltaSpot < 0 then '-' else '0' end 
                                 + case when CaPosDeltaSpot = 0 then replicate('0', 17)
                                   else 
                                     replicate( '0', 17 - len ( convert( varchar(17), round( abs(CaPosDeltaSpot) * 100 , 0 ) ) )  ) 
                                     + rtrim( convert( varchar(17), abs( CaPosDeltaSpot * 100 ) ) ) 
                                   end
   ,      'Monto_Mora_5'         = case when CaRieVega < 0 then '-' else '0' end 
                                 + case when CaRieVega = 0 then replicate('0', 17)
                                   else
                                       replicate( '0', 17 - len ( convert( varchar(17), round( abs( CaRieVega ) * 100 , 0 ) ) )  ) 
                                     + rtrim( convert( varchar(17), abs( CaRieVega * 100 ) ) )  
                                   end
   ,      'Monto_Mora_6'         = case when CaRieGammaSpot < 0 then '-' else '0' end 
                                 + Case when CaRieGammaSpot = 0 then replicate('0', 17)
                                   else
                                       replicate( '0', 17 - len ( convert( varchar(17), round( abs( CaRieGammaSpot ) * 100 , 0 ) ) )  ) 
                                 + rtrim( convert( varchar(17), abs( CaRieGammaSpot * 100 ) ) )  
                                   end
   ,	'c_riesgo'		= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( clrut, clcodigo, 'OPC' )

-- Campos 
   ,	  'fechaPrimerVencimiento'     = ''
   ,	  'tipoOtorgamiento'		   = ''
   ,	  'precioVivienda'			   = 0
   ,	  'tipoOperaconRenegociada'    = ''
   ,      'montoPiePagado'			   = 0
   ,      'seguroRemate'			   = ''
   ,      'diasMorosidad'			   = 0

   FROM   #CaDetContrato Det,
          #CaEncContrato Enc                           with (nolock)          
          LEFT JOIN OpcionEstructura Estructura ON   Estructura.OpcEstCod = Enc.CaCodEstructura   -- PROD-14245    
          LEFT JOIN BacParamSuda.dbo.CLIENTE Cli with (nolock) ON clrut = caRutCliente AND clcodigo = cacodigo
    where Det.CaNumContrato = Enc.CaNumContrato 
       and Enc.CaEstado <> 'C'
       and Estructura.OpcContabExternaTip <> 'OTROS_FWD'  -- PROD-14245
	   and (round( Det.CaMontoMon1 * 100.0 , 0 )>0	or 	round( Det.CaMontoMon2 * 100.0 , 0 )>0)	--20191024.RCHS.Excluir operaciones que estén informando valores negarivos
   ORDER BY Det.CaNumContrato , Det.CaNumEstructura

                     
   -- PROD-14245
   -- Productos informados en un solo componente
   SELECT Enc_CaRutCliente  = Enc.CaRutCliente 
   ,      Cli_ClDv               = Cli.ClDv
   ,      Enc_CaNumContrato      = Enc.CaNumContrato
   ,      Det_CaNumEstructura    = 1                    
   ,      Enc_CaFechaContrato    = Enc.caFechaContrato 
   ,      Det_CaFechaVctoAux     = Det.CaFechaVctoAux
   ,      Det_CaCodMon1          = Det.CaCodMon1 
   ,      Det_CaMontoMon1        = Det.CaMontoMon1    
   ,      Det_CaMontoMon2        = Det.CaMontoMon2             
   ,      Enc_CaCarNormativa     = Enc.caCarNormativa  
   ,      Det_CaModalidad        = Det.camodalidad
   ,      Det_CaCVOpc            = Enc.CaCVEstructura -- PROD-14245  Det.CaCVOpc  se enviará lo indicado en la estructura

          -- PROD-14245 Problema resolviéndose con JPFREIRE        
          --            El 28 de mayo 2012 dijo guiarse por Enc.CaCVEstructura   
   ,      Det_CaCallPut          = case when Enc.CaCVEstructura = 'C' then 'Call' else 'Put' end  /* PROD-14245 OJO Queda como el revés del FwAmericano */

   ,      CaPosDeltaSpot         = sum( CaPosDeltaSpot )  -- PROD-14245
   ,      CaRieVega              = 0.0                    -- PROD-14245
   ,      CaRieGammaSpot         = 0.0                    -- PROD-14245
   ,	  clrut					 = cli.clrut
   ,	  clcodigo				 = cli.clcodigo
   INTO   #TEMPORAL_DETALLE_OTROS_FWD
   FROM   #CaDetContrato							Det with(nolock)
	,	  #CaEncContrato							Enc with(nolock)
          LEFT JOIN OpcionEstructura         Estructura with(nolock) ON Estructura.OpcEstCod = Enc.CaCodEstructura
          LEFT JOIN BacParamSuda.dbo.CLIENTE Cli with(nolock) ON clrut = caRutCliente AND clcodigo = cacodigo
    where Det.CaNumContrato = Enc.CaNumContrato 
       and Enc.CaEstado <> 'C'
       and Estructura.OpcContabExternaTip = 'OTROS_FWD'  -- PROD-14245

   Group BY Enc.CaNumContrato 
          , Enc.CaRutCliente
          , Cli.ClDv
          , Enc.caFechaContrato
          , Det.CaFechaVctoAux
          , Det.CaCodMon1 
          , Det.CaMontoMon1 
          , Det.CaMontoMon2 
          , Enc.caCarNormativa
          , Det.camodalidad
          , Enc.CaCVEstructura

		  ,	cli.clrut
		  ,	cli.clcodigo


   INSERT INTO #TEMPORAL
   SELECT 'fecha_contable'   = @fecha
   ,      'status'           = 'A'
   ,      'cod_producto'     = 'MD49'
   ,      'T_producto'       = 'MDIR'
   ,      'rut'              = CONVERT( CHAR(9), Enc_CaRutCliente )
   ,      'dig'              = ISNULL( Cli_ClDv , '0' )
   ,      'costo'            = 0           -- Antes era 5 !!!
   ,      'n_operacion'      = CONVERT( VARCHAR(20), rtrim( convert( varchar(20), Enc_CaNumContrato ) )  
                                                   + rtrim( CONVERT( varchar(20), Det_CaNumEstructura  ) ) )
   ,      'fecha_inic'       = CONVERT(CHAR(8), Enc_caFechaContrato ,112)
   ,      'fecha_vcto'       = CONVERT(Char(8), Det_CaFechaVctoAux, 112)
   ,      'cod_inter_mda'    = Det_CaCodMon1 
   ,      's_mto_cap_ori'    = '+' 
   ,      'mto_cap_origen'   = round( Det_CaMontoMon1 * 100.0 , 0 ) 
   ,      's_mto_cap_loc'    = '+' 
   ,      'mto_cap_local'    = round( Det_CaMontoMon2 * 100.0 , 0 ) 
   ,      's_reaj_mda_loc'   = '+' 
   ,      'mto_reaj_loc'     = 0               
   ,      's_int_mda_loc'    = SPACE(1)
   ,      'mto_int_mda_loc'  = 0 
   ,      'tasa_f_v'         = 'F'
   ,      'spread'           = 0
   ,      'valor_en_pesos'   = 0              
   ,      'nomin_en_pesos'   = 0               
   ,      't_cartera'        = rtrim( ISNULL((SELECT rtrim( ltrim( ccn_codigo_nuevo ) ) FROM BacParamSuda.dbo.TBL_CODIFICACION_CARTERA_NORMATIVA with (nolock) WHERE ccn_codigo_cartera = Enc_caCarNormativa),4) )
   ,      'mto_op_compra'    = 0 -- CASE WHEN cadiferen > 0 THEN cadiferen ELSE 0 END OJO se podría usar !!! Por hacer:  Poner Art 84 !!!
   ,      'registros' 	     = @max
   ,      'indicador'        = CASE WHEN Det_camodalidad = 'C'      THEN 'A'       ELSE 'P' END
   ,      'colocacion'       = 0 
   ,      'destino'          = CASE WHEN Enc_caRutCliente  = 97029000 THEN	211
                                    WHEN Enc_caRutCliente  = 97030000 THEN	212
                                    ELSE									221
								END
   ,      'TasaInteres'      = 0.0
   ,      'MontoIniBFT'      = 0.0
   ,      'n_Tipo_Contrato'  = '3'                                               -- Asignado por NEOSOFT para SIGIR
   ,      'n_Tipo_Operacion' = case when Det_CaCVOpc = 'C' and Det_CaCallPut = 'Call' then '1' 
                                    when Det_CaCVOpc = 'C' and Det_CaCallPut = 'Put'  then '2'
                                    when Det_CaCVOpc = 'V' and Det_CaCallPut = 'Call' then '3'
                                    when Det_CaCVOpc = 'V' and Det_CaCallPut = 'Put'  then '4' end
   ,      'n_Operacion_Original' = convert( varchar(20), Enc_CaNumContrato )
   ,      'Monto_Mora_4'         = case when CaPosDeltaSpot < 0 then '-' else '0' end 
                                 + case when CaPosDeltaSpot = 0 then replicate('0', 17)
                                   else 
                                     replicate( '0', 17 - len ( convert( varchar(17), round( abs(CaPosDeltaSpot) * 100 , 0 ) ) )  ) 
                                     + rtrim( convert( varchar(17), abs( CaPosDeltaSpot * 100 ) ) ) 
                                   end
   ,      'Monto_Mora_5'         = case when CaRieVega < 0 then '-' else '0' end 
                                 + case when CaRieVega = 0 then replicate('0', 17)
                                   else
                                       replicate( '0', 17 - len ( convert( varchar(17), round( abs( CaRieVega ) * 100 , 0 ) ) )  ) 
                                     + rtrim( convert( varchar(17), abs( CaRieVega * 100 ) ) )  
                                   end
   ,      'Monto_Mora_6'         = case when CaRieGammaSpot < 0 then '-' else '0' end 
                                 + Case when CaRieGammaSpot = 0 then replicate('0', 17)
                                   else
                                       replicate( '0', 17 - len ( convert( varchar(17), round( abs( CaRieGammaSpot ) * 100 , 0 ) ) )  ) 
                                 + rtrim( convert( varchar(17), abs( CaRieGammaSpot * 100 ) ) )  
                                   end

   ,		'c_riesgo'				= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais(clrut, clcodigo, 'OPC')
   
   ,	  'fechaPrimerVencimiento'     = ''
   ,	  'tipoOtorgamiento'		   = ''
   ,	  'precioVivienda'			   = 0
   ,	  'tipoOperaconRenegociada'    = ''
   ,      'montoPiePagado'			   = 0
   ,      'seguroRemate'			   = ''
   ,      'diasMorosidad'			   = 0
   FROM		#TEMPORAL_DETALLE_OTROS_FWD
   where (round( Det_CaMontoMon1 * 100.0 , 0 )>0	or 	round(Det_CaMontoMon2 * 100.0 , 0 )>0)	--20191024.RCHS.Excluir operaciones que estén informando valores negarivos
              
	SELECT	fecha_contable			-->	01
		,	status
		,   cod_producto
		,   T_producto
		,   rut
		,   dig
		,   costo
		,   n_operacion
		,   fecha_inic
		, fecha_vcto				-->	10
		,   cod_inter_mda
		,   s_mto_cap_ori
		,   mto_cap_origen
		,   s_mto_cap_loc
		,   mto_cap_local
		,   s_reaj_mda_loc
		,   mto_reaj_loc
		,   s_int_mda_loc
		,   mto_int_mda_loc
		,   tasa_f_v				--> 20
		,   spread
		,   valor_en_pesos
		,   nomin_en_pesos
		,   t_cartera
		,   mto_op_compra
		,   registros
		,   indicador
		,   colocacion
		,   destino
		,   TasaInteres				-->	30
		,   MontoIniBFT
		,   n_Tipo_Contrato
		,   n_Tipo_Operacion
		,   n_Operacion_Original
		,   Monto_Mora_4
		,   Monto_Mora_5
		,   Monto_Mora_6
		,	c_riesgo				-->	38
----- 		
        ,	fechaPrimerVencimiento   --> 39
        ,	tipoOtorgamiento		 --> 40
        ,	precioVivienda			 --> 41
        ,	tipoOperaconRenegociada	 --> 42
        ,   montoPiePagado			 --> 43
        ,   seguroRemate			 --> 44
        ,   diasMorosidad			 --> 45
	FROM	#TEMPORAL

END

GO
