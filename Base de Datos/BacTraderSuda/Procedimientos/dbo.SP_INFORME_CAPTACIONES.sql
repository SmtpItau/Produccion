USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CAPTACIONES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_INFORME_CAPTACIONES] (@dfecproc CHAR(8))
AS BEGIN
Set Nocount on 

   DECLARE @ACFECPROC   CHAR(10),
	   @ACFECPROX   CHAR(10),
 	   @UF_HOY      FLOAT,
 	   @UF_MAN      FLOAT,
 	   @IVP_HOY     FLOAT,
	   @IVP_MAN     FLOAT,
	   @DO_HOY      FLOAT,
	   @DO_MAN      FLOAT,
	   @DA_HOY      FLOAT,
	   @DA_MAN      FLOAT,
	   @ACNOMPROP   CHAR(40),
	   @RUT_EMPRESA CHAR(12),
	   @HORA        CHAR(8)
	   ,@numerico	NUMERIC(19,4)	

	SELECT @numerico = 0.0

   EXECUTE dbo.sp_Base_Del_Informe
 	   @acfecproc   OUTPUT,
	   @acfecprox   OUTPUT,
	   @uf_hoy      OUTPUT,
	   @uf_man      OUTPUT,
	   @ivp_hoy     OUTPUT,
	   @ivp_man     OUTPUT,
	   @do_hoy      OUTPUT,
	   @do_man      OUTPUT,
	   @da_hoy      OUTPUT,
	   @da_man      OUTPUT,
	   @acnomprop   OUTPUT,
	   @rut_empresa OUTPUT,
	   @hora        OUTPUT

	SELECT 	'OPERACION'     = numero_operacion,
		'CLIENTE'	= ( SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = rut_cliente AND clcodigo = codigo_rut),
		'FECHA_INICIO'  = fecha_operacion,
		'FECHA_VCTO'	= fecha_vencimiento,
		'PLAZO'		= plazo,
		'TASA'		= tasa,
		'CANT'		= 1,
/*		'CANT'		= (SELECT COUNT(b.correla_corte)
                                     FROM GEN_CAPTACION as b
                                    WHERE b.estado      <> 'A'	 
                                      AND b.monto_final  >  0
                                      AND b.correla_corte = A.correla_corte 
                                      AND b.numero_operacion = A.numero_operacion 
                                 GROUP BY b.correla_corte)                       */
		'CORRELA_OP'    = correla_operacion,
		'CORRELA_COR'	= correla_corte,
		'MONEDA'	= moneda,
		'NOM_MONEDA'	= ( SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = moneda),
		'GLO_MONEDA'	= ( SELECT mnglosa FROM VIEW_MONEDA WHERE mncodmon = moneda),
		'MONTO_INICIO'  = monto_inicio_pesos,
		'MONTO_FINAL'   = monto_final,
		'VALOR_INICIAL_CORTE_P'  = CASE WHEN moneda = 13 THEN 0 ELSE monto_inicio_pesos END,
		'VALOR_INICIAL_CORTE_UM' = ( (CASE WHEN moneda <> '999' AND moneda <> '13' THEN
						 Round((monto_inicio_pesos  / (case (SELECT VMVALOR FROM VIEW_VALOR_MONEDA WHERE vmcodigo = moneda AND vmfecha = fecha_operacion) when 0 then 1 else (SELECT VMVALOR FROM VIEW_VALOR_MONEDA WHERE vmcodigo = moneda AND vmfecha = fecha_operacion) end)),2)
						WHEN moneda = '999' OR moneda = '13' THEN
						 (SELECT monto_inicio_pesos)
					   ELSE	
						(SELECT 0)
					   END) ),
		'VALOR_FINAL_CORTE_UM' = monto_final,--((SELECT COUNT(correla_corte)FROM GEN_CAPTACION WHERE correla_corte = A.correla_corte AND numero_operacion = A.numero_operacion GROUP BY correla_corte) *  monto_final) ,
		'VALOR_TOTAL_INICIAL_P'  = CASE WHEN moneda = 13 THEN 0 
                                                                 ELSE ((SELECT COUNT(correla_corte)
                                                                          FROM GEN_CAPTACION as b
                                                                         WHERE b.estado      <> 'A'	 
                                                                           AND b.monto_final  >  0
                                                                           AND b.correla_corte = A.correla_corte 
                                                                           AND b.numero_operacion = A.numero_operacion 
                                                                           AND b.numero_operacion = A.numero_operacion 
                                                                     GROUP BY b.correla_corte) * monto_inicio_pesos) END,

		'VALOR_TOTAL_INICIAL_UM' = @numerico,--SPACE(31), 
		'VALOR_TOTAL_FINAL_UM'	 = @numerico,--SPACE(31), 

		'INTERES_ACUMULADO_CORTE_UM' = @numerico,--SPACE(31),
		'INTERES_ACUMULADO_TOTAL_UM' = @numerico,--SPACE(31),
		'HORA'    = CONVERT(CHAR(8),getdate(),108),
		'FECHA_PROCESO' = CONVERT(DATETIME,@dfecproc),
                'RUT_EMPRESA'   = ACRUTPROP,
                'DIG_EMPRESA'   = ACDIGPROP,
                'BANCO'         = ACNOMPROP, 
                'numero_certificado_dcv'     = numero_certificado_dcv,
                'MIGRADO'		= '       '	-->jcamposd 20170718 para marcar migrados
	INTO #TMP_CAP	
	FROM GEN_CAPTACION A,MDAC
	WHERE fecha_vencimiento > acfecproc  AND
	    estado 			<> 'A'	     AND
		monto_final     >  0        


	--+++jcamposd 20170718 para marcar migrados

	UPDATE #TMP_CAP
	SET MIGRADO = CASE WHEN RTRIM(LTRIM(mousuario)) = 'USRMGCN' THEN 'Migrado' ELSE '' END
	FROM MDMO AS mov
	WHERE mov.monumdocu = OPERACION
		AND mocorrela = CORRELA_OP
		AND moinstser = 'CAP'
	--para las historicas
	UPDATE #TMP_CAP
	SET MIGRADO = CASE WHEN RTRIM(LTRIM(mousuario)) = 'USRMGCN' THEN 'Migrado' ELSE '' END
	FROM MDMH AS mov
	WHERE mov.monumdocu = OPERACION
		AND mocorrela = CORRELA_OP
		AND moinstser = 'CAP'
		
	-----jcamposd 20170718 para marcar migrados
	


	-- CALCULOS DE MONTOS TOTALES E INTERESE POR UM
	UPDATE 	#TMP_CAP SET
		VALOR_TOTAL_INICIAL_UM  = CONVERT (numeric(19,4),(Round(VALOR_INICIAL_CORTE_UM * CANT,2) )) ,
		VALOR_TOTAL_FINAL_UM	= CONVERT (numeric(19,4),(Round(VALOR_FINAL_CORTE_UM * CANT,2))) ,
		INTERES_ACUMULADO_CORTE_UM = ROUND( CONVERT( NUMERIC(19,4), VALOR_INICIAL_CORTE_UM * ( TASA * (1 + DATEDIFF ( dd,FECHA_INICIO, FECHA_PROCESO)) / (CASE WHEN MONEDA = '999' THEN 3000 ELSE 36000 END) ) ), CASE WHEN MONEDA = '999' THEN 0 ELSE 2 END) ,
		INTERES_ACUMULADO_TOTAL_UM = ROUND(CONVERT( NUMERIC(19,4), VALOR_INICIAL_CORTE_UM * ( TASA * (1 + DATEDIFF ( dd,FECHA_INICIO, FECHA_PROCESO)) / (CASE WHEN MONEDA = '999' THEN 3000 ELSE 36000 END) )  ), CASE WHEN MONEDA = '999' THEN 0 ELSE 2 END) * CANT


	FROM #TMP_CAP A
	WHERE  A.OPERACION = OPERACION AND A.CORRELA_COR = CORRELA_COR AND A.CORRELA_OP  = CORRELA_OP  AND OPERACION = A.OPERACION 

	SELECT 	OPERACION,
		CLIENTE,
		FECHA_INICIO,
		FECHA_VCTO,
		PLAZO,
		TASA,
		CANT,
		CORRELA_OP,
		CORRELA_COR,
		NOM_MONEDA,
		MONTO_INICIO,
		MONTO_FINAL,
		VALOR_INICIAL_CORTE_P,
		VALOR_INICIAL_CORTE_UM,					
		VALOR_FINAL_CORTE_UM,
		VALOR_TOTAL_INICIAL_P,
		'VALOR_TOTAL_INICIAL_UM'  = CONVERT ( NUMERIC(19,4),VALOR_TOTAL_INICIAL_UM ) ,
		'VALOR_TOTAL_FINAL_UM' = CONVERT ( NUMERIC(19,4), VALOR_TOTAL_FINAL_UM),
		'INTERES_ACUMULADO_CORTE_UM'  = CONVERT ( NUMERIC(19,4),INTERES_ACUMULADO_CORTE_UM),
		'INTERES_ACUMULADO_TOTAL_UM'  =	CONVERT ( NUMERIC(19,4),INTERES_ACUMULADO_TOTAL_UM),
		'UF_HOY' = @UF_HOY,
		'IVP_HOY' = @IVP_HOY,
		'DO_HOY' = @DO_HOY,
		'DA_HOY' = @DA_HOY,
		HORA,
		FECHA_PROCESO,
		GLO_MONEDA,
		RUT_EMPRESA,
		DIG_EMPRESA,
		BANCO, 
		numero_certificado_dcv,
		MIGRADO
	 FROM #TMP_CAP 
	GROUP BY OPERACION,
		CLIENTE,
		FECHA_INICIO,
		FECHA_VCTO,
		PLAZO,
		TASA,
		CORRELA_OP,
		CORRELA_COR,
		NOM_MONEDA,
		CANT,
		MONTO_INICIO,
		MONTO_FINAL,
		VALOR_INICIAL_CORTE_P,
		VALOR_INICIAL_CORTE_UM,				
		VALOR_FINAL_CORTE_UM,
		VALOR_TOTAL_INICIAL_P,
		VALOR_TOTAL_INICIAL_UM,
		VALOR_TOTAL_FINAL_UM,
		INTERES_ACUMULADO_CORTE_UM,
		INTERES_ACUMULADO_TOTAL_UM,
		HORA,
		FECHA_PROCESO,
		GLO_MONEDA,
		RUT_EMPRESA,
		DIG_EMPRESA,
		BANCO,
		numero_certificado_dcv,
		MIGRADO
	ORDER BY NOM_MONEDA DESC
END
GO
