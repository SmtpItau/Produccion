USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Devengo_Ventas_Con_Pacto]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Devengo_Ventas_Con_Pacto]
			(
			@dfechoy	DATETIME	,
			@dfecprox	DATETIME	,
			@devengo_dolar	CHAR	(01)
			)
AS
BEGIN

    SET NOCOUNT ON
    SET DATEFORMAT dmy

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
                @nintmes	FLOAT		,
		@nreames	FLOAT		,
		@dfecproxc	DATETIME   	,
                @codigosuper    CHAR(1)         ,
                @ntirvent       FLOAT

	DECLARE @dfecemi	DATETIME	,
		@dfecven	DATETIME	,
		@dfecinip	DATETIME	,
		@dfecvtop	DATETIME	,
		@cinstser	CHAR	(10)	,
		@cinstorg	CHAR	(10)	,
		@cseriado	CHAR	(01)	,
		@ctipopero	CHAR(03)	,
		@nrutcart	NUMERIC	(09,0)	,
		@ntipcart	NUMERIC	(09,0)	,
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
 		@ninterpacto	NUMERIC	(19,4)	,
		@ctipoper	CHAR	(02)	,
		@nvpresenci	NUMERIC	(19,4)	,

		@ninterpactoci	NUMERIC	(19,4)	,
		@nreajpactoci	NUMERIC	(19,4)	,
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
		@nreajpacto	NUMERIC	(19,4)	,
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
		@ndifreacup	NUMERIC	(19,4)	,
		@ncodcli	NUMERIC(09,0)	,
		@nvalvtop	NUMERIC	(19,4)	,
		@nvali		NUMERIC (19,4)	,
		@nvpresenvi     NUMERIC (19,4)  ,
                @nprecio_transferencia  FLOAT   ,
                @nlibro_transferencia   FLOAT   ,
                @ninteres_transferencia FLOAT  ,
                @finteres_transferencia FLOAT ,
                @nVPresen_Tras FLOAT         ,
                @nVPresen_Tras_M FLOAT          
     

	DECLARE @cestado 	CHAR(02) 	,  
		@cmensa  	VARCHAR(255) 
		
	DECLARE @sw_contab	CHAR	(01)	,
		@sw_deven	CHAR	(01)	,
		@x1		INTEGER		,
		@contador	INTEGER		,
		@nvalcomp	NUMERIC	(19,4)	,
		@nnominal	NUMERIC (19,4)	,
		@ccartera	CHAR	(03)	,
		@nFORPAGv	NUMERIC	(04,0)	,
		@nmonib		NUMERIC	(19,4)  ,
                @fecdevengo     DATETIME        ,
                @cTipo_Moneda   CHAR(01),
                @nRedondeo      NUMERIC(5),
		@marca		INTEGER

	DECLARE @nvalorpara	FLOAT 

	DECLARE @Tipo_Operacion	VARCHAR(3)

        --** guarda fecha de devengo segun dolar **--
	IF @devengo_dolar='S'
		SELECT	@fecdevengo	= @dfecprox
	ELSE
		SELECT	@fecdevengo	= @dfechoy

	--** revision de switch's y respaldo automÿtico **--
--	UPDATE	VIEW_DATOS_GENERALES SET acsw_pc='1'

/*	SELECT	@sw_contab	= acsw_co	,
		@sw_deven	= acsw_dvvi	,
		@dfpxreal	= Fecha_proxima
	FROM	VIEW_DATOS_GENERALES
*/
	SELECT	
		@dfpxreal	= Fecha_proxima
	FROM	VIEW_DATOS_GENERALES
	--** variables chequeo fin de mes no hÿbil **--
	SELECT	@x1		= 0		,
		@nmes		= 0		,
		@ndia		= 0		,
		@cmes		= ''		,
		@cdia		= ''

	--** se realiza la validaci¢n de las monedas necesarias para procesar devengamiento


        IF @devengo_dolar = 'N' AND ( SELECT COUNT(*) FROM CARTERA_VENTA_PACTO WHERE not (vimonpact IN(994,995,13)) ) = 0
	BEGIN
           SELECT 'OK', 'DEVENGAMIENTO DE LAS VENTAS CON PACTO HA TERMINADO EXITOSAMENTE'            
           RETURN
        END

        IF @devengo_dolar = 'S' AND ( SELECT COUNT(*) FROM CARTERA_VENTA_PACTO WHERE vimonpact IN(994,995,13) ) = 0
	BEGIN
           SELECT 'OK', 'DEVENGAMIENTO DE LAS VENTAS CON PACTO HA TERMINADO EXITOSAMENTE'            
           RETURN
        END




	WHILE @x1<=DATEDIFF(DAY,@dfechoy,@dfecprox)
	BEGIN
		SELECT	@nvalorpara	= 0.0

		IF @devengo_dolar='N'
		BEGIN
			SELECT	@nvalorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE  vmcodigo=998 AND vmfecha=DATEADD(DAY,@x1,@dfechoy)

			IF @nvalorpara IS NULL OR @nvalorpara=0.0
			BEGIN
				SELECT	'NO', 'Valor U.F. '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				RETURN
			END
	
			SELECT	@nvalorpara	= vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=997 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
			IF @nvalorpara	IS NULL OR @nvalorpara = 0.0
			BEGIN
				SELECT	'NO', 'Valor I.V.P. '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				RETURN
			END
		END

		IF @devengo_dolar='S'
		BEGIN
			SELECT	@nvalorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
			IF @nvalorpara IS NULL OR @nvalorpara=0.0
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
                @codigosuper    = ' '		,	
		@marca		= ' '           ,
                @nprecio_transferencia = 0,
                @nlibro_transferencia  = 0 ,
                @ninteres_transferencia = 0 ,
                @finteres_transferencia = 0 
-- select * from RESULTADO_DEVENGO where rsfecha = '20051215' and rscartera=115
	IF @devengo_dolar='N'	
	BEGIN
		DELETE RESULTADO_DEVENGO WHERE rstipopero IN('VI ','VIX','RP ','FLP') AND rsfecha=@dfechoy AND rscartera='115' AND rsmonpact NOT IN(994,995,13)

		IF @@error<>0
		BEGIN 
			SELECT 'NO','NO SE PUDIERON ELIMINAR REGISTROS DE TABLA RESULTADO'
			RETURN
		END
	END
        ELSE BEGIN

		DELETE RESULTADO_DEVENGO WHERE rstipopero IN('VI ','VIX','RP ','FLP') AND rsfecha=@dfechoy AND rscartera='115' AND rsmonpact IN(994,995,13)

        END


     -- D e v e n g a m i e n t o   I n t e r m e d i a c i o n    --
     -- ___________________________________________________________

	SELECT	@x1		= 1	
	SELECT  @contador	= COUNT(*) FROM CARTERA_VENTA_PACTO

	WHILE @x1<=@contador
	BEGIN
		SELECT	@cinstser	= '*'

		SET ROWCOUNT @x1
		SELECT  @cinstser	= viinstser		,
			@cinstorg	= viinstser		,
			@fnominal	= vinominal		,
			@ftir		= vitircomp		,
			@ncodigo	= vicodigo		,
			@dfecemi	= vifecemi		,
			@dfecven	= vifecven		,
			@ftasest	= vitasest		,
			@fpvp		= 0.0			,
			@fmt		= vivptirc		,
			@fmtum		= 0.0			,
			@fmt_cien	= 0.0			,
			@fvan		= 0.0			,

			@fvpar		= vivpcomp		,
			@fvpar2		= vivpcomp		,
			@nnumucup	= 0			,
			@nast		= 0			,
			@dfecucup	= ISNULL(vifecucup,'')	,
			@fintucup	= 0.0			,
			@famoucup	= 0.0			,
			@fsalucup	= 0.0			,
			@nnumpcup	= 0			,
			@dfecpcup	= ISNULL(vifecpcup,'')	,
			@fintpcup	= 0.0			,
			@famopcup	= 0.0			,
			@fsalpcup	= 0.0			,
			@cseriado	= viseriado		,
			@cmascara	= vimascara		,
			@nrutcart	= virutcart		,
			@ntipcart	= 1			,
			@nnumdocu	= vinumdocu		,
			@ncorrela	= vicorrela		,
			@fvpresen	= vivptirc		,
			@nnumoper	= vinumoper		,
          		@fvalcomu	= vivalcomu		,
			@ninteres	= viinteresv		,
			@nreajuste	= vireajustv		,
			@dfeccomp	= vifeccomp		,
			@nnumcupant	= vinumucupv		,
			@ninterpacto	= viinteresvi		,
			@nvalinip	= vivalinip		,
			@nbaspacto	= vibaspact		,
			@ntaspacto	= vitaspact		,                        
			@ctipoper	= vitipoper		,
			@nvpresen	= vivptirvi		,
			@nreajpacto	= vireajustvi		,
			@nrutclip	= virutcli		,
			@ncodcli	= vicodcli		,
			@dfecinip	= vifecinip		,
			@dfecvtop	= vifecvenp		,

			@nmonpacto	= vimonpact		,
			@nvalcomp	= vivalcomp		,
			@ctipopero	= vitipoper		,
                        @codigosuper    = codigo_carterasuper   ,         
			@fdurat		= 0.0			,
			@fconvx		= 0.0			,
			@fdurmo		= 0.0			,
                   	@nintmes	= ISNULL(viintermesvi,0)		,
			@nreames	= ISNULL(vireajumesvi,0)		,
			@nvalvtop	= vivalvenp		,
			@nvali		= vivalinip		,
			@nvpresenvi 	= vicapitalvi + viintacumvi + vireacumvi ,
                        @ntirvent       = vitirvent,
			@marca		= vicorvent,
                        @nprecio_transferencia =Precio_Transferencia,
                        @nlibro_transferencia  = libro_transferencia ,
                        @ninteres_transferencia = interes_transferencia  ,
			@Tipo_Operacion	= Tipo_Operacion
		FROM	CARTERA_VENTA_PACTO		
		SET ROWCOUNT 0
		SELECT	@x1		= @x1 +1

		IF @cinstser='*'
			BREAK

		IF @cseriado='S'
			SELECT	@ftasemi	= setasemi	,
				@nmonemi	= semonemi	,
				@fbasemi	= sebasemi	,
				@nrutemi	= serutemi
			FROM	VIEW_SERIE
			WHERE	semascara=@cmascara
		ELSE
			SELECT	@ftasemi	= nstasemi	,
				@nmonemi	= nsmonemi	,
				@fbasemi	= nsbasemi	,
				@nrutemi	= nsrutemi
			FROM	NOSERIE
			WHERE	nsrutcart=@nrutcart AND nsnumdocu=@nnumdocu AND nscorrela=@ncorrela


                SELECT @cTipo_Moneda = mnextranj,
                       @nRedondeo    = mnredondeo
                FROM   VIEW_MONEDA
                WHERE  mncodmon = @nmonpacto

                IF @devengo_dolar='S' AND (@nmonpacto=994 OR @nmonpacto=995 OR @nmonpacto=13) OR @devengo_dolar='N' AND
		(@nmonpacto<>994 AND @nmonpacto<>995 AND @nmonpacto<>13)
                BEGIN
			SELECT	@nvalmon_h	= 1.0	,
				@nvalmon_m	= 1.0	,
				@nvalmon_c	= 1.0	,
				@nreadia	= 0.0	,
				@nintdia	= 0.0

			IF @nmonpacto<>999 AND @cTipo_Moneda <> "0"
			BEGIN
				SELECT	@nvalmon_h=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonpacto AND vmfecha=@dfechoy
				SELECT	@nvalmon_m=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonpacto AND vmfecha=@dfecprox
				SELECT	@nvalmon_c=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonpacto AND vmfecha=@dfecinip

                            IF (@nvalmon_h  = 0 or @nvalmon_m = 0 or @nvalmon_c = 0) BEGIN
                                SELECT 'NO','Falta Moneda:' + CONVERT(CHAR(3),@nmonpacto) + ' del ' + CASE WHEN @nvalmon_h  = 0 THEN CONVERT(CHAR(10),@dfechoy,103)
                                                                                                      WHEN @nvalmon_m = 0  THEN CONVERT(CHAR(10),@dfecprox,103)
                                                                                                          ELSE CONVERT(CHAR(10),@dfecinip,103) END                    
                               RETURN
                            END
			END

			IF DATEDIFF(MONTH,@dfechoy,@dfecprox)>0
				SELECT	@nintmes	= 0.0	,
					@nreames	= 0.0

			IF @dfechoy=@dfecinip
				SELECT	@nvpresen = @nvalinip


			SELECT	@nvalinip  = ROUND(@nvalinip/@nvalmon_c,4)


			IF @dfecvtop= @dfecprox 
	 			SELECT	@fmt	   = CONVERT(FLOAT,ROUND( @nvalvtop * @nvalmon_m,CASE WHEN @ctipo_moneda = 0 THEN @nRedondeo ELSE 0 END))
			ELSE
 				SELECT	@fmt	   = CONVERT(FLOAT,ROUND(ROUND(@nvalinip*(((@ntaspacto/(@nbaspacto*100.0))*DATEDIFF(DAY,@dfecinip,@dfecprox))+1.0),4)*@nvalmon_m,CASE WHEN @ctipo_moneda = 0 THEN @nRedondeo ELSE 0 END))


			SELECT	@nreadia   = ROUND((@nvalmon_m-@nvalmon_h)*@nvalinip,CASE WHEN @ctipo_moneda = 0 THEN @nRedondeo ELSE 0 END)
			SELECT	@nintdia   = ROUND(@fmt - @nvpresen - @nreadia,CASE WHEN @ctipo_moneda = 0 THEN @nRedondeo ELSE 0 END)


			IF @dfecvtop = @dfecprox BEGIN
				SELECT	@nintdia   = ROUND( @fmt - ( @nvali + @ninterpacto + @nreadia + @nreajpacto ) ,CASE WHEN @ctipo_moneda = 0 THEN @nRedondeo ELSE 0 END)
			END

---TRANSFERENCIA
                        SELECT  @nVPresen_Tras_M  = CONVERT(FLOAT,ROUND(ROUND(@nvalinip*(((@nprecio_transferencia /(@nbaspacto*100.0))* DATEDIFF(DAY,@dfecinip,@dfecprox))+1.0),CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END)*@nvalmon_m,CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END))
                        SELECT  @nVPresen_Tras    = @nvalinip+ @ninteres_transferencia + @nreajpacto
  
                        SELECT @finteres_transferencia =ROUND( @nVPresen_Tras_M - (@nVPresen_Tras + @nreadia),CASE WHEN @ctipo_moneda =0 THEN @nRedondeo ELSE 0 END )
-----


---Dia 
--			SELECT	@ninteres  = @ninterpacto + @nintdia
--			SELECT	@nreajuste = @nreajpacto  + @nreadia
			SELECT	@ninteres  = @ninterpacto 
			SELECT	@nreajuste = @nreajpacto  
--Mes
--			SELECT	@nintmes   = @nintmes     + @nintdia
--			SELECT	@nreames   = @nreames     + @nreadia
			SELECT	@nintmes   = @nintmes     
			SELECT	@nreames   = @nreames     

			SELECT	@fvpresen  = @nvpresen    + @nintdia + @nreadia
--			SELECT	@fvpresen  = @nvpresen 
			SELECT	@famocupo  = 0.0	,
				@fintcupo  = 0.0	,
				@fvalcomu  = 0.0	,
				@ftasest   = 0.0	,
				@fpvp      = 0.0	,
				@fvpar     = 0.0

			SELECT	@dfecproxc = CASE 
						WHEN @devengo_dolar='S' THEN @dfecprox
						ELSE @dfechoy
					     END           
	
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
					rscupint	,--15
					rsflujo		,--16
					rsfecprox	,--17
					rsfecctb	,--18
					rsnominal	,--19
					rstir		,--20
					rstasFLOAT	,--21
					rsmonemi	,--22
					rsmonpact	,--23
					rstasemi	,--24
					rsbasemi	,--25
					rscodigo	,--26
					rsinteres	,--27
					rsreajuste	,--28
					rsintermes	,--29
					rsreajumes	,--30
					rsinteres_acum	,--31
					rsreajuste_acum	,--32
					rsforpagv	,--33
					rsvalcomp	,--34
					rsvalcomu	,--35
					rsvalvenc	,--36
					rsdurat		,--37
					rsdurmod	,--38
					rsconvex	,--39
					rsnumucup	,--40
					rsnumpcup	,--41
					rsfecucup	,--42
					rsfecpcup	,--43
					rsvpcomp	,--44
					rstipopero	,--45

					rsfecvtop	,--46
					rsvalvtop	,--47
					rsfecinip	,--48
					rsrutemis	,--49
					rsvalinip	,--50
					rstaspact	,--51                                
                                        codigo_carterasuper, --52
                                        rsfecemis       , -- 53
                                        rsfecvcto       , -- 54
                                        codigo_subproducto , --55
                                        precio_transferencia,
                                        libro_transferencia,
                                        interes_diario_transferencia,
                                        interes_acum_transferencia 
					)
			VALUES	
					(
					@dfechoy        , --1
					@nrutcart	, --2

					@ntipcart	, --3
					@nnumdocu	, --4
					@ncorrela	, --5
					@nnumoper	, --6
					'115'		, --7
					'DEV'		, --8
					@nrutclip	, --9
					@ncodcli	, --10
					@cinstser	, --11
					@fvpresen	, --12
					@fmt		, --13
					@famocupo	, --14
					@fintcupo	, --15
					@famocupo+@fintcupo,--16
					@dfecproxc	, --17 fecha prox.proceso
					@dfechoy	, --18
					@fnominal	, --19
					@ntirvent	, --20
					0.0		, --21
					@nmonemi	, --22
					@nmonpacto	, --23
					@ntaspacto	, --24
					@nbaspacto	, --25
					@ncodigo	, --26
					@nintdia	, --27 int dia
					@nreadia	, --28 rea dia 
					@nintmes	, --29 interes del mes
					@nreames	, --30 reajuste del mes
					@ninteres	, --31 int acum
					@nreajuste	, --32 rea acum
					0		, --33
					0		, --34 valcomp
					0.0		, --35 valcomu
					0.0		, --36 valvenc
					@fdurat		, --37
					@fdurmo		, --38
					@fconvx		, --39
					@nnumucup	, --40
					0		, --41
					@dfecucup	, --42
					@dfecpcup	, --43
					0.0		, --44 vpcomp
					@Tipo_Operacion	,	--'VI'		, --45
					@dfecvtop	, --46
					@nvalvtop	, --47
					@dfecinip	, --48
					@nrutemi	, --49	
					@nvali		, --50
					@ntaspacto	, --51                                                         
                                        @codigosuper    , --52
                                        @dfecemi        , --53
                                        @dfecven        , --54   
                                        (CASE WHEN @Tipo_Operacion = 'VIX' THEN 'VI' ELSE @Tipo_Operacion END)	, 	--'VI'            ,
                                        @nprecio_transferencia,
                                        @nlibro_transferencia,
                                        @finteres_transferencia,
                                        @ninteres_transferencia 
					)

			IF @@error<>0
			BEGIN
				SELECT	'NO','devengamiento ha fallado en grabaci+n de resultado'
				RETURN
			END
		END

	END

        SELECT 'OK', 'DEVENGAMIENTO DE LAS VENTAS CON PACTO HA TERMINADO EXITOSAMENTE'

	RETURN

   SET NOCOUNT OFF

END



GO
