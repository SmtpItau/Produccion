USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_C8_NUEVA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_C8_NUEVA]
AS
BEGIN


	SET NOCOUNT ON
	DECLARE	@c		CHAR	(1)	,
		@c1		CHAR	(1)	,
		@mascara 	CHAR	(12)	,
		@instrumento	CHAR	(12)	,
		@codigo		NUMERIC	(5)	,
		@nominal	NUMERIC	(19,4)	,
		@tir		NUMERIC	(19,4)	,
		@taspact	NUMERIC	(19,4)	,
		@fecvenpact	DATETIME	,
		@moneda		NUMERIC	(5)	,
		@cLetraFlujoAmo CHAR	(1)	,
		@cLetraFlujoInt CHAR	(1)	,
		@cTipoOperacion CHAR	(5)	,
		@cTipoCartera	CHAR	(1)	,
		@seriado	CHAR	(1)	,
		@tipoper	CHAR	(5)	,
		@valinip	NUMERIC	(19,4)	,
		@valvenp	NUMERIC	(19,4)	,
		@valcomp	NUMERIC	(19,4)	,
		@rutcli		NUMERIC	(9)	,
		@codcli		NUMERIC	(5)	,
		@rutemi		NUMERIC	(9)	,
		@tabla		CHAR	(4)	,
		@numero 	NUMERIC	(9)	,
		@cuenta		CHAR	(20)	,
		@cuenta_interes	CHAR	(20)	,
		@tipo_tasa	NUMERIC	(1)	,
		@tdfecven	DATETIME	,
		@tdinteres	NUMERIC (19,4)	,
		@tdamort	NUMERIC	(19,4)	,
		@tdsaldo	NUMERIC	(19,4)	,
		@inversion	NUMERIC	(5)	,
		@tipo_cuenta	CHAR	(2)	,
		@fecha		DATETIME	,
		@fecpro		DATETIME	,
		@periodo 	INTEGER		,
		@tdcupon	NUMERIC	(5)	,
		@fecvenp	DATETIME	,
		@cliente	NUMERIC	(9)	,
		@estado		NUMERIC	(9)	,
		@emtipo		CHAR	(2)	,
		@nmes 		CHAR	(2)	,
		@nmes_a 	CHAR	(2)	,
		@nano 		CHAR	(4)	,
		@cano 		CHAR	(4)	,
		@nNumdocu	NUMERIC	(10,0)	,
		@nNumoper	NUMERIC	(10,0)	,
		@nCorrela	NUMERIC	(03,0)	,
		@nVpresen	NUMERIC	(19,4)	,
		@tipo_linea     CHAR 	(1)	,
		@nValvenc	NUMERIC	(19,4)

	SELECT	@fecpro		= acfecproc	,
		@cliente	= acrutprop
	FROM	MDAC

	SELECT	@estado	= emrut FROM VIEW_EMISOR WHERE emgeneric='ESTAD'
	
	CREATE TABLE #CARTERA
				(
				mascara 	CHAR	(12)				,
				numdocu		NUMERIC	(10,0)				,
				numoper		NUMERIC	(10,0)				,
				corre		NUMERIC	(03,0)				,
				instrumento	CHAR	(12)				,
				codigo		NUMERIC	(05)				,
				nominal		NUMERIC	(19,4)				,
				tir		NUMERIC	(19,4)				,
				taspact		NUMERIC	(19,4)	NULL	DEFAULT	(0)	,
				fecvenpact	DATETIME	NULL			,
				moneda		NUMERIC	(05)				,
				seriado		CHAR	(01)				,
				tipoper		CHAR	(05)				,
				valinip		NUMERIC	(19,4)	NULL	DEFAULT	(0)	,
				rutcli		NUMERIC	(09)				,
				codcli		NUMERIC	(05)				,
				rutemi		NUMERIC	(09)				,
				tabla		CHAR	(04)				,
				periodo		INTEGER					,
				fecvenp		DATETIME	NULL			,						
				valvenp		NUMERIC	(19,4)	NULL	DEFAULT	(0)	,
				valcomp		NUMERIC	(19,4)	NULL	DEFAULT	(0)	,
				correla		NUMERIC	(09)	IDENTITY	(1,1)	,
				cuenta		CHAR	(20)	NULL	DEFAULT ('')	,
				tipo_linea	CHAR	(01)	NULL	DEFAULT	('H')	,
				flujea		CHAR	(01)	NULL			,
				fecemi		DATETIME	NULL			,
				vpresen		NUMERIC	(19,4)	NULL	DEFAULT	(0)	,
				valvenc		NUMERIC (19,4)  NULL	DEFAULT	(0)	,
				sw 		CHAR(1)					,
				base		NUMERIC(03)  	NULL	DEFAULT	(0)	,
				TipoCartera	CHAR(1)		NULL	DEFAULT (0)	,
				grupo		INTEGER					,
				cuenta_interes	CHAR(20)
				)

	TRUNCATE TABLE MDC08

	-- COMPRA PROPIA (CAPITAL)
	INSERT	#CARTERA
	SELECT	cpmascara	,
		cpnumdocu	,
		cpnumdocu	,
		cpcorrela	,
		cpinstser	,
		cpcodigo	,
		cpnominal	,
		CASE WHEN cpcodigo = 98 THEN 0 ELSE cptircomp END,
		0		,
		''		,
		CASE
			WHEN cpseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
			ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara)
		END		,
		cpseriado	,
		'CP'		,
		0		,
		cprutcli	,
		cpcodcli	,
		CASE
			WHEN cpseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
			ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)
		END		,
		'MDCP'		,
		ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=cpmascara),0)	,
		cpfecven	,
		cpnominal	,
		cpvalcomp	,
		CtaContable	,
		CASE
			WHEN tipolinea='H' THEN 'T'
			ELSE 'C'
		END		,
		CASE
			WHEN SUBSTRING(cpinstser,1,3)='SUD' THEN 'S'
			WHEN SUBSTRING(cpinstser,1,3)='BNS' THEN 'S'
			WHEN codigo_carterasuper='P' THEN 'S'
			ELSE 'N'
		END		,
		cpfecemi	,
		cpvptirc	,
		0		,
		''		,
		CASE
			WHEN cpseriado='N' THEN (SELECT DISTINCT nsbasemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
			ELSE (SELECT DISTINCT sebasemi FROM VIEW_SERIE WHERE semascara=cpmascara)
		END		,
		codigo_carterasuper,
		1		,
		''
	FROM	MDCP, CARTERA_CUENTA
	WHERE	cpnominal>0 AND cprutcart>0 AND
		(t_operacion='CP' AND numdocu=cpnumdocu AND correla=cpcorrela AND numoper=cpnumdocu AND	variable='valor_compra')

	UPDATE	#CARTERA
	SET	cuenta_interes = CtaContable
	FROM	CARTERA_CUENTA
	WHERE	grupo=1
	AND	t_operacion      ='DVCP'
	AND	#CARTERA.numdocu = CARTERA_CUENTA.numdocu
	AND	#CARTERA.corre   = CARTERA_CUENTA.correla
	AND	#CARTERA.numoper = CARTERA_CUENTA.numoper
	AND	variable         ='Interes_papel'


	UPDATE	#CARTERA
	SET	valvenc = rsvalvenc
	FROM 	mdrs, mdac
	WHERE	rsfecha = acfecprox
	AND	rscartera = '111'
	AND	rsnumdocu = numdocu
	AND	rsnumoper = numoper
	AND	rscorrela = corre
	AND	rstipoper = 'DEV'

	-- Cartera Intermediada
	INSERT	#CARTERA 
	SELECT	vimascara	,
		vinumdocu	,
		vinumoper	,
		vicorrela	,
		viinstser	,
		vicodigo	,
		vinominal	,
		vitircomp	,
		0		,
		vifecvenp	,
		vimonemi	,
		viseriado	,
		'CP'		,
		0		,
		virutcli	,
		vicodcli	,
		CASE
			WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
			ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
		END		,
		'MDCP'		,
		ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0)	,
		vifecven	,
		vinominal	,
		vivalcomp	,	
		ctacontable	,
		CASE
			WHEN tipolinea='H' THEN 'T'
			ELSE 'C'
		END		,
		CASE
			WHEN SUBSTRING(viinstser,1,3)='SUD' THEN 'S'
			WHEN SUBSTRING(viinstser,1,3)='BNS' THEN 'S'
			WHEN codigo_carterasuper='P' THEN 'S'
			WHEN DATEDIFF(DAY,acfecproc,vifecvenp)>29 AND codigo_carterasuper='T' THEN 'S'
			ELSE 'N'
		END		,
		vifecemi	,
		vivptirv	,
		0		,
		''		,
		CASE
			WHEN viseriado='N' THEN (SELECT DISTINCT nsbasemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
			ELSE (SELECT DISTINCT sebasemi FROM VIEW_SERIE WHERE semascara=vimascara)
		END		,
		'T'		,
		2		,
		''
	FROM	MDVI , CARTERA_CUENTA , MDAC
	WHERE	t_operacion='VI' AND numdocu=vinumdocu AND correla=vicorrela AND numoper=vinumoper  AND
		variable='valor_compra'


	UPDATE	#CARTERA
	SET	cuenta_interes = CtaContable
	FROM	CARTERA_CUENTA
	WHERE	grupo=2
	AND	t_operacion      = 'DVIT'
	AND	#CARTERA.numdocu = CARTERA_CUENTA.numdocu
	AND	#CARTERA.corre   = CARTERA_CUENTA.correla
	AND	#CARTERA.numoper = CARTERA_CUENTA.numoper
	AND	variable         = 'Interes_papel'


	-- Cartera VI
	INSERT	#CARTERA 
	SELECT	vimascara	,
		vinumdocu	,
		vinumoper	,
		vicorrela	,
		viinstser	,
		vicodigo	,
		vinominal	,
		vitircomp	,
		vitaspact	,
		vifecvenp	,
		vimonpact	,
		viseriado	,
		'VI'		,
		vivalinip	,
		virutcli	,
		vicodcli	,
		CASE
			WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
			ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
		END		,
		'MDVI'		,
		ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0)	,
		''		,
		vivalvenp	,
		vivalcomp	,
		CtaContable	,
		CASE
			WHEN tipolinea='H' THEN 'T'
			ELSE 'C'
		END		,
		'S'		,
		vifecinip	,
		vivptirvi	,
		0		,
		''		,
		vibaspact	,
		'T'		,
		3		,
		''
	FROM	MDVI, CARTERA_CUENTA
	WHERE	t_operacion='VI' AND numdocu=vinumdocu AND correla=vicorrela AND numoper=vinumoper	AND
		variable='valor_venta'


	-- Cartera Vi Intereses
	INSERT	#CARTERA 
	SELECT	vimascara	,
		vinumdocu	,
		vinumoper	,
		vicorrela	,
		viinstser	,
		vicodigo	,
		vinominal	,
		vitircomp	,
		vitaspact	,
		vifecvenp	,
		vimonpact	,
		viseriado	,
		'IN-VI'		,
		vivalinip	,
		virutcli	,
		vicodcli	,
		CASE
			WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
			ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
		END		,
		'MDVI'		,
		ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0)	,
		''		,
		vivalvenp	,
		vivalcomp	,
		CtaContable	,
		CASE
			WHEN tipolinea='H' THEN 'T'
			ELSE 'C'
		END		,
		'S'		,
		vifecinip	,
		vivptirvi	,
		0		,
		''		,
		vibaspact	,
		'T'		,
		4		,
		''
	FROM	MDVI, CARTERA_CUENTA
	WHERE	t_operacion='DVVI' AND numdocu=vinumdocu AND correla=vicorrela AND numoper=vinumoper	AND
		variable='interes_pacto'

	-- Cartera IB-CI
	INSERT	#CARTERA
	SELECT	cimascara	,
		cinumdocu	,
		cinumdocu	,
		cicorrela	,
		ciinstser	,
		cicodigo	,
		cinominal	,
		citircomp	,
		citaspact	,
		cifecvenp	,
		cimonpact	,
                ciseriado	,
               CASE
			WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
			ELSE 'CI'
		END		,
		civalinip	,
		cirutcli	,
		cicodcli	,
		CASE
			WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cirutcli
			ELSE (CASE WHEN ciseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
				nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
				ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cimascara)
				END)
		END		,
		'MDCI'		,
		ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0)	,
		''		,
		civalvenp	,
		civalcomp	,
		CtaContable	,
		CASE
			WHEN tipolinea='H' THEN 'T'
			ELSE 'C'
		END		,
		'S'		,
		cifecinip	,
		civptirci	,
		0		,
		''		,
		cibaspact	,
		'T'		,
		5		,
		''
	FROM	MDCI, CARTERA_CUENTA
	WHERE	t_operacion=(CASE WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'CP' ELSE 'CI' END) AND
		cicodigo=codigoinst AND	t_movimiento='MOV' AND numdocu=cinumdocu AND correla=cicorrela AND
		variable='valor_compra'

	-- Cartera IB-CI Intereses
	INSERT	#CARTERA
	SELECT	cimascara	,
		cinumdocu	,
		cinumdocu	,
		cicorrela	,
		ciinstser	,
		cicodigo	,
		cinominal	,
		citircomp	,
		citaspact	,
		cifecvenp	,
		cimonpact	,
		ciseriado	,
		CASE
			WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IN-IB'
			ELSE 'IN-CI'
		END		,
		civalinip	,
		cirutcli	,
		cicodcli	,
		CASE
			WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cirutcli
			ELSE (CASE WHEN ciseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
				nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
				ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cimascara)
				END)
		END		,
		'MDCI'		,
		ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0)	,
		''		,
		civalvenp	,
		civalcomp	,
		CtaContable	,
		CASE
			WHEN tipolinea='H' THEN 'T'
			ELSE 'C'
		END		,
		'S'		,
		cifecinip	,
		civptirci	,
		0		,
		''		,
		cibaspact	,
		'T'		,
		6		,
		''
	FROM	MDCI, CARTERA_CUENTA
	WHERE	t_operacion=(CASE WHEN ciinstser='ICOL' THEN 'DICO' WHEN ciinstser='ICAP' THEN 'DICA' ELSE 'DVCI' END) AND
		cicodigo=codigoinst AND numdocu=cinumdocu AND correla=cicorrela AND
		variable=(CASE WHEN ciinstser='ICOL' THEN 'Interes_pacto' WHEN ciinstser='ICAP' THEN 'Interes_papel' ELSE 'Interes_pacto' END)

	--** Pasivos **--
/*	INSERT	#CARTERA
	SELECT	cpmascara								,
		cpnumdocu								,
		cpnumdocu								,
		cpcorrela								,
		cpinstser								,
		cpcodigo								,
		cpnominal								,
		cptircol								,
		0									,
		''									,
		(SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara)	,
		cpseriado								,
		'CP'									,
		0									,
		0									,
		0									,
		(SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)	,
		'MDCP'									,
		ISNULL((SELECT sepervcup FROM VIEW_SERIE WHERE semascara=cpmascara),0)	,
		cpfecven								,
		cpnominal								,
		cpvalcol								,
		CtaContable								,
		CASE
			WHEN tipolinea='H' THEN 'T'
			ELSE 'C'
		END									,
		'S'									,
		cpfecemi								,
		cpvptircol								,
		0									,
		''									,
		(SELECT DISTINCT sebasemi FROM VIEW_SERIE WHERE semascara=cpmascara)	,
		'T'									,
		7									,
		''
	FROM	MDPASIVO, CARTERA_CUENTA
	WHERE	cpnominal>0 AND cprutcart>0 AND
		(t_operacion='CPP' AND numdocu=cpnumdocu AND correla=cpcorrela AND numoper=cpnumdocu AND variable='valor_compra')
*/
	UPDATE	#CARTERA
	SET	valvenc = rsvalvenc
	FROM 	MDRS, MDAC
	WHERE	rsfecha = acfecprox
	AND	rscartera = '211'
	AND	rsnumdocu = numdocu
	AND	rsnumoper = numoper
	AND	rscorrela = corre
	AND	rstipoper = 'DEVP'



	UPDATE	#CARTERA
	SET	cuenta_interes = CtaContable
	FROM	CARTERA_CUENTA
	WHERE	grupo=7
	AND	t_operacion      ='DVCPP'
	AND	#CARTERA.numdocu = CARTERA_CUENTA.numdocu
	AND	#CARTERA.corre   = CARTERA_CUENTA.correla
	AND	#CARTERA.numoper = CARTERA_CUENTA.numoper
	AND	variable         ='Interes_papel'


	--** Pasivos **--
	UPDATE	#CARTERA 
	SET	tir 	= tir * 12    ,
		taspact = taspact * 12
	WHERE	base=30	AND codigo<>888	AND codigo<>15

	SELECT	@numero	= 0

	DECLARE	@cFlujea	CHAR	(01)	,
		@dFecemi	DATETIME	,
		@iCupones	INTEGER


--SELECT * FROM #CARTERA WHERE MASCARA LIKE 'BR%'

-- delete #cartera where not (numdocu = 51088 AND numoper = 51088)
--delete #CARTERA where rtrim(ltrim(cuenta))<>'1710600011'
--delete #CARTERA where rtrim(ltrim(cuenta))<>'1735582034'
--delete #CARTERA where not ( tipoper in ('IN-IB'))
--select * from #CARTERA order by instrumento
--select * from #CARTERA 
--select * from #CARTERA 

	WHILE (1=1)
	BEGIN

		SELECT	@c	= '*'
 
		SET ROWCOUNT 1
		SELECT	@mascara	= mascara 	,
	      		@instrumento	= instrumento	,
			@codigo		= codigo	,
			@nominal	= nominal	,
			@tir		= tir		,
			@taspact	= taspact	,
			@fecvenpact	= fecvenpact	,
			@moneda		= moneda	,
			@seriado	= seriado	,
			@tipoper	= tipoper	,
			@valinip	= valinip	,
			@rutcli		= rutcli	,
			@codcli		= codcli	,
			@rutemi		= rutemi	,
			@tabla		= tabla		,
			@numero		= CONVERT(CHAR(9),correla),
			@c		= '1'		,
			@periodo	= periodo	,
			@fecvenp	= fecvenp	,
			@valvenp	= valvenp	,
			@valcomp	= valcomp	,
			@nNumdocu	= numdocu	,
			@nNumoper	= numoper	,
			@nCorrela	= corre		,
			@cuenta		= cuenta	,
			@cuenta_Interes	= cuenta_interes,
			@tipo_linea   	= tipo_linea	,
			@cFlujea	= flujea	,
			@dFecemi	= fecemi	,
			@iCupones	= 0		,
			@nVpresen	= vPresen	,
			@nValvenc	= Valvenc	,
			@cTipoCartera	= TipoCartera	,
			@cTipoOperacion	= TipOper
		FROM	#CARTERA
		WHERE	sw=''
		SET ROWCOUNT 0

		
		IF @c='*' BEGIN
			BREAK
		END

-- SELECT emtipo,* FROM VIEW_EMISOR order by emtipo
-- SELECT emtipo,* FROM VIEW_EMISOR order by emnombre
		SELECT	@emtipo	= emtipo FROM VIEW_EMISOR WHERE emrut=@rutemi

/*		IF @codigo=15
		BEGIN
			SELECT	@inversion=	(CASE @rutemi	WHEN @cliente THEN 22102 ELSE 
  						(CASE @emtipo WHEN 1 THEN 11110 ELSE	
						(CASE @rutemi WHEN @estado THEN 21402 ELSE
						(CASE @emtipo WHEN 2 THEN 22104 ELSE 12001 END) END) END)
						  END)
		END
		ELSE
		BEGIN
			SELECT	@inversion	= (CASE @rutemi WHEN @estado THEN 21401 ELSE		
							(CASE @rutemi WHEN @cliente THEN 21101 ELSE
							(CASE @emtipo WHEN 2 THEN 11111 ELSE 22101  END)END)
						  END)					
		END

		SELECT	@inversion = CASE
					WHEN @codigo = 4	THEN 21110
					WHEN @codigo = 6	THEN 21101
					WHEN @codigo = 7	THEN 21102
					WHEN @codigo = 9	THEN 22198
					WHEN @codigo = 11	THEN 22198
					WHEN @codigo = 31	THEN 22199
					WHEN @codigo = 50	THEN 30002
					WHEN @codigo = 51	THEN 30002
					WHEN @codigo = 52	THEN 30002
					WHEN @codigo = 53	THEN 30002
					WHEN @codigo = 54	THEN 30002
					WHEN @codigo = 98	THEN 12099
					WHEN @codigo = 300	THEN 21123
					WHEN @codigo = 301	THEN 21124
					WHEN @codigo = 888	THEN 11109  -- OK
					WHEN @codigo=15		THEN CASE WHEN @rutemi = @cliente  THEN 22102
                                                                          WHEN @rutemi = @estado   THEN 21402
                                                                          WHEN @emtipo = 2         THEN 22104
                                                                                                   ELSE 12001 
                                                                     END  -- OK 
					WHEN @codigo=20		THEN CASE
									WHEN @rutemi = @estado	THEN 21401
									WHEN @rutemi = @cliente	THEN 21101
									ELSE 22103  END
--									WHEN @emtipo = 2	THEN 11111
--									ELSE 22101  END
					END
*/
		SELECT	@inversion = CASE
					WHEN @codigo = 4	THEN 21110 -- PRC   (OK)
					WHEN @codigo = 6	THEN 21101 -- PDBC  (OK)
					WHEN @codigo = 7	THEN 21102 -- PRBC  (OK)
					WHEN @codigo = 9	THEN 22198 -- DPF   (OK)
					WHEN @codigo = 11	THEN 22198 -- DPR   (OK)
					WHEN @codigo = 14	THEN 22198 -- DPD   (OK)
					WHEN @codigo = 31	THEN 21122 -- PRD   (OK)
					WHEN @codigo = 32	THEN 21126 -- BCU   (OK)
					WHEN @codigo = 33	THEN 21125 -- BCP   (OK)
					WHEN @codigo = 34	THEN 21127 -- BCD   (OK)
					WHEN @codigo = 50	THEN 30002 -- DPX   (OK)
					WHEN @codigo = 51	THEN 30002 -- DPX   (OK)
					WHEN @codigo = 52	THEN 30002 -- DPX   (OK)
					WHEN @codigo = 53	THEN 30002 -- DPX   (OK)
					WHEN @codigo = 54	THEN 30002 -- DPX   (OK)
					WHEN @codigo = 98	THEN 12099 -- FMUTUO(OK)
					WHEN @codigo = 300	THEN 21123 -- CERO  (OK)
					WHEN @codigo = 301	THEN 21124 -- ZERO  (OK)
					WHEN @codigo = 888	THEN 11109 -- BR    (OK)
					WHEN @codigo=15		THEN 12001 -- BONOS (OK)
					WHEN @codigo=20		THEN ( CASE WHEN @rutemi = @estado	THEN 21401
                                                                            WHEN @rutemi = @cliente	THEN 22101
                                                                                                        ELSE 22103
                                                                       END -- LCHR  (OK)
                                                                     )
					END

                IF LEFT( @cTipoOperacion, 2 ) = 'CP' AND LEFT( @cTipoCartera, 1 ) = 'T' BEGIN
                   SELECT @cLetraFlujoAmo = 'A', @cLetraFlujoInt = 'B'

                END ELSE IF LEFT( @cTipoOperacion, 2 ) = 'CP' AND LEFT( @cTipoCartera, 1 ) = 'P' BEGIN
                   SELECT @cLetraFlujoAmo = 'C', @cLetraFlujoInt = 'D'

                END ELSE BEGIN
                   SELECT @cLetraFlujoAmo = '0', @cLetraFlujoInt = '1'

                END

--IF LEFT( @mascara, 2 ) = 'BR' SELECT @seriado, @tipoper, @cFlujea, @mascara

		IF @seriado='S' AND @tipoper='CP' --AND @cFlujea='S'
		BEGIN

			SELECT @tipo_linea     = 'C'
			SELECT @cLetraFlujoAmo = 'C', @cLetraFlujoInt = 'D'

                        IF @codigo=15 AND SUBSTRING(@mascara,1,4)='USUD'
                           SELECT   @inversion   = '00000'   ,
                                    @tipo_linea  = '0'                       

			SELECT	@fecha		= @fecpro
			SELECT	@tdcupon	= 0

			IF @codigo=20
				SELECT	@fecha	= ''

			WHILE (1=1)
			BEGIN
				SELECT	@c1	= '*'

				SET ROWCOUNT 1

				IF @codigo<>20
				BEGIN
					SELECT	@tdfecven	= tdfecven						,
						@tdamort	= ((tdamort*@nominal)/100)	,
						@tdinteres      = ((tdinteres*@nominal)/100)	,
						@tdsaldo	= tdsaldo						,
						@c1		= 1							,
						@tdcupon	= tdcupon
					FROM	VIEW_TABLA_DESARROLLO
					WHERE	tdmascara=@mascara AND tdfecven>@fecha
				END


				IF @codigo=20
				BEGIN	
					SELECT	@tdfecven	= DATEADD(mm,(tdcupon*@periodo),@dFecemi)									,
						@tdamort	= ((tdamort*@nominal)/100)											,
						@tdinteres      = ((tdinteres*@nominal)/100)											,
						@tdsaldo	= tdsaldo													,
						@c1		= 1														,
						@tdcupon	= tdcupon
					FROM	VIEW_TABLA_DESARROLLO
					WHERE	tdmascara=@mascara AND tdcupon>@tdcupon
				END


				SET ROWCOUNT 0

				IF @c1='*'
				BEGIN
					BREAK
				END

				SELECT	@fecha = @tdfecven

				IF @tdfecven>@fecpro begin


					IF @cFlujea='S'
					BEGIN
						INSERT MDC08 VALUES (@cuenta        ,@moneda,0,@tdfecven,@tdamort  ,@tir,0,@inversion,@tipo_linea    ,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
						INSERT MDC08 VALUES (@cuenta_Interes,@moneda,0,@tdfecven,@tdinteres,@tir,0,@inversion,@cLetraFlujoInt,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
					END

					IF @cTipoCartera='P' AND @cLetraFlujoAmo <> '0'
					BEGIN
						-- Capital e Intereses para C09 Permanente  (Flujos)
                                                INSERT MDC08 VALUES (@cuenta        ,@moneda,0,@tdfecven,@tdamort  ,@tir,0,@inversion,'G'            ,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
                                                INSERT MDC08 VALUES (@cuenta_Interes,@moneda,0,@tdfecven,@tdinteres,@tir,0,@inversion,'H'            ,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
					END

					IF @cTipoCartera='T' AND @cLetraFlujoAmo <> '0'
					BEGIN
						-- Capital e Intereses para C09 Trading (Flujos)
						INSERT MDC08 VALUES (@cuenta        ,@moneda,0,@tdfecven,@tdamort  ,@tir,0,@inversion,'E',@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
						INSERT MDC08 VALUES (@cuenta_Interes,@moneda,0,@tdfecven,@tdinteres,@tir,0,@inversion,'F',@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
					END

				END
			END
		END

		IF @seriado='S' AND @tipoper='CP' AND @cFlujea='N'
		BEGIN

			SELECT	@tipo_linea 	= 'A'
			SELECT	@fecha		= @fecpro

			IF @codigo=20
			BEGIN
				SELECT   @tdcupon	= 0

				WHILE (1=1)
				BEGIN
					SELECT	@c1	= '*'

				SET ROWCOUNT 1

					SELECT	@tdfecven	= DATEADD(mm,(tdcupon*@periodo),@dFecemi),
						@tdcupon	= tdcupon,
						@c1		= 1
					FROM	VIEW_TABLA_DESARROLLO
					WHERE	tdmascara=@mascara AND tdcupon>@tdcupon
					ORDER BY tdcupon
			
					SET ROWCOUNT 0

					IF @c1='*'
					BEGIN
						BREAK
					END
		
					IF @tdfecven>@fecpro 						BREAK
				END
			END
			ELSE
			BEGIN
				SET ROWCOUNT 1
				SELECT	@tdfecven	= tdfecven
				FROM	VIEW_TABLA_DESARROLLO
				WHERE	tdmascara=@mascara AND tdfecven>@fecha
				SET ROWCOUNT 0
			END

			SELECT	@tdamort	= 0
			SELECT	@tdamort	= ISNULL(CASE
							WHEN @nominal=valor_nominal THEN valor_mercado
							ELSE ROUND((@nominal/valor_nominal)*valor_mercado,0)
						  END,0)
			FROM	VALORIZACION_MERCADO, MDAC
			WHERE	rmnumdocu=@nNumdocu AND rmnumoper=@nNumoper AND rmcorrela=@nCorrela AND
				acfecsbif2=fecha_valorizacion


			IF @tdamort=0
                           SELECT   @tdamort   = @nVpresen

			SELECT @tdinteres = (@tdamort-@valcomp)

			IF @moneda<>999 AND @moneda<>13
				SELECT	@tdamort   =  ROUND(@tdamort/vmvalor,4)
				FROM	VIEW_VALOR_MONEDA
				WHERE	vmfecha=@fecpro	AND vmcodigo=@moneda

			IF @tdfecven>@fecpro 
			BEGIN

				-- Capital para C08 Trading (Monto Cartera)
				INSERT MDC08 VALUES (@cuenta,@moneda,0,@tdfecven,@tdamort,@tir,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)

			END

		END

		IF @seriado='N' AND @tipoper='CP' 
		BEGIN	

			SELECT	@tipo_linea 	= 'C'
			SELECT	@tdamort	= @nominal

			IF @codigo=98 BEGIN
                           SELECT @tdamort = @valcomp
                           SELECT @fecvenp = @fecpro
                           SELECT @tdcupon = 0

                        END

			IF @codigo=888
				SELECT   @tdamort   = @nValvenc

			IF @codigo=888	SELECT @moneda = 995

			SELECT @tdinteres = (@valvenp - @tdamort)

			IF @cFlujea='S'
			BEGIN	
				-- Capital para C08 Permanente (Flujos)
				INSERT MDC08 VALUES (@cuenta,@moneda,0,@fecvenp,@tdamort,@tir,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)
			END

			IF @cTipoCartera='P' AND @cLetraFlujoAmo <> '0'
			BEGIN
				-- Capital e Intereses para C09 Permanente (Flujos)
                                INSERT MDC08 VALUES (@cuenta        ,@moneda,0,@fecvenp,@tdamort  ,@tir,0,@inversion,'G',@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)

				IF @codigo<>98 AND @codigo<>888
					INSERT MDC08 VALUES (@cuenta_Interes,@moneda,0,@fecvenp,@tdinteres,@tir,0,@inversion,'H',@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
			END


			IF @cTipoCartera='T' AND @cLetraFlujoAmo <> '0'
			BEGIN
				-- Capital e Intereses para C09 Trading (Flujos)
				INSERT MDC08 VALUES (@cuenta        ,@moneda,0,@fecvenp,@tdamort  ,@tir,0,@inversion,'E',@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)

				IF @codigo<>98 AND @codigo<>888
					INSERT MDC08 VALUES (@cuenta_Interes,@moneda,0,@fecvenp,@tdinteres,@tir,0,@inversion,'F',@mascara,@nNumdocu,@nNumoper,@nCorrela,0,@tdcupon)
			END


		END

		IF @seriado='N' AND @tipoper='CP' AND @cFlujea='N'
		BEGIN	

			SELECT	@tdamort	= 0
			SELECT	@tipo_linea 	= 'A'
			SELECT	@tdamort	= ISNULL(CASE
							WHEN @nominal=valor_nominal THEN valor_mercado
							ELSE ROUND((@nominal/valor_nominal)*valor_mercado,0)
						  END,0)
			FROM	VALORIZACION_MERCADO, MDAC
			WHERE	rmnumdocu=@nNumdocu AND rmnumoper=@nNumoper AND rmcorrela=@nCorrela AND
				acfecsbif2=fecha_valorizacion

			IF @tdamort=0
                           SELECT   @tdamort = @nVpresen

			IF @moneda <> 999 AND @moneda<>13
			BEGIN 
				SELECT	@tdamort =  ROUND( @tdamort / vmvalor ,4 )
				FROM	view_valor_moneda
				WHERE	vmfecha = @fecpro
				AND	vmcodigo = @moneda

			END

			IF @codigo=98 BEGIN
                           SELECT @fecvenp = @fecpro
                           SELECT @tdcupon = 0

                        END

			IF @codigo=888	SELECT @moneda = 995

			SELECT @tdinteres = (@valvenp - @tdamort)

			-- Capital para C08 Trading (Valor Cartera)
			INSERT  MDC08 VALUES (@cuenta,@moneda,0,@fecvenp,@tdamort,@tir,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)

		END

		IF @tipoper='CI' OR @tipoper='VI' OR @tipoper='IB'
		BEGIN

			SELECT	@inversion	= '00000'

			SELECT	@tipo_linea 	= '0'

			IF @moneda <> 999 AND @moneda<>13
				SELECT	@valinip   = ROUND( @valinip / vmvalor ,4 )
				FROM	view_valor_moneda
				WHERE	vmfecha = @dFecemi
				AND	vmcodigo = @moneda

			SELECT @tdinteres = (@valvenp - @valinip )

			INSERT  MDC08 VALUES (@cuenta,@moneda,0,@fecvenpact,@valinip,@taspact,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)

		END



		IF @tipoper='IN-CI' OR @tipoper='IN-VI' OR @tipoper='IN-IB'
		BEGIN

			SELECT	@inversion	= '00000'
			SELECT	@tipo_linea 	= '1'

			IF @moneda <> 999 AND @moneda<>13
				SELECT	@valinip =  ROUND( @valinip / vmvalor ,4 )
				FROM	view_valor_moneda
				WHERE	vmfecha = @dFecemi
				AND	vmcodigo = @moneda

			SELECT @tdinteres = (@valvenp - @valinip )

			INSERT  MDC08 VALUES (@cuenta,@moneda,0,@fecvenpact,@tdinteres,@taspact,0,@inversion,@tipo_linea,@mascara,@nNumdocu,@nNumoper,@nCorrela,0,0)

		END

		UPDATE #CARTERA
		SET	sw ='S'
		WHERE 	correla = @numero

	END


	
/*
	SELECT	Distinct cuenta	,
		moneda		,
		tipo_tasa	,
		inversion	,
		tipo_cuenta
	FROM	MDC08 
	order by 
		cuenta	,
		moneda		,
		tipo_tasa	,
		inversion	,
		tipo_cuenta
*/

	UPDATE MDAC SET acint_c8 = '1'

	SELECT	cuenta		,
		'moneda'	= isnull(moneda,0),
		tipo_tasa	,
		'fecven'	= CONVERT(CHAR(8),fechaven,112)	,
		amortizacion	,
		tir		,
		saldo		,
		inversion	,
		tipo_cuenta	,
		mascara		,
		'totreg'     = (SELECT COUNT(*) FROM MDC08),
                'Referencia' = RIGHT( '0000000000' + CONVERT( VARCHAR(10), inumdocu ), 10 ) + '-' +
                               RIGHT(        '000' + CONVERT( VARCHAR(03),   icorre ), 3 ) + '-' +
                               RIGHT( '0000000000' + CONVERT( VARCHAR(10), inumoper ), 10 )
	FROM	MDC08 


END


-- SELECT tipo_cuenta,count(*) FROM MDC08  group by tipo_cuenta
-- TRUNCATE TABLE MDC08


-- sp_buscador_de_cuentas
-- sp_autoriza_ejecutar 'BACUSER'
-- SELECT * INTO PASOMDC08 FROM MDC08
-- select rsvalvenc,rsnominal, rsvppresen, rsnominal-rsvalvenc, rsnominal-rsvppresen,* from mdrs where rsfecha = '20020531' and rscodigo = 888




GO
