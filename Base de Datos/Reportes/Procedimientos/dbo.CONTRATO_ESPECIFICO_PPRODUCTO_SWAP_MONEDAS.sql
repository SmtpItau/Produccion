USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_ESPECIFICO_PPRODUCTO_SWAP_MONEDAS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[CONTRATO_ESPECIFICO_PPRODUCTO_SWAP_MONEDAS]  
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
   DECLARE @fechaccg  DATETIME 
  
   SELECT  @SwDevengo = devengo   
         , @fechaproc = fechaproc  
   FROM    Bacswapsuda..SWAPGENERAL  


   SELECT @fechaccg=FECHA_FIRMA_NUEVO_CCG FROM bacparamsuda..cliente CLIENTE
		  WHERE clrut = @rut_cliente AND clcodigo = @COD_CLIENTE AND clvigente = 'S'

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
	,	'RUT' = (SELECT distinct convert(varchar(20),Clrut)+'-'+ltrim(rtrim(Cldv)) From Bacparamsuda..cliente where A.rut = clrut)
	,   'RUT_CLI' = (SELECT distinct convert(varchar(20),Clrut)+'-'+ltrim(rtrim(Cldv)) From Bacparamsuda..cliente where clrut=@rut_cliente)
	,	'CLIENTE'				= CLNOMBRE 
	,	'DIRECCION_CLI'				= CLI.CLDIRECC  
	,	'FONO_CLI'					= CLI.CLFONO
	,	'FAX_CLI'					= CLI.CLFAX
	,	'COMUNA'						= COMUNA.NOMBRE  
	,	'CIUDAD'						= CIUDAD.NOMBRE  


	--,	'APODERADO_CLIENTE_1'		= APOCLI.APNOMBRE  
	--,   'RUT_APODERADO_CLIENTE_1'	= APOCLI.RUT_APODERADO  
	,	'APODERADO_CLIENTE_1'		= isnull((SELECT distinct APNOMBRE	FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO1 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE),'')
	,   'RUT_APODERADO_CLIENTE_1'	= isnull((SELECT distinct RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO1 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE)  ,'')


	--,	'APODERADO_CLIENTE_2'  = APOCLI2.APNOMBRE  
	--,   'RUT_APODERADO_CLIENTE_2' = APOCLI2.RUT_APODERADO  
	,	'APODERADO_CLIENTE_2'  = isnull((SELECT distinct APNOMBRE FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO2 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE)  ,'')
	,   'RUT_APODERADO_CLIENTE_2' = isnull((SELECT distinct RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO2 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE) ,'')



	,   'APODERADO_BANCO_1'   =   APOBAN.APNOMBRE  
	,   'RUT_APODERADO_BANCO_1'  = APOBAN.RUT_APODERADO  
	,   'APODERADO_BANCO_2'   = APOBAN2.APNOMBRE  
	,   'RUT_APODERADO_BANCO_2'  = APOBAN2.RUT_APODERADO 
	,   'DIRECCION_BANCO'   = A.DIRECCION  
	,	'TELEFONO_BANCO'	= A.TELEFONO
	,	'FAX_BANCO'				=	A.FAX 
	,   (SELECT CONVERT(CHAR(2), @fechaccg	, 103) + ' de '
										+ case when datepart(month,@fechaccg	) = 1 THEN 'Enero'
										 when datepart(month,@fechaccg	) = 2 THEN 'Febrero'
										  when datepart(month,@fechaccg	) = 3 THEN 'Marzo'
										   when datepart(month,@fechaccg	) = 4 THEN 'Abril'
										    when datepart(month,@fechaccg	) = 5 THEN 'Mayo'
										     when datepart(month,@fechaccg	) = 6 THEN 'Junio'
										      when datepart(month,@fechaccg	) = 7 THEN 'Julio'
										       when datepart(month,@fechaccg	) = 8 THEN 'Agosto'
										        when datepart(month,@fechaccg	) = 9 THEN 'Septiembre'
										         when datepart(month,@fechaccg	) = 10 THEN 'Octubre'
										          when datepart(month,@fechaccg	) = 11 THEN 'Noviembre'
										           when datepart(month,@fechaccg	) = 12 THEN 'Diciembre'
										           end + ' de '
										           + ltrim(rtrim(datepart(year,@fechaccg	)))) as fechaccg
	,	'Fecha_inicio'		 = convert(varchar(10), fecha_inicio,103)
	,	'Fecha_termino'		 = convert(varchar(10), fecha_termino,103)
	,	ACTIVO.numero_operacion
    ,   (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.COMPRA_MONEDA) as compra_mon 
	,	ACTIVO.COMPRA_SALDO
	,	ACTIVO.NUMERO_FLUJO
    ,   (select mnnemo from bacparamsuda..moneda where mncodmon = PASIVO.VENTA_MONEDA) as venta_mon 
	,	PASIVO.VENTA_SALDO
   	,   case when ACTIVO.compra_codigo_tasa =0 then convert(varchar(14),convert(numeric(10,4),ACTIVO.compra_valor_tasa)) else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                          FROM BacParamSuda..TABLA_GENERAL_DETALLE 
															  WHERE tbcodigo1 = ACTIVO.compra_codigo_tasa AND tbcateg = 1042),' '))) end+ 
	                 case when ACTIVO.compra_spread>0.0 then (case when ACTIVO.compra_codigo_tasa =0 
					                                             then '' else ' + ' end )+convert(varchar(10),convert(numeric(10,4),ACTIVO.compra_spread))+'%' else '' end as compra_codigo

	,   case when PASIVO.venta_codigo_tasa =0 then convert(varchar(14),convert(numeric(10,4),PASIVO.venta_valor_tasa)) else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                          FROM BacParamSuda..TABLA_GENERAL_DETALLE 
															  WHERE tbcodigo1 = PASIVO.venta_codigo_tasa AND tbcateg = 1042),' '))) end+ 
	                 case when PASIVO.venta_spread>0.0 then (case when PASIVO.venta_codigo_tasa =0 
					                                             then '' else ' + ' end )+convert(varchar(10),convert(numeric(10,4),PASIVO.venta_spread))+'%' else '' end as venta_codigo
	,	replace(case when charindex(PASIVO.paga_mon, PASIVO.venta_mon, 1)=0 AND PASIVO.paga_mon<>'CLP' then '; '+ --pagamos
		        case when charindex((select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda), (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), 1)=0 AND (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda) <> 'CLP' then  --recibimos
		            '; ' +
					 (  case when (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda)<>'CLP' then --compra
					   'Valor ' + (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda) + ' al día de vencimiento.' +
						   case when charindex((select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then
						   ' Y Valor ' + PASIVO.venta_mon + ' al día de vencimiento.' else '' end
					   else  		       
					   case when charindex((select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then --venta
                        'Valor' + PASIVO.venta_mon + ' al día de vencimiento.' end
					   end
                    ) + ' Valor '+ (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda) + ' al día de vencimiento.'
               else
			      + ' Valor '+ PASIVO.paga_mon + ' al día de vencimiento.'
			   end
		else
		     case when charindex((select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda), (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), 1)=0 AND (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda) <> 'CLP' then  --recibimos
		            '; ' +
					 (  case when (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda)<>'CLP' then --compra
					   'Valor ' + (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda) + ' al día de vencimiento.' +
						   case when charindex((select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then
						   ' Y Valor ' + PASIVO.venta_mon + ' al día de vencimiento.' else '' end
					   else  		       
					   case when charindex((select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then --venta
                       'Valor' + PASIVO.venta_mon + ' al día de vencimiento.' end
					   end
                    ) + ' Valor '+ (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda) + ' al día de vencimiento.'
               else
			      case when (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda)<>'CLP' then --compra
					   'Valor ' + (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda) + ' al día de vencimiento.' +
						   case when charindex((select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then
						   ' Y Valor ' + PASIVO.venta_mon + ' al día de vencimiento.' else '' end
					   else  		       
					   case when charindex((select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then --venta
                        'Valor' + PASIVO.venta_mon + ' al día de vencimiento.' end
					   end
			   end
        end,'USD','DO') as 'CambioRef'
	,	'N/A' as 'ParidadRef'
	,	'SANTIAGO' as 'Lugar'
    ,	'MONEDA NACIONAL	:	'+PASIVO.pagamosdoc as 'pagamosdoc'
	,   'MONEDA EXTRANJERA	:	'+ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = ACTIVO.recibimos_documento),' ')  as 'recibidoc'
	,	'T + ' + convert(varchar(10),isnull((select Diasvalor from BACSWAPSUDA..VIEW_FORMA_DE_PAGO where pagamos_documento=Codigo),0))  as 'forma_pago'
  	,   case when ACTIVO.compra_codigo_tasa =0 then 'FIJA' else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                          FROM BacParamSuda..TABLA_GENERAL_DETALLE 
															  WHERE tbcodigo1 = ACTIVO.compra_codigo_tasa AND tbcateg = 1042),' '))) end+ 
	                 case when ACTIVO.compra_spread>0.0 then (case when ACTIVO.compra_codigo_tasa =0 
					                                             then '' else ' + SPREAD' end ) else '' end as com_codigo
	,   case when PASIVO.venta_codigo_tasa =0 then 'FIJA' else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                          FROM BacParamSuda..TABLA_GENERAL_DETALLE 
															  WHERE tbcodigo1 = PASIVO.venta_codigo_tasa AND tbcateg = 1042),' '))) end+ 
	                 case when PASIVO.venta_spread>0.0 then (case when PASIVO.venta_codigo_tasa =0 
  				                                             then '' else ' + SPREAD' end ) else '' end as ven_codigo
    ,'COMPRA_CAPITAL' = (SELECT MAX(COMPRA_CAPITAL) FROM bacswapsuda..CARTERA c WHERE c.numero_operacion = ACTIVO.numero_operacion AND c.TIPO_FLUJO = 1)
    ,'VENTA_CAPITAL' = (SELECT MAX(VENTA_CAPITAL) FROM bacswapsuda..CARTERA c WHERE c.numero_operacion = ACTIVO.numero_operacion AND c.TIPO_FLUJO = 2)  
   INTO   #TMP_CARTERA_SWAP  
   FROM   bacswapsuda..CARTERA  ACTIVO
   inner join (     select      numero_operacion, fl = min(numero_flujo)
                                         from  BacSwapSuda.dbo.Cartera
                                         WHERE TIPO_FLUJO = 1
                                         group 
                                         by          numero_operacion, TIPO_FLUJO
                                   )     grp On      grp.numero_operacion    = ACTIVO.numero_operacion
                                               AND grp.fl                          = ACTIVO.NUMERO_FLUJO
                  
                  INNER JOIN (      SELECT NUMERO_OPERACION, TIPO_FLUJO, numero_flujo, VENTA_MONEDA, venta_saldo, venta_codigo_tasa, venta_spread, venta_valor_tasa,
						  				   (select mnnemo from bacparamsuda..moneda where mncodmon = A.VENTA_MONEDA) as venta_mon,
										   (select mnnemo from bacparamsuda..moneda where mncodmon = A.pagamos_moneda) as paga_mon,
										   ISNULL((SELECT glosa FROM BacParamSuda..FORMA_DE_PAGO  WHERE codigo    = A.pagamos_documento),' ') as 'pagamosdoc'
                                      FROM  BacSwapSuda.dbo.Cartera A
                                         WHERE TIPO_FLUJO = 2
                                   )     PASIVO      oN PASIVO.NUMERO_OPERACION = ACTIVO.NUMERO_OPERACION   
                                                     AND PASIVO.numero_flujo      = ACTIVO.NUMERO_FLUJO
   , Bacswapsuda..SwapGeneral A
		 ,   (SELECT CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX  
			FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI  
		
		 --, (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
			--FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO1 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE) APOCLI   
		 --, (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
			--FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO2 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE) APOCLI2   
		
		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB1 and aprutcli = 97023000) APOBAN --> CORPBANCA  
		 , (SELECT APNOMBRE, RUT_APODERADO = RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
			FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADOB2 and aprutcli = 97023000) APOBAN2  --> CORPBANCA   
		 , (SELECT COMU.NOMBRE FROM BACPARAMSUDA..COMUNA COMU   
			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE  
			WHERE CLRUT = @RUT_CLIENTE) COMUNA   
		 , (SELECT NOMBRE FROM BACPARAMSUDA..CIUDAD CIU  
			INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
			WHERE CLRUT = @RUT_CLIENTE) CIUDAD 
    WHERE  ACTIVO.numero_operacion    = @numoper  AND ACTIVO.TIPO_FLUJO = 1
    ---AND    Fecha_inicio_flujo  <> Fecha_vence_flujo  
    --ORDER BY tipo_flujo, numero_flujo  
                                          
--WHERE CART.NUMERO_OPERACION = 470
--AND         CART.TIPO_FLUJO = 1
 
  SELECT distinct * FROM #TMP_CARTERA_SWAP  
 -- ORDER BY tipo_flujo, numero_flujo   
  
--- DROP TABLE #TMP_CARTERA_SWAP  
END
GO
