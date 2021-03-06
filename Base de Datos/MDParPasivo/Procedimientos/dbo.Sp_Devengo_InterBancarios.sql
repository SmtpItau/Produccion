USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Devengo_InterBancarios]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Devengo_InterBancarios]
			(
			@dfechoy	DATETIME	,
			@dfecprox	DATETIME	,
			@devengo_dolar	CHAR	(01)
			)
AS
BEGIN

        SET DATEFORMAT dmy
        SET NOCOUNT ON
	DECLARE	@modcal		INTEGER		,
		@ncodigo	INTEGER		,
		@cmascara	CHAR	(10)	,
		@nmonemi	INTEGER		,
		@cfecemi	CHAR	(10)	,
		@cfecven	CHAR	(10)   	,
		@ftasemi	FLOAT		,
		@fbasemi	FLOAT		,
		@ftasest	FLOAT		,
		@fnominal	FLOAT		,
		@ftir		FLOAT		,
		@fpvp		FLOAT		,
		@fmt		FLOAT		,
		@fmtum		FLOAT		,
		@fmt_cien	FLOAT		,
		@fvan		FLOAT		,
		@fvpar		FLOAT		,
		@fvpar2		FLOAT		,
		@nnumucup	INTEGER		,
		@dfecucup	DATETIME	,
		@fintucup	FLOAT		,
		@famoucup	FLOAT		,
		@fsalucup	FLOAT		,
		@nnumpcup	INTEGER		,
		@dfecpcup	DATETIME	,
		@fintpcup	FLOAT		,
		@famopcup	FLOAT		,
		@fsalpcup	FLOAT		,
		@nerror		INTEGER		,
		@cprog		CHAR	(10)	,
		@fdurat		FLOAT		,
		@fconvx		FLOAT		,
		@fdurmo		FLOAT		,
		@nintmes 	FLOAT		,
		@nreames	FLOAT		

	DECLARE @dfecemi	DATETIME	,
		@dfecven	DATETIME	,
		@dfecinip	DATETIME	,
		@dfecvtop	DATETIME	,
		@cinstser	CHAR	(10)	,
		@cinstorg	CHAR	(10)	,
		@cseriado	CHAR	(01)	,
		@ctipopero	CHAR(03)	,
		@nrutcart	NUMERIC	(09,0)	,
		@ntipcart	NUMERIC	(03,0)	,
		@nrutclip	NUMERIC (09,0)	,
		@nrutcli	NUMERIC	(09,0)	,
		@nrutemi	NUMERIC	(09,0)	,
		@nnumdocu	NUMERIC	(10,0)	,
		@ncorrela	NUMERIC	(03,0)	,
		@nnumoper	NUMERIC	(10,0)	,
		@fvpresen	NUMERIC (19,4)	,
		@nvalmon_h	FLOAT		,
		@nvalmon_m	FLOAT		,
		@nvalmon_o	FLOAT		,
		@fvalcomu	FLOAT		,
		@fvalcupo	FLOAT		,
		@fintcupo	FLOAT		,
		@famocupo	FLOAT		,
		@dfeccomp	DATETIME	,
		@dfpxreal	DATETIME	,
		@dfecoriginal	DATETIME	,
		@bcupon		INTEGER		,
		@ffactor	FLOAT		,
		@nvalmon_c	FLOAT		,
		@nvalmon_i	FLOAT		,
		@nmoncupon	FLOAT		,
		@fcapital	FLOAT		,
		@nnumcupant	INTEGER		,
		@fcapital_um	FLOAT		,
 		@ninterpacto	NUMERIC	(19,0)	,
		@ctipoper	CHAR	(02)	,
		@nvpresenci	NUMERIC	(19,0)	,

		@ninterpactoci	NUMERIC	(19,0)	,
		@nreajpactoci	NUMERIC	(19,0)	,
		@ntaspactoci	NUMERIC	(08,4)	,
		@nmonpactoci	INTEGER		,
		@nbaspactoci	INTEGER		,
		@ninteres	NUMERIC	(19,4)	,
		@nreajuste	NUMERIC	(19,4)	,
		@nintdia	NUMERIC	(19,4)	,
		@nreadia	NUMERIC	(19,4)	,
		@nvalinip	NUMERIC	(19,4)	,
		@nbaspacto	INTEGER		,
		@ntaspacto	NUMERIC	(08,4)	,
		@nvpresen	NUMERIC	(19,4)	,
		@nmonpacto	INTEGER		,
		@nreajpacto	NUMERIC	(19,0)	,
		@nbasemi	INTEGER		,
		@ntasemi	NUMERIC	(08,4)	,
		@nreacup	NUMERIC	(19,4)	,
		@nintcup	NUMERIC	(19,4)	,
		@ndifcup	NUMERIC (19,4)	,
		@npagcup	NUMERIC	(19,4)	,
		@npagcupo	NUMERIC	(19,4)	,
		@pago_nohabil	INTEGER		,
		@nmes		INTEGER		,
		@ndia		INTEGER		,
		@nano		INTEGER		,
		@nmes_a		INTEGER		,
		@nast		INTEGER		,
		@cmes		CHAR	(02)	,
		@cdia		CHAR	(02)	,
		@cano		CHAR	(04)	,
		@nuf		INTEGER		,
		@nivp		INTEGER		,
		@ndo		INTEGER		,
		@ndifreacup	NUMERIC(19,0)	,
		@ncodcli	NUMERIC(09,0)	,
		@nvpresen1	NUMERIC(19,4)   ,
                @nprecio_transferencia FLOAT ,
                @nlibro_transferencia  FLOAT ,
                @ninteres_transferencia FLOAT,
                @finteres_transferencia FLOAT

	DECLARE @cestado 	CHAR(02) 	,  
		@cmensa  	varCHAR(255) 
		
	DECLARE @sw_contab	CHAR	(01)	,
		@sw_deven	CHAR	(01)	,
		@x1		INTEGER		,
		@contador	INTEGER		,
		@nvalcomp	NUMERIC	(19,4)	,
		@nnominal	NUMERIC (19,4)	,
		@ccartera	CHAR	(03)	,
		@nForpagv	NUMERIC	(04,0)	,
		@nforpagi	NUMERIC	(04,0)	,
		@nmonib		NUMERIC	(19,4)  ,
		@fecdevengo     DATETIME	,
		@nValorpara	FLOAT           ,
                @cTipo_Moneda   CHAR(1)         ,
                @nRedondeo      NUMERIC(5)      ,
                @nVPresen_Tras FLOAT         ,
                @nVPresen_Tras_M FLOAT          
     
    

 	IF @devengo_dolar='S'
 		SELECT	@fecdevengo	= @dfecprox
  	ELSE
		SELECT	@fecdevengo	= @dfechoy

--	UPDATE	VIEW_DATOS_GENERALES SET acsw_pc='1'
/*
	SELECT	@sw_contab	= acsw_co	,
		@sw_deven	= acsw_dvib	,
		@dfpxreal	= Fecha_proxima
	FROM	VIEW_DATOS_GENERALES
*/

	SELECT	@dfpxreal	= Fecha_proxima
	FROM	VIEW_DATOS_GENERALES
	--** variables chequeo fin de mes no hÿbil **--
	SELECT	@x1		= 0		,
		@nmes		= 0		,
		@ndia		= 0		,
		@cmes		= ''		,
		@cdia		= ''

	--** se realiza la validaci¢n de las monedas necesarias para procesar devengamiento
/*
       IF NOT EXISTS(SELECT numero_operacion FROM CARTERA_INTERBANCARIA
                      WHERE moneda_pacto NOT IN(994,995,13) AND @devengo_dolar = 'N' ) BEGIN

           SELECT	'OK','Proceso de Devengamiento ha finalizado en forma correcta'
    
           RETURN
        END

        IF NOT EXISTS(SELECT numero_operacion FROM CARTERA_INTERBANCARIA
                      WHERE moneda_pacto IN(994,995,13) AND @devengo_dolar = 'S' ) BEGIN

           SELECT	'OK','Proceso de Devengamiento ha finalizado en forma correcta'
           RETURN 
        END
*/
	

	IF @devengo_dolar = 'N' AND ( SELECT COUNT(*) FROM CARTERA_INTERBANCARIA WHERE NOT ( moneda_pacto IN(994,995,13) )) = 0
	BEGIN
           SELECT 'OK', 'DEVENGAMIENTO INTERBANCARIOS  HA TERMINADO EXITOSAMENTE'            
           RETURN
        END

        IF @devengo_dolar = 'S' AND ( SELECT COUNT(*) FROM CARTERA_INTERBANCARIA WHERE moneda_pacto IN(994,995,13) ) = 0
	BEGIN
           SELECT 'OK', 'DEVENGAMIENTO INTERBANCARIOS  HA TERMINADO EXITOSAMENTE'            
           RETURN
        END





	WHILE @x1<=DATEDIFF(DAY,@dfechoy,@dfecprox)
	BEGIN
		SELECT	@nValorpara	= 0.0

		IF @devengo_dolar='N'
		BEGIN
			SELECT	@nValorpara = vmvalor FROM VIEW_Valor_MONEDA WHERE  vmcodigo=998 AND vmfecha=DATEADD(DAY,@x1,@dfechoy)

			IF @nValorpara IS NULL OR @nValorpara=0.0
			BEGIN
				SELECT	'NO', 'Valor U.F. '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				RETURN
			END
	
			SELECT	@nValorpara	= vmvalor FROM VIEW_Valor_MONEDA WHERE vmcodigo=997 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
			IF @nValorpara	IS NULL OR @nValorpara = 0.0
			BEGIN
				SELECT	'NO', 'Valor I.V.P. '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				RETURN
			END
		END

		IF @devengo_dolar='S'
		BEGIN
			SELECT	@nValorpara = vmvalor FROM VIEW_Valor_MONEDA WHERE vmcodigo=994 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
			IF @nValorpara IS NULL OR @nValorpara=0.0
			BEGIN
				SELECT	'NO', 'Valor Dolar '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				RETURN
			END
		END

		SELECT	@x1 = @x1 + DATEDIFF(DAY,@dfechoy,@dfecprox)
	END

	SELECT	@nmonemi	= 0		,
		@dfecemi	= ''		,
		@dfecven	= ''		,
		@ftasemi	= 0.0		,
		@fbasemi	= 0		,
		@ftasest	= 0.0		,
		@fnominal	= 0.0		,
		@ftir		= 0.0		,
		@fpvp		= 0.0		,
		@fmt		= 0.0		,
		@fmtum		= 0.0		,
		@fmt_cien	= 0.0		,
		@fvan		= 0.0		,
		@fvpar		= 0.0		,
		@fvpar2		= 0.0		,
		@nnumucup	= 0.0		,
		@dfecucup	= ''		,
		@fintucup	= 0.0		,
		@famoucup	= 0.0		,
		@fsalucup	= 0.0		,
		@nnumpcup	= 0.0		,
		@dfecpcup	= ''		,
		@fintpcup	= 0.0		,
		@famopcup	= 0.0		,
		@fsalpcup	= 0.0		,
		@nerror		= 0		,
		@cprog		= ''		,
		@nvalcomp	= 0.0           ,
                @nprecio_transferencia = 0,
                @nlibro_transferencia  = 0 ,
                @ninteres_transferencia = 0 ,
                @finteres_transferencia = 0 

	IF @devengo_dolar='N'	
	BEGIN
--		DELETE RESULTADO_DEVENGO WHERE (rstipopero='IB' OR rstipopero='TD' OR rstipopero='LBC') AND rsfecha=@dfecprox
--		DELETE RESULTADO_DEVENGO WHERE (rstipopero='IB' OR rstipopero='TD' OR rstipopero='LBC') AND rsfecha=@dfechoy
		DELETE RESULTADO_DEVENGO WHERE rscartera='121' AND rsfecha=@dfechoy AND ( rsmonpact<>994 and rsmonpact<>995 and rsmonpact<>988 and rsmonpact<>13)
		IF @@error<>0
		BEGIN 
			SELECT	'NO', 'Problemas en Borrado de RESULTADO_DEVENGO'
			RETURN
		END
	END
	ELSE
	BEGIN

--		DELETE RESULTADO_DEVENGO WHERE rstipopero='IB' AND rsfecha=@dfecprox AND ( rsmonpact=994 OR rsmonpact=995 OR rsmonpact=988 )
--		DELETE RESULTADO_DEVENGO WHERE (rstipopero='IB' OR rstipopero='TD' OR rstipopero='LBC') AND rsfecha=@dfechoy  AND ( rsmonpact=994 OR rsmonpact=995 OR rsmonpact=988 )
		DELETE RESULTADO_DEVENGO WHERE rscartera='121' AND rsfecha=@dfechoy AND ( rsmonpact=994 OR rsmonpact=995 OR rsmonpact=988 OR rsmonpact = 13)
		IF @@error<>0
		BEGIN 
			SELECT	'NO', 'Problemas en Borrado de RESULTADO_DEVENGO'
			RETURN
		END
	END


	-- D e v e n g a m i e n t o    I n t e r b a n c a r i o s	  --
	-- _________________________________________________________________

	SELECT	@x1		= 1			,
		@contador	= 0			,
		@cinstser	= ''			,
		@ninteres	= 0.0			,
		@nreajuste	= 0.0			,
		@nmonemi	= 0.0			,
		@nbasemi	= 0.0			,
		@ftasemi	= 0.0			,
		@nnumdocu	= 0.0			,
		@ncorrela	= 0.0			,
		@dfecven	= ''			,
		@nvalcomp	= 0.0			,
		@fvalcomu	= 0.0			,
		@nnominal	= 0.0			,
		@fvpresen	= 0.0			,
		@nmonib		= 0.0

	SELECT  @contador	=  COUNT(*) FROM CARTERA_INTERBANCARIA 

	WHILE @x1<=@contador
	BEGIN
		SELECT	@cinstser='*'

		SET ROWCOUNT @x1
		SELECT  @cinstser	= mascara		,
			@nmonemi	= moneda_pacto		,
			@nbasemi	= base_pacto		,
			@ftasemi	= tasa_pacto		,
			@nrutcart	= rut_cartera		,
			@nnumdocu	= numero_documento	,
			@ncorrela	= correlativo_operacion	,
			@dfecven	= fecha_vencimiento_pacto	,
			@nvalinip	= ISNULL(valor_compra,0)	,
			@nvalcomp	= valor_compra		,
			@fvalcomu	= valor_compra_um	,
			@nnominal	= valor_vencimiento		,
			@nvpresen	= ISNULL(valor_presente_tir_pacto,0)	,
            		@fvpresen	= ISNULL(valor_presente_tir_compra,0)	,
			@nrutclip	= rut_cliente		,
			@ncodcli	= codigo_cliente	,
                        @nrutemi        = rut_cliente		,
			@ntipcart	= tipo_cartera		,
			@dfecinip	= fecha_inicio_pacto	,
			@ncodigo	= codigo		,
			@ninteres	= ISNULL(interes_compra,0)	,
			@nreajuste	= ISNULL(reajuste_compra,0)	,
			@nforpagv	= forma_pago_vencimiento	,
			@nforpagi	= forma_pago_inicio		,
			@nmonib		= ISNULL(nominal_pesos,0)	,
			@nintmes	= interes_mes		,
			@nreames	= reajuste_mes		,
			@fnominal	= nominal		,

			@dfeccomp	= fecha_inicio_pacto		,
			@nvpresen1      = capital_compra+interes_compra+reajuste_compra,
                        @ctipopero      = Tipo_Operacion, --serie
                        @nprecio_transferencia =Precio_Transferencia,
                        @nlibro_transferencia  = libro_transferencia ,
                        @ninteres_transferencia = interes_transferencia  
		FROM	CARTERA_INTERBANCARIA

		SET ROWCOUNT 0


                SELECT	@x1 = @x1 + 1

                /* dolares existentes =================================================== */
                /* 994 : dolar observado                                                  */
                /* 995 : dolar acuerdo                                                    */
                /* 996 : dolar interbancario                                              */
                /* ====================================================================== */

                IF @devengo_dolar='S'
                BEGIN
			IF @nmonemi<>994 AND @nmonemi<>995 AND @nmonemi<>988 AND @nmonemi<> 13
				CONTINUE
		END
                ELSE
               BEGIN
			IF @nmonemi=994 OR @nmonemi=995 OR @nmonemi=988 OR @nmonemi=13
				CONTINUE
		END

		IF @cinstser='*'
			BREAK
		
 		SELECT	@nvalmon_h	= 1.0	,
			@nvalmon_m	= 1.0	,
			@nvalmon_c	= 1.0	,
			@nreadia	= 0.0	,
			@nintdia	= 0.0

--		IF @nrutclip=97029000
--         		SELECT @ccartera='130'
--		ELSE
			SELECT @ccartera='121'

                SELECT @ctipo_moneda = mnextranj ,
                       @nRedondeo    = mnredondeo
                FROM VIEW_MONEDA WHERE mncodmon = @nmonemi

		IF @ctipo_moneda  <> 0 and @nmonemi<>999  --AND @nmonemi<>13
		BEGIN
			SELECT	@nvalmon_h=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonemi AND vmfecha=@dfechoy
			SELECT	@nvalmon_m=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonemi AND vmfecha=@dfecprox
			SELECT	@nvalmon_c=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonemi AND vmfecha=@dfecinip

                        IF (@nvalmon_h  = 0 or @nvalmon_m = 0 or @nvalmon_c = 0) BEGIN
                           SELECT 'NO','Falta Moneda:' + CONVERT(CHAR(3),@nmonemi) + ' del ' + CASE WHEN @nvalmon_h  = 0 THEN CONVERT(CHAR(10),@dfechoy,103)
                                                                                                    WHEN @nvalmon_m = 0  THEN CONVERT(CHAR(10),@dfecprox,103)
                                                                                                    ELSE CONVERT(CHAR(10),@dfecinip,103) END                    
                           RETURN
                       END

		END

		IF DATEDIFF(MONTH,@dfechoy,@dfecprox)>0
			SELECT	@nintmes	= 0.0	,
				@nreames	= 0.0

		IF @dfechoy=@dfecinip
			SELECT	@fvpresen = @nvalcomp

		SELECT	@nvalinip  = ROUND(@nvalinip/@nvalmon_c,4)


		IF @dfecvtop= @dfecprox 
			SELECT	@fmt	   = CONVERT(FLOAT,ROUND( @fnominal * @nvalmon_m,CASE WHEN @ctipo_moneda = 0 THEN @nRedondeo ELSE 0 END))
		ELSE
	            	SELECT	@fmt	          = CONVERT(FLOAT,ROUND(ROUND(@nvalinip*(((@ftasemi/(@nbasemi*100.0))* DATEDIFF(DAY,@dfecinip,@dfecprox))+1.0),CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END)*@nvalmon_m,CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END))
                
		SELECT	@nreadia   = ROUND((@nvalmon_m-@nvalmon_h)*@nvalinip,CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END )
		SELECT	@nintdia   = ROUND(@fmt - @nvpresen1 - @nreadia,CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END )

---TRANSFERENCIA
                SELECT  @nVPresen_Tras_M  = CONVERT(FLOAT,ROUND(ROUND(@nvalinip*(((@nprecio_transferencia /(@nbasemi*100.0))* DATEDIFF(DAY,@dfecinip,@dfecprox))+1.0),CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END)*@nvalmon_m,CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END))
                SELECT  @nVPresen_Tras    = @nvalinip+ @ninteres_transferencia + @nreajuste

                SELECT @finteres_transferencia =ROUND( @nVPresen_Tras_M - (@nVPresen_Tras + @nreadia),CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END )
-----

		IF @dfecvtop = @dfecprox BEGIN
			SELECT	@nintdia   = ROUND( @fmt - ( @nvalcomp + @ninteres + @nreadia + @nreajuste ) ,CASE WHEN @ctipo_moneda = 0 THEN @nRedondeo ELSE 0 END)
		END


		SELECT	@ninteres  = @ninteres  
		SELECT	@nreajuste = @nreajuste 
		SELECT  @nintmes   = @nintmes  
		SELECT  @nreames   = @nreames  
                SELECT  @fmt       = Round(@nvpresen + @nreadia + @nintdia,CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END)


		INSERT INTO RESULTADO_DEVENGO
				(
				rsfecha		, --1
				rsrutcart	, --2
				rstipcart	, --3
				rsnumdocu	, --4
				rscorrela	, --5
				rsnumoper	, --6
				rscartera	, --7
				rstipoper	, --8
				rsrutcli	, --9
				rscodcli	, --10
				rsinstser	, --11 
				rsvppresen	, --12
				rsvppresenx	, --13
				rscupamo	, --14
				rscupint	, --15
				rsflujo		, --16
				rsfecprox	, --17
				rsfecctb	, --18
				rsnominal	, --19
				rstir		, --20
				rstasfloat	, --21
				rsmonemi	, --22
				rsmonpact	, --23
				rstasemi	, --24
				rsbasemi	, --25
				rscodigo	, --26
				rsinteres	, --27
				rsreajuste	, --28
				rsintermes	, --29
				rsreajumes	, --30
				rsinteres_acum	, --31  
				rsreajuste_acum	, --32  
				rsforpagv	, --33
				rsvalcomp	, --34
				rsvalcomu	, --35
				rsvalvenc	, --36
				rsvpcomp	, --37
				rstipopero	, --38	
				rsfeccomp	, --40
				rsfecpcup	, --41
				rsforpagi	, --42
				rsfecinip	, --43
				rsfecvtop	, --44
                                rsrutemis       , --45
                                codigo_subproducto, --46
                                precio_transferencia,
                                libro_transferencia,
                                interes_diario_transferencia,
                                interes_acum_transferencia 
				)
		VALUES
				(
		--		@dfecprox	,
                                @dfechoy	,
				@nrutcart	,
				@ntipcart	,
				@nnumdocu	,
				@ncorrela	,
				@nnumdocu	,
				@ccartera	,
				'DEV'		,
				@nrutclip	,
				@ncodcli	,
				@cinstser	,
				@nvpresen	,
				@fmt		,
				0.0		,

				@nmonib  	,
				@nmonib  	,
       	                        @fecdevengo	,
--				@dfechoy	,
				@dfecprox       ,
				@fnominal	,
				@ftasemi	,
				0.0		,
				@nmonemi	,
				@nmonemi	,
				@ftasemi	,
				@nbasemi	,
				@ncodigo	,
				@nintdia	,
				@nreadia	,
				@nintmes	, -- interes del mes   -- 29
				@nreames	, -- reajuste del mes	--30
				@ninteres	,			--31
				@nreajuste	,			--32
				@nforpagv	,			--33
				@nvalcomp	, -- valcomp		--34
				0.0		, -- valcomu		--35
				@fnominal       , -- valvenc		--36
				0.0		, -- vpcomp		--37
				@ctipopero      ,			--38
				@dfeccomp	,			--39
				@dfecven	,			--40
				@nforpagi	,			--41
				@dFecinip	,			--42
				@dFecven        ,                       --43
                                @nrutemi        ,                       --44
                                @ctipopero      ,                        --45
                                @nprecio_transferencia,
                                @nlibro_transferencia,
                                @finteres_transferencia,
                                @ninteres_transferencia 
				)

		IF @@error<>0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT	'NO','Devengamiento ha fallado en grabacion de Interbancario'
			RETURN
		END



/*
		IF @dfecven<=@dfecprox

			INSERT INTO RESULTADO_DEVENGO
					(
					rsfecha		,
					rsrutcart	,
					rstipcart	,
					rsnumdocu	,
					rscorrela	,
					rsnumoper	,
					rscartera	,
					rstipoper	,
					rsrutcli	,
					rscodcli	,
                                        rsrutemis       ,
					rsinstser	,
					rsvppresen	,
					rsvppresenx	,
					rscupamo	,
					rscupint	,
--					rscuprea	,
					rscuprea	,
					rsflujo		,
					rsfecprox	,
					rsfecctb	,
					rsnominal	,
					rstir		,
					rstasfloat	,
					rsmonemi	,
					rsmonpact	,
					rstasemi	,
					rsbasemi	,
					rscodigo	,
					rsinteres	,
					rsreajuste	,
					rsintermes	,
					rsreajumes	,
					rsinteres_acum	,
					rsreajuste_acum	,
					rsforpagv	,
					rsvalcomp	,
					rsvalcomu	,
					rsvalvenc	,
					rsvpcomp	,
					rstipopero	,
					rsfeccomp	,
					rsforpagi	,
					rsfecinip	,
					rsfecvtop
					)
			VALUES
					(
					@dfecprox	,
					@nrutcart	,
					@ntipcart	,
					@nnumdocu	,
					@ncorrela	,
					@nnumdocu	,
					@ccartera	,
					'VC'		,
					@nrutclip	,
					@ncodcli	,
                                        @nrutemi        , 
					@cinstser	,
					@nvalcomp	,
					@nvalcomp+@ninteres+@nreajuste+@nintdia+@nreadia,
					@nvalcomp	,
					@ninteres	,
					@nReajuste	,
--					@nReajuste	,
					@nvalcomp+@ninteres+@nreajuste+@nintdia+@nreadia,
        	                        @dfecprox	,
					@dfechoy	,
					@fnominal	,
					@ftasemi	,
					0.0		,
					@nmonemi	,
					@nmonemi	,
					@ftasemi	,
					@nbasemi	,
					@ncodigo	,
					@nintdia	, -- interes del día
					@nreadia	, -- reajuste del día
					@nintmes + @nintdia, -- interes del mes
					@nreames + @nreadia, -- reajuste del mes
					@ninteres + @nintdia, -- int acum 
					@nreajuste + @nreadia, -- rea acum					
					@nforpagv	,
					@nvalcomp	, -- valcomp
					0.0		, -- valcomu
					0.0		, -- valvenc
					0.0		, -- vpcomp
					@ctipopero	,
					@dfeccomp	,
					@nforpagi	,
					@dFecinip	, --42
					@dFecven
					)

			IF @@error<>0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT	'NO','Devengamiento ha fallado en grabaci+n de Interbancario'
				RETURN
			END


*/
	END



--	IF @devengo_dolar='N'
	
--        UPDATE VIEW_DATOS_GENERALES SET acsw_dvib='1'

	SELECT	'OK','Proceso de Devengamiento ha finalizado en forma correcta'

	RETURN

END
   /* fin procedimiento */

GO
