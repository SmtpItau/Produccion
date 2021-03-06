USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_MTM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_MTM]   
AS BEGIN

DECLARE @uf		NUMERIC(18,2)	,
	@us		NUMERIC(18,2)	,
	@fecha_proc     DATETIME	,	
	@Banco          CHAR(70)	,	
	@Cont           INTEGER		,
	@Reg		INTEGER		,
	@Numero		NUMERIC(   6)	,
	@Numero_Flujo   NUMERIC(   4)	,
	@Tipo_Flujo     CHAR(1)		,
	@ValorP1        FLOAT		,
	@Moneda		INTEGER		,
	@Valor		FLOAT		,
	@ValorSS        FLOAT		,
	@ValorUS        FLOAT		,
	@VPSS		FLOAT		,
	@TFSS		FLOAT		,
	@DISS		FLOAT		,
	@Producto       NUMERIC(1)	,
	@Serie          CHAR(15)	,
	@Convertir      CHAR( 1)        ,
	@Total_Flujo    FLOAT		,
	@Valor_Presente FLOAT		,
	@Diferencia     FLOAT		,
	@Codigo_Papel   NUMERIC(4)


	SELECT @fecha_proc = fechaproc , @Banco = Nombre FROM swapgeneral
	SELECT @uf         = ISNULL(vmvalor,0)  FROM view_valor_moneda WHERE vmfecha = @fecha_proc AND vmcodigo = 998
	SELECT @us         = ISNULL(vmvalor,0)  FROM view_valor_moneda WHERE vmfecha = @fecha_proc AND vmcodigo = 994

	SELECT  'Capital'          = (CASE Tipo_Operacion WHEN 'C' THEN Compra_Capital ELSE Venta_Capital END),
		'Fecha_Inicio'     = CONVERT(CHAR(10),Fecha_Inicio,103),
		'Fecha_Cierre'     = CONVERT(CHAR(10),Fecha_Termino,103),
		'Fixed_Payer'      = (CASE Tipo_Swap WHEN 1 THEN Venta_Valor_Tasa 
                                                     WHEN 2 THEN Venta_Valor_Tasa
						     WHEN 3 THEN Compra_Valor_Tasa 
				      END),
                'Fixed_Payer_T'    = (CASE Venta_Codigo_Tasa WHEN 0 THEN 'FIJA' ELSE ISNULL((SELECT TBGLOSA FROM view_tabla_general_detalle WHERE TBCODIGO1 = venta_codigo_tasa 
					  AND TBCATEG = 1042),' ') END) ,
                'FLOATING_PAYER'   = (CASE Tipo_Swap WHEN 1 THEN Compra_Valor_Tasa
		                                     WHEN 2 THEN Compra_Valor_Tasa
				      		     WHEN 3 THEN Venta_Valor_Tasa 
				      END) ,
                'FLOATING_PAYER_T' = (CASE Compra_Codigo_Tasa WHEN 0 THEN 'FIJA' ELSE ISNULL((SELECT TBGLOSA FROM view_tabla_general_detalle WHERE TBCODIGO1 = compra_codigo_tasa 
					  AND TBCATEG = 1042),' ') END) ,
                'DATE1'            = Fecha_Vence_Flujo,
                'DAY'  		   = ISNULL(DATEDIFF(day,@FECHA_PROC,Fecha_Vence_Flujo),0) ,
                'FIXED_SIDE'       = (CASE Tipo_Swap  WHEN 1 THEN (CASE Tipo_Flujo WHEN 1 THEN Compra_Interes ELSE Venta_Interes END) 
						      WHEN 2 THEN (CASE Tipo_Flujo WHEN 1 THEN (Compra_Interes + Compra_Amortiza) ELSE (Venta_Interes + Venta_Amortiza) END)	
						      WHEN 3 THEN 0 								
				      END) ,

		'VPRESENTE'	   = (CASE WHEN Tipo_Flujo = 1 AND compra_Valor_Presente = 0 THEN Compra_Interes 
					   WHEN Tipo_Flujo = 2 AND venta_Valor_Presente = 0 THEN Venta_Interes 
					   ELSE compra_Valor_Presente 
				      END),
               'MARKET_RATE'       = (CASE Tipo_Operacion WHEN 'C' THEN Compra_Mercado_Tasa ELSE Venta_Mercado_Tasa END) ,                                     
               'NPV'		   = devengo_monto	,     
	       'Visible' 	   = (CASE WHEN (Fecha_Inicio_Flujo <= @fecha_proc AND Fecha_Vence_Flujo >= @fecha_proc) OR (Tipo_Flujo = 1 AND Compra_Codigo_Tasa = 0) OR (Tipo_Flujo = 1 AND Venta_Codigo_Tasa = 0)
    					  THEN 'S' ELSE  'N' END),
               Tipo_Flujo	,
               Tipo_Operacion	,
	       Numero_Flujo	,
               Numero_Operacion ,
	       'Fecha_Vence_Flujo' = CONVERT(CHAR(10),Fecha_Vence_Flujo,103), 	
               'Cliente'           = (SELECT clnombre FROM view_cliente WHERE clrut = rut_cliente AND CLCODIGO = codigo_cliente),
	       'NomBco'   	   = @Banco,
	       'UF'                = @UF,
	       'US'                = @US,
               'FECHA_PROC'        =  CONVERT(CHAR(10),@fecha_proc,103),
	       'Producto'          = Tipo_Swap,
--	       'Serie'		   = Serie,
	       'Moneda'		   = (CASE Tipo_Flujo WHEN 1 THEN Compra_Moneda ELSE Venta_Moneda END),
	       'Nemo_Moneda'	   = SPACE(10),
	       'ValorSS'	   = CONVERT(FLOAT,0),	
	       'Diferencia'	   = CONVERT(FLOAT,0),
	       'VPSS'  		   = CONVERT(FLOAT,0),
	       'TFSS'	 	   = CONVERT(FLOAT,0),
	       'DISS'		   = CONVERT(FLOAT,0)	
--	       'Codigo_Papel'      = Codigo_Papel		
	
	       INTO #Paso	
               FROM cartera  --WHERE numero_operacion = @OPERACION
               where estado <> 'C'
               ORDER BY tipo_flujo ,numero_flujo

/*
	SELECT @Reg = COUNT(*) FROM #Paso
	SELECT @Cont = 1


WHILE @Cont <=  @Reg
BEGIN
	SET ROWCOUNT @Cont
	SELECT @Numero	      = Numero_Operacion,
	       @Numero_Flujo  = Numero_Flujo,
	       @Tipo_Flujo    = Tipo_Flujo,
	       @Moneda	      = Moneda,
	       @Valor         = NPV,
	       @Producto      = Producto,
	       @Serie         = Serie	,
	       @Total_Flujo   = FIXED_SIDE,
	       @Valor_Presente= VPresente,
	       @Diferencia    = ROUND(NPV - VPresente,2),
	       @DISS	      = ROUND(NPV - VPresente,0),
	       @ValorSS       = NPV,		       
	       @VPSS  	      = VPRESENTE,
	       @TFSS	      = FIXED_SIDE,	       
	       @Codigo_Papel  = Codigo_Papel	
	  FROM #Paso
	SET ROWCOUNT 0
	
--	SELECT @Convertir,'VPTM' = @ValorSS,'Dif'=@Diferencia,'VP'=@VPSS,'Tf' = @TFSS,'Dif'=@DISS

	SELECT @Convertir = 'S'	
	 IF @Producto = 4 BEGIN	
			
		    SELECT @Moneda = ISNULL(inmonemi,0) FROM BACTRADERDEUTSCHE..mdin WHERE  incodigo = @Codigo_Papel   		    

		    IF @Moneda <> 13 Or @Moneda <> 994 Or @Moneda <> 995 BEGIN 
			SELECT @Convertir = 'N'								 
		    END					
	END
	
	IF @Convertir = 'S' BEGIN		
		EXECUTE CONVERSION @Total_Flujo    , @Moneda , @UF, @US , @FECHA_PROC, @TFSS    OUTPUT, @ValorUS    OUTPUT  --Total Flujo
		EXECUTE CONVERSION @Valor_Presente , @Moneda , @UF, @US , @FECHA_PROC, @VPSS    OUTPUT, @ValorUS    OUTPUT  --VP Tasa Cont
		EXECUTE CONVERSION @Valor 	   , @Moneda , @UF, @US , @FECHA_PROC, @ValorSS OUTPUT, @ValorUS    OUTPUT  --VP Tasa MTM
		EXECUTE CONVERSION @Diferencia     , @Moneda , @UF, @US , @FECHA_PROC, @DISS    OUTPUT, @ValorUS    OUTPUT  --Diferencia
	END
	

	UPDATE #Paso Set ValorSS     = @ValorSS, 
			 Nemo_Moneda = (SELECT mnnemo FROM mdmn WHERE mncodmon = @Moneda ),
			 Diferencia  = @Diferencia,
	       		 VPSS        = @VPSS,
	                 TFSS  	     = @TFSS,
	       		 DISS        = @DISS
	WHERE  Numero_Operacion  = @Numero
	 AND   Numero_Flujo      = @Numero_Flujo
	 AND   Tipo_Flujo        = @Tipo_Flujo

	SELECT @Cont = @Cont + 1
END
*/
	SELECT * FROM #Paso
END
GO
