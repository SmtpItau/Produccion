USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_CARTERA_PASIVO]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_CARTERA_PASIVO]
AS
BEGIN
 
DELETE CARTERA_PASIVO

--6757047

INSERT INTO CARTERA_PASIVO 
			( entidad_cartera,
			  codigo_instrumento,
			  numero_operacion,
			  numero_correlativo,
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
			  perido_amortizacion,
		  	  moneda_emision,
			  nominal,
			  nominal_pesos,
			  tasa_emision,
			  codigo_base,
			  valor_emision_pesos,
			  valor_emision_um,
			  saldo_flujo_emision,
			  reajuste_emision,
			  interes_emision,
			  presente_emision,
			  proximo_emision,
			  valor_par_emision,
			  tasa_colocacion,
			  base_colocacion,
			  valor_colocacion_clp,
			  valor_colocacion_um,
			  reajuste_colocacion,
			  interes_colocacion,
			  presente_colocacion,
			  proximo_colocacion,
			  valor_par_colocacion,
			  forma_pago,
			  tipo_tasa,
			  spread,
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
			  descuento,
			  numero_anterior,
			  cuenta_contable,
			  estado_operacion,
			  forma_pago_ven,
			  premio_acum,
			  descto_acum

			)
			SELECT 
			   '1',
			   CACODIGO,
			   CANUMOPER,
			   CACORRELA,
			   ISNULL(CAACUERDO,0),
			   CAINSTSER,
			   CAFECEMIS,
			   CAFECVCTO,
			   CAFECPCUP,
			   ISNULL(CAULTPCUP, CAFECCUP),
			   CAFECCOMP,
			   ISNULL(CARUTEMIS,0),
			   CASE WHEN CACARTERA = 141 THEN 60706000
				ELSE CARUTCLIC END,
			   1,
			   ISNULL(CANCUOTAS,0),
			   ISNULL(CAPERIODO,0),
			   (CASE WHEN CAMONEMIS  = 901 THEN 997
			         ELSE CAMONEMIS END ),
			   CANOMINAL,
			   CAVALCOMP,
			   CATASEMIS,
			   CABTSEMIS,
			   CAVPRESEN,
			   CAVALCOMU,
			   CANOMIREAL,
			   ISNULL(CAREAJUSTE,0),
			   ISNULL(CAINTERES,0),
			   CAVPRESEN,
			   0, 
 			   ISNULL(CAVALPARC,0),
			   ISNULL(CATIRVENT,0),
			   ISNULL(CABTRVENT,0),
			   ISNULL(CAVALVENP,0),
			   ISNULL(CAVALVENU,0),
			   ISNULL(CAREAVENT,0),
			   ISNULL(CAINTVENT,0),
			   ISNULL(CAVPRVENT,0),
			   ISNULL(CAVPXVENT,0),
			   ISNULL(CAVALPARC,0), 
			   CASE WHEN CAFORPAGO = 2  THEN 3 
				WHEN CAFORPAGO = 3  THEN 2
				WHEN CAFORPAGO = 4  THEN 1
				WHEN CAFORPAGO = 5  THEN 4
				WHEN CAFORPAGO = 20 THEN 7	
			   END,
			
			   CASE WHEN CACARTERA = '141' or CACARTERA = '142' THEN 333
			   ELSE 
				0
 			   END,
			   0,
			   0,
			   0,
			   '',
			   '',
			   0,
			   0,
			   '',
		           '',
			   0,
			   0,
			   0,
			   0,
			   0,
			   '',
			   '',
			   0,
			   0,
			   0
			
			FROM 	DESARROLLO.MDCA
				


DECLARE @numoper Numeric(5),
	@correla Numeric(5),
	@valppro Float

	select @valppro = 0

Declare resulta Cursor For
Select rsnumoper, rscorrela, rsvlpsppp
From   desarrollo.MdRs
Open resulta 
Fetch Next From resulta
Into @numoper, @correla, @valppro

While @@Fetch_Status = 0 Begin

	If Exists(select * from CARTERA_PASIVO where numero_operacion = @numoper AND numero_correlativo = @correla) Begin
		update CARTERA_PASIVO SET proximo_emision = (select isnull(@valppro,0) from CARTERA_PASIVO where numero_operacion = @numoper AND numero_correlativo = @correla)
	End

/*
	UPDATE CARTERA_PASIVO SET proximo_emision = 
		  	    (SELECT  isnull(A.RSVLPSPPP ,0)
			    FROM    DESARROLLO.MDRS A,
				    CARTERA_PASIVO  B	
			    WHERE   B.numero_operacion   = @numoper   AND
				    --B.retiro_documento   = A.RSNUMDOCU AND
			            B.numero_correlativo = @correla)
*/
	Fetch Next From resulta
	Into @numoper, @correla, @valppro
End
Close resulta
DealLocate resulta

END



/*
DELETE CARTERA_PASIVO

SELECT * FROM MDRS
SELECT * FROM MDCA  WHERE CANUMOPER=1079 AND CACORRELA = 1
SELECT * FROM MDRS  WHERE RSNUMOPER=1079 AND RSCORRELA = 2


SELECT * FROM CARTERA_PASIVO ORDER BY numero_operacion ,numero_correlativo
SELECT * FROM CARTERA_PASIVO WHERE NUMERO_OPERACION = 702


SELECT  A.RSVLPSPPP 
			    FROM    DESARROLLO.MDRS A,
				    CARTERA_PASIVO  B	
			    WHERE   A.RSNUMOPER = B.numero_operacion     AND
			            A.RSCORRELA = B.numero_correlativo


*/
GO
