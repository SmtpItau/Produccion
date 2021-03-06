USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTAFLUJOSINICIAN]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CONSULTAFLUJOSINICIAN]
	(   	@SwapIcp       INTEGER	= 0   
		,	@FechaDesde    DATETIME
		,	@FechaHasta    DATETIME


	)
AS
BEGIN

   SET NOCOUNT ON
   declare @FechaSistema   datetime
   declare @espacios	   char(50)
   DECLARE @CatTasas		int
   DECLARE @FerCL			datetime
   DECLARE @FerUS			DATETIME
   DECLARE @FerEN			DATETIME

   SET @CatTasas = 1042

   /* OBTENER FECHA PROCESO */
   select  @FechaSistema   = fechaproc
   from    BacSwapSuda.dbo.swapgeneral with(nolock)

	/* SP_CONSULTAFLUJOSINICIAN 0, '20150826', '20150826' */

	----/* OBTENGO FECHA PROCESO ANTERIOR */
	----select  fechaant , fechaproc , fechaprox  
	----	into #FechaHabilAnterior
	----	from bacSwapSuda.dbo.SwapGeneralHis 
	----union
	----select  fechaant , fechaproc , fechaprox  
	----	from bacSwapSuda.dbo.SwapGeneral 
	
	----/* CREO INDICE ASOCIADO A LA FECHA PROCESO ANTERIOR  */
	----create index #IFechaHabilAnterior on #FechaHabilAnterior ( fechaProc ) 
	--- Parte de otra alternativa de solución se debe eliminar de la homologación


	/* OBTENGO LOS CAMPOS DE LA QUERY */
   /* 1 */ select 'swap'                = case when Car.tipo_swap = 1 then 'TASA   '
                                       when Car.tipo_swap = 2 then 'MONEDA '
                                       when Car.tipo_swap = 3 then 'FRA'
                                       when Car.tipo_swap = 4 then 'PROM   '
                                       else                    '       '
                                  end
   /* 2 */ ,     'numero_operacion'     = car.numero_operacion
   /* 3 */ ,     'nombrecli'			= isnull(Cli.clnombre,'*conflicto con nombre*')
   /* 4 */ ,     'tipo_operacion'       = Car.tipo_operacion
   /* 5 */ ,     'nombreop'				= case when Car.tipo_operacion = 'c' then 'COMPRA ' else 'VENTA  ' end

   /* 6 */ ,   	 'fechainicio'			= convert(char(10),Car.fecha_inicio,103)
   /* 7 */ ,     'nombremoneda'			= isnull(case when Car.tipo_operacion = 'C' then c.mnglosa
                                              when Car.tipo_operacion = 'V' then v.mnglosa
                                         end,'')
   /* 8 */ ,     'nombremonedaconv'		= isnull(case when Car.tipo_operacion = 'C' then v.mnglosa
                                              when Car.tipo_operacion = 'V' then c.mnglosa
                                         end,'')

   /* 9 */ ,     'compra_amortiza'      = Car.compra_amortiza
   /* 10 */ ,     'compra_interes'     	= Car.compra_interes
   /* 11 */ ,     'venta_amortiza'     	= Car.venta_amortiza
   /* 12 */ ,     'venta_interes'        = Car.venta_interes
   /* 13 */ ,     'numero_flujo'         = car.numero_flujo
   /* 14 */ ,     'fecha_inicio_flujo'   = convert(char(10),Car.fecha_inicio_Flujo,103) + '**' + convert(char(10),Car.fecha_vence_Flujo,103) -- Car.fecha_inicio_flujo
   /* 15 */ ,     'dias'			    = datediff(dd, Car.fecha_inicio_flujo, Car.fecha_vence_flujo)
   /* 16 */ ,     'modalidad'			= isnull((case Car.modalidad_pago when 'c' then 'COMPENSACION' else 'ENTREGA' end),' ')
   /* 17 */ ,     'tipo_swap' 			= Car.tipo_swap
   /* 18 */ ,     'compra_tasa'			= Car.compra_valor_tasa
   /* 19 */ ,     'venta_tasa'			= Car.venta_valor_tasa

   /* 20 */ ,     'tasa_compra'			= Car.compra_codigo_tasa
   /* 21 */ ,     'tasa_venta'			= Car.venta_codigo_tasa

   /* 22 */ ,     'nombre_tasa_compra'	= convert(varchar(150),'')
   /* 23 */ ,     'nombre_tasa_venta'	= convert(varchar(150),'')
   /* 24 */ ,     'tipo_flujo'           = car.tipo_flujo
   /* 25 */ ,     'fecha_vence_flujo'    = Car.fecha_vence_flujo
   /* 26 */ ,     'ValorPropuesto'       = convert(numeric(21,6), isnull( round(mt.tasa, 6),0) )
   /* 27 */ ,	  'fecha_fijacion_tasa'  = Car.fecha_fijacion_tasa
   /* 28 */ ,	  'FeriadoLiquiChile'    = Car.FeriadoLiquiChile
   /* 29 */ ,	  'FeriadoLiquiEEUU'	 = Car.FeriadoLiquiEEUU
   /* 30 */ ,	  'FeriadoLiquiEnglan'   = Car.FeriadoLiquiEnglan
   /* 31 */ ,     'codMoneda'            = case when car.tipo_flujo = 1 then Car.compra_moneda
														ELSE Car.venta_moneda  end
   /* 32 */ ,     'codTasaFlujo'         = case when car.tipo_flujo = 1 then Car.compra_codigo_tasa
														ELSE Car.venta_codigo_tasa  end													
   /* 33 */ ,	'digitaSN'               =ISNULL(CarFij.digitaSN,'')
   /* 34 */ ,	 'fecha_rescate'         =ISNULL(CarFij.fecha_rescate,'')
   /* 35 */ ,	'valor_tasa'             =ISNULL(CarFij.valor_tasa, isnull( mt.tasa, 0 )  )
   /* 36 */ , 'feriadoCH'                =iif(BacParamSuda.dbo.fx_regla_feriados_internacionales(Car.fecha_fijacion_tasa,';6;')=Car.fecha_fijacion_tasa,'-','X') 
   /* 37 */ , 'feriadoUS'                =iif(BacParamSuda.dbo.fx_regla_feriados_internacionales(Car.fecha_fijacion_tasa,';225;')=Car.fecha_fijacion_tasa,'-','X')
   /* 38 */ , 'feriadoEN'                =iif(BacParamSuda.dbo.fx_regla_feriados_internacionales(Car.fecha_fijacion_tasa,';510;')=Car.fecha_fijacion_tasa,'-','X')
   /* 39 */ ,  'Moneda'			         = c.mnglosa 
                                         -- indica si la fecha de fijación es feriado en el pais de la tasa
   /* 40 */ ,  'tasapais'	             =iif(BacParamSuda.dbo.fx_regla_feriados_internacionales(fecha_fijacion_tasa,';' + CAST(tp.pais AS VARCHAR) + ';')=Car.fecha_fijacion_tasa,'-','X')
            ,   fecha_cierre      
   into  #tmp1
   from  cartera                       car with(nolock)
         left join bacparamsuda..cliente Cli  with(nolock) on Cli.clcodigo   = codigo_cliente        and Cli.clrut = rut_cliente
         left join bacparamsuda..moneda  c with(nolock) on c.mncodmon = compra_moneda
         left join bacparamsuda..moneda  v with(nolock) on v.mncodmon = venta_moneda
		 left join CARTERA_FIJACION  CarFij
					ON CarFij.numero_operacion=car.numero_operacion
					and CarFij.numero_flujo=Car.numero_flujo
					and CarFij.tipo_flujo=Car.tipo_flujo

		 LEFT JOIN (	SELECT DISTINCT 
								fecha
							,	CodMon
							,	CodTasa
							,	Tasa
							,	periodo

						FROM	BacParamSuda.dbo.MONEDA_TASA with(nolock)
					)	mt		On	mt.fecha   = car.fecha_fijacion_tasa 
								and	mt.CodMon  = car.compra_moneda 
								and	mt.CodTasa = car.compra_codigo_tasa
								and mt.periodo = 1 /* incorporación en el filtro que el periodo sera anual que se utiliza en el sistema */
		LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE tipTasa ON tipTasa.tbcateg = @CatTasas AND mt.CodTasa = tbcodigo1
		LEFT JOIN bacparamsuda.DBO.tasa_pais tp on tp.Cod_tasa=car.compra_codigo_tasa 

   where (		(	(car.fecha_fijacion_tasa >= @FechaDesde   and car.fecha_fijacion_tasa <= @FechaHasta)
				and (car.compra_codigo_tasa Not In(13, 21))
				)
				
			or (	/* ( fecha_vence_flujo  between @FechaDesde and @FechaSistema) */
			         ( car.fechaLiquidacion = @FechaSistema ) 
				and (car.compra_codigo_tasa	IN(13, 21))
				)
         )
         
   and	 car.tipo_flujo 			= 1
   and	 car.compra_codigo_tasa		> 0
   and   car.estado                 not in ( 'C' ,  'N' )  -- Descarta cotizaciones y anticipos
   and   car.fecha_inicio_flujo <> car.fecha_vence_flujo
   --AND	 tipTasa.tbvalor = 2  /* tipTasa.tbvalor = 2  ==> Fijables */
   order by car.numero_operacion
  
   insert into #tmp1
   select 'swap'                = case when car.tipo_swap = 1 then 'TASA   '
                                       when car.tipo_swap = 2 then 'MONEDA '
                                       when car.tipo_swap = 3 then 'FRA'
                                       when car.tipo_swap = 4 then 'PROM   '
                                       else                    '       '
									end
   ,     'numero_operacion'     = car.numero_operacion
   ,     'nombrecli'			= isnull(Cli.clnombre,'*conflicto con nombre*')
   ,     'tipo_operacion'       = car.tipo_operacion
   ,     'nombreop'				= case when car.tipo_operacion = 'c' then 'COMPRA ' else 'VENTA  ' end
   ,   	 'fechainicio'			= convert(char(10),car.fecha_inicio,103)

   ,     'nombremoneda'			= isnull(case when car.tipo_operacion = 'C' then c.mnglosa
                                              when car.tipo_operacion = 'V' then v.mnglosa
                                         end,'')
   ,     'nombremonedaconv'		= isnull(case when car.tipo_operacion = 'C' then v.mnglosa
                                              when car.tipo_operacion = 'V' then c.mnglosa
                                         end,'')
                                         
   ,     'compra_amortiza'      = car.compra_amortiza
   ,     'compra_interes'     	= car.compra_interes
   ,     'venta_amortiza'     	= car.venta_amortiza
   ,     'venta_interes'        = car.venta_interes
   ,     'numero_flujo'         = car.numero_flujo
   ,     'fecha_inicio_flujo'   = convert(char(10),Car.fecha_inicio_Flujo,103) + '**' + convert(char(10),Car.fecha_vence_Flujo,103) --car.fecha_inicio_flujo
   ,     'dias'					= datediff(dd, car.fecha_inicio_flujo,car.fecha_vence_flujo)
   ,     'modalidad'			= isnull((case car.modalidad_pago when 'c' then 'COMPENSACION' else 'ENTREGA' end),' ')
   ,     'tipo_swap' 			= car.tipo_swap
   ,     'compra_tasa'			= car.compra_valor_tasa
   ,     'venta_tasa'			= car.venta_valor_tasa
   ,     'tasa_compra'			= car.compra_codigo_tasa
   ,     'tasa_venta'			= car.venta_codigo_tasa
   ,     'nombre_tasa_compra'	= convert(varchar(150),'')
   ,     'nombre_tasa_venta'	= convert(varchar(150),'')
   ,     'tipo_flujo'           = car.tipo_flujo
   ,     'fecha_vence_flujo'    = car.fecha_vence_flujo
   ,     'ValorPropuesto'       = convert(numeric(21,6), isnull(round(mt.tasa, 6),0))
   ,	 'fecha_fijacion_tasa'	= car.fecha_fijacion_tasa
   ,     'FeriadoLiquiChile'    = car.FeriadoLiquiChile
   ,	 'FeriadoLiquiEEUU'	 = car.FeriadoLiquiEEUU
   ,	 'FeriadoLiquiEnglan'   = car.FeriadoLiquiEnglan
   ,     'codMoneda'            = case when car.tipo_flujo = 1 then car.compra_moneda
														ELSE car.venta_moneda  end
	,     'codTasaFlujo'         = case when car.tipo_flujo = 1 then car.compra_codigo_tasa
													ELSE car.venta_codigo_tasa  end	
	,	'digitaSN'               = ISNULL(CarFij.digitaSN,'')	
	,	'fecha_rescate'          = ISNULL(CarFij.fecha_rescate,'')
	,	'valor_tasa'             = ISNULL(CarFij.valor_tasa, isnull( mt.tasa, 0 )  )
   /* 36 */ , 'feriadoCH'         =iif(BacParamSuda.dbo.fx_regla_feriados_internacionales(fecha_fijacion_tasa,';6;')=fecha_fijacion_tasa,'-','X') -->    BacParamSuda.dbo.FX_TraeIndFestivoPlaza(fecha_fijacion_tasa,6)
   /* 37 */ , 'feriadoUS'         =iif(BacParamSuda.dbo.fx_regla_feriados_internacionales(fecha_fijacion_tasa,';225;')=fecha_fijacion_tasa,'-','X')
   /* 38 */ , 'feriadoEN'         =iif(BacParamSuda.dbo.fx_regla_feriados_internacionales(fecha_fijacion_tasa,';510;')=fecha_fijacion_tasa,'-','X')     -->    BacParamSuda.dbo.FX_TraeIndFestivoPlaza(fecha_fijacion_tasa,510)
   /* 39 */ ,  'Moneda'			  =v.mnglosa 
                                   -- indica si la fecha de fijación es feriado en el pais de la tasa
/* 40 */ ,  'tasapais'			  =iif(BacParamSuda.dbo.fx_regla_feriados_internacionales(fecha_fijacion_tasa,';' + CAST(tp.pais AS VARCHAR) + ';')=fecha_fijacion_tasa,'-','X')
         ,   fecha_cierre 

   from  cartera                       car with(nolock)
         left join bacparamsuda..cliente Cli  with(nolock) on clcodigo   = codigo_cliente      and clrut = rut_cliente
         left join bacparamsuda..moneda  c with(nolock) on c.mncodmon = compra_moneda
         left join bacparamsuda..moneda  v with(nolock) on v.mncodmon = venta_moneda
		 		 left join CARTERA_FIJACION CarFij
					ON CarFij.numero_operacion=car.numero_operacion
					and CarFij.numero_flujo=Car.numero_flujo
					and CarFij.tipo_flujo=Car.tipo_flujo

		 LEFT JOIN (	SELECT DISTINCT 
								fecha
							,	CodMon
							,	CodTasa
							,	Tasa
							,	periodo
						FROM	BacParamSuda.dbo.MONEDA_TASA with(nolock)
					)	mt		On	mt.fecha   = car.fecha_fijacion_tasa 
								and	mt.CodMon  = car.venta_moneda 
								and	mt.CodTasa = car.venta_codigo_tasa
								and mt.periodo = 1 /* incorporación en el filtro que el periodo sera anual que se utiliza en el sistema */
		LEFT JOIN bacparamsuda..TABLA_GENERAL_DETALLE tipTasa ON tipTasa.tbcateg = @CatTasas AND mt.CodTasa = tbcodigo1
		LEFT JOIN bacparamsuda.DBO.tasa_pais tp on tp.Cod_tasa=car.venta_codigo_tasa 

   where (  (	(fecha_fijacion_tasa		>= @fechadesde and fecha_fijacion_tasa  <= @fechahasta) 
			and	(venta_codigo_tasa NOT IN(13, 21))
			)
				
			or	(		/* ( fecha_vence_flujo  between @FechaDesde and @FechaSistema) */
			            fechaLiquidacion = @FechaSistema 
				and		venta_codigo_tasa		IN(13, 21)
				)
         )
   and	 car.tipo_flujo 			= 2
   and	 venta_codigo_tasa		> 0
   and   estado                 not in ( 'C' ,  'N' )  -- Descarta cotizaciones y anticipos
   and   car.fecha_inicio_flujo <> car.fecha_vence_flujo
   --AND	 tipTasa.tbvalor = 2  /* tg.tbvalor = 2  ==> Fijables */

   order by numero_operacion

   update #tmp1 
       set  #tmp1.fecha_rescate = bacparamsuda.dbo.fx_AGREGA_N_DIAS_HABILES( fecha_Fijacion_Tasa, -1 /* dia habil anterior*/ , ';' + CAST(tp.pais AS VARCHAR) + ';'  ) 
	    from bacparamsuda.DBO.tasa_pais tp  

   where  isnull( valor_tasa , 0 ) = 0            -- Sin fijacion por feriado
       and  tp.Cod_tasa= #tmp1.CodTasaFlujo
       and  #tmp1.codTasaFlujo not in ( 13, 21 )  -- pendiente usar el sitch de fijable por tasa

   update #tmp1
       set #tmp1.valor_tasa = mt.tasa
	   from BacParamSuda.dbo.MONEDA_TASA mt   
	where 	mt.fecha   = #tmp1.fecha_Rescate
			and	    mt.CodMon  = #Tmp1.codMoneda 
			and	    mt.CodTasa = #tmp1.CodTasaFlujo
			and     mt.periodo = 1 
            and  #tmp1.codTasaFlujo not in ( 13, 21 )
			and  isnull( valor_tasa , 0 ) = 0 

 
   update  #tmp1
   set	   nombremoneda			= case when a.compra_moneda = 0 then '' else isnull((select mnglosa from view_moneda with(nolock) where mncodmon = a.compra_moneda), ' ') end
   ,       nombremonedaconv		= case when a.compra_moneda = 0 then '' else isnull((select mnglosa from view_moneda with(nolock) where mncodmon = a.compra_moneda), ' ') end
   ,       compra_amortiza    	= a.compra_amortiza
   ,       compra_interes     	= a.compra_interes
   ,       compra_tasa			= a.compra_valor_tasa
   ,       tasa_compra			= a.compra_codigo_tasa
   ,       nombre_tasa_compra	= isnull((select tbglosa from view_tabla_general_detalle with(nolock) where tbcateg = 1042 and tbcodigo1 = a.compra_codigo_tasa), ' ') 
   from	   cartera	        a
   ,       #tmp1	        b
   where (a.fecha_fijacion_tasa >= @fechadesde and a.fecha_fijacion_tasa <= @fechahasta)
   and     a.tipo_flujo 		= 1
   and     a.numero_operacion 	= b.numero_operacion
   and     a.numero_flujo		= b.numero_flujo
   and     a.fecha_inicio_flujo <> b.fecha_vence_flujo

   update  #tmp1
   set	   nombremoneda			= case when a.venta_moneda = 0 then '' else isnull((select mnglosa from view_moneda with(nolock) where  mncodmon = a.venta_moneda), ' ') end
   ,       nombremonedaconv		= case when a.venta_moneda = 0 then '' else isnull((select mnglosa from view_moneda with(nolock) where  mncodmon = a.venta_moneda), ' ') end
   ,       venta_amortiza     	= a.venta_amortiza
   ,       venta_interes      	= a.venta_interes
   ,       venta_tasa			= a.venta_valor_tasa
   ,       tasa_venta			= a.venta_codigo_tasa
   ,       nombre_tasa_venta	= isnull((select tbglosa from view_tabla_general_detalle with(nolock) where  tbcateg = 1042 and tbcodigo1 = a.venta_codigo_tasa), ' ')  
   from	   cartera	        a	
   ,       #tmp1	        b
   where (a.fecha_fijacion_tasa >= @fechadesde and a.fecha_fijacion_tasa  <= @fechahasta)
   and     a.tipo_flujo 		= 2		  	
   and     a.numero_operacion 	= b.numero_operacion	
   and     a.numero_flujo		= b.numero_flujo
and     a.fecha_inicio_flujo <> a.fecha_vence_flujo

   -->    Modificado por Error en la Glosa de Las Tasas en el Despliege. 18-03-2009.-
   UPDATE #TMP1
      SET Nombre_tasa_compra = rtrim( tbglosa ) + case when 1.0 / #tmp1.dias * ( AM.Dias * 1.0 ) > 1.5 
	                                               and fecha_fijacion_tasa <= fecha_cierre 
	                                               then
	                                                    '*'    else '' end 
	                         + case when tasa_Compra not in (0,13,21) then  ' ' +  convert( varchar(5), #tmp1.dias ) else '' end	                        
     FROM BacParamSuda..TABLA_GENERAL_DETALLE tiptasa with(nolock)
	     left join BacParamSuda..PERIODO_AMORTIZACION AM on tabla = 1044 and AM.codigo =  tipTasa.tbtasa 
    WHERE tbcateg            = 1042
      AND tbcodigo1          = tasa_Compra

   UPDATE #TMP1
      SET Nombre_tasa_venta  = rtrim(tbglosa) + case when 1.0 / #tmp1.dias * ( AM.Dias * 1.0 ) > 1.5  
	                                            and fecha_fijacion_tasa <= fecha_cierre 
	                                            then 
	                                                    '*' else '' end
	                         + case when tasa_venta not in (0,13,21) then  ' ' +  convert( varchar(5), #tmp1.dias ) else '' end
     FROM BacParamSuda..TABLA_GENERAL_DETALLE tiptasa with(nolock) 
	           left join BacParamSuda..PERIODO_AMORTIZACION AM on tabla = 1044 and AM.codigo =  tipTasa.tbtasa 	
    WHERE tbcateg            = 1042
      AND tbcodigo1          = tasa_venta
   -->    Modificado por Error en la Glosa de Las Tasas en el Despliege. 18-03-2009.-

  update #TMP1
     set Nombre_tasa_compra = ltrim( rtrim( Nombre_tasa_compra ) )
	  ,  nombre_tasa_venta  =  ltrim( rtrim( Nombre_tasa_venta ) )
	
	
	
	IF @SwapIcp = 0  -- Fijación de tasa en fecha fijación tasa
	BEGIN   
		DELETE	FROM #TMP1
				WHERE	(	tasa_Compra IN(13,21) and tipo_Flujo = 1
						OR	tasa_venta	IN(13,21) and tipo_Flujo = 2
						)
	END ELSE
	BEGIN            -- Fijación de tasa ICP solo para Patas ICP al vencimiento
		IF @SwapIcp = 1 
			DELETE	FROM #TMP1
			WHERE	NOT (	tasa_Compra	= 13 and tipo_Flujo = 1
						OR	tasa_venta	= 13 and tipo_Flujo = 2 
							)
		IF @SwapIcp = 2
			DELETE	FROM #TMP1
			WHERE	NOT (	tasa_Compra	= 21 and tipo_Flujo = 1
						OR	tasa_venta	= 21 and tipo_Flujo = 2 
							)
        update #TMP1 
		   set fecha_fijacion_tasa = '19000101'
	END
		


	SELECT	swap
		,   numero_operacion
		,   nombrecli
		,   tipo_operacion
		,   nombreop
		,   fechainicio
		,   nombremoneda
		,   nombremonedaconv
		,   compra_amortiza
		,   compra_interes
		,   venta_amortiza
		,   venta_interes
		,   numero_flujo
		,   fecha_inicio_flujo
		,   dias
		,   modalidad
		,   tipo_swap
		,   compra_tasa
		,   venta_tasa
		,   tasa_compra
		,   tasa_venta
		,   nombre_tasa_compra
		,   nombre_tasa_venta
		,   tipo_flujo
		,   fecha_vence_flujo
		,   ValorPropuesto
		,	fecha_fijacion_tasa
		,   FeriadoLiquiChile
		,   FeriadoLiquiEEUU
		,	FeriadoLiquiEnglan
		,	codMoneda
		,	codTasaFlujo
		,	digitaSN
		,	fecha_rescate
		,	valor_tasa
		,   feriadoCH
		,   feriadoUS
		,	feriadoEN
		,   Moneda
		,   tasapais 
	FROM	#TMP1 
	ORDER 
	BY		numero_operacion
		,	tipo_flujo

END



GO
