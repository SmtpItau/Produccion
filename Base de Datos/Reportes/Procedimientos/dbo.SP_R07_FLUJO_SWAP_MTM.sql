USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_R07_FLUJO_SWAP_MTM]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--sp_helptext SP_R07_FLUJO_SWAP_MTM


CREATE PROCEDURE [dbo].[SP_R07_FLUJO_SWAP_MTM] (@dFechaProceso		DateTime=NULL)
AS
BEGIN
SET NOCOUNT ON  
    
Declare @SEP VarChar(1); Set @SEP = ';'
--Declare @dFechaProceso		DateTime='20210625'

Declare @TipoSalida	bit = 1


 IF(@dFechaProceso IS NULL)
         BEGIN    
              SELECT    @dFechaProceso = M.acfecproc
		      FROM Bacfwdsuda.dbo.mfac M with(nolock)
         END  


DECLARE @Flujo_Swap	 TABLE (			fechaproceso				DATETIME
									,	sistemaorigen				VARCHAR(10) 
									,	numerooperacion				VARCHAR(50) 
									,	tipoflujo					VARCHAR(3)
									,	numeroflujo					int
									,	mtm							numeric(19,4)
									,	mtmmo						numeric(19,4)
									,	modalidad_pago				char(1)
									,	tipo_flujo					int
									,	Activo_MO_C08				numeric(19,4)
									,	Pasivo_MO_C08				numeric(19,4)
									,	Tasa_Compra_CurvaVR			numeric(19,4)
									,	Tasa_Venta_CurvaVR			numeric(19,4)
									,	FechaLiquidacion			DATETIME
									,	compra_moneda				int			
									,	venta_moneda				int
									,	Recibimos_moneda			int
									,	pagamos_moneda				int
									,	PaisCliente					int
									,	amortizacion_mtm			numeric(19,4)
									,	interes_mtm					numeric(19,4)
									,	amortizacion_mtmmo			numeric(19,4)
									,	interes_mtmmo				numeric(19,4)
									,   compra_amortiza				numeric(19,4)
									,   venta_amortiza				numeric(19,4)
									,	compra_flujo_adicional		numeric(19,4)
									,	Venta_flujo_adicional		numeric(19,4)
									,	IntercPrinc					int
									,	tipo_swap					int
									,	valor_moneda_activa			numeric(19,4)
									,	valor_moneda_pasiva			numeric(19,4)
)	

CREATE TABLE #R07_Flujo_Swap_SALIDA
	(
	REG_SALIDA		Varchar(500))
		




/* Versión 1.0
INSERT INTO  @Flujo_Swap
	SELECT 
				 @dFechaProceso			AS fechaproceso
			,	'TURING'				as sistemaorigen
			,	numero_operacion	    AS 'numerooperacion'
			,	(case when tipo_flujo = 1   then 'ACT' Else 'PAS' End)					AS tipoflujo
			,	numero_flujo			AS numeroflujo
			,	0						AS mtm
			,	0						AS mtmmo
			,	modalidad_pago				
			,	tipo_flujo					
			,	Activo_MO_C08			
			,	Pasivo_MO_C08	
			,	Tasa_Compra_CurvaVR			
			,	Tasa_Venta_CurvaVR			
			,	FechaLiquidacion			
			,	compra_moneda							
			,	venta_moneda				
			,	Recibimos_moneda			
			,	pagamos_moneda		
			,	PaisCliente		
			,	0						AS	amortizacion_mtm
			,	0						AS	interes_mtm
			,	0						AS	amortizacion_mtmmmo
			,	0						AS	interes_mtmmo
			,   compra_amortiza
			,   venta_amortiza
			,	compra_flujo_adicional
			,	Venta_flujo_adicional
			,	IntercPrinc
			,   tipo_swap
			,   0
			,   0
   FROM BacSwapSuda.DBO.Cartera   Car WITH(NOLOCK)
   inner join 
(Select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) , PaisCliente = clpais
from	BacParamSuda.dbo.cliente with(nolock)
)	
Clie	On	Clie.clrut		= Car.rut_cliente
	and Clie.clcodigo	= Car.codigo_cliente
   WHERE 
        -- CAR.estado_flujo  = 1 AND
         CAR.estado       != 'C'
		AND CAR.fecha_inicio_flujo >= @dFechaProceso 
   ORDER BY CAR.numero_operacion, CAR.numero_flujo

*/

INSERT INTO  @Flujo_Swap
select -- count(1)
		 @dFechaProceso			AS fechaproceso
			,	'TURING'				as sistemaorigen
			,	Cartera.numero_operacion	    AS 'numerooperacion'
			,	(case when tipo_flujo = 1   then 'ACT' Else 'PAS' End)					AS tipoflujo
			,	Cartera.numero_flujo			AS numeroflujo
			,	(CASE WHEN tipo_flujo  = 1 THEN Activo_FlujoCLP         ELSE Pasivo_FlujoCLP        END	)					AS mtm
			,	(CASE WHEN tipo_flujo  = 1 THEN Activo_FlujoMO          ELSE Pasivo_FlujoMO         END )					AS mtmmo
			,	Cartera.modalidad_pago				
			,	Cartera.tipo_flujo					
			,	Cartera.Activo_MO_C08			
			,	Cartera.Pasivo_MO_C08	
			,	Cartera.Tasa_Compra_CurvaVR			
			,	Cartera.Tasa_Venta_CurvaVR			
			,	Cartera.FechaLiquidacion			
			,	Cartera.compra_moneda							
			,	Cartera.venta_moneda				
			,	Cartera.Recibimos_moneda			
			,	Cartera.pagamos_moneda		
			,	PaisCliente		
			,	0						AS	amortizacion_mtm
			,	0						AS	interes_mtm
			,	0						AS	amortizacion_mtmmmo
			,	0						AS	interes_mtmmo
			,	Cartera.compra_amortiza
			,	Cartera.venta_amortiza
			,	Cartera.compra_flujo_adicional
			,	Cartera.Venta_flujo_adicional
			,	Cartera.IntercPrinc
			,	Cartera.tipo_swap
			,   0
			,   0
from BacSwapSuda.dbo.Cartera Cartera
LEFT JOIN BacParamSuda..OPE_COLATERAL o ON o.id_sistema='SWP' and o.rut_cliente=cartera.rut_cliente and o.cod_cliente=cartera.codigo_cliente and o.numero_operacion=cartera.numero_operacion
inner join 
(Select	clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) , PaisCliente = clpais
from	BacParamSuda.dbo.cliente with(nolock)
)	
	Clie	On	Clie.clrut		= Cartera.rut_cliente
	and Clie.clcodigo	= Cartera.codigo_cliente
LEFT  JOIN
       (Select  numero_operacion  AS OPERACION              
               ,tipo_flujo        AS TIPO
			   ,numero_flujo      AS FLUJO
          from BacSwapSuda.dbo.Cartera Cartera
             ) CAR
              ON Cartera.numero_operacion = CAR.OPERACION
         AND Cartera.tipo_flujo       = CAR.TIPO 
		 AND Cartera.numero_flujo = CAR.FLUJO
left join
	(	select  Folio			= SwapCtas.folio
			,	Normativa		= SwapCtas.Id_Descripcion
			,	Id_Descrip_SCN	= SwapCtas.Id_Descrip_SCN
			,	CtaBac			= Reportes.dbo.fx_leer_cuentas_sbif_ima	
									(	SwapCtas.Id_Sistema
									,	SwapCtas.Id_Movimiento
									,	SwapCtas.Id_Operacion
									,	SwapCtas.Id_Instrumento
									,	SwapCtas.Id_Moneda
									,	SwapCtas.Id_Pata
									,	SwapCtas.Id_signo
									,	SwapCtas.Id_Pais
									,	SwapCtas.Id_Normativa
									,	SwapCtas.Id_Subcartera
									,	1
									)
		from
	
		(	select	distinct 
					Folio				= cartera.numero_operacion
				,	Id_Sistema			= 'PCS'
				,	Id_Movimiento		= 'DEV'
				,	Id_Operacion		= 'D' + ltrim(rtrim( cartera.tipo_swap ))
				,	Id_Instrumento		= ''
				,	Id_Moneda			= case when cartera.tipo_swap = 2 then '999' else cartera.compra_moneda end
				,	Id_Pata				= cartera.tipo_flujo
				,	Id_signo			= case when cartera.Valor_RazonableCLP >= 0 then '+' else '-' end
				,	Id_Pais				= cli.clpais
				,	Id_Normativa		= cartera.car_Cartera_Normativa
				,	Id_Subcartera		= cartera.car_SubCartera_Normativa
				,	Id_Descripcion		= isnull(cNormativa.Descripcion, '')
				,	Id_Descrip_SCN		= isnull(sSubCartera.Descripcion, '')

	 		from	BacSwapSuda.dbo.cartera cartera with(nolock)
	 				inner join
	 				(	select	clrut, clcodigo, clpais = case when clpais = 6 then 2 else 1 end 
	 				 	from	Bacparamsuda.dbo.cliente with(nolock)
	 				)	cli		On	cli.clrut		= cartera.rut_cliente
	 							and	cli.clcodigo	= cartera.codigo_cliente

	 				left join
	 				(	select	id = tbcodigo1
	 						,	Descripcion	= tbglosa
	 				 	from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
	 				 	where	tbcateg = 1111
	 				)	cNormativa On cNormativa.id = cartera.car_Cartera_Normativa

	 				left join
	 				(	select	id = tbcodigo1
	 						,	Descripcion	= tbglosa
	 				 	from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
	 				 	where	tbcateg = 1554
	 				)	sSubCartera On sSubCartera.id = cartera.car_SubCartera_Normativa

	 		where	cartera.tipo_flujo = 1
	 		and		cartera.estado	  <> 'C'
		)	SwapCtas
	)	SwapCtasSbif	On SwapCtasSbif.folio =  Cartera.numero_operacion

 left join baclineas.dbo.transacciones_idd with(nolock) on cModulo='PCS' and nOperacion=Cartera.numero_operacion
where Cartera.estado <> 'C'
And Cartera.fecha_vence_flujo <> @dFechaProceso 
/*
UPDATE @Flujo_Swap
--cashflow_nvp
--cálculo amortizacion_mtm
set		amortizacion_mtm= round(BacParamSuda.dbo.fx_convierte_monto(@dFechaProceso,isnull( case when tipo_Flujo = 1 then Compra_moneda else venta_moneda end, 999 ),
									(case	when tipo_flujo = 1 then
										 (compra_amortiza * ( case when tipo_swap = 2 then IntercPrinc else 1.0 end ) + compra_flujo_adicional)
							      / power ( 1.0 + Tasa_Compra_CurvaVR/100, datediff( dd, @dFechaProceso, FechaLiquidacion )/360.0)
								         
							else
					      -( venta_amortiza * ( case when tipo_swap = 2 then IntercPrinc else 1.0 end ) + Venta_flujo_adicional )
					       / power ( 1.0 + Tasa_Venta_CurvaVR/100, datediff( dd, @dFechaProceso, FechaLiquidacion )/360.0
						           )
							end 
							),999),0)
							
--cálculo amortizacion_mtmmo 
	,	amortizacion_mtmmo	= round(BacParamSuda.dbo.fx_convierte_monto(@dFechaProceso,isnull( case when tipo_Flujo = 1 then Compra_moneda else venta_moneda end, 999 ),
								(case	when tipo_flujo = 1 then
                                  (compra_amortiza * ( case when tipo_swap = 2 then IntercPrinc else 1.0 end ) + compra_flujo_adicional)
							      / power ( 1.0 + Tasa_Compra_CurvaVR/100, datediff( dd, @dFechaProceso, FechaLiquidacion )/360.0
								          )
								else
								  -( venta_amortiza * ( case when tipo_swap = 2 then IntercPrinc else 1.0 end ) + Venta_flujo_adicional )
								   / power ( 1.0 + Tasa_Venta_CurvaVR/100, datediff( dd, @dFechaProceso, FechaLiquidacion )/360.0
										   )
								end ),isnull( case when tipo_Flujo = 1 then Compra_moneda else venta_moneda end, 999 )),4)
--interest_nvp
----cálculo interes_mtm			
	,	interes_mtm			=  round(BacParamSuda.dbo.fx_convierte_monto(@dFechaProceso,isnull( case when tipo_Flujo = 1 then Compra_moneda else venta_moneda end, 999 ),
								round( CASE    WHEN tipo_flujo = 1 THEN   Activo_MO_C08  / power ( 1.0 + Tasa_Compra_CurvaVR/100,(datediff( dd, @dFechaProceso, FechaLiquidacion )/360.0) )   
								     WHEN tipo_flujo = 2 THEN - Pasivo_MO_C08  / power ( 1.0 + Tasa_Venta_CurvaVR/100, (datediff( dd, @dFechaProceso, FechaLiquidacion )/360.0) )   
	 							END	    , 4),999),0)
----cálculo interes_mtmmo
	,	interes_mtmmo		=  round(BacParamSuda.dbo.fx_convierte_monto(@dFechaProceso,isnull( case when tipo_Flujo = 1 then Compra_moneda else venta_moneda end, 999 ),
							   round( CASE    WHEN tipo_flujo = 1 THEN   Activo_MO_C08  / power ( 1.0 + Tasa_Compra_CurvaVR/100,(datediff( dd, @dFechaProceso, FechaLiquidacion )/360.0) )   
										 WHEN tipo_flujo = 2 THEN - Pasivo_MO_C08  / power ( 1.0 + Tasa_Venta_CurvaVR/100, (datediff( dd, @dFechaProceso, FechaLiquidacion )/360.0) )   
	 							END	    , 4)
								,isnull( case when tipo_Flujo = 1 then Compra_moneda else venta_moneda end, 999 )),4)
							 -- ,isnull( case when tipo_Flujo = 1 then Recibimos_moneda else pagamos_moneda end, 999 )),4)


--Suma Amortización + Interés	
UPDATE @Flujo_Swap			
set    mtm		=  (CASE WHEN tipo_flujo = 1 then amortizacion_mtm+interes_mtm else abs(amortizacion_mtm+interes_mtm) end)
,	   mtmmo	=  (CASE WHEN tipo_flujo = 1 then amortizacion_mtmmo+interes_mtmmo  else abs(amortizacion_mtmmo+interes_mtmmo ) end)
*/
If @TipoSalida = 1 
	begin
		Insert Into #R07_Flujo_Swap_SALIDA
		Select 
				--versión 3
				LTRIM(CONVERT(CHAR(10),fechaproceso,105))	+ @SEP + LTRIM(sistemaorigen)	+ @SEP +					
				lTRIM(numerooperacion)						+ @SEP + LTRIM(tipoflujo)		+ @SEP +
				LTRIM(numeroflujo)							+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), mtm ) ) , '.', ','))	+ @SEP + 
				lTRIM(REPLACE(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), mtmmo ) ) , '.', ','),' ',''))	AS   REG_SALIDA			
				--LTRIM(numeroflujo)		+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), mtm ) ) )+ @SEP + 
				--lTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), mtmmo ) ),' ',''))	AS   REG_SALIDA			

 		From 
			@Flujo_Swap order by numerooperacion, numeroflujo
	
		Select * from #R07_Flujo_Swap_SALIDA

		Drop table #R07_Flujo_Swap_SALIDA
		return
	end
	else
	begin
		SELECT  
			fechaproceso,tipo_swap,numerooperacion ,tipoflujo, numeroflujo, 
			mtm, mtmmo,amortizacion_mtm,amortizacion_mtmmo,interes_mtm,interes_mtmmo, 
			activo_MO_C08, Pasivo_MO_C08,
			compra_moneda, venta_moneda, Recibimos_moneda, pagamos_moneda, PaisCliente,
			compra_amortiza,venta_amortiza, compra_flujo_adicional, Venta_flujo_adicional,IntercPrinc 

		From
			@Flujo_Swap
			 --WHERE -- compra_moneda=142--
			--numerooperacion in (756,12526)
		--where tipoflujo='PAS'
		order by 			numerooperacion, numeroflujo
		
		DROP TABLE #R07_Flujo_Swap_SALIDA
	end

END 
GO
