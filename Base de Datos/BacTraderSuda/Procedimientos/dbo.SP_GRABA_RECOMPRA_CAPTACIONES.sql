USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_RECOMPRA_CAPTACIONES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_RECOMPRA_CAPTACIONES]
	(	@dfecpro         CHAR(10)
	,	@nrutcart        NUMERIC(10,0)
	,	@dfecvcto        CHAR(10)
	,	@idias           INTEGER
	,	@imoneda         INTEGER
	,	@iforpago        INTEGER
	,	@nrutcli         NUMERIC(09,0)
	,	@ncodcli         NUMERIC(09,0)
	,	@cretiro         CHAR(01)
	,	@Numero_Oper     NUMERIC(10,0)
	,	@ctipo_deposito  CHAR(01)
	,	@Ejecutivo       INTEGER = 00
	,	@Condicion       CHAR(01)
	,	@pago_hoy        CHAR(01)
	,	@dFecPmH         CHAR(10)
	,	@ncorrela_oper   NUMERIC(05,00) --- Correlativo Opera
	,	@nmtoini         NUMERIC(19,4)  --- Monto Corte
	,	@ftasa           FLOAT          --- Tasa Recompra
	,	@nmontofin       NUMERIC(19,4)  --- Monto a Pagar
	,	@nmontoint       NUMERIC(19,4)  --- Monto Interes
	,	@nmontorea       NUMERIC(19,4)  --- Monto Reajuste
	,	@susuari         CHAR(20)
	,	@observ          CHAR(70)
	,	@sucursal        CHAR(5)
	,	@Tipo_Emision    INTEGER
	,	@nnumope_gen     NUMERIC(10,0)
	,	@modcv           CHAR(1)
	,	@moclave_dcv     CHAR(10)
	,	@certificado     char(19)
	,	@rutContraparte  NUMERIC(9)		= 0	--+++jcamposd RECOMPRA PARA PAPELES DE PROPIA EMISIÓN
	,	@codContraparte  NUMERIC(5)		= 0	--+++jcamposd RECOMPRA PARA PAPELES DE PROPIA EMISIÓN
	,	@cTerminal		 varchar(15)	= ''
	,	@capital_Recomprado NUMERIC(19,4)	--+++jcamposd reclaculo
	,	@resultado_Recompra NUMERIC(19,4)	--+++jcamposd reclaculo
    ,	@Interes_Dev NUMERIC(19,4)			--+++jcamposd reclaculo
    
    ,	@nLibro				char(6)		= '1'
    ,	@nCarteraFinanciera	numeric(5)	= 25
    ,	@cCarteraNormativa	char(1)		= 'T'
	)
AS
BEGIN

	SET NOCOUNT ON

	declare @nFechaIni    datetime
	DECLARE @movalcomp    NUMERIC(19,4)
	DECLARE @movpreseni   NUMERIC(19,4)
	DECLARE @movalinip    NUMERIC(19,4)
	DECLARE @movpresen    NUMERIC(19,4)
	declare @Factor_Mto   NUMERIC(19,4)
	declare @Factor_Org   NUMERIC(19,4)
		  , @Factor_Pes   NUMERIC(19,4)
		  , @CorrCorte    Numeric(5)

	declare  @ibase        integer
	declare  @nnumoper     numeric(10,0)
	declare  @nvalmon      numeric(19,4)
	------''''''''''''''''''''''''FAS TENGO VALORES DE MONEDA

	------------------------------------------------------------------------------------------------------------------------
	--  Obtencin de Fcator a Rebajar Nominales de ''CAP''
	------------------------------------------------------------------------------------------------------------------------
	SELECT	fecha_operacion
		,	fecha_vencimiento
		,	tipo_operacion
		,	numero_operacion
		,	correla_operacion
		,	correla_corte
		,	rut_cliente
		,	codigo_rut
		,	entidad
		,	forma_pago
		,	retiro
		,	monto_inicio
		,	monto_inicio_pesos
		,	moneda
		,	tasa
		,	tasa_tran
		,	plazo
		,	monto_final
		,	estado
		,	fecha_origen
		,	control_renov
		,	custodia
		,	valor_ant_presente
		,	interes_diario
		,	reajuste_diario
		,	interes_acumulado
		,	reajuste_acumulado
		,	valor_presente
		,	interes_extra
		,	reajuste_extra
		,	tipo_deposito 
		,	numero_original
		,	Condicion_Captacion
		,	Tipo_Emision
		,	estado_mp
		,	mensaje_mp
		,	numero_certificado_dcv
		,	fecha_vencimiento_original
			-->	EN CASO DE ANTICIPO PARA EL MISMO DIA
		,	monto_inicio_org		= CASE WHEN monto_inicio_org = 0  THEN monto_inicio			ELSE monto_inicio_org		END
		,	monto_inicio_pesos_org	= CASE WHEN monto_inicio_org = 0  THEN monto_inicio_pesos	ELSE monto_inicio_pesos_org	END
			-->	EN CASO DE ANTICIPO PARA EL MISMO DIA
		,	monto_final_org
		,	Id_Compra
		,   capital_recomprado	
		,   resultado_recompra	
		,   Int_dev_recompra
		,   valor_recompra		
	INTO	#TMP_GEN_CAPTACION
	FROM	GEN_CAPTACION
	WHERE	numero_operacion  = @nnumope_gen
	AND		correla_operacion = @ncorrela_oper

	SELECT	@Factor_Org			= monto_final_org			/ monto_inicio_org
		,	@Factor_Pes			= monto_inicio_pesos_org	/ monto_inicio_org --// monto_inicio_pesos, valor_presente, valor_ant_presente
		,	@Factor_Mto			= monto_inicio
		,	@CorrCorte			= correla_corte
		,	@nFechaIni			= fecha_operacion
	FROM	#tmp_gen_captacion
	where	numero_operacion	= @nnumope_gen
	and		correla_operacion	= @ncorrela_oper
	and		tipo_operacion		= 'CAP'

	------------------------------------------------------------------------------------------------------------------------
	--  Valores al dia del Anticipo
	------------------------------------------------------------------------------------------------------------------------
	select @nvalmon = CASE  WHEN @imoneda in (999,13) THEN	1
							ELSE isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmfecha = @nFechaIni and vmcodigo = @imoneda),1)
						END
	------''''''''''''''''''''''''FAS NO TENGO VALORES DE MONEDA

	select @ibase = mnbase from VIEW_MONEDA  where mncodmon = @imoneda

	SELECT	@movalcomp    = ROUND(@nmtoini * @nvalmon,0)
		,	@movpreseni   = ROUND(@nmtoini * @nvalmon,0)
		,	@movalinip    = ROUND(@nmtoini * @nvalmon,0)
		,	@movpresen    = ROUND(@nmtoini * @nvalmon,0)
	------------------------------------------------------------------------------------------------------------------------
	--  Movimiento ''RIC''
	------------------------------------------------------------------------------------------------------------------------

	insert into MDMO
	(	mofecpro
	,	morutcart
	,	motipcart
	,	monumdocu
	,	mocorrela
	,	motipoper
	,	moinstser
	,	momascara
	,	mocodigo
	,	moseriado
	,	mofecemi
	,	mofecven
	,	momonemi
	,	mobasemi
	,	monominal
	,	movpresen
	,	movpreseni
	,	motir
	,	mofecinip
	,	mofecvenp
	,	movalinip
	,	movalvenp
	,	motaspact
	,	mobaspact
	,	momonpact
	,	moforpagi
	,	moforpagv
	,	mopagohoy
	,	morutcli
	,	mocodcli
	,	motipret
	,	mohora
	,	mousuario
	,	moterminal
	,	movalcomp
	,	monumdocuo
	,	mocorrelao
	,	monumoper
	,	motipopero
	,	monominalp
	,	mostatreg
	,	modcv
	,	moclave_dcv
	,	numero_certificado_dcv
	,	Ejecutivo
	,	Fecha_pagomañana
	,	sucursal
	,	tipo_deposito
	,	condicion_captacion
	,	codigo_carterasuper
	,	moobserv
	,	Tipo_Emision        
	,	morutContraparte --+++jcamposd RECOMPRA PARA PAPELES DE PROPIA EMISIÓN
	,	mocodContraparte
	,	id_libro
	,	Tipo_Cartera_Financiera)

	values ( convert(datetime,@dfecpro) ---  mofecpro            ,
	,	@nrutcart						---  morutcart           ,
	,	@nCarteraFinanciera				---  motipcart           , -->Valor por defecto +++jcamposd 20161222 Trading
	,	@nnumope_gen					---  monumdocu           ,
	,	@ncorrela_oper					---  mocorrela           ,
	,	'RIC'							---  motipoper           ,
	,	'CAP'							---  moinstser           ,
	,	'CAP'							---  momascara           ,
	,	0								---  mocodigo            ,
	,	'N'								---  moseriado           ,
	,	convert(datetime,@dfecpro)		---  mofecemi            ,
	,	convert(datetime,@dfecvcto)		---  mofecven            ,
	,	@imoneda						---  momonemi            ,
	,	@ibase							---  mobasemi            ,
	,	@nmtoini						---  monominal           ,
	,	@movpresen						---  movpresen           ,
	,	@movpreseni						---  movpreseni          ,
	,	@ftasa							---  motir               ,
	,	convert(datetime,@dfecpro)		---  mofecinip           ,
	,	convert(datetime,@dfecvcto)		---  mofecvenp           ,
	,	@movalinip						---  movalinip           ,
	,	@nmontofin						---  movalvenp           ,
	,	@ftasa							---  motaspact           ,
	,	@ibase							---  mobaspact           ,
	,	@imoneda						---  momonpact           ,
	,	@iforpago						---  moforpagi           ,
	,	0								---  moforpagv           ,
	,	@pago_hoy						---  mopagohoy           ,
	,	@nrutcli						---  morutcli            ,
	,	@ncodcli						---  mocodcli            ,
	,	@cretiro						---  motipret            ,
	,	convert(char(15),getdate(),108)	---  mohora              ,
	,	@susuari						---  mousuario           ,
	,	@cTerminal						---  moterminal          ,
	,	@movalcomp						---  movalcomp           ,
	,	@nnumope_gen					---  monumdocuo          ,
	,	@CorrCorte						---  mocorrelao          ,
	,	@Numero_Oper					---  monumoper           ,
	,	'IC'							---  motipopero          ,
	,	@nmontofin						---  monominalp          ,
	,	''								---  mostatreg           ,
	,	@modcv							---  modcv               ,
	,	@moclave_dcv					---  moclave_dcv         ,
	,	@certificado					---  numero_certificado_dcv,
	,	@Ejecutivo						---  Ejecutivo           ,
	,	CONVERT(DATETIME,@dFecPmH)		---  Fecha_pagomañana    ,
	,	@sucursal						---  sucursal            ,
	,	@ctipo_deposito					---  tipo_deposito       ,
	,	@condicion						---  condicion_captacion ,
	,	@cCarteraNormativa				---  codigo_carterasuper		-->valor por defecto +++jcamposd 20161222 --> disponible para la venta
	,	@observ							---  moobserv
	,	@Tipo_Emision					---  Tipo_Emision
	,	@rutContraparte					---	 +++jcamposd RECOMPRA PARA PAPELES DE PROPIA EMISIÓN
	,	@codContraparte
	,	@nLibro							---  Libro --> Valor por defecto +++jcamposd 20161222 -->Negociacion 
	,	@nCarteraFinanciera)			--   tipo carter financiera --> valor por defecto TRADING			

/*
	insert into MOVIMIENTO_ORIGINAL
	( mofecpro
	, morutcart
	, motipcart
	, monumdocu
	, mocorrela
	, motipoper
	, moinstser
	, momascara
	, mocodigo
	, moseriado
	, mofecemi
	, mofecven
	, momonemi
	, mobasemi
	, monominal
	, movpresen
	, movpreseni
	, motir
	, mofecinip
	, mofecvenp
	, movalinip
	, movalvenp
	, motaspact
	, mobaspact
	, momonpact
	, moforpagi
	, moforpagv
	, mopagohoy
	, morutcli
	, mocodcli
	, motipret
	, mohora
	, mousuario
	, moterminal
	, movalcomp
	, monumdocuo
	, mocorrelao
	, monumoper
	, motipopero
	, monominalp
	, mostatreg
	, modcv
	, moclave_dcv
	, numero_certificado_dcv
	, Ejecutivo
	, Fecha_pagomañana
	, sucursal
	, Codigo_Estado_de_Accion
	, tipo_deposito
	, condicion_captacion
	, codigo_carterasuper
	, Tipo_Emision        )
	values( convert(datetime,@dfecpro)   ---  mofecpro            ,
	, @nrutcart                    ---  morutcart           ,
	, 0                            ---  motipcart           ,
	, @nnumope_gen                 ---  monumdocu           ,
	, @ncorrela_oper               ---  mocorrela           ,
	, ''RIC''                        ---  motipoper           ,
	, ''CAP''                        ---  moinstser           ,
	, ''CAP''                        ---  momascara           ,
	, 0                            ---  mocodigo            ,
	, ''N''                          ---  moseriado           ,
	, convert(datetime,@dfecpro)   ---  mofecemi            ,
	, convert(datetime,@dfecvcto)  ---  mofecven            ,
	, @imoneda                     ---  momonemi            ,
	, @ibase                       ---  mobasemi            ,
	, @nmtoini                     ---  monominal           ,
	, @movpresen                   ---  movpresen           ,
	, @movpreseni                  ---  movpreseni          ,
	, @ftasa                       ---  motir               ,
	, convert(datetime,@dfecpro)   ---  mofecinip           ,
	, convert(datetime,@dfecvcto)  ---  mofecvenp           ,
	, @movalinip                   ---  movalinip           ,
	, @nmtoini                     ---  movalvenp           ,
	, @ftasa                       ---  motaspact           ,
	, @ibase                       ---  mobaspact           ,
	, @imoneda                     ---  momonpact           ,
	, @iforpago                    ---  moforpagi           ,
	, 0                            ---  moforpagv           ,
	, @pago_hoy                    ---  mopagohoy           ,
	, @nrutcli                     ---  morutcli            ,
	, @ncodcli                     ---  mocodcli            ,
	, @cretiro                     ---  motipret            ,
	, convert(char(15),getdate(),108) ---  mohora              ,
	, @susuari                     ---  mousuario           ,
	, ''TERMINAL 1''                 ---  moterminal          ,
	, @movalcomp                   ---  movalcomp           ,
	, @nnumope_gen                 ---  monumdocuo          ,
	, @CorrCorte                   ---  mocorrelao          ,
	, @Numero_Oper                 ---  monumoper           ,
	, ''IC''                         ---  motipopero          ,
	, @nmontofin                   ---  monominalp          ,
	, ''''                           ---  mostatreg           ,
	, @modcv                       ---  modcv               ,
	, @moclave_dcv                 ---  moclave_dcv         ,
	, @certificado                 ---  numero_certificado_dcv,
	, @Ejecutivo                   ---  Ejecutivo             ,
	, CONVERT(DATETIME,@dFecPmH)   ---  Fecha_pagomañana        ,
	, @sucursal                    ---  sucursal            ,
	, @ctipo_deposito              ---  Codigo_Estado_de_Accion        ,
	, @condicion                   ---  tipo_deposito            ,
	, 1                            ---  condicion_captacion        ,
	, @observ                      ---  codigo_carterasuper        ,
	, @Tipo_Emision )              ---  Tipo_Emision
	----------------------------
	if @@error<> 0
	begin
	set nocount off
	SELECT ''NO'', 0,''PROBLEMAS EN GRABACION DE OPERACION DE RECOMPRA CAPTACION, << MOVIMIENTO >>''
	return 1
	end
*/

	------------------------------------------------------------------------------------------------------------------------
	--  Actualizacion de nominal en Recompras en Cartera Gen_Captacion ''RIC''
	------------------------------------------------------------------------------------------------------------------------
UPDATE #tmp_gen_captacion
SET numero_operacion           = @Numero_Oper
	, numero_original            = numero_operacion
	, tipo_operacion             = 'RIC'
	, monto_inicio               = @capital_Recomprado  --+++jcamposd recalculo -->@nmtoini 
	, monto_final                = @nmtoini								 --+++jcamposd recalculo -->@nmontofin  --@nmtoini + @nmontoint -->20160303 no debe volver a calcular un valor final
	, monto_inicio_pesos         = Round(@capital_Recomprado * @nvalmon,0) --+++jcamposd recalculo --Round(@nmtoini * @nvalmon,0)
	, valor_ant_presente         = valor_presente --+++jcamposd recalculo -->Round(@nmtoini * @nvalmon,0)
	, tasa                       = @ftasa
	, tasa_tran                  = @ftasa
	, plazo                      = @idias
	, fecha_vencimiento          = @dfecvcto
	, fecha_vencimiento_original = fecha_vencimiento
----------------------------------------------------------------
-- Para agregar a la pantalla Motor de Pago de Control Financiero 07/11/2005
----------------------------------------------------------------
	, estado_mp                  = 'P'
	, interes_acumulado          = @nmontoint
	, reajuste_acumulado         = @nmontorea
	, capital_recomprado		 = @capital_Recomprado     
	, resultado_recompra		 = @resultado_Recompra     
	, Int_dev_recompra			 = @Interes_Dev 
	, valor_recompra			 = @nmontofin


UPDATE #tmp_gen_captacion
SET valor_presente             = Round(@capital_Recomprado * @nvalmon,0) --+++ jcamposd recalculo (valor recompra)-->Round((@nmtoini + @nmontoint)* isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmfecha=@dfecvcto and vmcodigo=moneda),1),0)
	------------------------------------------------------------------------------------------------------------------------
	--  Insertar nuevo Registro de Recompras en Cartera Gen_Captacion ''RIC''
	------------------------------------------------------------------------------------------------------------------------

	Insert Into gen_captacion
	select * from #tmp_gen_captacion

	if @@error<> 0 
	begin
	set nocount off
		SELECT 'NO', 0, 'PROBLEMAS AL INSERTAR REGISTRO DE RECOMPRAS DE CAPTACION, << CAPTACION >>'
		return 1
	end

	------------------------------------------------------------------------------------------------------------------------
	--  Actualizacion de nominal en Cartera Gen_Captacion ''CAP''
	------------------------------------------------------------------------------------------------------------------------
	Set	@Factor_Mto		= Case When @Factor_Mto - @nmtoini <= 0 then 0 else  @Factor_Mto - @nmtoini End

	UPDATE GEN_CAPTACION
	Set monto_inicio         = Round((monto_inicio - @capital_Recomprado) ,4) --+++jcamposd recalculo --->Convert(numeric(19,4), @Factor_Mto )
		, monto_inicio_pesos = Round((monto_inicio - @capital_Recomprado) * @nvalmon,0) --+++jcamposd recalculo -->Case @Factor_Mto When 0 Then 0 Else Round(Monto_inicio_pesos - (@nmtoini  * @Factor_Pes),0) End
		, monto_final        = monto_final - @nmtoini --+++jcamposd recalculo -->Case @Factor_Mto When 0 Then 0 Else Round(Convert(numeric(19,4), @Factor_Mto * @Factor_Org ), Case @imoneda When 999 Then 0 Else 4 End )End
		, valor_ant_presente = valor_presente --+++jcamposd recalculo -->Case @Factor_Mto When 0 Then 0 Else Round(Monto_inicio_pesos - (@nmtoini  * @Factor_Pes),0) End
	WHERE numero_operacion   = @nnumope_gen
		AND correla_operacion  = @ncorrela_oper
		AND tipo_operacion = 'CAP'

	IF @@ERROR<> 0 BEGIN
	SET NOCOUNT OFF
		SELECT 'NO', 0, 'PROBLEMAS AL ACTUALIZAR OPERACION DE CAPTACION, << CAPTACION >>'
		RETURN 1
	END

	UPDATE GEN_CAPTACION
	Set valor_presente     = Round(monto_inicio * @nvalmon,0) --+++jcamposd recalculo -->Round(@nmontofin * @nvalmon,0)   -->Case @Factor_Mto When 0 Then 0 Else Round(Monto_inicio_pesos - (@nmtoini  * @Factor_Pes),0) End
	WHERE numero_operacion   = @nnumope_gen
		AND correla_operacion  = @ncorrela_oper
		AND tipo_operacion = 'CAP'

	IF @@ERROR<> 0 BEGIN
	SET NOCOUNT OFF
		SELECT 'NO', 0, 'PROBLEMAS AL ACTUALIZAR OPERACION DE CAPTACION, << CAPTACION >>'
		RETURN 1
	END

	set nocount off
	select 'SI', @nnumoper, 'OPERACION DE CAPTACIONES, GRABADA CON EXITO '
	return 0

end
GO
