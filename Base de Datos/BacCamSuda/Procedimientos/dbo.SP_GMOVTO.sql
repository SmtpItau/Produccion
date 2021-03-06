USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GMOVTO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GMOVTO]
	(	@numope				NUMERIC(07)				,        -- 01    
		@tipmer				CHAR(04)				,        -- 02    
		@tipope				CHAR(01)				,        -- 03    
		@rutcli				NUMERIC(09)				,        -- 04    
		@codcli				NUMERIC(09)				,        -- 05    
		@nomcli				CHAR(35)				,        -- 06    
		@codmon				CHAR(03)				,        -- 07    
		@codcnv				CHAR(03)				,        -- 08    
		@monmo				NUMERIC(19,4)			,        -- 09    
		@ticam				NUMERIC(19,4)			,		 -- 10    
		@tctra				NUMERIC(19,4)			,        -- 11    
		@parida				NUMERIC(19,8)			,        -- 12    
		@partr				NUMERIC(19,8)			,        -- 13    
		@ussme				NUMERIC(19,4)			,        -- 14    
		@usstr				NUMERIC(19,4)			,        -- 15       
		@monpe				NUMERIC(19,4)			,        -- 16    
		@entre				NUMERIC(03)				,        -- 17    
		@recib				NUMERIC(03)				,        -- 18    
		@oper				CHAR(15)				,        -- 19  -- MAP 20060920    
		@term				CHAR(12)				,        -- 20    
		@fecha				DATETIME				,        -- 21    
		@codoma				NUMERIC(03)				,        -- 22 (xxx)    
		@estatus			CHAR(01)				,        -- 23    
		@codejec			NUMERIC(06)				,        -- 24    
		@valuta1			DATETIME				,        -- 25 (entregamos)    
		@valuta2			DATETIME				,        -- 26 (recibimos)    
		@rentab				NUMERIC(03)				,        -- 27    
		@linea				CHAR(01)				,        -- 28    
		@entidad			NUMERIC(03)				,        -- 29    
		@precio				NUMERIC(19,4)	=	0	,        -- 30    
		@pretra				NUMERIC(19,4)	=	0	,        -- 31    
		@estado				NUMERIC(01)		=	-1	,        -- 32 (para la captura automatica de fwd)    
		@respon				CHAR(03)				,        -- 33    
		@cotab				CHAR(01)				,        -- 34    
		@observa			VARCHAR(250)			,        -- 35    
		@swift_corrdonde	VARCHAR(10)				,        -- 36    
		@swift_corrquien	VARCHAR(10)				,        -- 37    
		@swift_corrdesde	VARCHAR(10)				,        -- 38    
		@plaza_corrdonde	NUMERIC(05)				,        -- 39    
		@plaza_corrquien	NUMERIC(05)				,        -- 40    
		@plaza_corrdesde	NUMERIC(05)				,        -- 41    
		@fpagomxcli			NUMERIC(05)				,        -- 42 (Canjes) fp mx    
		@fpagomncli			NUMERIC(05)				,        -- 43 (Canjes) FP MN    
		@valuta3			DATETIME				,        -- 44 (Canjes) Valuta MN    
		@valuta4			DATETIME				,        -- 45 (Canjes) Valuta MX    
		@codigo_area		VARCHAR(05)				,        -- 46    
		@codigo_comercio	CHAR(06)				,        -- 47    
		@codigo_concepto	CHAR(03)				,        -- 48    
		@casamatriz			NUMERIC(03)		=	0	,        -- 49    
		@montofinal			NUMERIC(19,4)	=	0	,        -- 50    
		@dias				NUMERIC(09)		=	0	,        -- 51    
		@rutgir				NUMERIC(09)				,        -- 52    
		@codigogirador		NUMERIC(09)				,        -- 53     
		@CostoFondo			NUMERIC(10,4)			,        -- 54    
		@utilpe				NUMERIC(19,0)			,		 -- 55    
		@tcfin				NUMERIC(19,4)			,        -- 56    
		@FechVcto			DATETIME				,		 -- 57    
		@VamosVienen		NUMERIC(01)				,        -- 58 Vamos - Vienen    
		@MoCorres			NUMERIC(08)				,        -- 59 Codigo Corresponsal           
		@forward			CHAR(01)		=	'N'	,		 -- 60 Indica si es de Forward    
		@der_numero			NUMERIC(08)		=	0	,		 -- 61     
		@der_inicio			DATETIME		=	''	,		 -- 62     
		@der_vcto			DATETIME		=	''	,		 -- 63    
		@der_precio			NUMERIC(19,4)	=	0	,		 -- 64         
		@der_instr			NUMERIC(02)		=	0	,		 -- 65    
		@netting			NUMERIC(10)		=	0	,		 -- 66    
		@numero_tbtx		NUMERIC(10)		=	0	,		 -- 67    
		@controla_tran		CHAR(01)		=	'S'	,		 -- 68    
		@CorresponsalCNT	CHAR(10)		=	'0'	,		 -- 69 Corresponsal Contable del Cliente Banco CorpBanca    
		@p_IndOriManual		NUMERIC(2,0)	=	0	,        -- 70    
		@CMX_Punta_Pizarra	NUMERIC(18,4)	=	0	,		 --71 Bac Operativo COMEX    
		@CMX_TC_Costo_Trad	NUMERIC(18,4)	=	0	,        --72     
		@DifTran_Mo			NUMERIC(19,4)	=	0	,		 -- 73 Resultados de diferencia de precios y paridades    
		@DifTran_Clp		NUMERIC(19, 0)	=	0   ,		 -- 74    
		@Canal				VARCHAR(15)		=	''			 -- 75    
	)
AS    
BEGIN    

	SET NOCOUNT ON    
    
	CREATE TABLE #tmp_cod_moneda ( Codigo_Moneda INT )

	----<< Para Planillas Automaticas    
	DECLARE @hora            CHAR(08)    
	DECLARE @planilla_numero NUMERIC(10)    -->	NUMERIC(06)
	DECLARE @planilla_fecha  DATETIME    
	DECLARE @rel_numero      NUMERIC(10)    -->	NUMERIC(06)    
	DECLARE @rel_fecha       DATETIME    
	DECLARE @rel_arbitraje   CHAR(01)    
	DECLARE @moneda          NUMERIC(03)    
	DECLARE @rut             NUMERIC(09)    
	DECLARE @codcar          NUMERIC(10)    
	DECLARE @EntidadBCCH     INT
	DECLARE @oper_contra     CHAR(01) -- Operacione Inversa en Operaciones M/X-USD    
	DECLARE @rut_banco       NUMERIC(10)     
	DECLARE @PesosxCompra    NUMERIC(19,4)    
	DECLARE @Rut_Corre_Corp  NUMERIC(10)      
	DECLARE @Cod_Corre_Corp  NUMERIC(10)    

	IF EXISTS (SELECT 1 FROM MEMO /*with(readpast)*/ WHERE monumope = @numope)
	BEGIN
		SELECT	@term		= moterm
        ,		@oper		= CASE WHEN @oper = '' THEN mooper ELSE @oper END
        FROM	MEMO		/*with(readpast)*/
		WHERE	monumope	= @numope
	END

	-----------------------------------------------------------------------------------------
	------   Calculo Resultado_Comercial, Solicitado por Caludia Avendaño 21-06-2011   ------  
	-----------------------------------------------------------------------------------------
--	DECLARE @Res_Comercial			NUMERIC(19,2)
	DECLARE @Res_Comercial			NUMERIC(21,2)  

	declare @iFlag_PerfilComercial	int
		set @iFlag_PerfilComercial	= -1

	if exists( select 1 from BacParamSuda.dbo.TABLA_GENERAL_DETALLE with(nolock) where tbcateg = 8602 and LTRIM(RTRIM(nemo)) = LTRIM(RTRIM(@term)) )
	begin
		set @iFlag_PerfilComercial	= 1
	end

	IF (@iFlag_PerfilComercial = 1)	-->	@term = 'COMEX'
		IF @codmon = 'USD'
			SET @Res_Comercial = ROUND((@ticam - @CMX_TC_Costo_Trad)* @monmo, 0) * CASE WHEN @tipope = 'C' THEN -1 ELSE 1 END  
		ELSE  
			SET @Res_Comercial = ROUND(((@monmo * (@parida - @CMX_TC_Costo_Trad)) * @ticam), 0) * CASE WHEN @tipope = 'C' THEN -1 ELSE 1 END
	ELSE
		SET @Res_Comercial = 0
	-----------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------


	IF @Canal <> 'CORREDORA'    
	BEGIN    
		IF (SELECT 1 FROM BacParamSuda.dbo.Sinacofi with(nolock) WHERE clrut = @rutcli AND PlataformaExterna = 1) = 1
		BEGIN
			SELECT	@term             = Isnull(terminal, @term)
            FROM	BacParamSuda.dbo.Sinacofi with(nolock)
			WHERE	clrut             = @rutcli
            AND		PlataformaExterna = 1
		END
	END

	IF @Canal = 'CORREDORA'
		SET @tipmer = 'CCBB'

	-->
	SELECT	@Rut_Corre_Corp = 96665450,     -- Rut corredora CorpBanca    
			@Cod_Corre_Corp = 1             -- Codigo corredora CorpBanca    

	SELECT	@estatus		= 'P'    
	SELECT  @rut_banco		= acrut FROM meac with(nolock)
    
	/*** Variables Para la Modificacion ***/    
	DECLARE @fx_ticam			NUMERIC(19,4)
	DECLARE @fx_monmo			NUMERIC(19,4)
	DECLARE @fx_ussme			NUMERIC(19,4)
	DECLARE @fx_codcnv			CHAR(03)
	DECLARE @fx_tctra			NUMERIC(19,4)
	DECLARE @fx_parida			NUMERIC(19,8)
	DECLARE @fx_partr			NUMERIC(19,8)
	DECLARE @fx_tipmer			CHAR(04)
	DECLARE @fx_tipope			CHAR(01)
	DECLARE @fx_codmon			CHAR(03)
	DECLARE @fx_costfn			NUMERIC(15,04)
	DECLARE @fx_USD30			NUMERIC(19,04)
	DECLARE @fx_Rentab			NUMERIC(19,4)
	/*** Planilla Automatica ***/
	DECLARE @parBCCH			NUMERIC(19,8)
	DECLARE @MtoUSD				NUMERIC(19,8)
	DECLARE @tc_BCCH			NUMERIC(19,8)
	DECLARE @cv_BCCH			CHAR(1)
	DECLARE @tipmoneda			CHAR(1)
	DECLARE @USD30dias			NUMERIC(19,4)
	DECLARE @TipoCliente		NUMERIC(05)
    
	/*** Fin de Variables  ***/    
	SET		@planilla_numero	= 0
	SET		@planilla_fecha		= @Fecha    
	SET		@rel_numero			= 0    
	SET		@rel_fecha			= ''    
	SET		@rel_arbitraje		= ''    
	SET		@moneda				= 0    
	SET		@TipoCliente		= 0    
	SET		@hora				= CONVERT(CHAR(8), GETDATE(), 108)    

	IF LTRIM(RTRIM(@term)) = '' AND @tipmer = 'ARBI' AND @der_numero = 0
		SET @term = 'TELEFONO'

	SELECT  @TipoCliente = ISNULL(cltipcli,0)
	FROM	VIEW_CLIENTE with(nolock)
    WHERE	clrut        = @rutcli
	AND		clcodigo     = @codcli

	SELECT  @EntidadBCCH = ISNULL(clcodban, 32)
    FROM	VIEW_CLIENTE with(nolock)
		,	MEAC		 with(nolock)
    WHERE	clrut        = acrut
	AND		clcodigo     = 1

	SELECT  @tipmoneda				= ISNULL(mnrrda,'D')
    FROM	VIEW_MONEDA				with(nolock)
    WHERE	SUBSTRING(mnnemo,1,3)	= @codmon

	SET		@estado = -1

	IF	@tipmer = 'EMPR' AND @term = 'DATATEC'
		SET @CostoFondo = @ticam

	IF @codoma = 0
	BEGIN
		IF @tipmer = 'PTAS'
		BEGIN
			IF @tipope = 'C'
				SET @codoma = 2
			ELSE
				SET @codoma = 7
		END
	END
    
	IF	@controla_tran = 'S'    
		BEGIN TRANSACTION       
    
	----<< captura correlativo    
	IF @numope = 0
	BEGIN

		IF @tipmer = 'EMPR'
		BEGIN
			UPDATE MEAC SET accorope = (accorope + 1)
			SELECT @numope = accorope  FROM MEAC
		END ELSE
			IF @tipmer = 'INFO'
			BEGIN
				UPDATE MEAC SET info_numope = ( info_numope + 1 )
				SELECT @numope = info_numope  FROM MEAC
			END ELSE
			BEGIN
				UPDATE MEAC SET  accorope = ( accorope + 1 )
				SELECT @numope = accorope  FROM MEAC
			END
	END

	/*----<< Carga Paridad BCCH y otros para planilla*/    
	SET		@parBCCH	= 0

	/*---- Valida Paridad Mensual del BCCH*/    
	SELECT	@parBCCH	= ISNULL(vmparmes,0)
	FROM	VIEW_POSICION_SPT with(nolock)
	WHERE	vmfecha		= @fecha	-->	CONVERT( CHAR(8), vmfecha, 112) = CONVERT( CHAR(8), @fecha, 112)
	AND		vmcodigo	= @codmon

	----<< Costo de Fondo para operaciones de Punta es igual a cierre    
	IF @tipmer = 'PTAS' OR @controla_tran = 'N' 
	BEGIN
		SET	@partr  = @parida
		SET	@tctra  = @ticam
		SET	@pretra = @precio
		SET	@usstr  = @ussme
	END

	----<< Dólares Calculados de Acuerdo al Central( Monto Moneda Origen / Paridad mensual )     
	EXECUTE Sp_Funcion_MxMtoUsd30 @codmon, @monmo, @USD30dias OUTPUT
    
	--------------------------<< Grabando Movimiento    
	IF EXISTS( SELECT 1 FROM MEMO WHERE monumope = @numope)
	BEGIN
		-- Respaldo de operación antes de modificar    
		INSERT INTO MEMO_MODIF SELECT * FROM MEMO WHERE monumope = @numope

		DELETE BacParamSuda.dbo.MDLBTR    
		WHERE  sistema          = 'BCC'    
		AND    numero_operacion = @numope    
		AND    estado_envio     in('P','','I')    

		-- Elimina Operacion Anterior de la Posicion    
		SELECT	@fx_ticam		= moticam
		,		@fx_monmo		= momonmo
		,		@fx_ussme		= moussme
		,		@fx_codcnv		= mocodcnv
		,		@fx_tctra		= motctra
		,		@fx_parida		= moparme
		,		@fx_partr		= mopartr
		,		@fx_tipmer		= motipmer
		,		@fx_tipope		= motipope
		,		@fx_codmon		= mocodmon
		,		@fx_codcnv		= mocodcnv
		,		@fx_costfn		= mocostofo
		,		@fx_USD30		= mouss30
		FROM	MEMO    
		WHERE	monumope		= @numope

		SET		@fx_monmo		= @fx_monmo * -1    
		SET		@fx_ussme		= @fx_ussme * -1    
		SET		@fx_USD30		= @fx_USD30 * -1    
		SET		@oper_contra	= CASE @fx_tipope WHEN 'C' THEN 'V' ELSE 'C' END

--		IF @forward <> 'S'  -- Esto Es mientras no se define correctamente el cálculo de los Forward    
		BEGIN
			IF @fx_tipmer = 'EMPR'
			BEGIN
				IF @Canal != 'CORREDORA'
					EXECUTE Sp_Recalc @fx_codmon, @fx_tipmer, @fx_tipope, @fx_costfn, @fx_USD30, @term

				IF @fx_codcnv = 'USD'  -- Operaciones Empresas M/X-USD
				BEGIN
					IF @Canal != 'CORREDORA'    
						EXECUTE Sp_Recalc @fx_codmon,  @fx_tipmer,  @oper_contra , @fx_costfn, @fx_ussme, @term
				END

				IF @Canal != 'CORREDORA'
					EXECUTE sp_recalc_empresas	@fx_tipope, @fx_ticam, @fx_ussme, @fx_codmon, @fx_codcnv, @fx_tctra, @fx_parida, @fx_partr, @fx_monmo

			END ELSE
			BEGIN

				EXECUTE Sp_Recalc @fx_codmon,  @fx_tipmer, @fx_tipope, @fx_ticam, @fx_USD30, @term

				IF @fx_codcnv = 'USD'  -- Operaciones Puntas M/X-USD
				BEGIN
					EXECUTE Sp_Recalc @fx_codmon,  @fx_tipmer, @oper_contra , @fx_ticam , @fx_ussme,@term    
				END
			END
		END
    
		DELETE	VIEW_PLANILLA_SPT
        WHERE	operacion_numero = @numope
		AND		operacion_fecha  = @fecha

		IF @@error <> 0 
		BEGIN
			IF @controla_tran = 'S'
				ROLLBACK TRANSACTION

			SELECT -1, 'NO SE PUEDE ELIMINAR DATOS ANTERIORES A LA MODIFICACION'    
			RETURN    
		END    

		UPDATE	MEMO
		SET		monumope			= @numope				,
				motipmer			= @tipmer				,
				motipope			= @tipope				,
				morutcli			= @rutcli				,
				mocodcli			= @codcli				,
				monomcli			= @nomcli				,
				mocodmon			= @codmon				,
				mocodcnv			= @codcnv				,
				momonmo				= @monmo				,
				moticam				= @ticam				,
				motctra				= @tctra				,
				moparme				= @parida				,
				mopar30				= @parBCCH				,
				mopartr				= @partr				,
				moussme				= @ussme				,
				mousstr				= @usstr				,
				mouss30				= @USD30dias			,
				momonpe				= @monpe				,
				moentre				= @entre				,
				morecib				= @recib				,
				mooper				= @oper					,
				moterm				= @term					,
				mohora				= @hora					,
				mofech				= @fecha				,
				mocodoma			= @codoma				,
				moestatus			= @estatus				,
				mocodejec			= @codejec				,
				movaluta1			= @valuta1				,
				movaluta2			= @valuta2				,
				morentab			= @rentab				,
				moalinea			= @linea				,
				moentidad			= @entidad				,
				moprecio			= @precio				,
				mopretra			= @pretra				,
				id_sistema			= @respon				,
				contabiliza			= @cotab				,
				observacion			= @observa				,    
				swift_corresponsal	= @swift_corrdonde		,    
				swift_recibimos		= @swift_corrquien		,    
				swift_entregamos	= @swift_corrdesde		,    
				plaza_corresponsal	= @plaza_corrdonde		,    
				plaza_recibimos		= @plaza_corrquien		,    
				plaza_entregamos	= @plaza_corrdesde		,    
				forma_pago_cli_nac	= @fpagomncli			,    
				forma_pago_cli_ext	= @fpagomxcli			,    
				valuta_cli_nac		= @valuta3				,    
				valuta_cli_ext		= @valuta4				,    
				codigo_area			= @codigo_area			,    
				codigo_comercio		= @codigo_comercio		,    
				codigo_concepto		= @codigo_concepto		,    
				morutgir			= @rutgir				,    
				mocodigogirador		= @codigogirador		,    
				mocostofo			= @CostoFondo			,    
				moutilpe			= @utilpe				,    
				motcfin				= @tcfin				,    
				mofecvcto			= @FechVcto				,    
				modias				= @dias					,    
				movamos				= @VamosVienen			,    
				mocorres			= @MoCorres				,    
				motipcar			= @der_instr			,    
				monumfut			= @der_numero			,    
				mofecini			= @der_inicio			,    
				anula_motivo		= @CorresponsalCNT		, --Corresponsal Contable    
				MOTLXP1				= @p_IndOriManual		, -- 1:El Origen de operacion Spot se ingreso en forma manual    
			  --Bac Operativo COMEX    
				CMX_Punta_Pizarra	= @CMX_Punta_Pizarra	,
				CMX_TC_Costo_Trad	= @CMX_TC_Costo_Trad	,
				moDifTran_Mo		= @DifTran_Mo			,
				moDifTran_Clp		= @DifTran_Clp			,
				moResultado_Comercial_Clp = @Res_Comercial
		WHERE	monumope			= @numope

	END ELSE	-->		IF EXISTS( SELECT 1 FROM MEMO WHERE monumope = @numope)
	BEGIN  

		INSERT INTO MEMO
		(		monumope				,
				motipmer				,
				motipope				,
				morutcli				,
				mocodcli				,
				monomcli				,
				mocodmon				,
				mocodcnv				,
				momonmo					,
				moticam					,
				motctra					,
				moparme					,
				mopar30					,
				mopartr					,
				moussme					,
				mouss30					,
				mousstr					,
				momonpe					,
				moentre					,
				morecib					,
				mooper					,
				moterm					,
				mohora					,
				mofech					,
				mocodoma				,
				moestatus				,
				mocodejec				,
				movaluta1				,
				movaluta2				,
				morentab				,
				moalinea				,
				moentidad				,
				moprecio				,
				mopretra				,
				id_sistema				,
				contabiliza				,
				observacion				,
				swift_corresponsal		,
				swift_recibimos			,
				swift_entregamos		,
				plaza_corresponsal		,
				plaza_recibimos			,    
				plaza_entregamos		,    
				forma_pago_cli_nac		,    
				forma_pago_cli_ext		,    
				valuta_cli_nac			,    
				valuta_cli_ext			,    
				codigo_area				,    
				codigo_comercio			,    
				codigo_concepto			,    
				morutgir				,    
				mocodigogirador			,    
				mocostofo				,    
				moutilpe				,    
				motcfin					,    
				mofecvcto				,    
				modias					,    
				movamos					,    
				mocorres				,    
				motipcar				,    
				monumfut				,               
				mofecini				,    
				anula_motivo			,    
				MOTLXP1					,    
			--	Bac Operativo COMEX
				CMX_Punta_Pizarra		,
				CMX_TC_Costo_Trad		,
				moDifTran_Mo			,
				moDifTran_Clp			,
				moResultado_Comercial_Clp
		)
		VALUES   
		(    
				@numope					,    
				@tipmer					,    
				@tipope					,    
				@rutcli					,    
				@codcli					,    
				@nomcli					,    
				@codmon					,    
				@codcnv					,    
				@monmo					,    
				@ticam					,    
				@tctra					,    
				@parida					,    
				@parBCCH				,    
				@partr					,    
				@ussme					,    
				@USD30dias				,    
				@usstr					,    
				@monpe					,    
				@entre					,    
				@recib					,    
				@oper					,    
				@term					,    
				@hora					,    
				@fecha					,    
				@codoma					,    
				@estatus				,    
				@codejec				,     
				@valuta1				,    
				@valuta2				,    
				@rentab					,    
				@linea					,    
				@entidad				,    
				@precio					,    
				@pretra					,    
				@respon					,    
				@cotab					,    
				@observa				,    
				@swift_corrdonde		,    
				@swift_corrquien		,    
				@swift_corrdesde		,    
				@plaza_corrdonde		,    
				@plaza_corrquien		,    
				@plaza_corrdesde		,    
				@fpagomncli				,    
				@fpagomxcli				,    
				@valuta3				,    
				@valuta4				,    
				@codigo_area			,    
				@codigo_comercio		,    
				@codigo_concepto		,    
				@rutgir					,    
				@codigogirador			,    
				@CostoFondo				,    
				@utilpe					,    
				@tcfin					,    
				@FechVcto				,    
				@dias					,    
				@VamosVienen			,    
				@MoCorres				,    
				@der_instr				,    
				@der_numero				,    
				@der_inicio				,    
				@CorresponsalCNT		, --Corresponsal Contable    
				@p_IndOriManual			,    
			--	Bac Operativo COMEX    
				@CMX_Punta_Pizarra		,    
				@CMX_TC_Costo_Trad		,    
				@DifTran_Mo				,   
				@DifTran_Clp			,
				@Res_Comercial
		)
    
		SET		@rut		= ISNULL( (SELECT rcrut		FROM VIEW_ENTIDAD with(nolock) WHERE rccodcar = @entidad), 0)    
		SET		@codcar		= ISNULL( (SELECT rccodcar	FROM VIEW_ENTIDAD with(nolock) WHERE rccodcar = @entidad), 0)    
    
		IF @tipmer = 'PTAS' 
		BEGIN
			UPDATE	MEAC     
			SET		acultpta	= (CASE @tipope WHEN 'C' THEN 'COMPRA A ' ELSE 'VENTA A ' END) 
								+    SUBSTRING( @nomcli , 1,20 ) + ' ' + @codmon,    
					acultmon	= @monmo,    
					acultpre	= @ticam    
			WHERE	acrut		= @rut      
			AND		accodigo	= @codcar
		END ELSE 
		BEGIN     
			UPDATE	meac     
			SET		acultempr   = (CASE @tipope WHEN 'C' THEN 'COMPRA A ' ELSE 'VENTA A ' END) 
								+  SUBSTRING( @nomcli , 1,20 ) + ' ' + @codmon,    
					acultmonempr = @monmo,    
					acultpreempr = @ticam,    
					acultpta     = (CASE @tipope WHEN 'C' THEN 'COMPRA A ' ELSE 'VENTA A ' END) +    
					SUBSTRING( @nomcli , 1,20 ) + ' ' + @codmon,    
					acultmon     = @monmo,    
					acultpre     = @ticam    
			WHERE	acrut        = @rut    AND    accodigo     = @codcar    
		END    

	END		-->		IF EXISTS( SELECT 1 FROM MEMO WHERE monumope = @numope)


   IF	@Canal != 'CORREDORA'
        AND @codcnv = 'CLP'               
		AND @tipmer IN ('PTAS' , 'CANJ', 'EMPR')													AND     
       ( ( @TipoCliente  > 0 AND @TipoCliente < 100 ) OR @forward = 'S' )							AND     
         ( @rutcli		<> 1 AND @rutcli <> 2 AND @rutcli <> 3 AND @rutcli <> 4 AND @rutcli <> 5	AND     
        @rutcli <> 70 AND @rutcli <> @rut_banco) --AND    
--        @rutcli <> @Rut_Corre_Corp -- Op. con corp corredora no debe generar planilla segun guillermo silva 06/05/2004    
 BEGIN    

/*
	IF	@Canal != 'CORREDORA'
	AND	@codcnv = 'CLP' AND @tipmer IN('PTAS', 'CANJ', 'EMPR')
	AND	(	( /*@TipoCliente	IN (1,2,3,4) OR */	@forward = 'S')
		AND		@rutcli		NOT IN (1, 2, 3, 4, 5, 70)	
		AND		@rutcli		<>	@rut_banco
		)
--	AND			@rutcli		<>	@Rut_Corre_Corp
	BEGIN		--> planilla mxclp
*/

		/*----<< Carga codigo de Moneda*/    
		SET		@moneda		= 0    
		SELECT	@moneda		= ISNULL(mncodmon,0)    
		FROM	VIEW_MONEDA	with(nolock)
        WHERE	SUBSTRING(mnnemo,1,3) = @codmon
    
		IF @moneda = 0 
		BEGIN
			IF @controla_tran = 'S'
				ROLLBACK TRANSACTION
			SELECT -1, 'CODIGO DE MONEDA ORIGINAL PARA PLANILLA AUTOMATICA NO FUE ENCONTRADA'
			RETURN
		END

		/*----<< Carga Paridad BCCH y otros para planilla*/    
		SET		@parBCCH	= 0    
		SET		@MtoUSD		= 0    
		SET		@tc_BCCH	= 0    
		SET		@cv_BCCH	= @tipope    

		/*---- Valida Paridad Mensual del BCCH*/    
		SELECT  @parBCCH	= ISNULL(vmparmes,0)     
		FROM	VIEW_POSICION_SPT with(nolock)
        WHERE	vmfecha		= @fecha	-->	CONVERT( CHAR(8), vmfecha, 112) = CONVERT( CHAR(8), @fecha, 112) 
		AND		vmcodigo	= @codmon    

		IF @parBCCH		IS NULL
		BEGIN
			IF @controla_tran = 'S'
				ROLLBACK TRANSACTION

			SELECT -1, 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA'
			RETURN
		END ELSE 
			IF @parBCCH = 0
			BEGIN
				IF @controla_tran = 'S'    
					ROLLBACK TRANSACTION

				SELECT -1, 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA'    
				RETURN     
			END    
    
		/*----<< valores para planilla*/    
		SET		@MtoUSD			= round( @monmo / @parBCCH , 2 )    
		SET		@tc_BCCH		= round( @monpe / @MtoUSD  , 4 )    
		SET		@PesosxCompra	= @monmo * @tctra
		/*----<< Canje*/    

		IF @tipmer = 'CANJ'
		BEGIN     
			---Compra de Dolares    
			EXECUTE @estado = Sp_Graba_Planilla_Automatica	@entidad,    
															@tipmer,    
															'C',    
															@fecha,    
															@numope,    
															@moneda,    
															@rutcli,    
															@codcli,    
															@monmo,    
															@parida,    
															@ussme,    
															@tctra,    
															@PesosxCompra,    
															@der_numero,    
															@der_inicio,    
															@der_vcto,    
															@der_precio,    
															@der_instr,    
															@EntidadBCCH,   -- relacion planilla, codigo del Bco segun el BCCH    
															@rel_fecha,    
															@rel_numero,    
															@rel_arbitraje,    
															@codigo_area,    
															@codigo_comercio,    
															@codigo_concepto,    
															@planilla_numero OUTPUT,    
															@planilla_fecha  OUTPUT    
    
			IF @estado <> 0   
			BEGIN
				IF @controla_tran = 'S'    
					ROLLBACK TRANSACTION    

				SELECT -1, 'No se puede generar planilla automatica de ingreso Canje'    
				RETURN
			END

			---Venta de Dolares    
			SET		@planilla_numero = 0    
			EXECUTE	@estado = Sp_Graba_Planilla_Automatica	@entidad,    
															@tipmer,    
															'V',    
															@fecha,    
															@numope,    
															@moneda,    
															@rutcli,    
															@codcli,    
															@monmo,    
															@parida,    
															@ussme,    
															@ticam,        -- Cambia    
															@monpe,        -- Cambia    
															@der_numero,    
															@der_inicio,    
															@der_vcto,    
															@der_precio,    
															@der_instr,    
															@EntidadBCCH,  -- relacion planilla, codigo del Bco segun el BCCH    
															@rel_fecha,    -- cambia    
															@rel_numero,    
															@rel_arbitraje,    
															@codigo_area,    
															@codigo_comercio,    
															@codigo_concepto,    
															@planilla_numero OUTPUT,    
															@planilla_fecha  OUTPUT     
			IF @estado <> 0 
			BEGIN
				IF @controla_tran = 'S'    
					ROLLBACK TRANSACTION    
				SELECT -1, 'No se puede generar planilla automatica de egreso Canje'    
				RETURN    
			END

		END ELSE	-->	IF @tipmer = 'CANJ'
		BEGIN

			IF ( @tipmer = 'EMPR' AND @TipoCliente <> 4 ) OR ( @rutcli = 96665450 )
			BEGIN
				IF @tipope = 'C'
					SET @codigo_comercio = '10100'

				IF @tipope = 'V'
					SET @codigo_comercio = '20100'
			END

			EXECUTE @estado = Sp_Graba_Planilla_Automatica  @entidad,    
															@tipmer,    
															@tipope,    
															@fecha,    
															@numope, 
															@moneda,    
															@rutcli,    
															@codcli,    
															@monmo,    
															@parBCCH,    
															@MtoUSD,    
															@tc_BCCH,    
															@monpe,    
															@der_numero,    
															@der_inicio,    
															@der_vcto,    
															@der_precio,    
															@der_instr,    
															0,       -- relacion planilla, codigo del Bco segun el BCCH    
															'',    
															0,    
															'',    
															@codigo_area,    
															@codigo_comercio,    
															@codigo_concepto,    
															@planilla_numero OUTPUT,    
															@planilla_fecha  OUTPUT     

			IF @estado <> 0
			BEGIN
				IF @controla_tran = 'S'    
					ROLLBACK TRANSACTION    
				SELECT -1, 'No se puede generar planilla automatica para operacion Spot'    
				RETURN     
			END    

		END    -->	IF @tipmer = 'CANJ'
    
	END		--> planilla mxclp	-- Planilla Automatica de M/X / $$    


	-------------------------------------------<< Arbitrajes    
	IF	@tipmer = 'ARBI' OR (@tipmer = 'EMPR' AND @forward = 'S' AND @codcnv = 'USD' AND @Canal != 'CORREDORA')
	BEGIN
		SET		@parBCCH	= 0    
		SET		@MtoUSD		= 0    
		SET		@tc_BCCH	= 0    
		SET		@cv_BCCH	= ''    
    
		SELECT	@moneda		= ISNULL(mncodmon,0)    
		FROM	VIEW_MONEDA with(nolock)
        WHERE	SUBSTRING(mnnemo,1,3) = @codmon

		---- Valida Paridad Mensual del BCCH    
		SELECT	@parBCCH	= ISNULL(vmparmes,0)     
		FROM	VIEW_POSICION_SPT with(nolock)
        WHERE	vmfecha		= @fecha	-->	CONVERT( CHAR(8), vmfecha, 112) = CONVERT( CHAR(8), @fecha, 112) 
		AND		vmcodigo	= @codmon    
    
		IF @parBCCH IS NULL 
		BEGIN
			IF @controla_tran = 'S'    
				ROLLBACK TRANSACTION    
			SELECT -1, 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA DE ARBITRAJE'    
			RETURN     
		END 
		IF @parBCCH = 0 
		BEGIN
			IF @controla_tran = 'S'    
				ROLLBACK TRANSACTION    
			SELECT -1, 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA DE ARBITRAJE'    
			RETURN     
		END    

		SET		@MtoUSD  = round( @monmo / @parBCCH, 2 )    
		SET		@tc_BCCH = round( @monpe / @MtoUSD , 4 )    

		EXECUTE @estado = Sp_Graba_Planilla_Automatica	@entidad,    
														'ARBI', --@tipmer    
														@tipope,    
														@fecha,    
														@numope,    
														@moneda,    
														@rutcli,    
														@codcli,    
														@monmo,    
														@parBCCH,    
														@MtoUSD,    
														@tc_BCCH,    
														@monpe,    
														@der_numero,    
														@der_inicio,    
														@der_vcto,    
														@der_precio,    
														@der_instr,    
														@EntidadBCCH,      -- relacion planilla, segun BCCH    
														@rel_fecha,    
														@rel_numero,    
														@rel_arbitraje,    
														@codigo_area,    
														@codigo_comercio,    
														@codigo_concepto,    
														@planilla_numero OUTPUT,    
														@planilla_fecha  OUTPUT    

		IF @estado <> 0   
		BEGIN    
			IF @controla_tran = 'S'    
				ROLLBACK TRANSACTION    
			SELECT -1, 'No se puede generar planilla automatica principal de arbitraje'    
			RETURN     
		END    

		SET		@rel_fecha = @planilla_fecha    

		----<< Planilla Moneda Cnv de operacion    
		SET		@moneda  = 0    
		SELECT	@moneda  = ISNULL(mncodmon,1)    
		FROM	VIEW_MONEDA with(nolock)
		WHERE	SUBSTRING(mnnemo,1,3) = @codcnv
    
		IF @moneda is NULL 
		BEGIN
			IF @controla_tran = 'S'    
				ROLLBACK TRANSACTION    

			SELECT -1,'PARIDAD BCHH DE MONEDA CONVERSION PARA PLANILLA AUTOMTICA NO FUE ENCONTRADA'    
			RETURN     
		END 

		IF @moneda = 0 
		BEGIN    
			IF @controla_tran = 'S'    
				ROLLBACK TRANSACTION    
			SELECT -1,'PARIDAD BCHH DE MONEDA CONVERSION PARA PLANILLA AUTOMTICA NO FUE ENCONTRADA'    
			RETURN     
		END    
    
		SET		@parBCCH	= 1 -- Corrección DMV,JCL    
		SET		@cv_BCCH	= (CASE @tipope WHEN 'C' THEN 'V' ELSE 'C' END)    
		SET		@MtoUSD		= ROUND( @ussme / @parBCCH, 2 )    
		SET		@tc_BCCH	= ROUND( @monpe / @MtoUSD , 4 )    

		EXECUTE @estado = Sp_Graba_Planilla_Automatica	@entidad,
														'ARBI', --@tipmer    
														@cv_BCCH,    
														@fecha,    
														@numope,    
														@moneda,    
														@rutcli,    
														@codcli,    
														@ussme,    
														@parBCCH,    
														@MtoUSD,    
														@tc_BCCH,    
														@monpe,    
														@der_numero,    
														@der_inicio,    
														@der_vcto,    
														@der_precio,    
														@der_instr,    
														@EntidadBCCH,      -- Relacion    
														@planilla_fecha,    
														@planilla_numero,    
														'A',    
														@codigo_area,    
														@codigo_comercio,    
														@codigo_concepto,    
														@rel_numero OUTPUT,    
														@rel_fecha  OUTPUT    

		IF @estado <> 0
		BEGIN
			IF @controla_tran = 'S'    
				ROLLBACK TRANSACTION    
			SELECT -1, 'No se puede generar planilla automatica contramoneda de arbitraje'    
			RETURN    
		END    

		IF @@error <> 0 
		BEGIN    
			IF @controla_tran = 'S'    
				ROLLBACK TRANSACTION    
			SELECT -1, 'NO SE PUEDEN RELACIONAR LAS PLANILLAS AUTOMATICA POR ARBITRAJE'    
			RETURN     
		END    
	END		-->		IF	@tipmer = 'ARBI' OR (@tipmer = 'EMPR' AND @forward = 'S' AND @codcnv = 'USD' AND @Canal != 'CORREDORA')

	IF @controla_tran = 'S'    
		COMMIT TRANSACTION    
    
	SET		@oper_contra = CASE WHEN @tipope = 'C' THEN 'V' ELSE 'C' END

	------<< Actualiza Posicion    
	--   IF @forward <> 'S' -- Esto Es mientras no se define correctamente el cálculo de los Forward    
	BEGIN    
		IF @tipmer = 'EMPR' AND @Canal != 'CORREDORA'
		BEGIN
			EXECUTE Sp_Recalc @codmon, @tipmer, @tipope, @CostoFondo, @USD30dias, @term

			IF @codcnv = 'USD'  -- Operaciones Empresas M/X-USD    
			BEGIN
				EXECUTE Sp_Recalc @codmon,  @tipmer, @oper_contra , @CostoFondo , @ussme,@term
			END

			EXECUTE sp_recalc_empresas	@tipope, @ticam, @ussme, @codmon, @codcnv, @tctra, @parida, @partr, @monmo
		END ELSE    
		BEGIN
			EXECUTE Sp_Recalc @codmon,  @tipmer, @tipope, @ticam, @USD30dias ,@term    

			IF @codcnv = 'USD'  -- Operaciones Puntas M/X-USD    
			BEGIN
				EXECUTE Sp_Recalc @codmon,  @tipmer, @oper_contra , @ticam , @ussme ,@term
			END
		END
	END
	------<< Retorna numero de operacion    
    
	IF @numero_tbtx <> 0     
	BEGIN    
		UPDATE	TBTXONLINE
		SET		operacion	= @numope    
		WHERE	origen		= @term 
		AND		numero		= @numero_tbtx
	END

	EXECUTE cal_resumenMonedas   -- VB+- 06/07/2009 Calcula los porductos en linea     

	/***    
		* registro de las operaciones corredora para interfaz    
	*/    

	IF @Canal = 'CORREDORA'    
	BEGIN     
		DECLARE @iMoneda		int    
		DECLARE @iContraMoneda	int    
		DECLARE @idv			char    
		DECLARE @iFPEntregamos	int    
		DECLARE @iFPRecibimos	int    
		DECLARE @iFechaOpe		char(8)    

		SELECT	@iMoneda		= mncodmon	FROM BacParamSuda..MONEDA with(nolock) WHERE mnnemo	= @codmon
		SELECT	@iContraMoneda	= mncodmon	FROM BacParamSuda..MONEDA with(nolock) WHERE mnnemo	= @codcnv

		SELECT	@idv			= cldv
		FROM	BacParamSuda..CLIENTE with(nolock)
		WHERE	clrut			= @rutcli
		and		clcodigo		= @codcli

		SELECT	@iFPEntregamos	= convert(varchar, CodigoBolsa)
		FROM	BacParamSuda.dbo.FORMA_DE_PAGO with(nolock)
		WHERE	@entre			= Codigo

		IF @iFPEntregamos = 0
			SET @iFPEntregamos	= 993

		SELECT	@iFPRecibimos	= convert(varchar, CodigoBolsa)
		FROM	BacParamSuda.dbo.FORMA_DE_PAGO with(nolock)
		WHERE	@recib			= Codigo

		IF	@iFPRecibimos		= 0 
			SET @iFPRecibimos	= 993    

		SELECT @iFechaOpe = convert(char(8), ACFECPRO, 112) from MEAC    

		INSERT INTO	TxOnlineCorredora
		VALUES (	@iFechaOpe    
				,	''    
				,	''    
				,	@numope    
				,	@tipope    
				,	@monmo    
				,	@iMoneda     
				,	@iContraMoneda     
				,	@ticam    
				,	@parida    
				,	@precio    
				,	@pretra    
				,	@rutcli    
				,	@idv    
				,	'BANCO'    
				,	@iFechaOpe    
				,	@iFPEntregamos    
				,	@valuta1    
				,	@iFPRecibimos    
				,	@valuta2    
				,	'I'    
				,	'I'    
				,	Space(20)    
				)    
    
		/*    
		 * Aprobar la operacion si es CORREDORA y el cliente es 97023000    
		*/

		IF @rutcli = 97023000
			UPDATE MEMO SET moestatus = '' WHERE monumope = @numope
	END    
 /***    
 * Fin de registro    
 */    
    
   SELECT @numope , 'OK'    

END
GO
