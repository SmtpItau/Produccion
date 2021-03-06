USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[DE52]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DE52 '20211010'
CREATE PROCEDURE [dbo].[DE52] (@dFechaProceso DateTime)
AS
BEGIN
   -- SP_INTERFAZ_DERIVADOS_SWAP, contingencia
   -- MAP 20071214 : Redefinición del flujo vigente, se utilizara campo Estado_Flujo
   -- Swap: Guardar Como    
   -- Reemplazar vRazActivoAjus_Mn  con Compra_Mercado_Clp

   SET NOCOUNT ON
--declare @dFechaProceso DateTime
--set @dFechaProceso ='20220329'

   DECLARE @Max        INTEGER
   ,       @Fecha_FM   DATETIME

   if @dFechaProceso is null  
	begin   
	 set @dFechaProceso = (select fechaproc from BacSwapSuda..swapgeneral)  
	end  


   /* BUSCA VALOR DE MONEDA PARA FIN DE MES -------------------------------------------- */
   SELECT @Fecha_FM = DATEADD(MONTH, -1, @dFechaProceso)
   SELECT @Fecha_FM = MAX(VMFECHA) FROM  BacSwapSuda..VIEW_VALOR_MONEDA WHERE MONTH(VMFECHA) = MONTH(@Fecha_FM) AND YEAR(VMFECHA) = YEAR(@Fecha_FM)

   IF (SELECT MONTH(fechaproc) FROM  BacSwapSuda..SWAPGENERAL) <> (SELECT MONTH(fechaprox) FROM  BacSwapSuda..SWAPGENERAL)
      SELECT @Fecha_FM = @dFechaProceso

   SELECT vmcodigo , vmvalor
   INTO   #ValMon
   FROM   BacParamSuda..VALOR_MONEDA
   WHERE  vmfecha = @dFechaProceso -- @Fecha_FM

   INSERT INTO #ValMon SELECT 13, vmvalor FROM #ValMon WHERE vmcodigo = 994
   INSERT INTO #ValMon SELECT 999 , 1.0

   SELECT vmcodigo , vmvalor 
   INTO   #VALOR_TC_CONTABLE
   FROM   #ValMon
   WHERE  vmcodigo IN(994,995,997,998,999)

   INSERT INTO #VALOR_TC_CONTABLE
   SELECT CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END , Tipo_Cambio
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE
   WHERE  Fecha    = @dFechaProceso 
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)
   

   /* ---------------------------------------------------------------------------------- */
   CREATE TABLE #NEOSOFT
   (   C_pais			CHAR(3)
   ,   F_interfaz		CHAR(8)
   ,   N_identificacion VARCHAR(4)
   ,   C_empresa        VARCHAR(3)
   ,   F_producto       CHAR(4)
   ,   T_producto       CHAR(4)
   ,   C_interno		CHAR(16)
   ,   C_producto       CHAR(1)
   ,   Tip_producto     CHAR(1)
   ,   Fecha_contable   CHAR(8)
   ,   C_sucursal       CHAR(4)
   ,   N_operacion     	VARCHAR(20)
   ,   I_cliente		VARCHAR(12)
   ,   D_cliente		VARCHAR(1)
   ,   F_inicio			CHAR(8)
   ,   F_vencimiento	CHAR(8)
   ,   M_compra			VARCHAR(3)
   ,   M_mda_comprada	NUMERIC(18,2)
   ,   M_venta			VARCHAR(3)
   ,   M_mda_vendida	NUMERIC(18,2)
   ,   T_vencimiento	VARCHAR(1)
   ,   Registros		INTEGER
   ,   tipoflujo		NUMERIC(1)
   ,   numero_armado    NUMERIC(20)
   ,   N_Flujo          NUMERIC(5)
   ,   M_compra_C08 	NUMERIC(18,2)
   ,   M_venta_C08  	NUMERIC(18,2)
   ,   T_tasa_compra 	VARCHAR(2)
   ,   T_tasa_venta		VARCHAR(2)
   ,   F_cambio_compra	CHAR(8)
   ,   F_cambio_venta	CHAR(8)
   ,   V_presen_activo	NUMERIC(18,2)
   ,   V_presen_pasivo	NUMERIC(18,2)
   ,   Mda_Pago_compra  VARCHAR(3)
   ,   Mda_Pago_venta   VARCHAR(3)
   ,   Tipo_Swap        int
   )
   Declare @DE52_SALIDA Table ( REG_SALIDA  Varchar(398))  
   Declare @VM Table(Vmfecha Date, VmCodigo	Int, VmValor Float)

   Declare @DE52 Table(
			ctry					VARCHAR(3)				--1	
		,	intf_dt					CHAR(8)					--2	
		,	src_id					VARCHAR(14)				--3	
		,	cem						VARCHAR(3)				--4	
		,	prod					VARCHAR(16)				--5	
		,	book_dt					CHAR(8)					--6	
		,	br						CHAR(04)				--7	
		,	con_no					VARCHAR(20)				--8
		,	ident_cli				VARCHAR(12)				--9
		,	strt_dt					CHAR(8)					--10
		,	end_dt					CHAR(8)					--11
		,	ccy_compra				VARCHAR(4)				--12
		,	ccy_compra_amt			NUMERIC(19,4)			--13
		,	ccy_vta					VARCHAR(4)				--14
		,	ccy_vta_amt				NUMERIC(19,4)			--15
		,	typ_vcto				VARCHAR(1)				--16
		,	mtm_activo_estimado		NUMERIC(19,2)			--17
		,	mtm_pasivo_estimado		NUMERIC(19,2)			--18
		,	fix_flting_ind_activo	VARCHAR(2)				--19
		,	fix_flting_ind_pasivo	VARCHAR(2)				--20
		,	next_ch_rt_dt_activo	CHAR(8)					--21
		,	next_ch_rt_dt_pasivo	CHAR(8)					--22
		,	aset_present_value		NUMERIC(19,2)			--23
		,	liab_present_value		NUMERIC(19,2)			--24
		,	ccy_pag_comp 			VARCHAR(4)				--25
		,	ccy_pag_vta				VARCHAR(4)				--26
		,	pac_rt					DECIMAL(16,8)			--27
		,	cod_instr				VARCHAR(10)				--28
		,	ocy_prima_tot			NUMERIC(19,4)			--29
		,	spot_rt					NUMERIC(16,8)			--30
		,	mark_comp				Varchar(1)				--31
		,	id_mark_comp			Varchar(52)				--32
   )

   SELECT DISTINCT   
         'OpNumero_Operacion' = C.Numero_Operacion 
   ,     'OpRut_cliente'      = C.Rut_cliente
   ,     'OpCodigo_cliente'   = C.Codigo_cliente
   ,     'OpFecha_Cierre'     = C.Fecha_Cierre
   ,     'OpT_cartera'        = ISNULL((SELECT ccn_codigo_nuevo FROM bacparamsuda..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = C.car_Cartera_Normativa),4)
   ,     'OpModalidad'        = CASE WHEN C.modalidad_pago = 'E' THEN 'D' ELSE C.modalidad_pago END
   ,	 'OpTipo_Swap'		  = tipo_swap
   INTO  #Operaciones
   FROM   BacSwapSuda..CARTERA              C 
   WHERE ( ( ( Fecha_Termino        > @dFechaProceso and Tipo_Swap <> 3 ) or ( Tipo_Swap = 3 and FechaLiquidacion > @dFechaProceso )  )
         -- MAP 20080115 Se corrige problema de NEOSOFT, no tomaba operaciones de un Flujo
         and (     compra_saldo + Compra_Amortiza > 0 and tipo_flujo = 1 
                or venta_saldo + venta_Amortiza > 0 and tipo_flujo = 2
                or Compra_Flujo_Adicional <> 0 and tipo_flujo = 1       -- 5203 Contingencia  
                or Venta_Flujo_Adicional <> 0 and tipo_flujo = 2        -- 5203 Contingencia
              ) 
         
         and estado <> 'N'  and estado <> 'C' )

   SELECT * 
   INTO   #FluCarVig
   FROM    BacSwapSuda..CARTERA  
			inner join
			(	select	folio	= numero_operacion
					,	tipo	= tipo_flujo
					,	Flujo	= min( numero_flujo )
				from	BacSwapSuda..CARTERA with(nolock)
				where	(	Estado_Flujo	= 1
					and		Fecha_Termino	> @dFechaProceso AND Tipo_Swap <> 3 and estado <> 'C'
						)
					or	(	Tipo_Swap		= 3 
						and FechaLiquidacion> @dFechaProceso 
						)
				group 
				by		numero_operacion
					,	tipo_flujo

			)	grp		On	grp.folio	= numero_operacion
						and	grp.tipo	= tipo_flujo
						and	grp.Flujo	= numero_flujo
   WHERE (  Estado_Flujo	= 1
	AND		Fecha_Termino	> @dFechaProceso AND Tipo_Swap <> 3 and estado <> 'C'
		)
	or	(	Tipo_Swap			= 3 
		and FechaLiquidacion	> @dFechaProceso 
		)



   INSERT INTO #NEOSOFT
   SELECT DISTINCT
          'C_pais'		    = 'CL'
   ,      'F_interfaz'		= CONVERT(CHAR(8),@dFechaProceso,112)
   ,      'N_identificacion'= 'DEC2'
   ,      'C_empresa'		= '001'
   ,      'F_producto'  	= 'MD02'
   ,      'T_producto'    	= 'MD02'
   ,      'C_interno'		= 'MD02'
   ,      'C_producto'		= SPACE(1)
   ,      'Tip_producto'	= 'M'
   ,      'fecha_contable' 	= CONVERT(CHAR(8),@dFechaProceso,112)
   ,      'C_sucursal'		= '0011'
   ,      'N_operacion'   	= CONVERT(VARCHAR(20),OpNumero_operacion)
   ,      'rut'           	= CONVERT(varchar(9),OpRut_cliente)
   ,      'dig'           	= ISNULL(Cldv,'0')
   ,      'fecha_inic'    	= CONVERT(CHAR(8),OpFecha_Cierre,112)
   ,      'fecha_vcto'    	= CONVERT(CHAR(8),(SELECT MAX(Fechaliquidacion) FROM  BacSwapSuda..CARTERA As  Car WHERE Numero_operacion = OpNumero_operacion),112)
   ,      'M_compra'    	= ISNULL((SELECT MAX(CONVERT(VARCHAR(3),compra_moneda)) FROM  BacSwapSuda..CARTERA    WHERE Numero_operacion = OpNumero_operacion AND Tipo_Flujo = 1),'   ')
   ,      'M_mda_comprada'    	= ISNULL((SELECT compra_capital                         FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 1),0)
   ,      'M_venta'    		= ISNULL((SELECT MAX(CONVERT(VARCHAR(3),venta_moneda))  FROM  BacSwapSuda..CARTERA    WHERE Numero_operacion = OpNumero_operacion AND Tipo_Flujo = 2),'   ')
   ,      'M_mda_vendida'     	= ISNULL((SELECT venta_capital                          FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 2),0)
   ,      'T_vencimiento'      	= OpModalidad
   ,      'Registros'		= 0
   ,      'tipoflujo'		= 1
   ,      'numero_armado'	= CONVERT(VARCHAR(10),Opnumero_operacion)
   ,      'N_Flujo'             = ISNULL((SELECT numero_flujo FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 1 ), 0 )
   ,      'M_compra_C08' 	= 0.0
   ,      'M_venta_C08' 	= 0.0
   ,      'T_tasa_compra' 	= ISNULL((SELECT CASE WHEN compra_codigo_tasa  = 0 THEN 'F'      ELSE 'V' END FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 1),' ')
   ,      'T_tasa_venta'	= ISNULL((SELECT CASE WHEN venta_codigo_tasa   = 0 THEN 'F'      ELSE 'V' END FROM #FluCarVig WHERE numero_operacion = OpNumero_operacion AND tipo_flujo = 2),' ')
   ,      'F_cambio_compra'	= ISNULL((SELECT CASE WHEN compra_codigo_tasa  = 0 THEN SPACE(8) ELSE CONVERT(CHAR(8),fecha_vence_flujo,112) END
                                            FROM #FluCarVig WHERE numero_operacion = OpNumero_Operacion AND Tipo_flujo = 1), SPACE(8))
   ,      'F_cambio_venta'	= ISNULL((SELECT CASE WHEN venta_codigo_tasa = 0 THEN SPACE(8) ELSE CONVERT(CHAR(8),fecha_vence_flujo,112) END
                                            FROM #FluCarVig WHERE numero_operacion = OpNumero_Operacion AND Tipo_flujo = 2), SPACE(8)) 
   ,      'V_presen_activo'     = ISNULL((SELECT DISTINCT compra_mercado_clp FROM  BacSwapSuda..CARTERA CarAux WHERE CarAux.Numero_Operacion = Car.OpNumero_Operacion AND CarAux.Tipo_Flujo = 1),0)
   ,      'V_presen_pasivo'     = ISNULL((SELECT DISTINCT Venta_mercado_clp FROM  BacSwapSuda..CARTERA CarAux WHERE CarAux.Numero_Operacion = Car.OpNumero_Operacion AND CarAux.Tipo_Flujo = 2),0)
   ,      'Mda_Pago_compra'    	= ISNULL((SELECT MAX(CONVERT(VARCHAR(3),recibimos_moneda)) FROM  BacSwapSuda..CARTERA    WHERE Numero_operacion = OpNumero_operacion AND Tipo_Flujo = 1),'   ')
   ,      'Mda_Pago_venta'    	= ISNULL((SELECT MAX(CONVERT(VARCHAR(3),pagamos_moneda)) FROM  BacSwapSuda..CARTERA    WHERE Numero_operacion = OpNumero_operacion AND Tipo_Flujo = 2),'   ')
   ,      'Tipo_swap'			= OpTipo_Swap
   FROM  #Operaciones	        Car 
         LEFT JOIN BacParamSuda..CLIENTE ON clrut = Car.Oprut_cliente AND clcodigo = Car.Opcodigo_cliente
   ,     BacParamSuda..ENTIDAD

   SELECT @Max      = COUNT(1)
   FROM   #NEOSOFT

   UPDATE #NEOSOFT 
   SET    registros = @Max

 

   insert into @DE52
   SELECT
		C_pais,												--1	ctry
		F_interfaz,											--2	intf_dt
		N_Identificacion+space(10),					    	--3	src_id
		C_empresa,											--4	cem
		CONVERT(CHAR(16),F_producto),						--5	prod
		Fecha_contable,										--6	book_dt
		C_sucursal,											--7	br
		n_operacion,--(REPLICATE('0',20- DATALENGTH(ltrim(rtrim(n_operacion))) ) + LTRIM(RTRIM(CONVERT(CHAR(20),n_operacion)))),	--8	con_no
		right(replicate('0',12)+convert(varchar(10),i_cliente)+d_cliente,12), --9	ident_cli
		F_inicio,											--10	strt_dt
		f_vencimiento,										--11	end_dt
		convert(char(4),m1.mncodbkb),						--12	ccy_compra
		m_mda_comprada,										--13	ccy_compra_amt
		convert(char(4),m2.mncodbkb),						--14	ccy_vta
		m_mda_vendida,										--15	ccy_vta_amt
		t_vencimiento,										--16	typ_vcto
		V_presen_activo,									--17	mtm_activo_estimado
		V_presen_pasivo,									--18	mtm_pasivo_estimado
		convert(char(2),T_tasa_compra),						--19	fix_flting_ind_activo
		convert(char(2),T_tasa_venta),						--20	fix_flting_ind_pasivo
		F_cambio_compra,									--21	next_ch_rt_dt_activo
		F_cambio_venta,										--22	next_ch_rt_dt_pasivo
		V_presen_activo,									--23	aset_present_value
		V_presen_pasivo,									--24	liab_present_value
		convert(char(4),Mda_Pago_compra),					--25	ccy_pag_comp
		convert(char(4),Mda_Pago_venta),					--26	ccy_pag_vta
		0,													--27	pac_rt
		REPLICATE(' ',8)+'05',								--28	cod_instr
		0,													--29	ocy_prima_tot
		0,													--30	spot_rt
		'0',												--31	mark_comp
		REPLICATE('X',52)									--32	id_mark_comp
   FROM   #NEOSOFT
   inner join bacparamsuda..moneda m1 on m1.mncodmon=m_compra
   inner join bacparamsuda..moneda m2 on m2.mncodmon=m_venta

Declare @TipoSalida bit = 0
Declare @Pie_Archivo Varchar(20) = ''
Declare @iCantidadRegistros int = 0

set @iCantidadRegistros = (select count(1) from @DE52)
set @Pie_Archivo		= '99'+LTRIM(RTRIM(CONVERT(CHAR(10),getdate(),112)))+REPLICATE('0', 10 - len(LTRIM(RTRIM(@iCantidadRegistros))))+RTRIM(RTRIM(@iCantidadRegistros))


if @TipoSalida != 0
	SELECT 
			ctry		
		,	intf_dt	
		,	src_id
		,	cem		
		,	prod
		,   book_dt
		,	br
		,	left(con_no+space(20), 20)  	as con_no	
		,	ident_cli
		,   CASE WHEN strt_dt		= '19000101' THEN '00000000'  when  strt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),strt_dt,112)	END as strt_dt
		,	CASE WHEN end_dt		= '19000101' THEN '00000000'  when  end_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),end_dt,112)	END as end_dt
		,   ccy_compra
		,   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ccy_compra_amt*10000))),19) as ccy_compra_amt
		,   ccy_vta
		,   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ccy_vta_amt*10000))),19) as ccy_vta_amt
		,   typ_vcto
		,   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(mtm_activo_estimado*100))),19) as mtm_activo_estimado
		,   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(mtm_pasivo_estimado*100))),19) as mtm_pasivo_estimado
		,	fix_flting_ind_activo
		,	fix_flting_ind_pasivo
		,   CASE WHEN next_ch_rt_dt_activo		= '19000101' THEN '00000000'  when  next_ch_rt_dt_activo	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_ch_rt_dt_activo,112)	END	 as next_ch_rt_dt_activo
		,	CASE WHEN next_ch_rt_dt_pasivo		= '19000101' THEN '00000000'  when  next_ch_rt_dt_pasivo	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_ch_rt_dt_pasivo,112)	END	 as next_ch_rt_dt_pasivo
		,   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(aset_present_value*100))),19)  as aset_present_value
		,   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(liab_present_value*100))),19) as liab_present_value

	
	FROM @DE52 Order by  cast(con_no as numeric(9)), cem ,  prod 
else
	begin
		INSERT INTO @DE52_SALIDA
		SELECT
			ctry		
		+	intf_dt	
		+	src_id
		+	cem		
		+	prod
		+   book_dt
		+	br
		+	left(con_no+space(20), 20)  	--con_no	
		+	ident_cli
		+   CASE WHEN strt_dt		= '19000101' THEN '00000000'  when  strt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),strt_dt,112)	END	
		+	CASE WHEN end_dt		= '19000101' THEN '00000000'  when  end_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),end_dt,112)	END	
		+   ccy_compra
		+   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ccy_compra_amt*10000))),19)
		+   ccy_vta
		+   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(ccy_vta_amt*10000))),19)
		+   typ_vcto
		+   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(mtm_activo_estimado*100))),19)
		+   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(mtm_pasivo_estimado*100))),19)
		+	fix_flting_ind_activo
		+	fix_flting_ind_pasivo
		+	CASE WHEN next_ch_rt_dt_activo		= '19000101' THEN '00000000'  when  next_ch_rt_dt_activo	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_ch_rt_dt_activo,112)	END	
		+	CASE WHEN next_ch_rt_dt_pasivo		= '19000101' THEN '00000000'  when  next_ch_rt_dt_pasivo	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_ch_rt_dt_pasivo,112)	END	
		+   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(aset_present_value*100))),19)
		+   right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(liab_present_value*100))),19)

		FROM @DE52


		SELECT * FROM @DE52_SALIDA order by 1 desc
	end

drop table #ValMon
drop table #VALOR_TC_CONTABLE
drop table #NEOSOFT
drop table #Operaciones
drop table #FluCarVig



END

GO
