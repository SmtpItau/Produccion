USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_OPERACIONES_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_OPERACIONES_SWAP]
AS
BEGIN

   /****************************************************************************************
   * TAG MPNG20060307                                                                     * 
   * El dia de vencimiento del SWAP No se informa nada en las interfaces                  *
   *
   * TAG MPNG20071214
   * Se cambia definición del flujo vigente: Estado_Flujo = 1
   * **************************************************************************************/

   SET NOCOUNT ON
-- Swap: Guardar Como
   DECLARE @iFound      INTEGER
   SELECT  @iFound      = -1
   SELECT  @iFound      = 0
   FROM    BacParamSuda..VALOR_MONEDA_CONTABLE , SWAPGENERAL
   WHERE   Fecha        = fechaproc
   AND     Tipo_Cambio <> 0

   IF @iFound = -1
   BEGIN
      RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
      RETURN
   END

   DECLARE @Max    INTEGER
   DECLARE @Fecha  DATETIME

   CREATE TABLE #NEOSOFT
   (   codigo_pais		VARCHAR(3)
   ,   fecha_contable		DATETIME
   ,   fecha_interfaz		DATETIME
   ,   ident_interfaz 		VARCHAR(14)
   ,   cod_empresa		VARCHAR(3)
   ,   cod_sucursal		VARCHAR(3)
   ,   status_contrato		VARCHAR(3)
   ,   status_crediticio	VARCHAR(1)
   ,   fam_producto		CHAR(4)
   ,   T_producto		CHAR(4)
   ,   C_interno		VARCHAR(16)
   ,   Clase_Producto 		VARCHAR(1)
   ,   Tipologia_producto       VARCHAR(1)
   ,   F_operacion              DATETIME
   ,   F_devengamiento          DATETIME
   ,   rut			VARCHAR(12)
   ,   dig                      VARCHAR(1)
   ,   costo			VARCHAR(10)
   ,   n_operacion		CHAR(20)
   ,   fecha_inic		DATETIME
   ,   fecha_vcto		DATETIME
   ,   fecha_renovacion         VARCHAR(8)
   ,   indicador		VARCHAR(1)
   ,   cod_inter_mda		VARCHAR(3)
   ,   s_mto_cap_ori		CHAR(1)
   ,   mto_cap_origen		NUMERIC(19,4)
   ,   s_mto_cap_loc		CHAR(1)
   ,   mto_cap_local		NUMERIC(19,4)
   ,   mto_linea_credito	NUMERIC(19,4)
   ,   s_reaj_mda_loc		CHAR(1)
   ,   mto_reaj_loc		NUMERIC(19,4)
   ,   s_int_mda_orig		CHAR(1)
   ,   mto_int_mda_orig	        NUMERIC(19,4)
   ,   s_int_mda_loc		CHAR(1)
   ,   mto_int_mda_loc		NUMERIC(19,4)
   ,   tasa_f_v		        CHAR(1)
   ,   tasa_base                CHAR(4)
   ,   tasa_interes		NUMERIC(16,8)
   ,   tasa_penalidad		NUMERIC(16,8)
   ,   calc_interes             VARCHAR(1)
   ,   c_operacion		NUMERIC(16,8)
   ,   c_fondo_oper		VARCHAR(5)
   ,   c_penalidad		VARCHAR(4)
   ,   spread			NUMERIC(16,8)
   ,   spread_pool		NUMERIC(16,8)
   ,   spread_tasa_penalidad	NUMERIC(16,8)
   ,   indicador_p_a            VARCHAR(1)
   ,   s_mto_vencido            VARCHAR(1)
   ,   d_vencidas   		NUMERIC(18,2)
   ,   t_tasa			NUMERIC(3)
   ,   p_transfronterizo	NUMERIC(2)
   ,   t_oper_transfronterizo   NUMERIC(1)
   ,   s_comision               VARCHAR(1)
   ,   mto_comision   		NUMERIC(18,2)
   ,   fec_otorgamiento         VARCHAR(8)
   ,   fec_cartera	        VARCHAR(8)
   ,   fec_mora		        VARCHAR(8)
   ,   fec_cartera_castigada    VARCHAR(8)
   ,   n_operacion_orig	        VARCHAR(20)
   ,   n_cuotas		        NUMERIC(4)
   ,   n_cuotas_mora		NUMERIC(4)
   ,   n_cuotas_total		NUMERIC(4)
   ,   destino			NUMERIC(3)
   ,   f_suspension		VARCHAR(8)
   ,   f_u_pago		        VARCHAR(8)
   ,   indicador_renovacion     VARCHAR(1)
   ,   f_renovacion             VARCHAR(8)
   ,   f_cambio	                VARCHAR(8)
   ,   f_ultimo_cambio		VARCHAR(8)
   ,   nomin_en_pesos		NUMERIC(18,2)
   ,   s_mda_local		NUMERIC(18,2)
   ,   m_mora1			NUMERIC(18,2)
   ,   m_mora2			NUMERIC(18,2)
   ,   m_mora3			NUMERIC(18,2)
   ,   colocacion		NUMERIC(18,2)
   ,   l_credito                NUMERIC(18,2)
   ,   p_minimo		        NUMERIC(18,2)
   ,   i_cobranza		VARCHAR(1)
   ,   v_mercado		NUMERIC(18,2)
   ,   v_pesos			NUMERIC(18,2)
   ,   t_cartera		CHAR(10)
   ,   n_renegociacion		NUMERIC(3)
   ,   p_cuotas		 NUMERIC(4)
   ,   m_pagado		        NUMERIC(18,2)
   ,   t_contrato		VARCHAR(1)
   ,   t_operacion              VARCHAR(1)
   ,   t_entrega  		VARCHAR(1)
   ,   mto_op_compra		NUMERIC(19,4)
   ,   i_instrumento		VARCHAR(5)
   ,   i_emisor		        VARCHAR(15)
   ,   s_instrumento		VARCHAR(4)
   ,   s_registrada		VARCHAR(4)
   ,   c_riesgo				VARCHAR(3)	-->	VARCHAR(4)
   ,   registros		NUMERIC(5)
   ,   tipoflujo		NUMERIC(5)
   ,   numero_armado		CHAR(20)
   ,   numeroflujo		NUMERIC(5)
   ,   dias_flujo		NUMERIC(5)
   ,   dias_corr		NUMERIC(5)
   )

   SELECT @Fecha  = fechaproc
   FROM   SWAPGENERAL

   SELECT vmcodigo ,vmvalor INTO #VALMON FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @Fecha
                     INSERT INTO #VALMON VALUES(999, 1.0)
                     INSERT INTO #VALMON SELECT 13, vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @Fecha

   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo
   ,      vmvalor
   INTO   #VALOR_TC_CONTABLE
   FROM   #VALMON
   WHERE  vmcodigo IN(994,995,998,997,999)

   INSERT INTO #VALOR_TC_CONTABLE
   SELECT CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      Tipo_Cambio
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE   
   WHERE  Fecha         = @Fecha
   AND    Codigo_Moneda NOT IN(13,995,998,997,999)


   -- DOCUMENTAR COMO ESTANDAR
   -- GENERAR UNA LISTA DE LAS OPERACIONES QUE DEBEN SER INCLUIDAS EN LA INTERFAZ
   -- Se ponen todos los conceptos que nunca serán diferentes por          
   -- Pata para luego agregar los datos que corresponden a cada pata.  
   SELECT DISTINCT 
          'OpNumero_Operacion' = C.Numero_Operacion
   ,      'OpRut_cliente'      = C.Rut_cliente
   ,      'OpCodigo_cliente'   = C.Codigo_cliente
   ,      'OpFecha_Cierre'     = C.Fecha_Cierre
   ,      'OpT_cartera'        = ISNULL((SELECT top 1 ccn_codigo_nuevo FROM BacParamSuda..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = C.car_Cartera_Normativa),4)
   INTO   #Operaciones
   FROM   CARTERA              C 
   WHERE  ( ( Fecha_Termino        > @Fecha and tipo_swap <> 3 ) or ( Tipo_swap = 3 and fechaliquidacion > @Fecha ) )
          and Compra_Saldo + Compra_Amortiza + Compra_Flujo_Adicional > 0 -- MAP 20081115 Corrige problema NEOSOFT
          and estado_Flujo = 1                                            -- MAP 20081115 Corrige problema NEOSOFT
          and Estado <> 'N'                                               -- MAP 20081115 Corrige problema NEOSOFT
          and Estado <> 'C'

 
   INSERT INTO #NEOSOFT
   SELECT DISTINCT
       'codigo_pais'           = 'CL'
   ,   'fecha_contable'	       = @Fecha
   ,   'fecha_interfaz'	       = GETDATE()
   ,   'ident_interfaz'	       = 'OP52'
   ,   'cod_empresa'           = '001'
   ,   'cod_sucursal'          = '1'
   ,   'status_contrato'       = 'A'
   ,   'status_crediticio'     = '1'
   ,   'fam_producto'	       = 'MDIR'
   ,   'T_producto'	       = 'MDIR'
   ,   'C_interno'	       = 'MD02'
   ,   'Clase_Producto'        = ''
   ,   'Tipologia_producto'    = 'M'
   ,   'F_operacion'	       = OpFecha_Cierre
   ,   'F_devengamiento'       = @Fecha
   ,   'rut'		       = CONVERT(CHAR(9),clrut)
   ,   'dig'                   = CONVERT(CHAR(1),cldv)
   ,   'costo'		       = SPACE(1)
   ,   'n_operacion'           = OpNumero_Operacion
   ,   'fecha_inic'            = OpFecha_Cierre  
   ,   'fecha_vcto'	       = (SELECT MAX( case when c1.Tipo_swap <> 3 then Fecha_Termino else FechaLiquidacion end) FROM CARTERA C1 WHERE C1.Numero_operacion = OpNumero_Operacion)
   ,   'fecha_renovacion'      = SPACE(8)
   ,   'indicador'	       = 'V'
   ,   'cod_inter_mda'	       = ''
   ,   's_mto_cap_ori'	       = '+'
   ,   'mto_cap_origen'	       = 0
   ,   's_mto_cap_loc'	       = '+'
   ,   'mto_cap_local'	       = 0
   ,   'mto_linea_credito'    = 0
   , 's_reaj_mda_loc'	       = '+'
   ,   'mto_reaj_loc'	       = 0
   , 's_int_mda_orig'	       = '+'
   ,   'mto_int_mda_orig'      = 0
   ,   's_int_mda_loc'	       = '+'
   ,   'mto_int_mda_loc'       = 0
   ,   'tasa_f_v'	       = 'F'
   ,   'tasa_base'             = ''
   ,   'tasa_interes'	       = 0
   ,   'tasa_penalidad'	       = 0
   ,   'calc_interes'	       = 0
   ,   'C_operacion'	       = 0
   ,   'c_fondo_oper'	       = SPACE(5)
   ,   'c_penalidad'	       = SPACE(4)
   ,   'spread'		       = 0
   ,   'spread_pool'	       = 0
   ,   'spread_tasa_penalidad' = 0
   ,   'indicador_p_a'         = 'A'
   ,   's_mto_vencido'         = '+'
   ,   'd_vencidas'   	       = 0
   ,   't_tasa'		       = '101'
   ,   'p_transfronterizo'     = 0
   ,   't_oper_transfronterizo'= 0
   ,   's_comision'            = '+'
   ,   'mto_comision'          = 0
   ,   'fec_otorgamiento'      = SPACE(8)
   ,   'fec_cartera'	       = SPACE(8)
   ,   'fec_mora'              = SPACE(8)
   ,   'fec_cartera_castigada' = SPACE(8)
   ,   'n_operacion_orig'      = OpNumero_Operacion
   ,   'n_cuotas'	       = 1 --> Aca
   ,   'n_cuotas_mora'	       = 0 --> Aca
   ,   'n_cuotas_total'	       = 0
   ,   'destino'	       = CASE WHEN rcrut 	 = Oprut_cliente THEN 211
                                      WHEN Oprut_cliente = 97030000      THEN 212
				      ELSE				      221
				 END
   ,   'f_suspension'	       = SPACE(8)
   ,   'f_u_pago'	       = SPACE(8)
   ,   'indicador_renovacion'  = SPACE(1)
   ,   'f_renovacion'	       = SPACE(8)
   ,   'f_cambio'	       = SPACE(8)
   ,   'f_ultimo_cambio'       = SPACE(8)
   ,   'nomin_en_pesos'	       = 0
   ,   's_mda_local'	       = 0
   ,   'm_mora1'	       = 0
   ,   'm_mora2'	       = 0
   ,   'm_mora3'	       = 0
   ,   'colocacion'	       = 0
   ,   'l_credito'             = 0
   ,   'p_minimo'	       = 0
   ,   'i_cobranza'	       = SPACE(1)
   ,   'v_mercado'	       = 0
   ,   'v_pesos'	       = 0
   ,   't_cartera'	       = OpT_cartera 
   ,   'n_renegociacion'       = 000
   ,   'p_cuotas'	       = 0
   ,   'm_pagado'	       = 0
   ,   't_contrato'            = '1'
   ,   't_operacion'	       = SPACE(1) 
   ,   't_entrega'	       = SPACE(1) 
   ,   'mto_op_compra'	       = 0	
   ,   'i_instrumento'	       = SPACE(5) 
   ,   'i_emisor'	       = SPACE(15) 
   ,   's_instrumento'	       = SPACE(4) 
   ,   's_registrada'	       = SPACE(4) 

--		,	'c_riesgo'				= SPACE(3) 
		,	'c_riesgo'				= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( clrut, clcodigo, 'PCS' )

   ,   'registros'	       = 0
   ,   'tipoflujo'	       = 0 -- Tipo_Flujo   -- Por la nueva estrategia no deberia ser necesario retener esto !!
   ,   'numero_armado'	       = CONVERT(VARCHAR(10),OpNumero_Operacion)
   ,   'numeroflujo'	       = 0 -- Numero_Flujo -- Por la nueva estrategia no deberia ser necesario retener esto !!
   ,   'dias_flujo'	       = 0 -- <-- Poner el del concepto del flujo vigente de compra y si no hay el de venta, más abajo
   ,   'dias_corr'	       = 0 -- <-- Poner el del concepto del flujo vigente de compra y si no hay el de venta, más abajo
   FROM  #Operaciones
         LEFT JOIN BacParamSuda..CLIENTE  ON Oprut_cliente = clrut  AND Opcodigo_cliente = clcodigo	
   ,	 VIEW_ENTIDAD  

   -- SELECICONAR FLUJOS VIENTES DE LA CARTERA
   -- Seleccion de flujos vigentes de la cartera
   SELECT * 
   INTO   #FluCarVig -- select * from #FluCarVig
   FROM   CARTERA As C2 
			
			INNER JOIN
			(	SELECT	CONTRATO		= NUMERO_OPERACION
					,	TIPO			= TIPO_FLUJO
					,	FLUJO			= MIN( NUMERO_FLUJO )
				FROM	CARTERA			WITH(NOLOCK)
				WHERE (	Estado_Flujo	= 1	)   
				AND     Fecha_Termino	> @Fecha      
				AND     Estado			<> 'N'
				AND     Estado			<> 'C'
				GROUP 
				BY		NUMERO_OPERACION
					,	TIPO_FLUJO
			)	GRP		ON	GRP.CONTRATO	= C2.NUMERO_OPERACION
						AND	GRP.TIPO		= C2.TIPO_FLUJO
						AND	GRP.FLUJO		= C2.NUMERO_FLUJO


   WHERE ( /* Cambia definición de Flujo Vigente 
          (@Fecha >= C2.fecha_cierre       AND C2.numero_flujo = 1                    AND @Fecha          <= C2.fecha_vence_flujo)
       OR (@Fecha >  C2.fecha_Inicio_flujo AND @Fecha         <= C2.fecha_vence_flujo AND C2.numero_flujo <> 1)
           */
           Estado_Flujo = 1
         )   
   AND     Fecha_Termino > @Fecha      
   AND     Estado <> 'N'
   AND     Estado <> 'C'

   -- CARGA DE INFORMACION 
   -- Si no hay flujo de compra (tipo1) , poner valores de flujo de venta (tipo2)
   -- según la definición stándar

   UPDATE #NEOSOFT
   SET    n_cuotas      =	(	SELECT	COUNT(1) 
								FROM	CARTERA 
								WHERE	numero_operacion	= n_operacion 
								AND		fecha_vence_flujo	> @Fecha 
								AND		tipo_flujo			= 1
							)

   ,      n_cuotas_mora =	(	SELECT	COUNT(1) 
								FROM	CARTERA 
								WHERE	numero_operacion	= n_operacion 
								AND		fecha_vence_flujo	> @Fecha 
								AND		tipo_flujo			= 2
							) 
   ,      dias_flujo    = ISNULL((SELECT DATEDIFF(DAY,Fecha_Inicio_Flujo, Fecha_Vence_Flujo) FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                        , ISNULL((SELECT DATEDIFF(DAY,Fecha_Inicio_Flujo, Fecha_Vence_Flujo) FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))
   ,      dias_corr     = ISNULL((SELECT DATEDIFF(DAY,Fecha_Inicio_Flujo, @Fecha)      FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                        , ISNULL((SELECT DATEDIFF(DAY,Fecha_Inicio_Flujo, @Fecha)            FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))


   UPDATE #NEOSOFT
   SET    cod_inter_mda  = ISNULL((SELECT Compra_Moneda  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                         , ISNULL((SELECT Venta_Moneda   FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))             
   ,	  mto_cap_origen = ISNULL((SELECT Compra_Capital FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                         , ISNULL((SELECT Venta_Capital  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))             
   ,	  mto_cap_local	 = ROUND(ISNULL((SELECT Compra_Capital FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                                      * (SELECT vmvalor        FROM #VALOR_TC_CONTABLE /*#VALMON*/ WHERE vmcodigo = (SELECT Compra_Moneda FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1))
                                ,ISNULL((SELECT Venta_Capital  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2) 
                                      * (SELECT vmvalor        FROM #VALOR_TC_CONTABLE /*#VALMON*/ WHERE vmcodigo = (SELECT Venta_Moneda  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2)),0)),0)
   ,	  mto_reaj_loc   = 0
   ,	  mto_int_mda_orig= 0.0 
   ,	  mto_int_mda_loc= 0.0 
   ,	  nomin_en_pesos = 0.0             
   ,	  mto_op_compra	 = 0.0             
   ,	  colocacion	 = 0.0        
   ,	  tasa_base      = (SELECT B.Base        FROM BASE B WHERE B.codigo = ISNULL((SELECT Compra_base FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                                                                            , ISNULL((SELECT Venta_base  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0)))

   ,	  tasa_interes	 = ISNULL((SELECT CASE WHEN Compra_Valor_Tasa < 0 THEN 0.0 ELSE Compra_Valor_Tasa END FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1),0)

   ,	  calc_interes   = (SELECT B.Cod_Neosoft FROM BASE B WHERE B.codigo = ISNULL((SELECT Compra_base FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                                                                            , ISNULL((SELECT Venta_base  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0)))
   ,	  spread         = ISNULL((SELECT Compra_Spread FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                         , ISNULL((SELECT Venta_Spread  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))
   ,	  n_cuotas_total = ISNULL((SELECT COUNT(1)      FROM CARTERA    WHERE fecha_vence_flujo > @Fecha AND n_operacion = numero_operacion),0)

   ,      v_pesos        = 0.0 -- UPDATE PENDIENTE: proximo comando con <-- mto_cap_local -- ROUND(compra_capital * (SELECT vmvalor FROM #VALMON WHERE vmcodigo = compra_moneda), 0)

   ,	  p_cuotas	 = ISNULL((SELECT dias FROM BacParamSuda..PERIODO_AMORTIZACION WHERE tabla = 1044 and sistema = 'PCS' and codigo = ISNULL((SELECT Compra_CodAmo_interes FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                     , ISNULL((SELECT Venta_CodAmo_interes  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))), 0.0)

	UPDATE #NEOSOFT SET spread = 0.0 WHERE spread < 0                                                                                                                                     
                                                                                                                                         
   UPDATE #NEOSOFT
   SET    nomin_en_pesos  = mto_cap_local
   ,	  mto_op_compra	  = mto_cap_origen
   ,	  v_pesos      = mto_cap_local -- ROUND(compra_capital * (SELECT vmvalor FROM #VALMON WHERE vmcodigo = compra_moneda), 0)
   ,	  tasa_penalidad  = ISNULL((SELECT CASE WHEN Venta_Valor_Tasa < 0 THEN 0.0 ELSE Venta_Valor_Tasa END FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0)
   ,	  dias_corr       = CASE WHEN dias_corr < 0 THEN 0.0 ELSE dias_corr END 

   SELECT @max            = COUNT(1) 
   FROM	  #NEOSOFT

   UPDATE #NEOSOFT
   SET    registros       = @max
   ,      mto_op_compra   = ISNULL((SELECT ROUND(MAX(Monto),0) FROM BacTraderSuda..MARGEN_ARTICULO84 WHERE Numdocu = n_operacion),0) 

   -- No se trasmite Art 84 para Swap 20050825, C. Mascareño 
   -- Si se trasmite Art 84 para Swap 20050825, A. Bay

   	select	codigo_pais						-->		01
		,	fecha_contable
		,	fecha_interfaz
		,	ident_interfaz
		,	cod_empresa
		,	cod_sucursal
		,	status_contrato
		,	status_crediticio
		,	fam_producto
		,	T_producto						-->		10
		,	C_interno
		,	Clase_Producto
		,	Tipologia_producto
		,	F_operacion
		,	F_devengamiento
		,	rut
		,	dig
		,	costo
		,	n_operacion
		,	fecha_inic						-->		20
		,	fecha_vcto
		,	fecha_renovacion
		,	indicador
		,	cod_inter_mda
		,	s_mto_cap_ori
		,	mto_cap_origen
		,	s_mto_cap_loc
		,	mto_cap_local
		,	mto_linea_credito
		,	s_reaj_mda_loc					-->		30
		,	mto_reaj_loc
		,	s_int_mda_orig
		,	mto_int_mda_orig
		,	s_int_mda_loc
		,	mto_int_mda_loc
		,	tasa_f_v
		,	tasa_base
		,	tasa_interes
		,	tasa_penalidad
		,	calc_interes					-->		40
		,	c_operacion
		,	c_fondo_oper
		,	c_penalidad
		,	spread
		,	spread_pool
		,	spread_tasa_penalidad
		,	indicador_p_a
		,	s_mto_vencido
		,	d_vencidas
		,	t_tasa							-->		50
		,	p_transfronterizo
		,	t_oper_transfronterizo
		,	s_comision
		,	mto_comision
		,	fec_otorgamiento
		,	fec_cartera
		,	fec_mora
		,	fec_cartera_castigada
		,	n_operacion_orig
		,	n_cuotas						-->		60
		,	n_cuotas_mora
		,	n_cuotas_total
		,	destino
		,	f_suspension
		,	f_u_pago
		,	indicador_renovacion
		,	f_renovacion
		,	f_cambio
		,	f_ultimo_cambio
		,	nomin_en_pesos					-->		70
		,	s_mda_local
		,	m_mora1
		,	m_mora2
		,	m_mora3
		,	colocacion
		,	l_credito
		,	p_minimo
		,	i_cobranza
		,	v_mercado
		,	v_pesos							-->		80
		,	t_cartera
		,	n_renegociacion
		,	p_cuotas
		,	m_pagado
		,	t_contrato
		,	t_operacion
		,	t_entrega
		,	mto_op_compra
		,	i_instrumento
		,	i_emisor						-->		90
		,	s_instrumento
		,	s_registrada
		,	c_riesgo						-->		93	(En mantencion)
		,	registros						-->		94	(...)
		,	tipoflujo
		,	numero_armado
		,	numeroflujo
		,	dias_flujo
		,	dias_corr						-->		99
	from	#NEOSOFT 
	order
	by		n_operacion 

   SET NOCOUNT OFF

END
GO
