USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CAPTACIONES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_CAPTACIONES]
	(	@dfecpro		char(10)
	,	@nrutcart		numeric(10,0)
	,	@dfecvcto		char(10)
	,	@ftasa			float
	,	@ftasatran		float
	,	@idias			integer
	,	@imoneda		integer
	,	@iforpago		integer
	,	@nrutcli		numeric(09,0)
	,	@ncodcli		numeric(09,0)
	,	@cretiro		char(01)
	,	@nnumdocu		numeric(10,0)
	,	@ccustodia		char(01)
	,	@ctipo_deposito char(01)
	,	@ncorrela_corte numeric(03,00)
	,	@ncorrela_oper	numeric(05,00)
	,	@nmtoini		numeric(19,4)
--+++fmo 20180718 agregar decimales
	,	@nmtoiniclp		numeric(19,4)
-----fmo 20180718
	,	@nmontofin		numeric(19,4)
	,	@susuari		char(20)
	-->	ITAU
	,	@Ejecutivo      INTEGER
	,	@Condicion      CHAR(01)
	,	@pago_hoy		CHAR(01)
	,	@dFecPmH 		CHAR(10)
	,	@observ			CHAR(70)
	,	@sucursal       CHAR(5)
	,	@Tipo_Emision	Integer
	-->	ITAU
	,	@cTerminal		varchar(15)
 )
AS
BEGIN
	/*	Se recompila proceso al 20-11-2015 : 17:51	*/
--SONDA			: CAPTACIONES
--DESCRIPCION	: ingreso de captaciones
--MODIFICACION	: 18-07-2018 agregar decimales a montos enteros

	SET NOCOUNT ON
   
	DECLARE @ibase		integer
 
	DECLARE @nnumoper	numeric(10,0)
		set @nnumoper	= @nnumdocu
 
	if @imoneda = 999 
	begin
		select @nmtoini    = round( @nmtoini    ,0)
		select @nmtoiniclp = round( @nmtoiniclp ,0)
		select @nmontofin  = round( @nmontofin  ,0)
	end
	--> +++cvegasan 2017.09.14 [CORRECCION] - Pantalla de Captaciones cuando es Pesos base tiene que ser 30
	select	@ibase			= case when mncodmon = 999 then 30 else mnbase end
	--< ---cvegasan 2017.09.14 [CORRECCION] - Pantalla de Captaciones cuando es Pesos base tiene que ser 30
	from	VIEW_MONEDA 
	where	mncodmon		= @imoneda  

	insert into MDMO
	(	mofecpro			,
		morutcart   ,
		motipcart   ,
		monumdocu   ,
		mocorrela   ,
		motipoper   ,
		moinstser   ,
		momascara   ,
		mocodigo   ,
		moseriado   ,
		mofecemi   ,
		mofecven   ,
		momonemi   ,
		mobasemi   ,
		monominal   ,
		movpresen   ,
		movpreseni   ,
		motir    ,
		mofecinip   ,
		mofecvenp   ,
		movalinip   ,
		movalvenp   ,
		motaspact   ,
		mobaspact   ,
		momonpact   ,
		moforpagi   ,
		moforpagv   ,
		mopagohoy   ,
		morutcli   ,
		mocodcli   ,
		motipret   ,
		mohora    ,
		mousuario   ,
		moterminal   ,
		movalcomp   ,
		monumdocuo   ,
		mocorrelao   ,
		monumoper   ,
		motipopero   ,
		monominalp   ,
		mostatreg    ,
		modcv,
		-->	ITAU
		Ejecutivo ,
		tipo_deposito,
		condicion_captacion,
		Tipo_Emision
		-->	ITAU
	)
	VALUES
	(	convert(datetime,@dfecpro)		,
		@nrutcart   ,
		0    ,
		@nnumdocu   ,
		@ncorrela_oper   ,
		'IC'							,
		'CAP'							,
		'CAP'							,
		0    ,
		'N'								,
		convert(datetime,@dfecpro)   ,
		convert(datetime,@dfecvcto)   ,
		@imoneda   ,
		@ibase    ,
		@nmtoini   ,
		@nmtoiniclp   ,
		@nmtoiniclp   ,
		@ftasa    ,
		@dfecpro   ,
		@dfecvcto   ,
		@nmtoiniclp   ,
		@nmontofin   ,
		@ftasa    ,
		@ibase    ,
		@imoneda   ,
		@iforpago   , 
		0    ,  -- pago vencimiento 
		'N'								,
		@nrutcli   ,
		@ncodcli   ,
		@cretiro   ,
		convert(char(15),getdate(),108) ,
		@susuari   ,
		@cTerminal						,
		@nmtoiniclp   ,
		@nnumdocu   ,
		1                               ,
		@nnumdocu   ,
		'IC'							,
		@nmontofin   ,
		' '    , -- campo estado cuando se inicia la operaci¢n tiene que quedar en blanco 
		@ccustodia,
		-->	ITAU
		@Ejecutivo,
		@ctipo_deposito,
		@condicion,
		@Tipo_Emision
		-->	ITAU
	)

 if @@error<> 0 
 begin
               set nocount off
  SELECT 'NO', 0,'PROBLEMAS EN GRABACI¢N DE OPERACI¢N DE CAPTACI¢N, << MOVIMIENTO >>'
  return 1
 end



	insert into GEN_CAPTACION
	(	fecha_operacion  ,
		fecha_vencimiento  ,
		tipo_operacion   ,
		numero_operacion  ,
		correla_operacion ,
		correla_corte  ,
		rut_cliente   ,
		codigo_rut   ,
		entidad   ,
		forma_pago   ,
		retiro    ,
		monto_inicio   ,
		monto_inicio_pesos  ,
		moneda    ,
		tasa    ,
		tasa_tran   ,
		plazo    ,
		monto_final   ,
		estado   ,
		fecha_origen   ,
		control_renov  ,
		custodia  ,
		valor_ant_presente ,
		valor_presente  ,
		tipo_deposito ,
		numero_original,
		-->	ITAU
		Condicion_Captacion,
		Tipo_Emision
		-->	ITAU
	,	interes_diario
	,	reajuste_diario
	,	interes_acumulado
	,	reajuste_acumulado
	,	interes_extra
	,	reajuste_extra
	)
	VALUES
	(	convert(datetime,@dfecpro)  , -- 01
		convert(datetime,@dfecvcto)  , -- 02
		'CAP'							, -- 03
		@nnumdocu  , -- 04 
		@ncorrela_oper  , -- 05
		@ncorrela_corte  , -- 06
		@nrutcli  , -- 07
		@ncodcli  , -- 08 
		@nrutcart  , -- 07
		convert(char(04),@iforpago), --08
		@cretiro  , -- 09
		@nmtoini  , -- 10
		@nmtoiniclp  , -- 11
		@imoneda  , -- 12
		@ftasa   , -- 13
		@ftasatran  , -- 14
		@idias   , -- 15
		@nmontofin  , -- 16
		' '   , -- 17 cuando el estado sea ' ' quiere decir que es una operaci¢n activa
		@dfecpro  , -- se guarda la fecha origen de la captaci¢n para mantener historial
		0   , -- corresponde a la cantidad de renovaciones que obtendra
		@ccustodia  , 
		@nmtoiniclp  ,
		@nmtoiniclp         ,
		@ctipo_deposito  ,
		@nnumdocu,
		-->	ITAU
		@Condicion,
		@Tipo_Emision
		-->	ITAU
	,	0				-->	interes_diario
	,	0				--> reajuste_diario
	,	0				-->	interes_acumulado
	,	0				--> reajuste_acumulado
	,	0				-->	interes_extra
	,	0				-->	reajuste_extra
	)

	--ITAU-----------------------------------------------
	update GEN_CAPTACION
		set monto_inicio_org        = monto_inicio
		, monto_inicio_pesos_org	= monto_inicio_pesos
		, monto_final_org			= monto_final
		Where numero_operacion      = @nnumdocu
		and correla_operacion       = @ncorrela_oper
		and correla_corte           = @ncorrela_corte
--ITAU-----------------------------------------------
 if @@error<> 0 
 begin
                set nocount off
  SELECT 'NO', 0, 'PROBLEMAS EN GRABACI¢N DE OPERACI¢N DE CAPTACI¢N, << CAPTACI¢N >>'
  return 1
 end

        set nocount off
 select 'SI', @nnumoper, 'OPERACI¢N DE CAPTACINONES, GRABADA SATISFACTORIAMENTE '
 return 0

END
GO
