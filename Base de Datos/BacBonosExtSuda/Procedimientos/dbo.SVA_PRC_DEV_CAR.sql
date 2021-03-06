USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_PRC_DEV_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SVA_PRC_DEV_CAR]
   (   @dFechaproc     DATETIME
   ,   @dFechaprox     DATETIME
   ,   @ProcEspecial   CHAR(1)	= ''
   )
AS
BEGIN

		/* Bitacora de modIFicaciones 

			AUTOR       : Victor Gonzalez S.
			FECHA       : 20/06/2005
			FONO        : 65168000
			MAIL        : Victor.Gonzalez@Sonda.com
			DESCRIPCION : Filtro de cartera no estaba tomANDo los bons que vencen el mismo dia 
							de devengo, para el proceso normal de devengamiento. VGS (20/06/2005)	*/
	SET NOCOUNT ON
		
	DECLARE @dFecPro			DATETIME		,
		@TipFomulas				CHAR(1)			,
		@tipo_cal				FLOAT			,
		@cod_familia			NUMERIC(04)		,
		@cod_nemo				CHAR(20)		,
		@fecha_vcto				DATETIME		,
		@TR						FLOAT			,
		@TE						FLOAT			,
		@TV						FLOAT			,
		@TT						FLOAT			,
		@BA						FLOAT			,
		@BF						FLOAT			,
		@NOM					FLOAT			,
		@MT						FLOAT			,
		@VV						FLOAT			,
		@VP						FLOAT			,
		@PVP					FLOAT			,
		@VAN					FLOAT			,
		@FP						DATETIME		,
		@FE						DATETIME		,
		@FV						DATETIME		,
		@FU						DATETIME		,
		@FX						DATETIME		,
		@FC						DATETIME		,
		@CI						FLOAT			,
		@CT						FLOAT			,
		@INDEV					FLOAT			,
		@PRINC					FLOAT			,
		@INCTR					FLOAT			,
		@FIP					DATETIME		,
		@CAP					FLOAT			,
		@SPREAD					FLOAT			,
		@Retorno				CHAR(1)			,	
		@PX_IN					FLOAT			,
		@PX_AM					FLOAT			,
		@PRINC_PASO				FLOAT			,
		@INDEV_PASO				FLOAT			,
		@PX_IN_CUPON			FLOAT			,
		@PX_AM_CUPON			FLOAT			,
        @Factor					FLOAT			,
        @Dur_Mac				FLOAT			,
        @Dur_Mod				FLOAT			,
        @Convexi				FLOAT           

	DECLARE	@rutcart			NUMERIC(10)		,
		@numdocu				char(12)		,
		@nominal				NUMERIC(19, 4)	,
		@fecpago				DATETIME		,
		@valcomu				FLOAT			,
		@tircomp				NUMERIC(19, 7)	,
		@pvpcomp				NUMERIC(19, 7)	,
		@vpcomp					NUMERIC(19, 8)	,
		@fecemi					DATETIME		,
		@fecven					DATETIME		,
		@tasemi					NUMERIC(9, 4)	,
		@basemi					NUMERIC(3)		,
		@monemi					NUMERIC(3)		,
		@vptirc					NUMERIC(19, 7)	,
		@capital				NUMERIC(19, 4)	,
		@interes				NUMERIC(19, 4)	,
		@reajust				NUMERIC(19, 4)	,
		@tipo_tasa				NUMERIC(3)		,
		@reajuste_acum			NUMERIC(19, 4)	,
		@interes_acum			NUMERIC(19, 4)  ,
		@spreadEmi				FLOAT			,
		@Interescomp			NUMERIC(19, 4)	,
		@DIFIntVcto				NUMERIC(19, 4)	,
		@ValorVctoCpPeso		NUMERIC(23)		,
		@InteresPesoAcum		NUMERIC(23)		,
		@ValorProxProc			FLOAT			,
		@Princdia				NUMERIC(19, 4)	,
		@valorprespeso			NUMERIC(24)		,
		@valorpres				NUMERIC(19, 4)	,
		@valorproxpeso			NUMERIC(24)		,
		@PDia					NUMERIC(19, 4)	,
		@PDiaPeso				NUMERIC(24)		,
		@interesapagar			NUMERIC(19, 4)	,
		@feproxcorte			DATETIME        ,
		@valorPresAnt			NUMERIC(19, 7)	, 
		@InteresAntCorte		NUMERIC(19, 4)	,
		@InteresDesCorte		NUMERIC(19, 4)	,
		@FecCorte				DATETIME

	DECLARE	@i					INTEGER         ,
		@dFechaante				DATETIME        ,
        @dFechaActual			DATETIME

	DECLARE @ValorDolar			NUMERIC(19, 4)	,  
		@interesPeso			NUMERIC(24)		,
		@NominalPeso			NUMERIC(24)		,		
		@RefMoneda				CHAR(1)  		,
		@CorteCupon				CHAR(1)         ,
		@OKCUPON				CHAR(1)

--+++ jcamposd 20170116
	DECLARE @DIFDIAS			NUMERIC(5)		,
		@DIFDIAS_prox			NUMERIC(5)		,
		@TasaNomina				FLOAT			,
		@interesesMañana		NUMERIC(19, 4)	,
		@FechaproxProc			DATETIME
----- jcamposd 20170116

	CREATE TABLE 
	#cartera(
			rutcart				NUMERIC(9, 0)	,
			numdocu				char(12)		,
			cod_familia			NUMERIC(4)		,
			cod_nemo			CHAR (20)		,
			nominal				NUMERIC(19, 4)	,
			fecpago				DATETIME		,
			valcomu				NUMERIC(19, 4)	, -- FLOAT		,
			tircomp				NUMERIC(19, 7)	,
			pvpcomp				NUMERIC(19, 7)	,
			vpcomp				NUMERIC(19, 8)	,
			fecemi				DATETIME		,
			fecven				DATETIME		,
			tasemi				NUMERIC(19, 4)	,
			basemi				NUMERIC(3, 0)	,
			monemi				NUMERIC(3, 0)	,
			monpag				NUMERIC(3, 0)	,
			vptirc				NUMERIC(19, 7)	,
			capital				NUMERIC(19, 4)	,
			interes				NUMERIC(19, 4)	,
			reajust				NUMERIC(19, 4)	,
			tipo_tasa			NUMERIC(3)		,
			sw					CHAR(1)			,
			spreadEmi			FLOAT			,
			interescomp			NUMERIC(19, 4)	,
			valorpres			NUMERIC(24, 4)  , -- NUMERIC(24, 1)  , redondeaba muy grueso
			principaldia		NUMERIC(19, 4)	,
			interesapagar		NUMERIC(19, 4)	,
			feproxcorte			DATETIME		,
			valorPresAnt		NUMERIC(19, 7)	
         )

	SELECT @dFechaante		= acfecante
            ,@dFechaActual	= acfecproc
            ,@FechaproxProc	= acfecprox -->+++jcamposd20170123 CDTCOP
	FROM TEXT_ARC_CTL_DRI

    IF @dFechaproc = @dFechaprox
		SELECT @dFechaprox = acfecprox FROM TEXT_ARC_CTL_DRI

	BEGIN TRANSACTION

	DELETE	TEXT_RSU	WHERE	rsfecpro = @dFechaProc
	DELETE	TEXT_RSU 	WHERE	rsfecpro = @dFechaProx -- borra los vencimientos cupon del proximo dia
	IF @@ERROR<>0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
		RETURN
	END


	IF  @ProcEspecial  <> 'S' 
	BEGIN  
		INSERT INTO	#cartera
        SELECT	cprutcart		,
				cpnumdocu		,
				cod_familia		,
				cod_nemo		,
				cpnominal		,
				cpfecpago		,
				cpvalcomu		,
				cptircomp		,
				cppvpcomp		,
				cpvpcomp		,
				cpfecemi		,
				cpfecven		,
				cptasemi		,
				cpbasemi		,
				cpmonemi		,
				cpmonpag		,
				cpvptirc		,
				cpcapital		,
				cpinteres		,
				cpreajust		,
				tipo_tasa		,
				'N'				,
				0				,
				cpint_compra	,
				cpvptirc		,
				princdia		,
				cpvalvenc       ,                        
				cpfecpcup       ,
				valorpresentant 
		  FROM 	TEXT_CTR_INV            -- SELECT cpvptirc, * from TEXT_CTR_INV where cpnumdocu in ( 4022, 4023)
		 WHERE	cpnominal  > 0
		   AND	cpfecpago <= @dFechaProc
		--+++jcamposd no debe considerar los vencimientos
		--AND	cpfecven  > @dFechaproc
		  AND cpfecven  >= @dFechaproc   -- VGS (20050620)
		-----jcamposd no debe considerar los vencimientos
	END
    ELSE 
	BEGIN    /* FIN DE MES ESPECIAL */           
		INSERT INTO	#cartera
        SELECT	
			cprutcart	,
			cpnumdocu	,
			TEXT_CTR_INV.cod_familia	,
			TEXT_CTR_INV.cod_nemo	,
			cpnominal	,
			cpfecpago	,
			cpvalcomu	,
			cptircomp	,
			cppvpcomp	,
			cpvpcomp	,
			cpfecemi	,
			cpfecven	,
			cptasemi	,
			cpbasemi	,
			cpmonemi	,
			cpmonpag	,
			ISNULL (rsvppresenx, 0) ,
			cpcapital	,
			rsinteres_acum	,
			rsreajuste_acum	,
			TEXT_CTR_INV.tipo_tasa	,
			'N'             ,
			0		,
			cpint_compra	,
			rsvppresenx	,
			rsprincipal	,
			cpvalvenc       ,                        
			cpfecpcup       ,
			rsvppresen 
	   FROM TEXT_CTR_INV, TEXT_RSU
	  WHERE	cpnominal  > 0
	    AND	cpfecpago <= @dFechaProc
  --	AND	cpfecven  >= @dFechaprox
        AND rsfecpro = (SELECT acfecproc from text_arc_ctl_dri) --DATEADD(day, -1,@dFechaProc)
        AND RSNUMOPER =  cpnumdocu
        AND rstipoper = 'DEV'  

	END
	IF @@ERROR<>0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
		RETURN
	END

	UPDATE #Cartera SET spreadEmi = isnull(t.valor_spread,0.0)
	  FROM TEXT_ser t
	 WHERE t.fecha_vcto = fecven
	   AND t.cod_nemo = #cartera.cod_nemo		

	DECLARE @PrimerDiaMes			CHAR(12),
			@UltimoDiaMes			CHAR(12),
			@Paridad				NUMERIC(12,4),
			@TipoCambio				NUMERIC(12,4),
			@UltimoDiaMesVCTO		CHAR(12)

	SELECT @PrimerDiaMes		= SUBSTRING( ( convert(char(8), @dFechaproc , 112))  ,1,6)  + '01'
	SELECT @UltimoDiaMes		= SUBSTRING(CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,35,@PrimerDiaMes)),112),1,6) + '01'
	SELECT @UltimoDiaMes		= CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@UltimoDiaMes)),112)
	SELECT @UltimoDiaMesVCTO	= CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@PrimerDiaMes)),112)

----<< Chequea si es el ultimo dia del Mes
--	IF SUBSTRING(@UltimoDiaMes,5,2)  <> SUBSTRING((convert(char(8), @dFechaprox , 112))  ,5,2)
	IF DATEPART(MONTH,@UltimoDiaMes) <> DATEPART(MONTH,CONVERT(CHAR(10),@dFechaprox,112))
	BEGIN
		SELECT @valorDolar  = ISNULL(Tipo_Cambio,0.0) FROM BacParamSuda..VALOR_MONEDA_CONTABLE, TEXT_ARC_CTL_DRI  WHERE  Fecha        = acfecproc /*@dFechaproc*/ AND Codigo_Moneda = 994
	END ELSE
	BEGIN
		SELECT @valorDolar  = ISNULL(Tipo_Cambio,0.0) FROM BacParamSuda..VALOR_MONEDA_CONTABLE, TEXT_ARC_CTL_DRI  WHERE  Fecha = acfecproc 		AND    Codigo_Moneda     = 994
	END	

	WHILE 1=1
	BEGIN
		SET ROWCOUNT 1

		SET	@i				= 0
		SET @CorteCupon		= 'N'

		SELECT	@i 				= 1				,
				@rutcart		= rutcart		,
				@numdocu		= numdocu		,
				@cod_familia	= cod_familia	,
				@cod_nemo		= cod_nemo		,
				@nominal		= nominal		,
				@fecpago		= fecpago		,
				@valcomu		= valcomu		,
				@tircomp		= tircomp		,
				@pvpcomp		= pvpcomp		,
				@vpcomp			= vpcomp		,
				@fecemi			= fecemi		,
				@fecven			= fecven		,
				@tasemi			= tasemi		,
				@basemi			= basemi		,
				@monemi			= monemi		,
				@vptirc			= vptirc		,	 -- 
				@capital		= capital		,
				@interes_acum	= interes		,
				@reajuste_acum	= reajust		,
				@tipo_tasa		= tipo_tasa		,
				@interes		= 0				,
				@reajust		= 0				,
				@spreadEmi		= spreadEmi		,
				@interescomp	= interescomp	,
				@valorpres		= valorpres		,
				@PDia			= principaldia  ,
				@interesapagar	= interesapagar	,
				@feproxcorte    = feproxcorte   ,
		-- ================================================================================================================================================
		-- +++  VBF 03012019 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================
--				@valorPresAnt   = CASE WHEN cod_familia = 2002 THEN vptirc ELSE valorPresAnt END --> VB
				@valorPresAnt   = valorPresAnt --+++fmo 20190219 obtener valor presente
		-- ================================================================================================================================================
		-- ---  VBF 03012019 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================

		FROM	#cartera
		WHERE	sw = 'N'
		SET ROWCOUNT 0

		IF @i = 0	BREAK
               
		SELECT	@dFecPro	= case when @cod_familia = 2002 then @dFechaproc else @dFechaprox end , /* VB 10012019*/
				@TipFomulas	= ''			,
				@tipo_cal	=  2			,
				@fecha_vcto	= @fecven		,
				@TR			= @tircomp		,
				@TE			= @tasemi		,
				@TV			= @tasemi		,
				@TT			= @tipo_tasa	,
				@BA			= @basemi		,
				@BF			= @basemi		,
				@NOM		= @nominal		,
				@MT			= @vptirc		,
				@VV			= 0				,
				@VP			= 0				,
				@PVP		= @pvpcomp		,
				@VAN		= 0				,
				@FP			= @dFechaprox	,
				@FE			= @fecemi		,
		-- ================================================================================================================================================
		-- +++  VBF 03012019 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================
				@FV			= case when @cod_familia = 2002 then  @fecven else @fecemi end,
		-- ================================================================================================================================================
		-- ---  VBF 03012019 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================
				@FU			= ''			,
				@FX			= ''			,
				@FC			= @fecpago		,
				@CI			= 0				,
				@CT			= 0				,
				@INDEV		= 0				,
				@PRINC		= 0				,
				@FIP		= @fecpago		,
				@INCTR		= 0				,
				@CAP		= @capital		,
				@Retorno	= 'N'			,
				@SPREAD		= @spreadEmi    ,
				@Dur_Mac    = 0.0           ,
				@Dur_Mod    = 0.0           ,
				@Convexi    = 0.0


		IF @cod_familia = 2001 AND @tipo_cal	= 2
		BEGIN
			SELECT	@NOM = @valcomu		,					@FE  = @FC
		END

		IF @cod_familia = 2003 AND @tipo_cal	= 2
		BEGIN
			SELECT @FV   = @fecven
		END

		IF @cod_familia in ( 2004, 2005 )  
			SELECT @FV   = @fecven

		--+++jcamposd COD 
		IF @cod_familia = 2006 AND @tipo_cal	= 2
		BEGIN
			SELECT @FV   = @fecven
		END
		-----jcamposd COD 

		EXECUTE Svc_Prc_val_ins	@dFecPro			,
								@TipFomulas			,
								@tipo_cal			,
								@cod_familia		,
								@cod_nemo			,
								@fecha_vcto			,
								@TR			OUTPUT	,
								@TE			OUTPUT	,
								@TV			OUTPUT	,
								@TT			OUTPUT	,
								@BA			OUTPUT	,
								@BF			OUTPUT	,
								@NOM		OUTPUT	,
								@MT			OUTPUT	,
								@VV			OUTPUT	,
								@VP			OUTPUT	,
								@PVP		OUTPUT	,
								@VAN		OUTPUT	,
								@FP			OUTPUT	,
								@FE			OUTPUT	,
								@FV			OUTPUT	,
								@FU			OUTPUT	,
								@FX			OUTPUT	,
								@FC			OUTPUT	,
								@CI			OUTPUT	,
								@CT			OUTPUT	,
								@INDEV		OUTPUT	,
								@PRINC		OUTPUT	,
								@FIP		OUTPUT	,
								@CAP		OUTPUT	,
								@INCTR		OUTPUT	,
								@SPREAD		OUTPUT	,
								@Retorno			,
								@monemi				,
								@PX_IN		OUTPUT  ,
								@PX_AM		OUTPUT  ,
								@Factor     OUTPUT  ,
								@Dur_Mac    OUTPUT  ,
								@Dur_Mod    OUTPUT  ,
								@Convexi    OUTPUT  

		IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
			RETURN
		END

		IF @cod_familia in ( 2002, 2005 ) AND 1 = 2
		BEGIN
	        SELECT 'debug', 'llamada valorizador' , '@numdocu'= @numdocu,
												 ' @cod_familia ' = @cod_familia 
											, ' @cod_nemo ' = @cod_nemo 
											, ' @fecha_vcto ' = @fecha_vcto 
											, ' @TR ' = @TR 
											, ' @TE ' = @TE 
											, ' @TV ' = @TV 
											, ' @TT ' = @TT 
											, ' @BA ' = @BA 
											, ' @BF ' = @BF 
											, ' @NOM ' = @NOM 
											, ' @MT ' = @MT 
											, ' @VV ' = @VV 
											, ' @VP ' = @VP 
											, ' @PVP ' = @PVP 
											, ' @VAN ' = @VAN 
											, ' @FP ' = @FP 
											, ' @FE ' = @FE 
											, ' @FV ' = @FV 
											, ' @FU ' = @FU 
											, ' @FX ' = @FX 
											, ' @FC ' = @FC 
											, ' @CI ' = @CI 
											, ' @CT ' = @CT 
											, ' @INDEV ' = @INDEV 
											, ' @PRINC ' = @PRINC 
											, ' @FIP ' = @FIP 
											, ' @CAP ' = @CAP 
											, ' @INCTR ' = @INCTR 
											, ' @SPREAD ' = @SPREAD 
											, ' @Retorno ' = @Retorno 
											, ' @monemi ' = @monemi 
											, ' @PX_IN ' = @PX_IN 
											, ' @PX_AM ' = @PX_AM ,
                                                @Factor            ,
                                                @Dur_Mac           ,
                                                @Dur_Mod           ,
                                                @Convexi           

		END

		-- MAP 20160606 
		-- Bonex reasignará el valor de esta variable la idea es que se defina para todos las familias
		SET @ValorProxProc = @MT
		SET @interes       = @valorpres - @valorPresAnt
		SET @interes_acum  = @valorpres - @valcomu
		-- ================================================================================================================================================
		-- +++  VBF 24102018 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================
--		+++fmo 20190219 se modifico para mejorar devengo
--		IF  @cod_familia = 2002
--		BEGIN 
--			SET @ValorProxProc = @MT
--			SET @interes       = @ValorProxProc - @valorpres -- cambio VBF07-11-18  @MT - @vptirc
--			SET @interes_acum  = @MT - @capital
--		END 
--		---fmo 20190219 se modifico para mejorar devengo
		-- ================================================================================================================================================
		-- ---  VBF 24102018 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================


		IF @cod_familia = 2000  -- SOLO BONOS
		BEGIN	
			IF @FU > @dFechaante AND @FU <= @dFechaproc AND @FU >= @FC 
			BEGIN -- *3
				SELECT @FecCorte	=  @FU    -- paso a variable para no perder valor
				SELECT @OKCUPON = 'S'	
				IF month(@dFechaante)  <> 	month(@dFechaproc) 
				BEGIN
					IF @FU <= @UltimoDiaMesVCTO 
					BEGIN  -- *2
						-- ya se contabilizo el mes anterior, corte fue en dia fin de mes especial 
						SELECT @OKCUPON = 'N'
						SELECT	@interes     = @vptirc - @PDIA   
						SELECT  @ValorProxProc	= @PRINC + @INDEV
						SELECT 	@interes_acum	= @vptirc - @PDIA -- INT ACUM = PRESENTE HOY - PRICIPAL HOY 
					END 
				END				
				-- el dia de corte cupon se crean 2 registros en la tabla de resultado uno
				-- por devengo y otro por vcto cupon, si es dia normal el registro de
				-- devengo para interes e interes acumulado van en cero. El interes 
				-- que falta reconocer va en el registro de vcto cupon. 
				-- La contabilidad desde este reconoce  interes y vcto cupon			 	
				IF    @OKCUPON  = 'S' 
				BEGIN -- *1 			-- VENCIMIENTO CUPON
					SELECT @CorteCupon = 'S'
					SELECT @ValorProxProc =  @PRINC + @INDEV
					-- valorizacion al dia del corte (proceso o dia anterior inhabil)
					EXECUTE Svc_Prc_val_ins		
							--	ale					@dFechaproc		,
							@FecCorte		, -- fecha de corte cupon ale
							@TipFomulas		,
							@tipo_cal		,
							@cod_familia	,
							@cod_nemo		,
							@fecha_vcto		,
							@TR		OUTPUT	,  @TE	OUTPUT	, @TV OUTPUT	, @TT OUTPUT	, @BA		OUTPUT	,  @BF	OUTPUT	, @NOM	OUTPUT	, @MT	OUTPUT	,
							@VV		OUTPUT	,  @VP	OUTPUT	, @PVP	OUTPUT	, @VAN	OUTPUT	, @FP		OUTPUT	, @FE	OUTPUT	, @FV	OUTPUT	, @FU	OUTPUT	,
							@FX		OUTPUT	, @FC	OUTPUT	, @CI	OUTPUT	, @CT	OUTPUT	, @INDEV	OUTPUT	, @PRINC OUTPUT	, @FIP	OUTPUT	, @CAP	OUTPUT	,
							@INCTR	OUTPUT	, @SPREAD	OUTPUT	, @Retorno	, @monemi	, @PX_IN	OUTPUT  , @PX_AM	OUTPUT  , @Factor OUTPUT  , @Dur_Mac OUTPUT , @Dur_Mod OUTPUT , @Convexi  OUTPUT  

					SELECT 	@PX_IN_CUPON	=  @PX_IN,
							@PX_AM_CUPON	=  @PX_AM

					-- se limpia para que en  cartera muestre 0, en dia de proceso normal  
					IF @ProcEspecial  = 'S' 
					BEGIN
						-- Corte en fin de mes especial reconoce interes para ese mes
						SELECT @interes  =  @valorpres - @valorPresAnt
						
						SELECT @interes_acum = @interes_acum	+ @interes  
						-----------------------------------------------------------------------------
						-- +++ VBF 06-09-2018  CORRIGE PROBLEMA CONTABLE DE CORTE DE CUPON
						-----------------------------------------------------------------------------
						--SELECT @DIFIntVcto   = @PX_IN_CUPON - @interes_acum  --VGS 29/04/2005	
						SELECT @DIFIntVcto   =  (@ValorProxProc+@PX_IN_CUPON)-@valorpres
						-----------------------------------------------------------------------------
						-- --- VBF 06-09-2018  CORRIGE PROBLEMA CONTABLE DE CORTE DE CUPON
						-----------------------------------------------------------------------------

						IF @interes < 0			--VGS 29/04/2005
							SELECT @interes = 0
					END
					ELSE BEGIN
						-- @DIFIntVcto = interes total (corte cupon)- interes acumulado  ,
						-- el cual se guarda en el registro del vcto 
						-- cupon para contabilizarse (campo rsinteres)

						-----------------------------------------------------------------------------
						-- +++ VBF 06-09-2018  CORRIGE PROBLEMA CONTABLE DE CORTE DE CUPON
						-----------------------------------------------------------------------------
						--SELECT @DIFIntVcto   = @PX_IN_CUPON - @interes_acum  --VGS 29/04/2005	

						SELECT @DIFIntVcto   =  (@valorpres-@valorPresAnt)+@PX_IN_CUPON --+++FMO 20190304 correccion corte cupon
--						SELECT @DIFIntVcto   =  (@ValorProxProc+@PX_IN_CUPON)-@valorpres 
						-----------------------------------------------------------------------------
						-- --- VBF 06-09-2018  CORRIGE PROBLEMA CONTABLE DE CORTE DE CUPON
						-----------------------------------------------------------------------------

						-- se limpian variables pues si es habil para el dia de corte o inicio de otro periodo aun no hay intereses	
						SELECT @interes      = 0
						SELECT @interes_acum = 0 
											
						IF @FU < @dFechaproc 
						BEGIN			
							-- si hubo corte fin dia inhabil, debe reconocer interes desde el día del corte al de proceso y queda en registro de devengo	
    						SELECT @fp = @dfechaproc
							-- valoriza con fecha de proceso para sacar valor actual que correspoderia a interes y al acumulado que debe reconocerse contablemente 		

							EXECUTE Svc_Prc_val_ins		
									@dFechaproc				,
									@TipFomulas				,
									@tipo_cal				,
									@cod_familia			,
									@cod_nemo				,
									@fecha_vcto				,
									@TR				OUTPUT	,
									@TE				OUTPUT	,
									@TV				OUTPUT	,
									@TT				OUTPUT	,
									@BA				OUTPUT	,
									@BF				OUTPUT	,
									@NOM			OUTPUT	,
									@MT				OUTPUT	,
									@VV				OUTPUT	,
									@VP				OUTPUT	,
									@PVP			OUTPUT	,
									@VAN			OUTPUT	,
									@FP				OUTPUT	,
									@FE				OUTPUT	,
									@FV				OUTPUT	,
									@FU				OUTPUT	,
									@FX				OUTPUT	,
									@FC				OUTPUT	,
									@CI				OUTPUT	,
									@CT				OUTPUT	,
									@INDEV			OUTPUT	,
									@PRINC			OUTPUT	,
									@FIP			OUTPUT	,
									@CAP			OUTPUT	,
									@INCTR			OUTPUT	,
									@SPREAD			OUTPUT	,
									@Retorno				,
									@monemi					,
									@PX_IN			OUTPUT  ,
									@PX_AM			OUTPUT  ,
									@Factor         OUTPUT  ,
									@Dur_Mac        OUTPUT  ,
									@Dur_Mod		OUTPUT  ,
									@Convexi        OUTPUT  
							
							SELECT @interes      = @indev
							SELECT @interes_acum = @indev 
						END
						-- Valor a pagar paga interes + amortizacion
						SELECT @VV           = @PX_IN_CUPON + @PX_AM_CUPON 
					END				
				END 
			END
			ELSE
			BEGIN	-- *10
				-- DEVENGO NORMAL
				IF @interes_acum = 0 AND  @FC = @dFechaproc  
				BEGIN 	-- Si no tiene acumulado es que es el primer devengo EL PRIMER DIA NO HAY INTERESES 
					SELECT	@interes	= 0
				END	--marcelo Quilodran
				ELSE 
				IF @FC >= @dFechaante AND @FC < @dFechaproc  AND @interes_acum = 0 
				BEGIN -- *5
					SET @fp=@dfechaproc
					SET @princ_paso = @princ
					SET @indev_paso = @indev	
						 
					EXECUTE Svc_Prc_val_ins		
							@dFechaproc				,
							@TipFomulas				,
							@tipo_cal				,
							@cod_familia			,
							@cod_nemo				,
							@fecha_vcto				,
							@TR				OUTPUT	,
							@TE				OUTPUT	,
							@TV				OUTPUT	,
							@TT				OUTPUT	,
							@BA				OUTPUT	,
							@BF				OUTPUT	,
							@NOM			OUTPUT	,
							@MT				OUTPUT	,
							@VV				OUTPUT	,
							@VP				OUTPUT	,
							@PVP			OUTPUT	,
							@VAN			OUTPUT	,
							@FP				OUTPUT	,
							@FE				OUTPUT	,
							@FV				OUTPUT	,
							@FU				OUTPUT	,
							@FX				OUTPUT	,
							@FC				OUTPUT	,
							@CI				OUTPUT	,
							@CT				OUTPUT	,
							@INDEV			OUTPUT	,
							@PRINC			OUTPUT	,
							@FIP			OUTPUT	,
							@CAP			OUTPUT	,
							@INCTR			OUTPUT	,
							@SPREAD			OUTPUT	,
							@Retorno				,
							@monemi					,
							@PX_IN			OUTPUT  ,
							@PX_AM			OUTPUT  ,
							@Factor         OUTPUT  ,
							@Dur_Mac        OUTPUT  ,
							@Dur_Mod        OUTPUT  ,
							@Convexi        OUTPUT  
						
					SET	@interes	= (@PRINC+@INDEV)-@valcomu
					SET @vptirc		= (@PRINC+@INDEV)
					SET @princ		= @princ_PASO
					SET @indev		= @indev_PASO	
				END 
				ELSE 
				IF @interescomp = 0  AND @interes_acum = 0 
				BEGIN  --por devengo del segundo dia cuANDo se compra papel el primer dia del periodo del cupon  PENDIENTE OJO OJO
					SELECT 	@interes =  (@vptirc - @PDIA)
				END 
				ELSE  
				BEGIN -- *7
					-- INTERES = VALOR PRESENTE HOY - VALOR PRESENTE ANTERIOR
					SELECT	@interes     = @vptirc - @valorPresAnt   
					IF @interes     < 0 
					BEGIN  -- *6 
						IF  @ProcEspecial = 'S' 
						BEGIN  
							SELECT @interes = 0
						END 
						ELSE 
						BEGIN
							-- en este caso la op esta en cartera, pero valor presente es menor que ayer lo que implica que hubo venta parcial
							-- se rescatara el valor para hoy completo sin rebajar la venta de tabla resultado                
							SET @interes      = isnull(( SELECT (rsvppresenx - rsvppresen)
														   FROM text_rsu  , text_arc_ctl_dri
                        	                        	  WHERE rsfecpro = acfecante
															AND rsnumoper = @numdocu
	                                        				AND rscartera = 333
        	                                        		AND RSTIPOPER = 'DEV'   )   , 0)                                   
						END
					END
				END
				SELECT  @ValorProxProc	= @PRINC + @INDEV
				SELECT 	@interes_acum	= @vptirc - @PDIA -- INT ACUM = PRESENTE HOY - PRICIPAL HOY 
			END	
		END	-- FIN BLOQUE SOLO BONOS
		ELSE 
		BEGIN -- Bloque resto de productos            --- PRODUCTOS CD - DPEX - NOTEX
			IF @cod_familia in ( 2004, 2005)  -->VB
			BEGIN
			   SELECT @ValorProxProc = @ValorProxProc 
			END
			ELSE
			BEGIN
		-- ================================================================================================================================================
		-- +++  VBF 24102018 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================
				IF @cod_familia <> 2002  --> vb
				BEGIN 
					--SELECT 'entre para notex'
					IF @FU >= @dFechaante AND @FU <= @dFechaproc 
					BEGIN
						SET	@interes		=  @INCTR - @interes_acum 
						SET	@interes_acum	=  @INCTR
					END
					ELSE 
					BEGIN
						SET	@interes		= @INCTR - @interes_acum 
						SET	@interes_acum	= @INCTR 
					END
				END 
				SET  @ValorProxProc	= @CAP + @INCTR	
			END		
		-- ================================================================================================================================================
		-- ---  VBF 24102018 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================


		--+++jcamposd 20170109 -->=REDONDEAR((G20+H20)/(1+D10)^(K20/365),6)
			IF @cod_familia = 2006
			BEGIN
				--para tasa nominal calculo dias base 30 desde inicio a fin
				EXECUTE Svc_fmu_dIF_d30 @fecemi, @fecven, @DIFDIAS OUTPUT  					
				SELECT @TasaNomina = (ROUND((POWER((1+(@TE/100)),(@DIFDIAS/360))-1)*(360/@DIFDIAS),6)) 						--ROUND(  ROUND( ((((POWER((1+ (@TE/100)),(@V001/360))-1)*(360/@V001))*@V001)/360),6)   *@nom , 0 )'
				
				EXECUTE Svc_fmu_dIF_d30 @fecemi, @dFechaProc, @DIFDIAS OUTPUT  --> dias para los acumulados 
				IF @DIFDIAS < = 0
				BEGIN
					SET @interes = 0
					SET @interes_acum = 0
				END
				ELSE
				BEGIN
					--los intereses @interes es el interes del dia y los acumulados es por la dIFerencia de dias					
					--SELECT @interes_acum	= @interes_acum + ROUND(@TasaNomina*@DIFDIAS/360,6)*@nominal
					--SELECT @interes			= ROUND(@TasaNomina*@DIFDIAS/360,6)*@nominal
					SET @interes_acum	= ROUND(@TasaNomina*@DIFDIAS/360,6)*@nominal
					--SELECT @interes			= ROUND(@TasaNomina*datedIFf(day,@dFechaante,@dFechaproc) /360,6)*@nominal
				END

				EXECUTE Svc_fmu_dIF_d30 @fecemi, @FechaproxProc, @DIFDIAS OUTPUT  														
				SET @interesesMañana = ROUND(@TasaNomina*@DIFDIAS/360,6)*@nominal

				--> estos valores corresponde a valor presente hoy y proximo					
				--SELECT  @ValorProxProc	= ROUND((@INDEV +  @PRINC) /POWER((1 + (@TE/100)),(DATEDIFF(d, @dFechaprox,@FV)/365.00000000000)),6)		
				--SELECT  @vptirc	= ROUND((@INDEV +  @PRINC) /POWER((1 + (@TE/100)),(DATEDIFF(d, @dFechaActual,@FV)/365.00000000000)),6)		
				SET  @ValorProxProc		= @CAP + @interesesMañana		
				SET  @vptirc			= @CAP + @interes_acum--@interes

				IF @interes_acum <> 0
				BEGIN
					SET @interes = @vptirc - @valorPresAnt
				END
			END	
		-----jcamposd 20170109
		END
		IF @cod_familia = 2002
		BEGIN
			IF @interes_acum = 0 AND  @FC = @dFechaproc  
			BEGIN 	-- Si no tiene acumulado es que es el primer devengo EL PRIMER DIA NO HAY INTERESES 
				SELECT	@interes	= 0
			END
		END
		
        IF @monemi IN ( 994, 13 ) 
        BEGIN
			SET @interespeso	= ROUND ( @interes * @valorDolar , 0 )

			IF @dFecPro = @fecha_vcto 
			BEGIN
				SET @NominalPeso	= ROUND ( @nominal * @valorDolar , 0 ) -- vencimiento cupon y TOTAL
			END 	
			ELSE 
			BEGIN
				SET @NominalPeso	= ROUND ( @valcomu * @valorDolar , 0 )
			END 

			SET @ValorVctoCpPeso	= ROUND ( @vv	   * @valorDolar , 0 )
			SET @InteresPesoAcum	= ROUND ( @interes_acum * @valorDolar , 0 )
			SET @valorprespeso		= ROUND ( @valorpres * @valorDolar , 0 )
			SET @valorproxpeso		= ROUND ( @ValorProxProc * @valorDolar , 0 )
			SET @PDiaPeso			= ROUND ( @PDia * @valorDolar , 0 )		
      	END
        ELSE 
		IF  @monemi <> 999 AND  @monemi <> 998
        BEGIN 
			SELECT @TipoCambio	= ISNULL(Tipo_Cambio, 0 ) 
			  FROM BacParamSuda..VALOR_MONEDA_CONTABLE
			 WHERE Codigo_Moneda = @monemi 
			   AND Fecha = CASE WHEN @ProcEspecial = 'N' THEN @dFechaproc ELSE @dFechaActual END
                   
			SET @interespeso	= ROUND ( @interes * @TipoCambio , 0 )

			IF @dFecPro = @fecha_vcto 
			BEGIN
				SET @NominalPeso	= ROUND ( @nominal * @TipoCambio , 0 ) -- vencimiento cupon y TOTAL
			END	
			ELSE 
			BEGIN
				SET @NominalPeso	= ROUND ( @valcomu * @TipoCambio , 0 ) -- 
			END 

			SET @ValorVctoCpPeso	= ROUND ( @vv	          * @TipoCambio , 0 )				
			SET @InteresPesoAcum	= ROUND ( @interes_acum   * @TipoCambio , 0 )				
			SET @valorprespeso		= ROUND ( @valorpres      * @TipoCambio , 0 )
			SET @valorproxpeso		= ROUND ( @ValorProxProc  * @TipoCambio , 0 )
			SET @PDiaPeso			= ROUND ( @PDia           * @TipoCambio , 0 )
        END

		-- ================================================================================================================================================
		-- +++  VBF 03012019 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================
			IF @cod_familia = 2002 
			BEGIN
				SELECT @interes_acum = (@MT-@valorPresAnt) 
			END 
		-- ================================================================================================================================================
		-- ---  VBF 03012019 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================

/*********************************************************/
/*			DEVENGAMIENTO	                 */
/*********************************************************/
		INSERT INTO
		TEXT_RSU(	rsfecpro					,	 --1
					rscartera					,
					rsrutcart 					,
					rsnumdocu 					,		
					rsnumoper					,
					cod_familia					,
					cod_nemo					, --5
					id_instrum					,
					rsrutcli					,
					rscodcli					,
					rsvppresen					,
					rsvppresenx					, --10
					rscupamo					,
					rscupint					,
					rscuprea					,
					rsflujo						,
					rsfecprox					, --15
					rsnominal					,
					rstir						,
					rspvp						,
					rsmonemi					,
					rsmonpag					,
					rstasemi					,
					rsbasemi					, --20
					rsinteres					,
					rsreajuste					,
					rsreajuste_acum				,
					rsinteres_acum				,
					rsvalcomu					, --25
					rsvalvenc					,
					rsnumucup					,
					rsnumpcup					,
					rsfecucup					,
					rsfecpcup					, --30
					rsvpcomp					,
					rsfecpago					,
					rsfeccomp					,
					rsfecemis					,
					rsfecvcto					, --	35
					rsrutemis					,
					rstirmerc					,
					rsvalmerc					,
					basilea						,
					tipo_tasa					, --40
					encaje						,		
					monto_encaje				,
					codigo_carterasuper			,
					Tipo_Cartera_Financiera		,
					sucursal					,	 --45
					calce						,
					rscodemi					,
					rsint_compra				, --50
					rsprincipal					,
					operador_banco				,
					corr_cli_nombre				,
					corr_cli_cta				,
					corr_cli_aba				,--35
					corr_cli_pais				,
					corr_cli_ciud				,
					corr_cli_swIFt				,
					corr_cli_ref				,
					rsfecneg					,
					rspfectraspaso				,
					rsajuste_traspaso			,
					rstipoper					,
					rsfecpvencap   				,
					rspvpmerc 					,
					rsfecpag					,
					sw_tir						,
					sw_pvp 						,
					CapitalPeso					,
					InteresPeso					,
					ValorCuponPeso				,
					InteresPesoAcum				,
					PrincipalDia				,
					ValorPresentePeso			,
					Principaldiapeso			,
					DurMacaulay					,
					DurModIFicada				,
					Convexidad					,
					RsId_Libro					)

		SELECT		@dFechaproc					,--1
					'333'						,
					cprutcart 					,
					cpnumdocu 					,
					cpnumdocu 					,
					cod_familia					,
					cod_nemo					, --5
					id_instrum					,
					cprutcli					,
					cpcodcli					,
		-- ================================================================================================================================================
		-- +++  VBF 24102018 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================
--					CASE WHEN @COD_FAMILIA = 2002 THEN @valorPresAnt ELSE  @vptirc   END    				, -->VB
					@vptirc,   --+++fmo 20190219 mojorar devengo 				
					CASE WHEN @COD_FAMILIA = 2002  THEN @MT ELSE @ValorProxProc	END 			, -- @MontoCAP + @INCTR  , --10
		-- ================================================================================================================================================
		-- ---  VBF 24102018 inicio cambio para devengamiento de NOTEX 
		-- ================================================================================================================================================
					0							,		--rscupamo
					0							,		--rscupint
					0							,		--rscuprea
					0							,		--rsflujo
					@dFechaProx					,	 --15
					cpnominal					,
					cptircomp					,
					cppvpcomp					,
					cpmonemi					,
					cpmonpag					,
					cptasemi					,
					cpbasemi					, --20
					@interes					,
					@reajust					,
					@reajuste_acum				,
					@interes_acum				,
					@valcomu					, --25
					@vv							,
					0							,		--rsnumucup
					0							,		--rsnumpcup
					@fu							,
					@fx							, --30
					@vpcomp						,
					cpfecpago					,
					cpfeccomp					,
					cpfecemi					,
					cpfecven					, --35
					cprutemi					,
					0							,
					0							,
					basilea						,
					tipo_tasa					, --40
					encaje						,
					monto_encaje				,
					codigo_carterasuper			,
					Tipo_Cartera_Financiera		,
					sucursal					, --45
					calce						,
					--				tipo_riesgo	,
					--			codigo_riesgo	,
					cpcodemi					,
					cpint_compra				, --50
					@PRINC						,
					operador_banco				,
					corr_cli_nombre				,
					corr_cli_cta				,
					corr_cli_aba				,--35
					corr_cli_pais				,
					corr_cli_ciud				,
					corr_cli_swIFt				,
					corr_cli_ref				,
					cpfecneg 					,
					cpfectraspaso				,
					cpajuste_traspaso			,
					'DEV'						,
					'' 							,
					0							,
					''							,
					0							,
					0							,
					isnull(@nominalPeso,0)		,
					isnull(@interesPeso,0)	,
					isnull(@ValorVctoCpPeso,0)	,
					isnull(@InteresPesoAcum,0)	,
					isnull(@PDIA,0)	,
					isnull(@valorprespeso,0.0)	,
					isnull(@PDiaPeso,0.0)       ,
					@Dur_Mac					,
					@Dur_Mod					,
					@Convexi					,
					Id_Libro
		FROM	TEXT_CTR_INV
		WHERE	cprutcart = @rutcart
		AND	cpnumdocu = @numdocu

		IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
			RETURN
		END
		IF @cod_familia IN ( 2004, 2005 ) AND 1 = 2
		SELECT	'Debug',  '@dFechaproc' =	@dFechaproc		,--1
				RsCartera = '333'			,
				cprutcart 		,
				cpnumdocu 		,
				cpnumdocu 		,
				cod_familia		,
				cod_nemo		, --5
				id_instrum		,
				cprutcli		,
				cpcodcli		,
				'rsvppresen @vptirc'        = @vptirc      		, 				
				'rsVpPresenx @ValorProxProc' = @ValorProxProc		, -- @MontoCAP + @INCTR  , --10
				rscupamo = 0			,		--rscupamo
				rscupint = 0			,		--rscupint
				rscuprea = 0			,		--rscuprea
				rsflujo = 0			,		--rsflujo
				'rsfecProx @dFechaProx' = @dFechaProx	, --15
				cpnominal		,
				cptircomp		,
				cppvpcomp		,
				cpmonemi		,
				cpmonpag		,
				cptasemi		,
				cpbasemi		, --20
				'rsInteres @interes'  = @interes		,
				'@reajust'  = @reajust		,
				'@reajuste_acum' = @reajuste_acum		,
				'rsInteres_Acum @interes_acum'  = @interes_acum		,
				'rsValComU @valcomu'       = @valcomu		, --25          -- SELECT rsvalVenc, * from bacbonosExtSuda.dbo.text_rsu where rsnumdocu = 4031
				'rsValVenc @vv'            = @vv			,
				rsnumucup  = 0			,		--rsnumucup
				rsnumpcup  = 0			,		--rsnumpcup
				'rsFecuCup @fu' = @fu			,
				'rsFecpCup @fx' = @fx			, --30
				'rsVpComp @vpcomp' = @vpcomp	,
				cpfecpago		,
				cpfeccomp		,
				cpfecemi		,
				cpfecven		, --35
				cprutemi		,
				0			,
				0			,
				basilea			,
				tipo_tasa		, --40
				encaje			,
				monto_encaje		,
				codigo_carterasuper	,
				Tipo_Cartera_Financiera	,
				sucursal		, --45
				calce			,
--				tipo_riesgo		,
--				codigo_riesgo		,
				cpcodemi		,
				cpint_compra		, --50
				'rsPrincipal @PRINC'	= @PRINC		,
				operador_banco		,
				corr_cli_nombre		,
				corr_cli_cta		,
				corr_cli_aba		,--35
				corr_cli_pais		,
				corr_cli_ciud		,
				corr_cli_swIFt		,
				corr_cli_ref		,
				cpfecneg 		,
				cpfectraspaso		,
				cpajuste_traspaso	,
				'DEV'			,
				'' 			,
				0			,
				''			,
				0			,
				0			,
				@nominalPeso		,
				@interesPeso		,
				@ValorVctoCpPeso	,
				@InteresPesoAcum	,
				@PDIA			,
				isnull(@valorprespeso,0.0)		,
				isnull(@PDiaPeso,0.0)               ,
                                @Dur_Mac                ,
                                @Dur_Mod                ,
                                @Convexi                ,
				Id_Libro


		FROM	TEXT_CTR_INV
		WHERE	cprutcart = @rutcart
		AND	cpnumdocu = @numdocu
		AND cod_familia in ( 2004, 2005 )

/*********************************************************/
/*		VENCIMIENTO DE CUPON                     */
/*********************************************************/
--		IF @dFecPro = @fecha_vcto or @fx =   @dFechaprox or (@dFechaprox = @feproxcorte) BEGIN
		IF @CorteCupon = 'S' 
		BEGIN
			INSERT INTO
			TEXT_RSU(	rsfecpro				, --1
						rscartera				,
						rsrutcart 				,
						rsnumdocu 				,
						rsnumoper				, --5
						cod_familia				,
						cod_nemo				,
						id_instrum				,
						rsrutcli				,
						rscodcli				, --10
						rsvppresen				,
						rsvppresenx				,
						rscupamo				,
						rscupint				,
						rscuprea				, --15
						rsflujo					,
						rsfecprox				,
						rsnominal				,
						rstir					,
						rspvp					, --20
						rsmonemi				,
						rsmonpag				,
						rstasemi				,
						rsbasemi				,
						rsinteres				, --25
						rsreajuste				,
						rsreajuste_acum			,
						rsinteres_acum			,
						rsvalcomu				, 
						rsvalvenc				, --30
						rsnumucup				,
						rsnumpcup				,
						rsfecucup				,
						rsfecpcup				,	 
						rsvpcomp				, --35
						rsfecpago				,
						rsfeccomp				,
						rsfecemis				,
						rsfecvcto				,		 
						rsrutemis				, --40
						rstirmerc				,
						rsvalmerc				,
						basilea					,
						tipo_tasa				,	 
						encaje					, --45
						monto_encaje			,
						codigo_carterasuper		,
						Tipo_Cartera_Financiera	,
						sucursal				, 
						calce					, --50
						rscodemi				,
						rsint_compra			, 
						rsprincipal				,
						operador_banco			,
						corr_cli_nombre			, --55
						corr_cli_cta			,
						corr_cli_aba			,
						corr_cli_pais			,
						corr_cli_ciud			,
						corr_cli_swIFt			,--	60
						corr_cli_ref			,
						rsfecneg				,
						rspfectraspaso			,
						rsajuste_traspaso		,
						rstipoper				,--65
						rsfecpvencap   			,
						rspvpmerc 				,
						rsfecpag				,
						sw_tir					,
						sw_pvp 					,--70
						CapitalPeso				,
						InteresPeso				,
						ValorCuponPeso			,
						InteresPesoAcum			,
						PrincipalDia			,
						ValorPresentePeso		,
						Principaldiapeso		,
						DurMacaulay             ,
						DurModIFicada           ,
						Convexidad              ,
						RsId_Libro				)

			SELECT		@dFechaproc				,-- @dFecPro  ,--1
						'333'					,
						cprutcart 				,
						cpnumdocu 				,
						cpnumdocu 				,--5
						cod_familia				,
						cod_nemo				, 
						id_instrum				,
						cprutcli				,
						cpcodcli				,--10
						cpvptirc				,
						@ValorProxProc			,	-- @MontoCAP + @INCTR	,
						@PX_AM_CUPON			,		--rscupamo
						@PX_IN_CUPON			,		--rscupint
						0						,--15		--rscuprea
						@vv						,		--rsflujo
						@dFechaProx				,		 
						cpnominal				,
						cptircomp				,
						cppvpcomp				,--20
						cpmonemi				,
						cpmonpag				,
						cptasemi				,
						cpbasemi				,	 
						@DIFIntVcto	  			, -- @interes		,--25
						@reajust				,
						@reajuste_acum			,
						@PX_IN 					, -- Interes acumulado total  @interes_acum		,
						@valcomu				,---- @DIFIntVcto	, 
						@vv						,--30
						0						,		--rsnumucup
						0						,		--rsnumpcup
						@fu						,
						@fx						,	 
						@vpcomp					,--35
						cpfecpago				,
						cpfeccomp				,
						cpfecemi				,
						cpfecven				,	 
						cprutemi				,--40
						0						,
						0						,
						basilea					,
						tipo_tasa				, 
						encaje					,--45
						monto_encaje			,
						codigo_carterasuper		,
						Tipo_Cartera_Financiera	,
						sucursal				, 
						calce					,--50
						cpcodemi				,
						cpint_compra			,
						cpprincipal				,---- @DIFIntVcto, -- Capitalizacion
						operador_banco			,
						corr_cli_nombre			,--55
						corr_cli_cta			,
						corr_cli_aba			,
						corr_cli_pais			,
						corr_cli_ciud			,
						corr_cli_swIFt			,--	60
						corr_cli_ref			,
						cpfecneg 				,
						cpfectraspaso			,
						cpajuste_traspaso		,
						'VCP'					,--65
						'' 						,
						0						,	
						''						,
						0						,
						0						,--70
						isnull(@nominalPeso,0)	,
						isnull(@interesPeso,0)	,
						isnull(@ValorVctoCpPeso,0)	,
						isnull(@InteresPesoAcum,0)	,
						isnull(@Pdia,0)			,
						isnull(@valorprespeso,0),
						isnull(@PDiaPeso,0)		,
						@Dur_Mac                ,
						@Dur_Mod                ,
						@Convexi                ,
						Id_Libro
			FROM	TEXT_CTR_INV
			WHERE	cprutcart = @rutcart
			AND	cpnumdocu = @numdocu

			IF @@ERROR<>0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
				RETURN
			END
		END
/*********************************************************/
/*		VENCIMIENTO DE OPERACIONES NOTEX-DPEX-CD */
/*********************************************************/
		IF @fecven	<=   @dFechaprox AND @cod_familia <> 2000  
		BEGIN
			INSERT INTO
			TEXT_RSU(	rsfecpro				, --1
						rscartera				,
						rsrutcart 				,
						rsnumdocu 				,
						rsnumoper				, --5
						cod_familia				,
						cod_nemo				,
						id_instrum				,
						rsrutcli				,
						rscodcli				, --10
						rsvppresen				,
						rsvppresenx				,
						rscupamo				,
						rscupint				,
						rscuprea				, --15
						rsflujo					,
						rsfecprox				,
						rsnominal				,
						rstir					,
						rspvp					, --20
						rsmonemi				,
						rsmonpag				,
						rstasemi				,
						rsbasemi				,
						rsinteres				, --25
						rsreajuste				,
						rsreajuste_acum			,
						rsinteres_acum			,
						rsvalcomu				, 
						rsvalvenc				, --30
						rsnumucup				,
						rsnumpcup				,
						rsfecucup				,
						rsfecpcup				,	 
						rsvpcomp				, --35
						rsfecpago				,
						rsfeccomp				,
						rsfecemis				,
						rsfecvcto				,		 
						rsrutemis				, --40
						rstirmerc				,
						rsvalmerc				,
						basilea					,
						tipo_tasa				, 
						encaje					, --45
						monto_encaje			,
						codigo_carterasuper		,
						Tipo_Cartera_Financiera	,
						sucursal				, 
						calce					, --50
						rscodemi				,
						rsint_compra			,	 
						rsprincipal				,
						operador_banco			,
						corr_cli_nombre			, --55
						corr_cli_cta			,
						corr_cli_aba			,
						corr_cli_pais			,
						corr_cli_ciud			,
						corr_cli_swIFt			,--60
						corr_cli_ref			,
						rsfecneg				,
						rspfectraspaso			,
						rsajuste_traspaso		,
						rstipoper				,--65
						rsfecpvencap   			,
						rspvpmerc 				,
						rsfecpag				,
						sw_tir					,
						sw_pvp 					,--70
						CapitalPeso				,
						InteresPeso				,
						ValorCuponPeso			,
						InteresPesoAcum			,
						PrincipalDia			,
						ValorPresentePeso		,
						PrincipalDiaPeso		,
						DurMacaulay             ,
						DurModIFicada           ,
						Convexidad              ,
						RsId_Libro				)

			SELECT		@dFechaproc				,--1
						'333'					,
						cprutcart 				,
						cpnumdocu 				,
						cpnumdocu 				,--5
						cod_familia				,
						cod_nemo				,	 
						id_instrum				,
						cprutcli				,
						cpcodcli				,--10
						cpvptirc				,
						@ValorProxProc			,	-- @MontoCAP + @INCTR	,
						@PX_AM					,		--rscupamo
						@PX_IN					,		--rscupint
						0						,--15		--rscuprea
						@vv						,		--rsflujo
						@dFechaProx				, 
						cpnominal				,
						cptircomp				,
						cppvpcomp				,--20
						cpmonemi				,
						cpmonpag				,
						cptasemi				,
						cpbasemi				,	 
						@interes				,--25
						@reajust				,
						@reajuste_acum			,
						@interes_acum			,
						@valcomu 				, 
						@vv						,--30
						0						,		--rsnumucup
						0						,		--rsnumpcup
						@fu						,
						@fx						, 
						@vpcomp					,--35
						cpfecpago				,
						cpfeccomp				,
						cpfecemi				,
						cpfecven				,	 
						cprutemi				,--40
						0						,
						0						,
						basilea					,
						tipo_tasa				, 
						encaje					,--45
						monto_encaje			,
						codigo_carterasuper		,
						Tipo_Cartera_Financiera	,
						sucursal				, 
						calce					,--50
						cpcodemi				,
						cpint_compra			,
						cpprincipal 			, -- Capitalizacion
						operador_banco			,
						corr_cli_nombre			,--55
						corr_cli_cta			,
						corr_cli_aba			,
						corr_cli_pais			,
						corr_cli_ciud			,
						corr_cli_swIFt			,--	60
						corr_cli_ref			,
						cpfecneg 				,
						cpfectraspaso			,
						cpajuste_traspaso		,
						'V'						,--65
						'' 						,
						0						,
						''						,
						0						,
						0						,--70
						isnull((CASE WHEN @dFecPro = @fecha_vcto THEN @nominalPeso ELSE 0 END ),0)		,
						isnull(@interesPeso			,0),
						isnull(@ValorVctoCpPeso		,0),
						isnull(@InteresPesoAcum		,0),
						isnull(@Pdia					,0),
						isnull(@valorproxpeso			,0),
						isnull(@PDiaPeso               ,0),
						@Dur_Mac                ,
						@Dur_Mod                ,
						@Convexi                ,
						Id_Libro
			FROM	TEXT_CTR_INV
			WHERE	cprutcart = @rutcart
			AND	cpnumdocu = @numdocu
		
			IF @@ERROR<>0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
				RETURN

			END
		END
--		SELECT 'NRO',@numdocu

		UPDATE	#cartera
		SET	sw ='S'
		WHERE	rutcart = @rutcart
		AND	numdocu = @numdocu

		IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
			RETURN
		END

	END

/*********************************************************/
/*			COMPRAS  	                 */
/*********************************************************/


	INSERT INTO
	TEXT_RSU(		rsfecpro		,--1
				rscartera		,
				rsrutcart 		,
				rsnumdocu 		,
				rsnumoper 		,
				cod_familia		,--5
				cod_nemo		,
				id_instrum		,
				rsrutcli		,
				rscodcli		,
				rsvppresen		, --10
				rsnominal		, 
				rstir			,
				rspvp			,
				rsmonemi		,
				rsmonpag		,--15
				rstasemi		,
				rsbasemi		,
				rsvalcomu		,
				rsfecpago		,
				rsfeccomp		,--20
				rsfecemis		,
				rsfecvcto		,
				rsrutemis		,
				codigo_carterasuper	,
				Tipo_Cartera_Financiera	,--25
				sucursal		,
				rscodemi		,
				rsint_compra		,
				rsprincipal		,
				operador_banco		,--30
				rsfecneg		,
				rsfecpag		,
				corr_cli_nombre		,
				corr_cli_cta		,
				corr_cli_aba		,--35
				corr_cli_pais		,
				corr_cli_ciud		,
				corr_cli_swIFt		,
				corr_cli_ref		,
				rstipoper		,--39
				tipo_tasa		,
				basilea			,
                                DurMacaulay             ,
                                DurModIFicada           ,
                                Convexidad              ,
				RsId_Libro		)

	SELECT			@dFechaproc		,--1
				'334'			,
				morutcart 		,
				monumdocu 		,
				monumoper		,
				cod_familia		,--5
				cod_nemo		,
				id_instrum		,
				morutcli		,
				mocodcli		,
				movalcomu		,--10
				monominal		,
				motir			,
				mopvp			,
				momonemi		,
				momonpag		,--15
				motasemi		,
				mobasemi		,
				movalcomu		,
				mofecpago		,
				mofecpro		,--20
				mofecemi		,
				mofecven		,
				morutemi		,
				codigo_carterasuper	,
				Tipo_Cartera_Financiera	,--25
				sucursal		,
				cod_emi			,
				moint_compra		,
				moprincipal		,
				operador_banco		,--30
				mofecpro		,
				mofecpago		,
				corr_cli_nombre		,
				corr_cli_cta		,
				corr_cli_aba		,--35
				corr_cli_pais		,
				corr_cli_ciud		,
				corr_cli_swIFt		,
				corr_cli_ref		,
				motipoper		,
				tipo_tasa		,
				basilea                 ,
                                DurMacaulay             ,
                                DurModIFicada           ,
                                Convexidad              ,
				Id_Libro
	FROM	text_ctr_cpr 
	WHERE	motipoper = 'CP'


/*********************************************************/
/*			VENTAS				 */
/*********************************************************/


	INSERT INTO
	TEXT_RSU(		rsfecpro		,--1
				rscartera		,
				rsrutcart 		,
				rsnumdocu 		,
				rsnumoper		,
				cod_familia		,--5
				cod_nemo		,
				id_instrum		,
				rsrutcli		,
				rscodcli		,
				rsvppresen		, --10
				rsnominal		, 
				rstir			,
				rspvp			,
				rsmonemi		,
				rsmonpag		,--15
				rstasemi		,
				rsbasemi		,
				rsvalcomu		,
				rsfecpago		,
				rsfeccomp		,--20
				rsfecemis		,
				rsfecvcto		,
				rsrutemis		,
				codigo_carterasuper	,
				Tipo_Cartera_Financiera	,--25
				sucursal		,
				rscodemi		,
				rsint_compra		,
				rsprincipal		,
				operador_banco		,--30
				rsfecneg		,
				rsfecpag		,
				corr_cli_nombre		,
				corr_cli_cta		,
				corr_cli_aba		,--35
				corr_cli_pais		,
				corr_cli_ciud		,
				corr_cli_swIFt		,
				corr_cli_ref		,
				rstipoper		,--39
				tipo_tasa		,
				basilea			,
                                DurMacaulay             ,
                                DurModIFicada           ,
                                Convexidad              ,
				RsId_Libro		)

	SELECT			@dFechaproc		,--1
				'335'			,
				morutcart 		,
				monumdocu 		,
				monumoper		,
				cod_familia		,--5
				cod_nemo		,
				id_instrum		,
				morutcli		,
				mocodcli		,
				movalcomu		,--10
				monominal		,
				motir			,
				mopvp			,
				momonemi		,
				momonpag		,--15
				motasemi		,
				mobasemi		,
				movalcomu		,
				mofecpago		,
				mofecpro		,--20
				mofecemi		,
				mofecven		,
				morutemi		,
				codigo_carterasuper	,
				Tipo_Cartera_Financiera	,--25
				sucursal		,
				cod_emi			,
				moint_compra		,
				moprincipal		,
				operador_banco		,--30
				mofecpro		,
				mofecpago		,
				corr_cli_nombre		,
				corr_cli_cta		,
				corr_cli_aba		,--35
				corr_cli_pais		,
				corr_cli_ciud		,
				corr_cli_swIFt		,
				corr_cli_ref		,
				motipoper		,
				tipo_tasa		,
				basilea                 ,
                                DurMacaulay             ,
                                DurModIFicada           ,
                                Convexidad              ,
				Id_Libro
	FROM	text_ctr_cpr
	WHERE	motipoper = 'VP'


         ---- VENTAS del dia que deben devengar el ultimo reg de interes

        SELECT DISTINCT monumdocu, cod_nemo ,'nominal'= sum(monominal), mofecpago
        INTO #TEMP_VENTAS
        FROM text_mvt_dri 
        WHERE mofecpago <= @dFechaproc AND 
                mofecpro =  @dFechaproc  
          AND motipoper  = 'vp'
		  AND mostatreg  = '' -- MAP 2016-06-20 Pueden haber anulaciones 
        GROUP BY monumdocu, cod_nemo, mofecpago




		INSERT INTO
		TEXT_RSU(	rsfecpro		, --1
				rscartera		,
				rsrutcart 		,
				rsnumdocu 		,
				rsnumoper		,
				cod_familia		,
				cod_nemo		, --5
				id_instrum		,
				rsrutcli		,
				rscodcli		,
				rsvppresen		,
				rsvppresenx		, --10
				rscupamo		,
				rscupint		,
				rscuprea		,
				rsflujo			,
				rsfecprox		, --15
				rsnominal		,
				rstir			,
				rspvp			,
				rsmonemi		,
				rsmonpag		,
				rstasemi		,
				rsbasemi		, --20
				rsinteres		,
				rsreajuste		,
				rsreajuste_acum		,
				rsinteres_acum		,
				rsvalcomu		, --25
				rsvalvenc		,
				rsnumucup		,
				rsnumpcup		,
				rsfecucup		,
				rsfecpcup		, --30
				rsvpcomp		,
				rsfecpago		,
				rsfeccomp		,
				rsfecemis		,
				rsfecvcto		, --35
				rsrutemis		,
				rstirmerc		,
				rsvalmerc		,
				basilea			,
				tipo_tasa		, --40
				encaje			,
				monto_encaje		,
				codigo_carterasuper	,
				Tipo_Cartera_Financiera	,
				sucursal		, --45
				calce			,
				rscodemi		,
				rsint_compra		, --50
				rsprincipal		,
				operador_banco		,
				corr_cli_nombre		,
				corr_cli_cta		,
				corr_cli_aba		,--35
				corr_cli_pais		,
				corr_cli_ciud		,
				corr_cli_swIFt		,
				corr_cli_ref		,
				rsfecneg		,
				rspfectraspaso		,
				rsajuste_traspaso	,
				rstipoper		,
				rsfecpvencap   		,
				rspvpmerc 		,
				rsfecpag		,
				sw_tir			,
				sw_pvp 			,
				CapitalPeso		,
				InteresPeso		,
				ValorCuponPeso		,
				InteresPesoAcum		,
				PrincipalDia		,
				ValorPresentePeso	,
				Principaldiapeso	,
                                DurMacaulay             ,
                                DurModIFicada           ,
                                Convexidad              ,
				RsId_Libro		)

		SELECT		@dFechaproc		,--1
                                337 ,--- rscartera		,
				rsrutcart 		,
				rsnumdocu 		,
				rsnumoper		,
				cod_familia		,
				text_rsu.cod_nemo		, --5
				id_instrum		,
				rsrutcli		,
				rscodcli		,
				rsvppresenx, --rsvppresen		,
				rsvppresenx		, --10
				rscupamo		,
				rscupint		,
				rscuprea		,
				rsflujo			,
				rsfecprox		, --15
				rsnominal		,
				rstir			,
				rspvp			,
				rsmonemi		,
				rsmonpag		,
				rstasemi		,
				rsbasemi		, --20
				rsvppresenx - rsvppresen, -- rsinteres		,
				rsreajuste		,
				rsreajuste_acum		,
				rsinteres_acum	+ (rsvppresenx - rsvppresen)	,
				rsvalcomu		, --25
				rsvalvenc		,
				rsnumucup		,
				rsnumpcup		,
				rsfecucup		,
				rsfecpcup		, --30
				rsvpcomp		,
				mofecpago		, --rsfecpago		,
				rsfeccomp		,
				rsfecemis		,
				rsfecvcto		, --35
				rsrutemis		,
				rstirmerc		,
				rsvalmerc		,
				basilea			,
				tipo_tasa		, --40
				encaje			,
				monto_encaje		,
				codigo_carterasuper	,
				Tipo_Cartera_Financiera	,
				sucursal		, --45
				calce			,
				rscodemi		,
				rsint_compra		, --50
				rsprincipal		,
				operador_banco		,
				corr_cli_nombre		,
				corr_cli_cta		,
				corr_cli_aba		,--35
				corr_cli_pais		,
				corr_cli_ciud		,
				corr_cli_swIFt		,
				corr_cli_ref		,
				rsfecneg		,
				rspfectraspaso		,
				rsajuste_traspaso	,
				'DV',--rstipoper		,
				rsfecpvencap   		,
				rspvpmerc 		,
				rsfecpag		,
				sw_tir			,
				sw_pvp 			,
				CapitalPeso		,
				InteresPeso		,
				ValorCuponPeso		,
				InteresPesoAcum		,
				PrincipalDia		,
				ValorPresentePeso	,
				Principaldiapeso	,
                                text_rsu.DurMacaulay    ,
                                text_rsu.DurModIFicada  ,
                                text_rsu.Convexidad     ,
				text_rsu.RsId_Libro
		FROM	text_rsu  
		,	text_arc_ctl_dri
		,	#TEMP_VENTAS
        WHERE rsfecpro = acfecante
         -- AND rsnumoper = monumdocu  MAP 2016-06-20 Checar que esot no tenga un efecto colateral
		 AND rsnumdocu = monumdocu
         AND rscartera = 333
		 AND rstipoper = 'DEV'
         AND rsnominal = nominal  -- SELECT * from Text_rsu where rsfecpro = '20160426' order by rsnumdocu

        update text_rsu
        set rsinteres = rsinteres /datedIFf(day,@dFechaante,@dFechaproc) --(rsvppresenx - rsvppresen)/datedIFf(day,@dFechaante,@dFechaproc)
        where rstipoper = 'DV'
        AND rsfecpro = @dFechaproc
        AND rsfecpago <= @dFechaproc    

        update text_rsu
        set rsinteres = rsinteres * datedIFf(day,@dFechaante,rsfecpago)
        where rstipoper = 'DV'
        AND rsfecpro = @dFechaproc
        AND rsfecpago <= @dFechaproc    


      DROP TABLE #TEMP_VENTAS

	COMMIT TRANSACTION

	SELECT 'SI','DEVENGAMIENTO OK......'
	update text_arc_ctl_dri set acsw_dv = 1

	SET NOCOUNT OFF


	RETURN

END
GO
