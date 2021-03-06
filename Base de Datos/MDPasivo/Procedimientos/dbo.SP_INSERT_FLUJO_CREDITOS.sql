USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_FLUJO_CREDITOS]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_FLUJO_CREDITOS]
AS
BEGIN

DELETE FLUJO_CREDITOS
 
INSERT INTO FLUJO_CREDITOS 
			( fecha_movimiento,
			  entidad_cartera,
			  codigo_instrumento,
			  numero_operacion,
			  numero_correlativo,
			  cuota_correlativo,
			  tipo_operacion,
			  cuota_vencimiento,	
			  cuota_capital,
		          cuota_interes,
			  cuota_flujo,
		          cuota_saldo,
			  cuota_tasa,
			  tipo_cuota
			)
			SELECT 
			   ISNULL((SELECT CAFECCOMP FROM desarrollo.mdca WHERE tvnumoper = canumoper),0),
			   '1',
			   ISNULL((SELECT CACODIGO  FROM desarrollo.mdca WHERE tvnumoper = canumoper),0),
			   TVNUMOPER,
			   1,
			   TVCORRELA,
			   'ING',
			   TVFECVCTO,
			   TVMONCTAS,
			   ISNULL(TVINTERES,0),
			   ISNULL(TVFLUJO,0),
			   ISNULL(TVSALDOS,0),
			   0,
			   ''
			
			FROM 	DESARROLLO.MDTV 
			  
END

GO
