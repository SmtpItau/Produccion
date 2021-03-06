USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERAFRA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARTERAFRA](   
					@TipOpe  CHAR	(1) 	,
					@Cartera Integer
					)
AS
BEGIN

  DECLARE @dFecha      	 CHAR (08)	,
	  @NomBco      	 CHAR (70) 	,
	  @FechaProc   	 CHAR (10)	,
  	  @Glosa_Cartera Char (20)

Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'PCS'
     And  rcrut     = @Cartera
	--ORDER BY rcrut  

  if @Glosa_Cartera = '' 
		Select @Glosa_Cartera = '< TODAS >'  

	SELECT	@dFecha = CONVERT(CHAR(8),fechaproc,112),
		@FechaProc = CONVERT(CHAR(10),fechaproc,103),
		@NomBco = ISNULL(Nombre,'***')
	FROM SwapGeneral

	SELECT	'Nro'           = numero_operacion,
		'Cliente'       = ISNULL((SELECT clnombre FROM view_cliente WHERE clcodigo = codigo_cliente and clrut = Rut_cliente),' ') ,
		'Cierre'        = fecha_cierre,
		'Inicio'        = fecha_inicio_flujo,
		'Término'       = fecha_vence_flujo,
		'Capital'       = compra_capital,
		'Tasa'          = ISNULL(b.tbglosa,'***'),
		'Periodo'       = ISNULL(d.glosa,'***'),
		'TasaContrato'  = CASE tipo_operacion WHEN 'C' THEN compra_valor_tasa   ELSE venta_valor_tasa   END,
		'InteresInicial'= CASE tipo_operacion WHEN 'C' THEN compra_interes      ELSE venta_interes      END,
		'TasaMercado'   = CASE tipo_operacion WHEN 'V' THEN compra_mercado_tasa ELSE venta_mercado_tasa END,
		'Interes'       = CASE tipo_operacion WHEN 'V' THEN compra_mercado_clp  ELSE venta_mercado_clp  END,
		'MtoLiquidarMO' = monto_mtm,
		'MtoLiquidar'   = monto_mtm_clp,
		'CodMoneda'     = compra_moneda,
		'Moneda'        = c.mnnemo,
		'Cartera'       =    (SELECT Distinct
					IsNull(rcnombre,'')
				     FROM   BacParamSuda..TIPO_CARTERA
				     WHERE  rcsistema = 'PCS'
				     And    rcrut     = cartera_inversion),
		'TipOpe'        = tipo_operacion,
		'NomBaco'	= @NomBco,
		'Hora'		= CONVERT (CHAR (8) , getdate(),114),		
		'FechaProc'	= @FechaProc			,
		'Tipo_Cartera'	= @Glosa_Cartera
	FROM Cartera    		     
         LEFT JOIN view_tabla_general_detalle  b ON b.TBCATEG      = 1042        AND compra_codigo_tasa    = b.TBCODIGO1  -- Tasas
         LEFT JOIN view_moneda      		   c ON compra_moneda  = c.mncodmon  -- Monedas
         LEFT JOIN View_Periodo_Amortizacion   d ON d.tabla        = 1044        AND compra_codamo_interes = d.codigo  -- Amortiza Intereses

	WHERE tipo_swap = 3
        AND (@TipOpe = '' OR tipo_operacion = @TipOpe OR (@TipOpe = 'X' AND fecha_termino = @dFecha))
	And (cartera_inversion = @Cartera Or @Cartera = 0)

END

GO
