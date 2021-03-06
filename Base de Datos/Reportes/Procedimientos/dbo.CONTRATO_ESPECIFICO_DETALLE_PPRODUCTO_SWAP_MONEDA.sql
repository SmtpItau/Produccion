USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_ESPECIFICO_DETALLE_PPRODUCTO_SWAP_MONEDA]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--CONTRATO_ESPECIFICO_DETALLE_PPRODUCTO_SWAP_MONEDA 4019,'20111004',77771980,1,8501318,8501318,8346589,8346589

CREATE PROCEDURE [dbo].[CONTRATO_ESPECIFICO_DETALLE_PPRODUCTO_SWAP_MONEDA]  
   (   
	     @numoper   NUMERIC (09)  
	    ,@fecha				AS CHAR(8)
 		,@RUT_CLIENTE		AS NUMERIC(11)  
	    ,@COD_CLIENTE		AS NUMERIC(10)  
	    ,@RUT_APODERADO1	AS NUMERIC(11) = 0  
	    ,@RUT_APODERADO2	AS NUMERIC(11) = 0  
	    ,@RUT_APODERADOB1	AS NUMERIC(11) = 0  
	    ,@RUT_APODERADOB2	AS NUMERIC(11) = 0   
   )  
AS  
BEGIN  
   SET NOCOUNT ON  
  
   DECLARE @SwDevengo  NUMERIC(01)  
   DECLARE @fechaproc  DATETIME  
  
   SELECT  @SwDevengo = devengo   
         , @fechaproc = fechaproc  
   FROM    Bacswapsuda..SWAPGENERAL  


   select 'FECHA_CONTRATO'			= (SELECT CONVERT(CHAR(2), @fecha	, 103) + ' de '
										+ case when datepart(month,@fecha	) = 1 THEN 'Enero'
										 when datepart(month,@fecha	) = 2 THEN 'Febrero'
										  when datepart(month,@fecha	) = 3 THEN 'Marzo'
										   when datepart(month,@fecha	) = 4 THEN 'Abril'
										    when datepart(month,@fecha	) = 5 THEN 'Mayo'
										     when datepart(month,@fecha	) = 6 THEN 'Junio'
										      when datepart(month,@fecha	) = 7 THEN 'Julio'
										       when datepart(month,@fecha	) = 8 THEN 'Agosto'
										        when datepart(month,@fecha	) = 9 THEN 'Septiembre'
										         when datepart(month,@fecha	) = 10 THEN 'Octubre'
										          when datepart(month,@fecha	) = 11 THEN 'Noviembre'
										           when datepart(month,@fecha	) = 12 THEN 'Diciembre'
										           end + ' de '
										           + ltrim(rtrim(datepart(year,@fecha	))))
	,	'BANCO' = A.Nombre
	,	'RUT' = (SELECT distinct convert(varchar(20),Clrut)+'-'+Cldv From Bacparamsuda..cliente where A.rut = clrut)
	,   'RUT_CLI' = (SELECT distinct convert(varchar(20),Clrut)+'-'+Cldv From Bacparamsuda..cliente where clrut=@rut_cliente)
	,	'CLIENTE'				= ''--CLNOMBRE 
	,	'DIRECCION_CLI'				= ''--CLI.CLDIRECC  
	,	'FONO_CLI'					= ''--CLI.CLFONO
	,	'FAX_CLI'					= ''--CLI.CLFAX
	,	'COMUNA'						= ''--COMUNA.NOMBRE  
	,	'CIUDAD'						= ''--CIUDAD.NOMBRE  
	,	'APODERADO_CLIENTE_1'		= ''--APOCLI.APNOMBRE  
	,   'RUT_APODERADO_CLIENTE_1'	= ''--APOCLI.RUT_APODERADO  
	,	'APODERADO_CLIENTE_2'  = ''--APOCLI2.APNOMBRE  
	,   'RUT_APODERADO_CLIENTE_2' = ''--APOCLI2.RUT_APODERADO  
	,   'APODERADO_BANCO_1'   =   ''--APOBAN.APNOMBRE  
	,   'RUT_APODERADO_BANCO_1'  = ''--APOBAN.RUT_APODERADO  
	,   'APODERADO_BANCO_2'   = ''--APOBAN2.APNOMBRE  
	,   'RUT_APODERADO_BANCO_2'  = ''--APOBAN2.RUT_APODERADO 
	,   'DIRECCION_BANCO'   = A.DIRECCION  
	,	'TELEFONO_BANCO'	= A.TELEFONO
	,	'FAX_BANCO'				=	A.FAX 
	,	'Fecha_inicio'		 = fecha_inicio
	,	'Fecha_termino'		 = fecha_termino
	,   'Tipo_operacion'     = Tipo_operacion  
   ,    'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END  
   ,    'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END  
   ,    'Modalidad'          = ISNULL(CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END,' ')  
   ,    'fechainicioflujo'   = CONVERT(CHAR(10),Fecha_inicio_flujo,103)  
   ,    'fechavenceflujo'    = CONVERT(CHAR(10),Fecha_vence_flujo,103)  
   ,    'dias'               = PlazoFlujo  
   ,    'MontoCompra'        = compra_valor_tasa + compra_spread  
   ,    'MontoVenta'         = venta_valor_tasa  + venta_spread  
   ,    'nombretasacompra'   = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = compra_codigo_tasa AND tbcateg = 1042),' ')  
   ,    'nombretasaventa'    = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = venta_codigo_tasa  AND tbcateg = 1042),' ')  
   ,    'pagamosdoc'         = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = pagamos_documento),' ')  
   ,    'recibimosdoc'       = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = recibimos_documento),' ')  
   ,    'numero_flujo'       = numero_flujo  
   ,    'compra_capital'     = ISNULL(Compra_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  compra_flujo_adicional ELSE 0 END),0)  
   ,    'compra_amortiza'    = compra_amortiza  
   ,    'compra_saldo'       = compra_saldo  
   ,    'compra_interes'     = compra_interes  
   ,    'compra_spread'      = compra_spread  
   ,    'venta_capital'      = ISNULL(Venta_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  Venta_flujo_adicional ELSE 0 END),0)  
   ,    'venta_amortiza'     = venta_amortiza  
   ,    'venta_saldo'        = venta_saldo  
   ,    'venta_interes'      = venta_interes  
   ,    'venta_spread'       = venta_spread  
   ,    'pagamos_moneda'     = pagamos_moneda  
   ,    'recibimos_moneda'   = recibimos_moneda  
   ,    'tipo_flujo'         = tipo_flujo  
   ,    'compra_moneda'      = compra_moneda  
   ,    'venta_moneda'       = venta_moneda  
   ,    'compra_capital1'    = compra_capital  
   ,    'venta_capital1'     = venta_capital  
   ,    'nemo_compra_moneda' = isnull((select MNNEMO from BACSWAPSUDA..view_moneda where compra_moneda=MNCODMON),'')  
   ,    'nemo_venta_moneda'  = isnull((select MNNEMO from BACSWAPSUDA..view_moneda where venta_moneda =MNCODMON) ,'')  
   ,    'VALUTA'        = isnull((select Diasvalor from BACSWAPSUDA..VIEW_FORMA_DE_PAGO where pagamos_documento=Codigo),0)  
   ,    'EstadoFlujo'        = estado_flujo     
   ,    'Amortiza'           = Case when (select TOP 1 IntercPrinc from BACSWAPSUDA..cartera A where A.numero_operacion = @numoper  and Tipo_Swap=2 and Tipo_flujo=1 and (fecha_inicio_flujo=fecha_vence_flujo)  )<>0    --numero_flujo=1  
             then 'Intercambio Nocionales al Inicio. '  else ' '   
                                    end  
   ,    'FechaFijacionTasa'     = CONVERT(CHAR(10),fecha_fijacion_tasa,103)   
   ,    'FechaLiquidacion'      = CONVERT(CHAR(10),FechaLiquidacion,103)   
   ,    'nemo_pagamos_moneda'   = isnull((select mnnemo from BACSWAPSUDA..view_moneda where MNCODMON=(CASE WHEN pagamos_moneda=998 THEN 999 ELSE pagamos_moneda END)),'')  
   ,    'nemo_recibimos_moneda' = isnull((select mnnemo from BACSWAPSUDA..view_moneda where MNCODMON=(CASE WHEN recibimos_moneda=998 THEN 999 ELSE recibimos_moneda END)) ,'')  
   ,    'TituloModComp'         = 'El Diferencial de Amortización y el Diferencial de Intereses se pagarán en: '   
   ,    'TituloModEF_1'         = 'Las Amortizaciones e Interés se pagarán en Pago Pasivo: '   
   ,    'TituloModEF_2'         = ' y se recibiran en Pago Activo: '   
   ,    'Tipo_Swap'             = CASE tipo_swap WHEN 1 THEN 'TASA'  
												 WHEN 2 THEN 'MONEDA'  
												 WHEN 3 THEN 'FRA'  
												 WHEN 4 THEN 'TASA' --> 'CAMARA'  
								  END  
   ,    'INTER_NOCIONAL'   = IntercPrinc  
   ,    'CompraGlosaBase'   = ISNULL((SELECT Glosa FROM BACSWAPSUDA..Base Base WHERE Base.codigo  = compra_base),'N/A')   
   ,    'VentaGlosaBase'    = ISNULL((SELECT Glosa FROM BACSWAPSUDA..Base Base WHERE Base.codigo  = Venta_base),'N/A') 
   ,    'numero_operacion' = @numoper
   ,   case when CARTERA.compra_codigo_tasa =0 then convert(varchar(14),convert(numeric(10,4),CARTERA.compra_valor_tasa)) else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                          FROM BacParamSuda..TABLA_GENERAL_DETALLE 
															  WHERE tbcodigo1 = CARTERA.compra_codigo_tasa AND tbcateg = 1042),' '))) end+ 
	                 case when CARTERA.compra_spread>0.0 then (case when CARTERA.compra_codigo_tasa =0 
					                                             then '' else ' + ' end )+convert(varchar(10),convert(numeric(10,4),CARTERA.compra_spread))+'%' else '' end as compra_codigo
	,	@fecha	as 'fecparam'	--		AS CHAR(8)
	,	@RUT_CLIENTE as 'rutparam'	--	AS NUMERIC(11)  
	,	@COD_CLIENTE	as 'codparam'	--AS NUMERIC(10)  
	,	@RUT_APODERADO1	as 'rutapo1param' --AS NUMERIC(11) = 0  
	,	@RUT_APODERADO2	as 'rutapo2param'--AS NUMERIC(11) = 0  
	,	@RUT_APODERADOB1 as 'rutapo1bparam'	--AS NUMERIC(11) = 0  
	,	@RUT_APODERADOB2 as 'rutap2bparam'	--AS NUMERIC(11) = 0     
   INTO   #TMP_CARTERA_SWAP  
   FROM   bacswapsuda..CARTERA  , Bacswapsuda..SwapGeneral A
--		 ,   (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX  
--			FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI  
--		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
--			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO1 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE) APOCLI   
--		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
--			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO2 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE) APOCLI2   
--		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
--			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB1 and aprutcli = 97023000) APOBAN --> CORPBANCA  
--		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
--			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB2 and aprutcli = 97023000) APOBAN2  --> CORPBANCA   
--		 , (SELECT COMU.NOMBRE FROM BACPARAMSUDA..COMUNA COMU   
--			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE  
--			WHERE CLRUT = @RUT_CLIENTE) COMUNA   
		 , (SELECT NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
			WHERE CLRUT = @RUT_CLIENTE) CIUDAD 
    WHERE  CARTERA.numero_operacion    = @numoper  
    ---AND    Fecha_inicio_flujo  <> Fecha_vence_flujo  
    ORDER BY tipo_flujo, numero_flujo  
  
    DECLARE @dFecha   DATETIME  
        SET @dFecha   = (SELECT MIN(Fecha_Proceso) FROM BACSWAPSUDA..CARTERARES WHERE CARTERARES.numero_operacion = @numoper)  
  
    INSERT INTO #TMP_CARTERA_SWAP  
	select 'FECHA_CONTRATO'			= (SELECT CONVERT(CHAR(2), @fecha	, 103) + ' de '
										+ case when datepart(month,@fecha	) = 1 THEN 'Enero'
										 when datepart(month,@fecha	) = 2 THEN 'Febrero'
										  when datepart(month,@fecha	) = 3 THEN 'Marzo'
										   when datepart(month,@fecha	) = 4 THEN 'Abril'
										    when datepart(month,@fecha	) = 5 THEN 'Mayo'
										     when datepart(month,@fecha	) = 6 THEN 'Junio'
										      when datepart(month,@fecha	) = 7 THEN 'Julio'
										       when datepart(month,@fecha	) = 8 THEN 'Agosto'
										        when datepart(month,@fecha	) = 9 THEN 'Septiembre'
										         when datepart(month,@fecha	) = 10 THEN 'Octubre'
										          when datepart(month,@fecha	) = 11 THEN 'Noviembre'
										           when datepart(month,@fecha	) = 12 THEN 'Diciembre'
										           end + ' de '
										           + ltrim(rtrim(datepart(year,@fecha	))))
	,	'BANCO' = A.Nombre
	,	'RUT' = (SELECT distinct convert(varchar(20),Clrut)+'-'+Cldv From Bacparamsuda..cliente where A.rut = clrut)
	,   'RUT_CLI' = @rut_cliente
	,	'CLIENTE'				= ''--CLNOMBRE 
	,	'DIRECCION_CLI'				= ''--CLI.CLDIRECC  
	,	'FONO_CLI'					= ''--CLI.CLFONO
	,	'FAX_CLI'					='' --CLI.CLFAX
	,	'COMUNA'						= ''--COMUNA.NOMBRE  
	,	'CIUDAD'						='' --CIUDAD.NOMBRE  
	,	'APODERADO_CLIENTE_1'		= ''--APOCLI.APNOMBRE  
	,	'RUT_APODERADO_CLIENTE_1'	= ''--APOCLI.RUT_APODERADO  
	,	'APODERADO_CLIENTE_2'  = ''--APOCLI2.APNOMBRE  
	, 'RUT_APODERADO_CLIENTE_2' = ''--APOCLI2.RUT_APODERADO  
	, 'APODERADO_BANCO_1'   =   ''--APOBAN.APNOMBRE  
	, 'RUT_APODERADO_BANCO_1'  = ''--APOBAN.RUT_APODERADO  
	, 'APODERADO_BANCO_2'   = ''--APOBAN2.APNOMBRE  
	, 'RUT_APODERADO_BANCO_2'  = ''--APOBAN2.RUT_APODERADO 
	,   'DIRECCION_BANCO'   = A.DIRECCION  
	,	'TELEFONO_BANCO'	= A.TELEFONO
	,	'FAX_BANCO'				=	A.FAX 
	,	'Fecha_inicio'		 = fecha_inicio
	,	'Fecha_termino'		 = fecha_termino
	,	'Tipo_operacion'     = Tipo_operacion  
    ,   'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END  
    ,   'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END  
    ,   'Modalidad'          = ISNULL(CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END,' ')  
    ,	'fechainicioflujo'   = CONVERT(CHAR(10),Fecha_inicio_flujo,103)  
    ,	'fechavenceflujo'    = CONVERT(CHAR(10),Fecha_vence_flujo,103)  
    ,	'dias'               = PlazoFlujo  
    ,   'MontoCompra'        = compra_valor_tasa + compra_spread  
    ,   'MontoVenta'         = venta_valor_tasa  + venta_spread  
    ,   'nombretasacompra'   = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = compra_codigo_tasa AND tbcateg = 1042),' ')  
    ,   'nombretasaventa'    = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = venta_codigo_tasa  AND tbcateg = 1042),' ')  
    ,   'pagamosdoc'         = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = pagamos_documento),' ')  
    ,   'recibimosdoc'       = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = recibimos_documento),' ')  
    ,   'numero_flujo'       = numero_flujo  
    ,   'compra_capital'     = ISNULL(Compra_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  compra_flujo_adicional ELSE 0 END),0)  
    ,   'compra_amortiza'    = compra_amortiza  
    ,   'compra_saldo'       = compra_saldo  
    ,   'compra_interes'     = compra_interes  
    ,   'compra_spread'      = compra_spread  
    ,   'venta_capital'      = ISNULL(Venta_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  Venta_flujo_adicional ELSE 0 END),0)  
    ,   'venta_amortiza'     = venta_amortiza  
    ,   'venta_saldo'        = venta_saldo  
    ,   'venta_interes'      = venta_interes  
    ,   'venta_spread'       = venta_spread  
    ,   'pagamos_moneda'     = pagamos_moneda  
    ,   'recibimos_moneda'   = recibimos_moneda  
    ,   'tipo_flujo'         = tipo_flujo  
    ,   'compra_moneda'      = compra_moneda  
    ,   'venta_moneda'       = venta_moneda  
    ,   'compra_capital1'     = compra_capital  
    ,   'venta_capital1'      = venta_capital  
    ,   'nemo_compra_moneda' = isnull((select mnnemo from BACSWAPSUDA..view_moneda where compra_moneda = mncodmon),'')  
    ,   'nemo_venta_moneda'  = isnull((select mnnemo from BACSWAPSUDA..view_moneda where venta_moneda  = mncodmon) ,'')  
    ,   'VALUTA'           = isnull((select Diasvalor from BACSWAPSUDA..VIEW_FORMA_DE_PAGO where pagamos_documento=Codigo),0)  
    ,   'EstadoFlujo'   = estado_flujo     
    ,   'Amortiza'           = Case when (select TOP 1 IntercPrinc 
										  from   BACSWAPSUDA..CARTERARES 
										  where  Fecha_Proceso = @dFecha and CARTERARES.numero_operacion = @numoper  and Tipo_Swap=2 and Tipo_flujo=1 and 
												 (fecha_inicio_flujo=fecha_vence_flujo)  )<>0    --numero_flujo=1  
									then 'Intercambio Nocionales al Inicio. '  else ' '   
                               end  
    ,	'FechaFijacionTasa'     = CONVERT(CHAR(10),fecha_fijacion_tasa,103)   
    ,	'FechaLiquidacion'      = CONVERT(CHAR(10),FechaLiquidacion,103)   
    ,   'nemo_pagamos_moneda'   = isnull((select MNNEMO from BACSWAPSUDA..view_moneda where MNCODMON = (CASE WHEN pagamos_moneda=998 THEN 999 ELSE pagamos_moneda END)),'')  
    ,   'nemo_recibimos_moneda' = isnull((select MNNEMO from BACSWAPSUDA..view_moneda where MNCODMON = (CASE WHEN recibimos_moneda=998 THEN 999 ELSE recibimos_moneda END)) ,'')  
    ,   'TituloModComp'         = 'El Diferencial de Amortización y el Diferencial de Intereses se pagarán en: '   
    ,   'TituloModEF_1' = 'Las Amortizaciones e Interés se pagarán en Pago Pasivo: '   
    ,   'TituloModEF_2'         = ' y se recibiran en Pago Activo: '   
    ,   'Tipo_Swap'             = CASE tipo_swap WHEN 1 THEN 'TASA'  
											     WHEN 2 THEN 'MONEDA'  
											     WHEN 3 THEN 'FRA'  
											     WHEN 4 THEN 'TASA' -- 'CAMARA'  
								  END  
    ,	'INTER_NOCIONAL'   = IntercPrinc  
    ,   'CompraGlosaBase'   = ISNULL((SELECT Glosa FROM BACSWAPSUDA..Base Base WHERE Base.codigo  = compra_base),'N/A')   
    ,   'VentaGlosaBase'    = ISNULL((SELECT Glosa FROM BACSWAPSUDA..Base Base WHERE Base.codigo  = Venta_base),'N/A')   
    ,   'numero_operacion' = @numoper 
    ,   case when CARTERAHIS.compra_codigo_tasa =0 then convert(varchar(14),convert(numeric(10,4),CARTERAHIS.compra_valor_tasa)) else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                          FROM BacParamSuda..TABLA_GENERAL_DETALLE 
															  WHERE tbcodigo1 = CARTERAHIS.compra_codigo_tasa AND tbcateg = 1042),' '))) end+ 
	                 case when CARTERAHIS.compra_spread>0.0 then (case when CARTERAHIS.compra_codigo_tasa =0 
					                                             then '' else ' + ' end )+convert(varchar(10),convert(numeric(10,4),CARTERAHIS.compra_spread))+'%' else '' end as compra_codigo   
	,	@fecha	as 'fecparam'	--		AS CHAR(8)
	,	@RUT_CLIENTE as 'rutparam'	--	AS NUMERIC(11)  
	,	@COD_CLIENTE	as 'codparam'	--AS NUMERIC(10)  
	,	@RUT_APODERADO1	as 'rutapo1param' --AS NUMERIC(11) = 0  
	,	@RUT_APODERADO2	as 'rutapo2param'--AS NUMERIC(11) = 0  
	,	@RUT_APODERADOB1 as 'rutapo1bparam'	--AS NUMERIC(11) = 0  
	,	@RUT_APODERADOB2 as 'rutap2bparam'	--AS NUMERIC(11) = 0     
  FROM   bacswapsuda..CARTERAHIS , Bacswapsuda..SwapGeneral A
--		 , (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX  
--			FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI  
--		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
--			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO1 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE) APOCLI   
--		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
--			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO2 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE) APOCLI2   
--		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
--			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB1 and aprutcli = 97023000) APOBAN --> CORPBANCA  
--		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
--			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB2 and aprutcli = 97023000) APOBAN2  --> CORPBANCA   
--		 , (SELECT COMU.NOMBRE FROM BACPARAMSUDA..COMUNA COMU   
--			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE  
--			WHERE CLRUT = @RUT_CLIENTE) COMUNA   
		 , (SELECT NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
			WHERE CLRUT = @RUT_CLIENTE) CIUDAD   
  WHERE  CARTERAHIS.numero_operacion    = @numoper  
---      AND    Fecha_Proceso       = @dFecha  
---      AND    Fecha_inicio_flujo  <> Fecha_vence_flujo  
  ORDER BY tipo_flujo, numero_flujo  
  
  
  SELECT * FROM #TMP_CARTERA_SWAP  
  ORDER BY tipo_flujo, numero_flujo   
  
 DROP TABLE #TMP_CARTERA_SWAP  
END  


--CONTRATO_ESPECIFICO_PPRODUCTO_SWAP_MONEDA 4019,'20111004',77771980,1,8501318,8501318,8346589,8346589
GO
