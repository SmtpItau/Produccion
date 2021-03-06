USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCACAPTACION_RC]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCACAPTACION_RC]
	(	@NumOper	numeric(10)
	,	@nUser		varchar(20)
	)
AS
BEGIN

	IF EXISTS(SELECT 1
	FROM GEN_CAPTACION (NOLOCK) cap
	WHERE	cap.FECHA_OPERACION			< ( select acfecproc from BacTraderSuda.dbo.MDAC with(nolock) )
	AND		cap.FECHA_VENCIMIENTO		> ( select acfecproc from BacTraderSuda.dbo.MDAC with(nolock) )
	AND		cap.NUMERO_OPERACION		= @NUMOPER
	AND		cap.TIPO_OPERACION			= 'CAP'
	AND		cap.ESTADO					IN ('','V')
	AND		cap.monto_final				> 0
	AND		tipo_deposito				= 'F' --+++jcamposd solo disponibilizar tipo de depositos fijo
	AND		tipo_emision				= 2 )
	
	
	BEGIN
			SELECT	'TIPOPER'					= cap.TIPO_OPERACION							-- 01
			,	'F_EMISION'					= CONVERT(CHAR(10),cap.FECHA_OPERACION,103)		-- 02
			,	'DIAS'						= CONVERT(CHAR(10),cap.PLAZO)					-- 03
			,	'F_VENCIMIENTO'				= CONVERT(CHAR(10),cap.FECHA_VENCIMIENTO,103)	-- 04
			,	'MONEDA'					= moneda.mnnemo									-- 05
			,	'TASA'						= cap.TASA										-- 06
			,	'RUT_CARTERA'				= CONVERT(CHAR(9), cap.ENTIDAD)					-- 07
			,	'TIPO_CARTERA'				= ''											-- 08
			,	'FORMA_PAGO_INICIO'			= fpago.GLOSA									-- 09
			,	'FORMA_PAGO_VENCIMIENTO'	= ''											-- 10
			,	'TIPO_RETIRO'				= cap.RETIRO									-- 11
			,	'RUT_CLI'					= CONVERT(CHAR(09),cap.RUT_CLIENTE)				-- 12
			,	'DIG_CLI'					= CONVERT(CHAR(7),cap.CODIGO_RUT)				-- 13
			,	'NUMERO_CORRELACION'		= cap.correla_operacion							-- 14
			,	'NUMERO_CORRELACION_corte'	= cap.correla_corte								-- 15
			,	'MONTO_INICIAL_CORTE'		= cap.monto_inicio								-- 16
			,	'TASA_TRAN'					= cap.tasa_tran									-- 17
			,	'CUSTODIA'					= cap.custodia									-- 18
			,	'TIPO_DEPOSITO'				= cap.tipo_deposito								-- 19
			,	'CONDICION'					= cap.Condicion_Captacion						-- 20
			,	'TIPO_EMISION'				= cap.Tipo_Emision								-- 21
			,	'NUMERO_DCV'				= cap.numero_certificado_dcv				    -- 22	(Aun no se homologa)
			,	'CORTE_MAXIMO'				= cap.correla_operacion							-- 23
			,	'Plazo1'					= abs( datediff( day, (select acfecproc from bactradersuda.dbo.mdac with(nolock)), fecha_operacion) )
			--+++jcamposd 20151106 recalculo recompra dap
			,   'monto_final'              = cap.monto_final                            -- 25
			-----jcamposd 20151106 recalculo recompra dap
		FROM	GEN_CAPTACION				cap with(nolock)
				left join
				(	select	mncodmon, mnnemo 
					from	bacparamsuda.dbo.moneda with(nolock)
				)	moneda	On moneda.mncodmon	= cap.MONEDA
				left join
				(	select	rcrut 
					from	view_Entidad with(nolock)	
				)	Ent		On Ent.rcrut		= cap.ENTIDAD
				left join
				(	select	clrut, clcodigo, clnombre
					from	BacParamSuda.dbo.Cliente with(nolock)
				)	Cliente	On Cliente.clrut = cap.rut_cliente and Cliente.clcodigo = cap.codigo_rut
				left join
				(	select	codigo, glosa
					from	BacParamSuda.dbo.Forma_De_Pago with(nolock)
				)	fpago	On fpago.codigo	= convert(int, cap.forma_pago)
		WHERE	cap.FECHA_OPERACION			< ( select acfecproc from BacTraderSuda.dbo.MDAC with(nolock) )
		AND		cap.FECHA_VENCIMIENTO		> ( select acfecproc from BacTraderSuda.dbo.MDAC with(nolock) )
		AND		cap.NUMERO_OPERACION		= @NUMOPER
		AND		cap.TIPO_OPERACION			= 'CAP'
		AND		cap.ESTADO					IN ('','V')
		AND		cap.monto_final				> 0
		AND		tipo_deposito				= 'F' --+++jcamposd solo disponibilizar tipo de depositos fijo
		AND		tipo_emision				= 2 --+++solo disponibilizar tipo de emisión DCV
	END 
	ELSE
	BEGIN
		SELECT 'NO','Captación: No Encontrada / Es una Operacion del Día / Es un Depósito Renobable ó de Emisión Física.'
	END

END
GO
