USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ChkLimite_Deuda]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_ChkLimite_Deuda]
				(
				@cSistema	 CHAR	(12)	,
				@cTipoper	 CHAR	(03)	,
				@nRutcli	 NUMERIC	(09,0)	,
				@nCodcli	 NUMERIC	(09,0)	,
				@nMonto		 NUMERIC	(19,2)	,
				@iEntidad	 INTEGER,
				@Tipo_Porcentaje INTEGER
				)
AS
/***********************************************************************
NOMBRE         : dbo.[Sp_ChkLimite_Deuda].StoredProcedure.sql
AUTOR          : SONDA (Unidad de Desarrollo)
FECHA CREACION : 09/08/2011
DESCRIPCION    : Migracion a SQL 2008
HISTORICO DE CAMBIOS
FECHA        AUTOR           DESCRIPCION   
----------------------------------------------------------------------


**********************************************************************/
BEGIN
	SET NOCOUNT OFF

	DECLARE	@nPor_Endeuda_Menor	NUMERIC	(05,2)	,
		@nPor_Endeuda_Mayor	NUMERIC	(05,2)	,
		@nMto_Endeuda_Menor	NUMERIC	(19,0)	,
		@nMto_Endeuda_Mayor	NUMERIC	(19,0)	,
		@nPorEnd_Bco		NUMERIC	(05,2)	,
		@nMaxPorEnd_Bco		NUMERIC	(05,2)	,
		@nFwd_Perd_Dif		NUMERIC	(05,2)	,
		@nMtoEnd_Bco		NUMERIC	(19,0)	,
		@nMtoMaxPorEnd_Bco	NUMERIC	(19,0)	,
		@nMtoFwd_Perd_Dif	NUMERIC	(19,0)	,
		@nActivo_Circ		NUMERIC	(19,0)	,
		@nActivo_CircBkb	NUMERIC	(19,0)	,
		@nOcupado		NUMERIC	(19,0)	,
		@nOcupadoTotal		NUMERIC	(19,0)	,
		@nTipCli		NUMERIC	(05,0)	,
		@nDolarObs		FLOAT		,
		@nExcesoMenor		NUMERIC	(19,0)	,
		@nExcesoMayor		NUMERIC	(19,0)	,
		@cEntidad		CHAR	(11)	,
		@cMensEntidad		VARCHAR	(50)

	SELECT	@nTipCli		= 0	,
		@nActivo_CircBkb	= 0	,
		@nOcupado			= 0	,
		@nOcupadoTotal		= 0	,
		@cEntidad			= ''	,
		@cMensEntidad		= ''

	SELECT	@nTipCli		= cltipcli		,
		@nDolarObs			= 0.0			,
		@nActivo_CircBkb	= Activo_Circulante
	FROM	CLIENTE with(nolock), ENDEUDAMIENTO with (nolock)
	WHERE	clrut=@nRutcli AND clcodigo=@nCodcli

	IF @nTipCli<1 AND @nTipCli>3	--** 1.- Bancos Ext.  2.- Bancos Nac.  3.- Financieras
	BEGIN
		SELECT	'Estado'	= 0		,
			'Msg'			= 'Operacion OK',
			'Exceso'		= 0		,
			'PorMenor'		= 0		,
			'PorMayor'		= 0		,
			'MtoMenor'		= 0		,
			'MtoMayor'		= 0
		RETURN
	END

	SELECT	@nDolarObs	= vmvalor
	FROM	VALOR_MONEDA, VIEW_MDAC
	WHERE	vmcodigo=994 AND vmfecha=acfecproc

	SELECT	@nOcupadoTotal	= SUM(outstanding) + isnull(round((SUM(ISNULL(Captaciones_Dolares,0))*@nDolarObs),0),0)
	FROM	LIMITE_TOTAL_ENDEUDAMIENTO with(nolock)

	SELECT	@nOcupado	= @nOcupado

	SELECT	@nActivo_Circ	= Activo_Circulante			,
		@nOcupado	= outstanding + isnull(round((ISNULL(Captaciones_Dolares,0) * @nDolarObs),0),0)
	FROM	LIMITE_TOTAL_ENDEUDAMIENTO with(nolock)
	WHERE	rut_cliente=@nRutcli AND @nCodcli=codigo_cliente

	IF @iEntidad=1  --BKB
		SELECT	@nActivo_Circ	= @nActivo_CircBkb

	SELECT	@nPorEnd_Bco		= Pend_Inst_Finan					,
		@nMaxPorEnd_Bco		= Pmax_End_Inst_Finan					,
		@nFwd_Perd_Dif		= PFwp_Perd_Dif						,
		@nMtoEnd_Bco		= ROUND((Pend_Inst_Finan/100.0)*@nActivo_Circ,2)	,
		@nMtoMaxPorEnd_Bco	= ROUND((Pmax_End_Inst_Finan/100.0)*@nActivo_CircBkb,2)	,
		@nMtoFwd_Perd_Dif	= ROUND((PFwp_Perd_Dif/100.0)*@nActivo_Circ,2)
	FROM	ENDEUDAMIENTO with(nolock)

	SELECT	@nPor_Endeuda_Menor	= @nPorEnd_Bco		,
		@nPor_Endeuda_Mayor	= @nMaxPorEnd_Bco	,
		@nMto_Endeuda_Menor	= @nMtoEnd_Bco		,
		@nMto_Endeuda_Mayor	= @nMtoMaxPorEnd_Bco


	SELECT	@nExcesoMenor	= (@nMonto+@nOcupado)-@nMto_Endeuda_Menor	,
		@nExcesoMayor	= (@nMonto+@nOcupadoTotal)-@nMto_Endeuda_Mayor


	If @Tipo_Porcentaje = 1 

	 BEGIN
  		IF @nExcesoMayor>0
		BEGIN
			SELECT	'Estado'	= 2										,
				'Msg'		= 'Operacion Sobrepasa '+STR(@nPor_Endeuda_Mayor,5,2)+'% del Activo Circulante, Operacion Rechazada'	,
				'Exceso'	= ABS(@nExcesoMayor)								,
				'PorMenor'	= @nPor_Endeuda_Menor								,
				'PorMayor'	= @nPor_Endeuda_Mayor								,
				'MtoMenor'	= @nMto_Endeuda_Menor								,
				'MtoMayor'	= @nMto_Endeuda_Mayor								,
				'Msg2'		= @cMensEntidad
			RETURN
		END

	        ELSE

		  BEGIN
		 	SELECT	'Estado'	= 3			,
				'Msg'		= 'Operacion OK'	,
				'Exceso'	= 0			,
				'PorMenor'	= @nPor_Endeuda_Menor	,
				'PorMayor'	= @nPor_Endeuda_Mayor	,
				'MtoMenor'	= @nMto_Endeuda_Menor	,
				'MtoMayor'	= @nMto_Endeuda_Mayor	,
				'Msg2'		= @cMensEntidad
			RETURN
		   END	

        END
	SET NOCOUNT ON

	IF @nExcesoMenor>0

	BEGIN
		IF @iEntidad=1		
			SELECT	@cEntidad	= 'de BKB'	,
				@cMensEntidad	= '  .Utiliza Activo Circulante del Cliente??'
		ELSE
			SELECT	@cEntidad	= 'del Cliente'	,
				@cMensEntidad	= '  .Utiliza Activo Circulante de BKB??'

		SELECT	'Estado'	= 1									,
			'Msg'		= 'Operacion Sobrepasa '+STR(@nPor_Endeuda_Menor,5,2)+'% '+@cEntidad	,
			'Exceso'	= ABS(@nExcesoMenor)							,
			'PorMenor'	= @nPor_Endeuda_Menor							,
			'PorMayor'	= @nPor_Endeuda_Mayor							,
			'MtoMenor'	= @nMto_Endeuda_Menor							,
			'MtoMayor'	= @nMto_Endeuda_Mayor							,
			'Msg2'		= @cMensEntidad
		RETURN
	END

	SELECT	'Estado'	= 0			,
		'Msg'		= 'Operacion OK'	,
		'Exceso'	= 0			,
		'PorMenor'	= @nPor_Endeuda_Menor	,
		'PorMayor'	= @nPor_Endeuda_Mayor	,
		'MtoMenor'	= @nMto_Endeuda_Menor	,
		'MtoMayor'	= @nMto_Endeuda_Mayor	,
		'Msg2'		= @cMensEntidad

	RETURN

END


GO
