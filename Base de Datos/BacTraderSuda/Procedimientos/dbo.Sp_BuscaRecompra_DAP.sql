USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BuscaRecompra_DAP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_BuscaRecompra_DAP]
	(@NUMOPER  NUMERIC(10,0), @NUSER  CHAR(20)='')
AS 
BEGIN
/*****************************************************************************************
Autor     : Felipe Silva
Motivo    : Se agregan nuevos campos por desarrollo de RESCATE DE DAP BANCO EMISOR
Y RECOMPRA ANTICIPADA DE DEPÓSITOS
Fecha     : 16/02/2009
Autor     : Mantencion SONDA
Motivo    : Rescate de Recompras DAP con Fecha De Proceso.
Fecha     : 17/03/2009

******************************************************************************************/
SET NOCOUNT ON

DECLARE @SFORPAI    CHAR(25)
	, @SFORPAV    CHAR(25)
	, @STIPCAR    CHAR(25)
	, @NVALMON    FLOAT
	, @NTOTMTOINI    FLOAT
	, @NTOTMTOFIN    FLOAT

	SELECT GEN_CAPTACION.*
	INTO #GEN_CAPTACION
	FROM GEN_CAPTACION With(Nolock)
		INNER JOIN MDAC  With(Nolock) ON 
			GEN_CAPTACION.FECHA_VENCIMIENTO = MDAC.ACFECPROC
	WHERE NUMERO_OPERACION = @NUMOPER
		AND TIPO_OPERACION   = 'RIC'
		AND ESTADO  IN ('','V')
		AND MONTO_INICIO > 0

	IF EXISTS(SELECT 1  FROM #GEN_CAPTACION)
	BEGIN
		SELECT @SFORPAV    = ''
		, @STIPCAR    = ''
		, @NVALMON    = 1.0

		SELECT @NVALMON = ISNULL(VMVALOR,0)
		FROM VIEW_VALOR_MONEDA
		, #GEN_CAPTACION
		WHERE (VMCODIGO = MONEDA
		AND  VMFECHA  = FECHA_OPERACION)
		AND  MONEDA  <> 999



		SELECT 'TIPOPER'             = a.TIPO_OPERACION                         -- 1
		, 'F_EMISION'                = CONVERT(CHAR(10),a.FECHA_OPERACION,103)  -- 2
		, 'DIAS'                     = CONVERT(CHAR(10),a.PLAZO)                -- 3
		, 'F_VENCIMIENTO'            = CONVERT(CHAR(10),a.FECHA_VENCIMIENTO,103)-- 4
		, 'MONEDA'                   = MNNEMO                                   -- 5
		, 'TASA'                     = a.TASA					                -- 6
		, 'RUT_CARTERA'              = CONVERT(CHAR(9),a.ENTIDAD)               -- 7
		, 'TIPO_CARTERA'             = @STIPCAR                                 -- 8
		, 'FORMA_PAGO_INICIO'        = GLOSA                                    -- 9
		, 'FORMA_PAGO_VENCIMIENTO'   = @SFORPAV                                 -- 10
		, 'TIPO_RETIRO'              = a.RETIRO                                 -- 11
		, 'RUT_CLI'                  = CONVERT(CHAR(09),a.RUT_CLIENTE)          -- 12
		, 'DIG_CLI'                  = CONVERT(CHAR(7),a.CODIGO_RUT)            -- 13
		, 'NUMERO_CORRELACION'       = a.correla_operacion                      -- 14
		, 'NUMERO_CORRELACION_corte' = a.correla_corte                          -- 15
		, 'MONTO_INICIAL_CORTE'      = a.monto_inicio                           -- 16
		, 'TASA_TRAN'                = a.tasa_tran                              -- 17
		, 'CUSTODIA'                 = a.custodia                               -- 18
		, 'TIPO_DEPOSITO'            = a.tipo_deposito                          -- 19
		, 'CONDICION'                = a.Condicion_Captacion                    -- 20
		, 'TIPO_EMISION'             = a.Tipo_Emision                           -- 21
		, 'NUMERO_DCV'               = a.numero_certificado_dcv                 -- 22
		, 'CORTE_MAXIMO'             = A.correla_operacion                      -- 23
		, 'Plazo'                    = B.PLAZO                                  -- 24
		, 'DCV'                      = modcv                                    -- 25
		, 'CLAVE_DCV'                = moclave_dcv                              -- 26
		, 'Valor_Presente'           = a.valor_presente    --movalvenp								  -- 27
		, 'Valor_Interes'            = a.interes_acumulado --a.monto_final-a.monto_inicio             -- 28
		, 'Valor_Reajuste'           = a.reajuste_acumulado                     -- 29
		, 'Vcto_Original'            = CONVERT(CHAR(10),B.FECHA_VENCIMIENTO,103)-- 30
		--+++jcamposd 20151106 recalculo recompra dap
		, 'Monto_Final'			   = a.monto_final							  -- 31
		, 'valor_recompra'		   = a.valor_recompra						  -- 32
		, 'Int_dev_recompra'	   = a.Int_dev_recompra						  -- 33
		, 'resultado_recompra'	   = a.resultado_recompra					  -- 34
		-----jcamposd 20151106 recalculo recompra dap

		FROM #GEN_CAPTACION				AS A With(Nolock)
		INNER JOIN VIEW_MONEDA             With(Nolock) ON MNCODMON  = MONEDA
		INNER JOIN VIEW_ENTIDAD            With(Nolock) ON RCRUT     = ENTIDAD
		INNER JOIN VIEW_CLIENTE            With(Nolock) ON CLRUT     = a.RUT_CLIENTE    AND CLCODIGO = a.CODIGO_RUT
		INNER JOIN VIEW_FORMA_DE_PAGO      With(Nolock) ON CONVERT(INTEGER,FORMA_PAGO) = CODIGO
		LEFT  JOIN MDMO                    With(Nolock) ON MONUMOPER = a.NUMERO_OPERACION  AND MONUMDOCU = a.NUMERO_ORIGINAL
			AND MOCORRELA = a.CORRELA_OPERACION
			left  join gen_captacion      as B With(Nolock) On 
				A.numero_original   = B.numero_Operacion
				And A.correla_operacion = B.correla_operacion
		ORDER BY A.CORRELA_OPERACION
	END
	ELSE
	BEGIN
		SELECT 'NO','Recompra Captación No Existe o es una Operación del Día.'
		SET NOCOUNT OFF
	END
END
GO
