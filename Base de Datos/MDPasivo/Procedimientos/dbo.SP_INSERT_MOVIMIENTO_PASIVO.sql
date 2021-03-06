USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_MOVIMIENTO_PASIVO]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_MOVIMIENTO_PASIVO]
AS
BEGIN

DELETE MOVIMIENTO_PASIVO 

INSERT INTO MOVIMIENTO_PASIVO 
			( entidad_cartera,
			  codigo_instrumento,
			  numero_operacion,
			  numero_correlativo,
			  fecha_movimiento,
			  tipo_operacion,
			  numero_contrato,
			  nombre_serie,
			  fecha_emision_papel,
			  fecha_vencimiento,
			  fecha_proximo_cupon,
			  fecha_anterior_cupon,
			  fecha_colocacion,
			  rut_emisor,
			  rut_cliente,
			  codigo_cliente,
			  numero_cuotas,
			  periodo_amortizacion,
			  moneda_emision,
			  nominal,
			  nominal_pesos,
			  tasa_emision,
			  codigo_base,
			  valor_emision_pesos,
			  valor_emision_um,
			  saldo_flujo_emision,
			  presente_emision,
			  proximo_emision,
			  valor_par_emision,
			  tasa_colocacion,
			  base_colocacion,
			  valor_colocacion_clp,
			  valor_colocacion_um,
			  presente_colocacion,
			  proximo_colocacion,
			  valor_par_colocacion,
			  forma_pago,
			  tipo_tasa,
			  spread,
			  prima,
			  descuento,
			  operador,
			  terminal,
			  hora,
			  tipo_mercado,
			  impreso,
			  pago_hoy_man,
			  retiro_documento,
			  rut_acreedor,
			  dv_acreedor,
			  nombre_acreedor,
			  codigo_area,
			  sucursal,
			  observacion,
			  numero_pu,
			  keyid_deskmanager,
			  libro_deskmanager,
			  premio,
			  estado_operacion,
			  numero_anterior,
			  operador_anulacion,
			  hora_anulacion,
			  cuenta_contable,
			  forma_pago_ven,
			  numero_decimales,
			  Periodo_Gracia,
			  premio_acum,
			  descto_acum
			)
			SELECT 
			   1,
			   MHCODI,
			   MHNUMOPER,
			   MHCORRELA,
			   MHFECHA,
			   'ING',
			   ISNULL((SELECT 	numero_contrato 
 			   	   FROM	 	CARTERA_PASIVO 
 			   	   WHERE 	mhnumoper = cartera_pasivo.numero_operacion AND
						mhcorrela = cartera_pasivo.numero_correlativo),0),
			   MHINSTSER,
			   MHFECEMIS,
			   MHFECVCTO,
			   ISNULL((SELECT	fecha_proximo_cupon 
 			    	   FROM		CARTERA_PASIVO 
 			           WHERE 	mhnumoper = cartera_pasivo.numero_operacion AND
						mhcorrela = cartera_pasivo.numero_correlativo),'19990101'),


			   ISNULL((SELECT	fecha_anterior_cupon 
 			    	   FROM		CARTERA_PASIVO 
 			           WHERE 	mhnumoper = cartera_pasivo.numero_operacion AND
						mhcorrela = cartera_pasivo.numero_correlativo),'19990101'),

			   MHFECCOMP,
			   MHRUTEMIS,
			   MHRUTCLIC,
			   1,
			   ISNULL((SELECT 	numero_cuotas 
 			           FROM 	CARTERA_PASIVO 
 			           WHERE 	mhnumoper = cartera_pasivo.numero_operacion AND
						mhcorrela = cartera_pasivo.numero_correlativo),0),

			   ISNULL((SELECT 	perido_amortizacion
 			   	   FROM 	CARTERA_PASIVO
			   	   WHERE 	mhnumoper = cartera_pasivo.numero_operacion AND
						mhcorrela = cartera_pasivo.numero_correlativo),0),


			   CASE  WHEN MHMONEMIS = 901 THEN 997
			   ELSE
				MHMONEMIS   
			   END,
	
			   MHNOMINAL,
			   MHVALCOMP,

			   ISNULL((SELECT 	tasa_emision
 			   	   FROM 	CARTERA_PASIVO
			   	   WHERE 	mhnumoper = cartera_pasivo.numero_operacion AND
						mhcorrela = cartera_pasivo.numero_correlativo),0),


			   MHBTSEMIS,
			   MHNOMINAL,
			   MHVALCOMP,
			   MHNOMINAL,
			   MHVPRESEN,
			   MHVPRESEN,
			   MHPRCVPAR,
			   MHTIRCOMP,
			   MHBTSCOMP,
			   MHVALVENP,
			   MHVALVENU,
			   MHVALVENP,
			   MHVALVENP,
			   MHVALPARC,
			   CASE  WHEN MHFORPAGO = 2   THEN 3	
				 WHEN MHFORPAGO = 3   THEN 2
				 WHEN MHFORPAGO = 4   THEN 1
				 WHEN MHFORPAGO = 5   THEN 4
				 WHEN MHFORPAGO = 20  THEN 7
			  ELSE
				3	
			   END,

			   CASE  WHEN MHCARTERA='141' or MHCARTERA='142' THEN 333
			   ELSE
				0   
			   END,

			   0,
			   MHPRIMACO,
			   MHDSCTOCO,
			   '',
			   '',
			   '',
			   0,
			   'S',
			   0,
			   0,
			   0,
			   '',
			   '',
			   0,
			   88,
			   '',
			   '',
			   0,
			   0,
			   0,
			   '',
			   0,
			   '',
			   '',
			   '',
			   0,
			   4,
			   0,
			   0,
			   0

 

			FROM 	DESARROLLO.MDMH 
			  
END




GO
