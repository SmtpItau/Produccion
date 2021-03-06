USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_DETALLE_PPRODUCTO_SWAP]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--drop table #TMP_CARTERA_SWAP
-- 11979, '20160316', 76541059, 1, 9669354, 12222761, 12688470, 14906298, 0

CREATE PROCEDURE [dbo].[CONTRATO_DETALLE_PPRODUCTO_SWAP]  
   (  
	     @numoper   NUMERIC (09)			
	    ,@fecha				AS CHAR(8)	
 	,@RUT_CLIENTE		AS NUMERIC(11)  
	    ,@COD_CLIENTE		AS NUMERIC(10)  
	    ,@RUT_APODERADO1	AS NUMERIC(11)  
	    ,@RUT_APODERADO2	AS NUMERIC(11) 
	    ,@RUT_APODERADOB1	AS NUMERIC(11)
	    ,@RUT_APODERADOB2	AS NUMERIC(11) 
	)
AS
BEGIN
   SET NOCOUNT ON  
  
   DECLARE @SwDevengo  NUMERIC(01)  
   DECLARE @fechaproc  DATETIME 
   DECLARE @fechaccg   DATETIME 
   DECLARE @fechacond  DATETIME, @fecha1 datetime 
   
   
      	DECLARE @NomEntidad		VARCHAR(100)
	DECLARE @RutEntidad		NUMERIC(12)
	DECLARE	@DvEntidad		VARCHAR(1)
	DECLARE @CodEntidad		VARCHAR(2)
	DECLARE	@DirecEntidad	VARCHAR(100)
	DECLARE @FonoEntidad	VARCHAR(14)
	DECLARE @ComunaEntidad	VARCHAR(30)
	DECLARE @CiudadEntidad	VARCHAR(30)

   	SELECT 
			@NomEntidad		=	RazonSocial	
	,		@RutEntidad		=	RutEntidad	
	,		@DvEntidad		=	DigitoVerificador
	,		@CodEntidad		=   CodigoEntidad
	,		@DirecEntidad	=	DireccionLegal + ', ' + Comuna + ', ' + Ciudad
	,		@FonoEntidad	=	TelefonoLegal
	,		@ComunaEntidad  =	Comuna
	,		@CiudadEntidad  =	Ciudad
	FROM bacparamsuda..Contratos_ParametrosGenerales

    
   SELECT  @SwDevengo = devengo   
         , @fechaproc = fechaproc  
   FROM    Bacswapsuda..SWAPGENERAL  

   SELECT @fechaccg	 = FECHA_FIRMA_NUEVO_CCG, 
		  @fechacond = clfechafirma_cond 
   FROM   bacparamsuda..cliente CLIENTE
   WHERE  clrut     = @rut_cliente 
   AND    clcodigo  = @COD_CLIENTE 
   AND    clvigente = 'S'

   select @fecha1 = convert(datetime,@fecha)
   
   -- PRD 12712 - 21707
   DECLARE  @Banco				VARCHAR(100)
   DECLARE  @Cliente			VARCHAR(MAX)  
   --DECLARE  @ContOper			INT
   DECLARE	@Termino_anticipado VARCHAR(1000)
   
   
    SELECT  @Banco = (SELECT ltrim(rtrim(Nombre)) From BacSwapSuda.dbo.SwapGeneral)
     
   SELECT @Cliente          = ISNULL(ltrim(rtrim(clnombre)),'**')--, mov.* 
     FROM BacSwapSuda.dbo.Cartera mov LEFT JOIN BacParamSuda..CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo
     --FROM BacSwapSuda.dbo.MOVDIARIO mov LEFT JOIN BacParamSuda..CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo
    WHERE estado_flujo   = 1  
      AND   ((cltipcli       <  5 /*AND @FINANCIEROS = 'S'*/)
         OR  (cltipcli       >  4 /*AND @EMPRESAS    = 'S'*/)
            ) and estado <> 'C'
      AND   numero_operacion = @numoper
	  --AND   fecha_cierre     = @fechaproc
		   
	

   SELECT	@Termino_anticipado = CASE WHEN bearlytermination = 1 THEN 
   									'Las partes acuerdan que dentro del plazo  de diez (10) Días Hábiles contados desde el día ' 
   									+ right('00'+convert(varchar(2),DATEPART(day,fechainicio)) ,2) +   									
   									+ ' de ' 
   									+  case when datepart(month,fechainicio	) = 1  THEN 'Enero'
										    when datepart(month,fechainicio	) = 2  THEN 'Febrero'
										    when datepart(month,fechainicio	) = 3  THEN 'Marzo'
										    when datepart(month,fechainicio	) = 4  THEN 'Abril'
										    when datepart(month,fechainicio	) = 5  THEN 'Mayo'
										    when datepart(month,fechainicio	) = 6  THEN 'Junio'
										    when datepart(month,fechainicio	) = 7  THEN 'Julio'
										    when datepart(month,fechainicio	) = 8  THEN 'Agosto'
										    when datepart(month,fechainicio	) = 9  THEN 'Septiembre'
										    when datepart(month,fechainicio	) = 10 THEN 'Octubre'
										    when datepart(month,fechainicio	) = 11 THEN 'Noviembre'
										    when datepart(month,fechainicio	) = 12 THEN 'Diciembre' end
   									+ ' del ' + rtrim(DATEPART(year,fechainicio)) + ' , y con una periodicidad '   									
   									+ CASE WHEN Periodicidad = 0 THEN ''
   									       ELSE (SELECT ltrim(rtrim(gd.tbglosa))   
   												 FROM   BacParamSuda..TABLA_GENERAL_DETALLE GD 
   									             WHERE  GD.tbcateg			 = 9920
   												 AND    ca.Periodicidad      = gd.tbcodigo1 )
   									  END 
   									+ ', cualquiera de las partes tendrá la facultad de terminar en forma unilateral y anticipada el presente contrato.' 
   									+ ' La terminación deberá comunicarse a la otra parte antes de las 11:00 horas a.m. de cualquiera de los días comprendidos en el citado plazo ' 
   									+ '(en adelante,  la “Fecha de Terminación Anticipada”). Dentro de los 2 Días Hábiles siguientes a la Fecha de Terminación Anticipada deberá procederse al pago,'
   									+ ' por la parte que resulte deudora, del Valor de Mercado del contrato, calculado conforme a la Tasa de Valorización Referencial de Mercado y al Plazo residual a la Fecha de Terminación Anticipada.'

                                  ELSE 'No Aplica' END    
   
   FROM BacSwapSuda..cartera ca
   WHERE ca.numero_operacion    = @numoper  
   AND ca.TIPO_FLUJO			= 1
   AND ca.fecha_cierre			= @fecha1	--> Revisar
   AND ca.rut_cliente			= @RUT_CLIENTE
   AND ca.codigo_cliente		= @COD_CLIENTE
   
	DECLARE @InterNocIni AS INT
	,		@InterNocFin AS INT

	SELECT top 1 
			@InterNocIni	 = InterNocIni
	,		@InterNocFin	 = InterNocFin
	FROM	BacSwapSuda..Cartera 
	WHERE	numero_operacion = @numoper 

	   
   --Temporal para determinar montos en el intercambio nocionales final
 --  SELECT	'numero_flujo'       = numero_flujo 
	--,		'compra_amortiza'    = compra_amortiza    
	--,		'venta_amortiza'     = venta_amortiza  
	--,		'tipo_flujo'         = tipo_flujo  
	--INTO	#TMP_CARTERA_SWAP_INTERNOC  
	--FROM	bacswapsuda..CARTERA  , Bacswapsuda..SwapGeneral A		 
	--	,	(SELECT distinct CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX  
	--		 FROM   BACPARAMSUDA..CLIENTE 
	--		 WHERE  CLRUT    = @RUT_CLIENTE 
	--		 and    clcodigo = @COD_CLIENTE)  CLI
 --   WHERE	CARTERA.numero_operacion    = @numoper  
 --   AND		CARTERA.numero_flujo > 1 
 --   ORDER BY tipo_flujo, CARTERA.numero_flujo  
    
    -- PRD 12712 - 21707
  

   select 'FECHA_CONTRATO'			= (SELECT CONVERT(CHAR(2), @fecha1	, 103) + ' de '
									+ case when datepart(month,@fecha1	) = 1 THEN 'Enero'
										   when datepart(month,@fecha1	) = 2 THEN 'Febrero'
										   when datepart(month,@fecha1	) = 3 THEN 'Marzo'
										   when datepart(month,@fecha1	) = 4 THEN 'Abril'
										   when datepart(month,@fecha1	) = 5 THEN 'Mayo'
										   when datepart(month,@fecha1	) = 6 THEN 'Junio'
										   when datepart(month,@fecha1	) = 7 THEN 'Julio'
										   when datepart(month,@fecha1	) = 8 THEN 'Agosto'
										   when datepart(month,@fecha1	) = 9 THEN 'Septiembre'
										   when datepart(month,@fecha1	) = 10 THEN 'Octubre'
										   when datepart(month,@fecha1	) = 11 THEN 'Noviembre'
										   when datepart(month,@fecha1	) = 12 THEN 'Diciembre'
									  end 
									+ ' de ' + ltrim(rtrim(datepart(year,@fecha1	))))
	--,	'BANCO'                  = A.Nombre	
	--,	'RUT'                    = (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.')))) + '-' + ltrim(rtrim(Cldv)) 
	-- 	                            From   Bacparamsuda..cliente 
	-- 	                            where  A.rut = clrut)
	,	'BANCO'                  = @NomEntidad --(select RazonSocial from bacparamsuda..Contratos_ParametrosGenerales)	
	--,	'RUT'                    = (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, RutEntidad), 1), '.00', ''), ',','.')))) + '-' + ltrim(rtrim(DigitoVerificador)) From bacparamsuda..Contratos_ParametrosGenerales where A.rut = RutEntidad)
	,	'RUT'                   = (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, @RutEntidad), 1), '.00', ''), ',','.')))) + '-' + ltrim(rtrim(@DvEntidad)))
	
	
	,   'RUT_CLI'                = (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.')))+'-'+ltrim(rtrim(Cldv)) 
	                                From   Bacparamsuda..cliente 
	                                where  clrut = @rut_cliente)
	,	'CLIENTE'		 = CLNOMBRE 
	,	'DIRECCION_CLI'	 = CLI.CLDIRECC  
	,	'FONO_CLI'		 = CLI.CLFONO
	,	'FAX_CLI'		 = CLI.CLFAX
	,	'COMUNA'		 = 
		                           isnull( (SELECT distinct COMU.NOMBRE 
		                                    FROM   BACPARAMSUDA..COMUNA COMU   
			                                INNER JOIN BACPARAMSUDA..CLIENTE CLI ON COMU.CODIGO_COMUNA = CLI.CLCOMUNA and clcodigo = @COD_CLIENTE  
			                                WHERE  CLRUT = @RUT_CLIENTE),'')

	,	'CIUDAD'		 = 
                                   isnull((SELECT distinct NOMBRE 
                              FROM   BACPARAMSUDA..CIUDAD CIU  
			                               INNER JOIN BACPARAMSUDA..CLIENTE CLI ON CIU.CODIGO_CIUDAD = CLI.CLCIUDAD and clcodigo = @COD_CLIENTE  
			                               WHERE  CLRUT = @RUT_CLIENTE),'')
	
	
	,	'APODERADO_CLIENTE_1'	  = isnull((SELECT distinct APNOMBRE	FROM BACPARAMSUDA..CLIENTE_APODERADO WHERE APRUTAPO = @RUT_APODERADO1 and aprutcli = @RUT_CLIENTE and apcodcli = @COD_CLIENTE),'')	
	,   'RUT_APODERADO_CLIENTE_1' = isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
			                                                                      FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                                                                              WHERE  APRUTAPO = @RUT_APODERADO1 
	                                                                              and    aprutcli = @RUT_CLIENTE 
	                                                                              and    apcodcli = @COD_CLIENTE),'')  

	,	'APODERADO_CLIENTE_2'     = isnull((SELECT distinct APNOMBRE 
	 	                                    FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	 	                                    WHERE  APRUTAPO = @RUT_APODERADO2 
	 	                                    and    aprutcli = @RUT_CLIENTE 
	 	                                    and    apcodcli = @COD_CLIENTE),'')

	,   'RUT_APODERADO_CLIENTE_2' = isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
			                                                                       FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                                                                               WHERE  APRUTAPO = @RUT_APODERADO2 
	                                                                               and    aprutcli = @RUT_CLIENTE 
	                                                                               and    apcodcli = @COD_CLIENTE),'')
	
	,   'APODERADO_BANCO_1'       = isnull((SELECT distinct APNOMBRE	
	                                        FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                                        WHERE  APRUTAPO = @RUT_APODERADOB1 
	                                        and    aprutcli = 97023000),'')

	,   'RUT_APODERADO_BANCO_1'  = isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
			                                                                      FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                                                                              WHERE  APRUTAPO = @RUT_APODERADOB1 
	                                                                              and    aprutcli = 97023000),'') 
	
	,   'APODERADO_BANCO_2'      = isnull((SELECT distinct APNOMBRE 
	                                       FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                                       WHERE  APRUTAPO = @RUT_APODERADOB2 
	                                       and    aprutcli = 97023000),'')

	,   'RUT_APODERADO_BANCO_2'  = isnull( (select distinct(convert(varchar(20), (select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO  
			                                                                      FROM   BACPARAMSUDA..CLIENTE_APODERADO 
	                                                                              WHERE  APRUTAPO = @RUT_APODERADOB2 
	                                                                              and    aprutcli = 97023000),'')

	,   'DIRECCION_BANCO'   = @DirecEntidad --A.DIRECCION  
	,	'TELEFONO_BANCO'	= @FonoEntidad --A.TELEFONO
	,	'FAX_BANCO'			= A.FAX 
	,   'fechaccg'          = (SELECT CONVERT(CHAR(2), @fechaccg	, 103) + ' de '
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
									+ ltrim(rtrim(datepart(year,@fechaccg	)))) --as fechaccg
	,	'Fecha_inicio'		 = convert(varchar(10), fecha_inicio,103)
	,	'Fecha_termino'		 = convert(varchar(10), fecha_termino,103)
	,	'numero_operacion'   = ACTIVO.numero_operacion
    ,   'compra_mon'         = (select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.COMPRA_MONEDA) --as compra_mon 
	,	'COMPRA_CAPITAL'     = ACTIVO.COMPRA_CAPITAL
	,	'NUMERO_FLUJO'       = ACTIVO.NUMERO_FLUJO
    ,   'venta_mon'          = (select mnnemo from bacparamsuda..moneda where mncodmon = PASIVO.VENTA_MONEDA) --as venta_mon 
	,	'VENTA_CAPITAL'      = PASIVO.VENTA_CAPITAL
   	,   'compra_codigo'      = case when ACTIVO.compra_codigo_tasa = 0 then convert(varchar(14),convert(numeric(10,4),ACTIVO.compra_valor_tasa)) + '%' else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                          FROM BacParamSuda..TABLA_GENERAL_DETALLE 
															  WHERE tbcodigo1 = ACTIVO.compra_codigo_tasa AND tbcateg = 1042),' '))) END + 
	                           case when ACTIVO.compra_spread>0.0 then (case when ACTIVO.compra_codigo_tasa =0 
					                                             then '' else ' + ' end )+convert(varchar(10),convert(numeric(10,4),ACTIVO.compra_spread))+'%' else '' end --as compra_codigo

	,   'venta_codigo'       = case when PASIVO.venta_codigo_tasa =0 then convert(varchar(14),convert(numeric(10,4),PASIVO.venta_valor_tasa)) + '%' else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                          FROM BacParamSuda..TABLA_GENERAL_DETALLE 
															  WHERE tbcodigo1 = PASIVO.venta_codigo_tasa AND tbcateg = 1042),' '))) end+ 
	                           case when PASIVO.venta_spread>0.0 then (case when PASIVO.venta_codigo_tasa =0 
					                                             then '' else ' + ' end )+convert(varchar(10),convert(numeric(10,4),PASIVO.venta_spread))+'%' else '' end --as venta_codigo
	,	'CambioRef'          = isnull(replace( case when charindex(PASIVO.paga_mon, PASIVO.venta_mon, 1)=0 AND PASIVO.paga_mon<>'CLP' then ''+ --pagamos
												   case when charindex((select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda), (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), 1)=0 
												   AND (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda) <> 'CLP' then  --recibimos
													'' +
													 (  case when (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda)<>'CLP' then --compra
													   'Valor ' + (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda) + ' al día de vencimiento.' +
														   case when charindex((select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then
														   ' Y Valor ' + PASIVO.venta_mon + ' al día de vencimiento.' else '' end
													   else  		       
													   case when charindex((select mnnemo from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then --venta
														'Valor' + PASIVO.venta_mon + ' al día de vencimiento.' end
													   end
													) + ' Valor '+ (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda) + ' al día de vencimiento.'
												   else
													   + ' Valor '+ PASIVO.paga_mon + ' al día de vencimiento.'
												   end
											   else
												   case when charindex((select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda), (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), 1)=0 
												   AND (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda) <> 'CLP' then  --recibimos
													'' +
													 ( case when (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda)<>'CLP' then --compra
													   'Valor ' + (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda) + ' al día de vencimiento.' +
														   case when charindex((select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then
														   ' Y Valor ' + PASIVO.venta_mon + ' al día de vencimiento.' else '' end
													   else  		       
													   case when charindex((select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then --venta
														'Valor' + PASIVO.venta_mon + ' al día de vencimiento.' end
													   end
													 ) + ' Valor '+ (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.recibimos_moneda) + ' al día de vencimiento.'
												   else
													   case when (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda)<>'CLP' then --compra
													   'Valor ' + (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda) + ' al día de vencimiento.' +
														   case when charindex((select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then
														   ' Y Valor ' + PASIVO.venta_mon + 'al día de vencimiento.' else '' end
													   else  		       
													   case when charindex((select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.compra_moneda), PASIVO.venta_mon, 1)=0 and PASIVO.venta_mon<>'CLP' then --venta
														'Valor' + PASIVO.venta_mon + ' al día de vencimiento.' end
													   end
												   end
											  end,'USD','DO'),'N/A') --as 'CambioRef'
	,	'ParidadRef'    = 'N/A' --as 'ParidadRef'
	,	'Lugar'         = 'SANTIAGO' --as 'Lugar'
    ,	'pagamosdoc'    = 'MONEDA NACIONAL : '+PASIVO.pagamosdoc --as 'pagamosdoc'
	,   'recibidoc'     = 'MONEDA EXTRANJERA : '+ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO  WHERE codigo    = ACTIVO.recibimos_documento),' ')  --as 'recibidoc'
	,	'forma_pago'    = 'T + ' + convert(varchar(10),isnull((select Diasvalor from BACSWAPSUDA..VIEW_FORMA_DE_PAGO where PASIVO.pagamos_documento=Codigo),0))  --as 'forma_pago'
  	,   'com_codigo'    = case when ACTIVO.compra_codigo_tasa =0 then 'FIJA' else ltrim(rtrim(ISNULL((SELECT tbglosa 
																									  FROM   BacParamSuda..TABLA_GENERAL_DETALLE 
																									  WHERE  tbcodigo1 = ACTIVO.compra_codigo_tasa 
																									  AND    tbcateg   = 1042),' '))) END + 
	                      case when ACTIVO.compra_spread > 0.0 then (case when ACTIVO.compra_codigo_tasa = 0 then '' else ' + SPREAD' end ) else '' end --as com_codigo
	,   'ven_codigo'    = case when PASIVO.venta_codigo_tasa = 0 then 'FIJA' else ltrim(rtrim(ISNULL((SELECT tbglosa 
	                                                                                         FROM   BacParamSuda..TABLA_GENERAL_DETALLE 
															                                          WHERE  tbcodigo1 = PASIVO.venta_codigo_tasa 
															                                          AND    tbcateg   = 1042),' '))) END + 
	                      case when PASIVO.venta_spread>0.0 then (case when PASIVO.venta_codigo_tasa = 0 then '' else ' + SPREAD' end ) else '' end --as ven_codigo
	,   'fechacond'     = (SELECT CONVERT(CHAR(2), @fechacond	, 103) + ' de '
										+ case when datepart(month,@fechacond	) = 1 THEN 'Enero'
										       when datepart(month,@fechacond	) = 2 THEN 'Febrero'
										       when datepart(month,@fechacond	) = 3 THEN 'Marzo'
										       when datepart(month,@fechacond	) = 4 THEN 'Abril'
										       when datepart(month,@fechacond	) = 5 THEN 'Mayo'
										       when datepart(month,@fechacond	) = 6 THEN 'Junio'
										       when datepart(month,@fechacond	) = 7 THEN 'Julio'
										       when datepart(month,@fechacond	) = 8 THEN 'Agosto'
										       when datepart(month,@fechacond	) = 9 THEN 'Septiembre'
										       when datepart(month,@fechacond	) = 10 THEN 'Octubre'
										       when datepart(month,@fechacond	) = 11 THEN 'Noviembre'
										       when datepart(month,@fechacond	) = 12 THEN 'Diciembre'
										  end + ' de '
										           + ltrim(rtrim(datepart(year,@fechacond	)))) --as fechacond
	,	'fecini'        = (SELECT CONVERT(CHAR(2), fecha_inicio	, 103) + ' de '
										+ case when datepart(month,fecha_inicio	) = 1 THEN 'Enero'
										       when datepart(month,fecha_inicio	) = 2 THEN 'Febrero'
										       when datepart(month,fecha_inicio	) = 3 THEN 'Marzo'
										       when datepart(month,fecha_inicio	) = 4 THEN 'Abril'
										       when datepart(month,fecha_inicio	) = 5 THEN 'Mayo'
										       when datepart(month,fecha_inicio	) = 6 THEN 'Junio'
										       when datepart(month,fecha_inicio	) = 7 THEN 'Julio'
										       when datepart(month,fecha_inicio	) = 8 THEN 'Agosto'
										       when datepart(month,fecha_inicio	) = 9 THEN 'Septiembre'
										       when datepart(month,fecha_inicio	) = 10 THEN 'Octubre'
										       when datepart(month,fecha_inicio	) = 11 THEN 'Noviembre'
										       when datepart(month,fecha_inicio	) = 12 THEN 'Diciembre'
										  end + ' de '
										           + ltrim(rtrim(datepart(year,fecha_inicio	)))) --as fecini
	,	'fecfin'        = (SELECT CONVERT(CHAR(2), fecha_termino	, 103) + ' de ' -- (SELECT CONVERT(CHAR(2), fecha_inicio	, 103) + ' de '
										+ case when datepart(month,fecha_termino	) = 1 THEN 'Enero'
										       when datepart(month,fecha_termino	) = 2 THEN 'Febrero'
										       when datepart(month,fecha_termino	) = 3 THEN 'Marzo'
										       when datepart(month,fecha_termino	) = 4 THEN 'Abril'
										       when datepart(month,fecha_termino	) = 5 THEN 'Mayo'
										       when datepart(month,fecha_termino	) = 6 THEN 'Junio'
										       when datepart(month,fecha_termino	) = 7 THEN 'Julio'
										       when datepart(month,fecha_termino	) = 8 THEN 'Agosto'
										       when datepart(month,fecha_termino	) = 9 THEN 'Septiembre'
										       when datepart(month,fecha_termino	) = 10 THEN 'Octubre'
										       when datepart(month,fecha_termino	) = 11 THEN 'Noviembre'
										       when datepart(month,fecha_termino	) = 12 THEN 'Diciembre'
										   end + ' de '
										+ ltrim(rtrim(datepart(year,fecha_termino	)))) --as fecfin
   ,	'Termino_anticipado' = ISNULL(@Termino_anticipado,'No aplica')
   ,	'ItercambioInicial'  = @InterNocIni
   ,	'ItercambioFinal'	 = @InterNocFin
   /*
   ,   'ItercambioInicial'  = CASE WHEN @InterNocIni = 0 then 'Sin Intercambio'
									  ELSE	'-  Fecha Intercambio Inicial: ' 
									      	+ right('00'+convert(varchar(2),DATEPART(day,Fecha_inicio_flujo)) ,2) + ' de ' 
   											+  case when datepart(month,Fecha_inicio_flujo	) = 1  THEN 'Enero'
													when datepart(month,Fecha_inicio_flujo	) = 2  THEN 'Febrero'
													when datepart(month,Fecha_inicio_flujo	) = 3  THEN 'Marzo'
													when datepart(month,Fecha_inicio_flujo	) = 4  THEN 'Abril'
													when datepart(month,Fecha_inicio_flujo	) = 5  THEN 'Mayo'
													when datepart(month,Fecha_inicio_flujo	) = 6  THEN 'Junio'
													when datepart(month,Fecha_inicio_flujo	) = 7  THEN 'Julio'
													when datepart(month,Fecha_inicio_flujo	) = 8  THEN 'Agosto'
													when datepart(month,Fecha_inicio_flujo	) = 9  THEN 'Septiembre'
													when datepart(month,Fecha_inicio_flujo	) = 10 THEN 'Octubre'
													when datepart(month,Fecha_inicio_flujo	) = 11 THEN 'Noviembre'
													when datepart(month,Fecha_inicio_flujo	) = 12 THEN 'Diciembre' end
   											+ ' del ' + rtrim(DATEPART(year,Fecha_inicio_flujo)) +
									      	+ CHAR(13) + CHAR(10) 
											+ '-  Monto Intercambio Inicial para ' + @Banco + ' : ' 
											+ (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.COMPRA_MONEDA)											
											--+ ' ' + (SELECT TOP 1 replace(replace(replace(rtrim(COMPRA_AMORTIZA),'.',';'),',','.'),';',',') FROM bacswapsuda..cartera WHERE numero_flujo > 1 and numero_operacion = @numoper AND TIPO_FLUJO = 1 )
											+ ' ' + (SELECT TOP 1 REPLACE(REPLACE(REPLACE(CONVERT(VarChar(50), cast( COMPRA_AMORTIZA as money ), 1),'.',';'),',','.'),';',',') FROM bacswapsuda..cartera WHERE numero_flujo > 1 and numero_operacion = @numoper AND TIPO_FLUJO = 1 ) 
											+ CHAR(13) + CHAR(10)
											+ '-  Monto Intercambio Inicial para ' + @Cliente + ' : '
											+ (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = PASIVO.VENTA_MONEDA)											
											--+ ' ' + (SELECT TOP 1 replace(replace(replace(rtrim(VENTA_AMORTIZA),'.',';'),',','.'),';',',')	FROM bacswapsuda..cartera WHERE numero_flujo > 1 and numero_operacion = @numoper AND TIPO_FLUJO = 1) 
											+ ' ' + (SELECT TOP 1 REPLACE(REPLACE(REPLACE(CONVERT(VarChar(50), cast( VENTA_AMORTIZA as money ), 1),'.',';'),',','.'),';',',') FROM bacswapsuda..cartera WHERE numero_flujo > 1 and numero_operacion = @numoper AND TIPO_FLUJO = 1)
											+ CHAR(13) + CHAR(10) 
                              END
	,	'ItercambioFinal'  = CASE WHEN @InterNocFin = 0 then 'Sin Intercambio'
									  ELSE	'-  Fecha Intercambio Final: ' 
									      	+ right('00'+convert(varchar(2),DATEPART(day,fecha_termino)) ,2) + ' de ' 
   											+  case when datepart(month,fecha_termino	) = 1  THEN 'Enero'
													when datepart(month,fecha_termino	) = 2  THEN 'Febrero'
													when datepart(month,fecha_termino	) = 3  THEN 'Marzo'
													when datepart(month,fecha_termino	) = 4  THEN 'Abril'
													when datepart(month,fecha_termino	) = 5  THEN 'Mayo'
													when datepart(month,fecha_termino	) = 6  THEN 'Junio'
													when datepart(month,fecha_termino	) = 7  THEN 'Julio'
													when datepart(month,fecha_termino	) = 8  THEN 'Agosto'
													when datepart(month,fecha_termino	) = 9  THEN 'Septiembre'
													when datepart(month,fecha_termino	) = 10 THEN 'Octubre'
													when datepart(month,fecha_termino	) = 11 THEN 'Noviembre'
													when datepart(month,fecha_termino	) = 12 THEN 'Diciembre' end
   											+ ' del ' + rtrim(DATEPART(year,fecha_termino)) +
									      	+ CHAR(13) + CHAR(10) 
											+ '-  Monto Intercambio Final para ' + @Banco + ' : ' 
											+ (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = ACTIVO.COMPRA_MONEDA)																				
											--+ ' ' + (SELECT TOP 1 replace(replace(replace(rtrim(COMPRA_AMORTIZA),'.',';'),',','.'),';',',') FROM #TMP_CARTERA_SWAP_INTERNOC WHERE TIPO_FLUJO = 1 ORDER BY numero_flujo DESC)
											+ ' ' + (SELECT TOP 1 REPLACE(REPLACE(REPLACE(CONVERT(VarChar(50), cast( COMPRA_AMORTIZA as money ), 1),'.',';'),',','.'),';',',') FROM #TMP_CARTERA_SWAP_INTERNOC WHERE TIPO_FLUJO = 1 ORDER BY numero_flujo DESC)																				
											+ CHAR(13) + CHAR(10)
											+ '-  Monto Intercambio Final para ' + @Cliente + ' : '
											+ (select rtrim(mnnemo) from bacparamsuda..moneda where mncodmon = PASIVO.VENTA_MONEDA)											
											--+ ' ' + (SELECT TOP 1 replace(replace(replace(rtrim(VENTA_AMORTIZA),'.',';'),',','.'),';',',')	FROM #TMP_CARTERA_SWAP_INTERNOC WHERE tipo_flujo = 2 ORDER BY numero_flujo DESC)
											+ ' ' + (SELECT TOP 1 REPLACE(REPLACE(REPLACE(CONVERT(VarChar(50), cast( VENTA_AMORTIZA as money ), 1),'.',';'),',','.'),';',',') FROM #TMP_CARTERA_SWAP_INTERNOC WHERE tipo_flujo = 2 ORDER BY numero_flujo DESC) 											
											+ CHAR(13) + CHAR(10) 
                                 END
				
		*/		
   INTO   #TMP_CARTERA_SWAP  
   FROM   bacswapsuda..CARTERA  ACTIVO
   inner join (     select      numero_operacion, fl = min(numero_flujo)
                                         from  BacSwapSuda.dbo.Cartera
                                         WHERE TIPO_FLUJO = 1
                                         group 
                                         by          numero_operacion, TIPO_FLUJO
                                   )     grp On      grp.numero_operacion    = ACTIVO.numero_operacion
                                   AND grp.fl                          = ACTIVO.NUMERO_FLUJO
                  
                  INNER JOIN (      SELECT venta_capital,NUMERO_OPERACION, TIPO_FLUJO, numero_flujo, VENTA_MONEDA, venta_saldo, venta_codigo_tasa, venta_spread, venta_valor_tasa,
						  				   (select mnnemo from bacparamsuda..moneda where mncodmon = A.VENTA_MONEDA) as venta_mon,
										   (select mnnemo from bacparamsuda..moneda where mncodmon = A.pagamos_moneda) as paga_mon,
										   ISNULL((SELECT glosa FROM BacParamSuda..FORMA_DE_PAGO  WHERE codigo    = A.pagamos_documento),' ') as 'pagamosdoc', pagamos_documento
                                         FROM  BacSwapSuda.dbo.Cartera A
                                         WHERE TIPO_FLUJO = 2
                                   )     PASIVO      oN PASIVO.NUMERO_OPERACION = ACTIVO.NUMERO_OPERACION   
                                                     AND PASIVO.numero_flujo      = ACTIVO.NUMERO_FLUJO
   , Bacswapsuda..SwapGeneral A  
   , (SELECT distinct CLNOMBRE, RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV, CLDIRECC, CLFONO, CLFAX  
			FROM BACPARAMSUDA..CLIENTE WHERE CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE)  CLI
			
   WHERE  ACTIVO.numero_operacion    = @numoper  AND ACTIVO.TIPO_FLUJO = 1   
         
 
  SELECT distinct * FROM #TMP_CARTERA_SWAP  

END

GO
