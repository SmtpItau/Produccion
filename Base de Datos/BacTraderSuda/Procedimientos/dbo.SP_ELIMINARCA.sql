USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINARCA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINARCA] ( 
				@noperacion 	NUMERIC(10,0), 
				@rutcart 	NUMERIC(09,0),
				@mensaje 	CHAR(255) OUTPUT ) WITH RECOMPILE
  
AS
BEGIN

	DECLARE @ctipoper	CHAR	(03)		,
		@numdocu	NUMERIC	(10,0)		,
		@correla	NUMERIC	(03,0)		,
		@suma		NUMERIC	(10,0)		,
		@nerror		INTEGER			,
		@fnominal	FLOAT			,
		@vptirc         NUMERIC	(19,0)		,
		@interesc       NUMERIC	(19,0)		,
		@reajustec      NUMERIC	(19,0)		,
		@valcomu        NUMERIC	(19,0)		,
		@valcomp        NUMERIC	(19,0)		,
		@nnominalp	NUMERIC	(19,0)		,	
		@x		INTEGER	                ,
                @Return         INTEGER

	SELECT	@fnominal	= 0			,
		@x	 	= 1     		,
		@vptirc		= 0			,
		@interesc	= 0			,
		@reajustec	= 0			,
		@valcomu	= 0			,
		@valcomp	= 0			,
		@nnominalp	= 0			,
		@suma		= 0

	CREATE TABLE
	#TEMP
		(
		numdocu		NUMERIC	(10,0)	NOT NULL	,
		correla		NUMERIC	(03,0)	NOT NULL	,
		tipoper		CHAR	(03)	NOT NULL	,
		numoper		NUMERIC	(10,0)	NOT NULL	,
		nominal		NUMERIC	(19,4)	NOT NULL	,
		tasest		NUMERIC	(09,4)	NOT NULL	,
		tirventa	NUMERIC	(09,4)	NOT NULL	,
		monemi		NUMERIC	(03,0)	NOT NULL	,
		serie		CHAR	(12)	NOT NULL	,
		cod_ser		NUMERIC	(05,0)	NOT NULL	,
		vptirc		NUMERIC	(19,4)	NULL		,
		interesc	NUMERIC	(19,4)	NULL		,
		reajustec	NUMERIC	(19,4)	NULL		,

		valcomu		NUMERIC	(19,4)	NULL		,
		valcomp		NUMERIC	(19,4)	NULL		,
		nominalp	NUMERIC	(19,0)	NULL		,
		fecinip		DATETIME	NULL		,
		fecvenp		DATETIME	NULL		,
		valinip		NUMERIC	(19,0)	NULL		,
		valvenp		NUMERIC	(19,4)	NULL		,
		intpact		FLOAT 		NULL		,
		reapact		FLOAT 		NULL		,
		baspact		INTEGER		NULL		,
		monpact		INTEGER		NULL		,
		rutcli		NUMERIC	(10,0)	NULL		,
		codcli		NUMERIC	(10,0)	NULL		,
		registro	INTEGER	IDENTITY(1,1) PRIMARY KEY NOT NULL,
		valpacto	FLOAT		NULL		,
		taspacto	FLOAT		NULL
		)		

	INSERT	INTO #TEMP
	SELECT 	vinumdocu		,
		vicorrela		,
		vitipoper		,
		vinumoper		,
		vinominal		,
		vitasest		,
		vitirvent		,
		vimonemi		,
		viinstser		,
		vicodigo		,
		vivptirc		,
		viinteresv		,
		vireajustv		,
		vivalcomu		,
		vivalcomp		,
		vinominalp		,
		vifecinip		,
		vifecvenp		,
		vivalinip		,
		vivalvenp		,
		viinteresvi		,
		vireajustvi		,
		vibaspact		,
		vimonpact		,
		virutcli 		,
		vicodcli 		,
		vivptirvi		,
		vitaspact
	FROM	MDANT_VI
	WHERE	virutcart=@rutcart
	AND	vinumoper=@noperacion

	IF @@error<>0
	BEGIN
		
	     	SELECT  @mensaje = 'No se Pudo Anular Operacion'                
		RETURN  1
	END			

	WHILE @x=1
	BEGIN
		SELECT	@ctipoper='*' 

		SET ROWCOUNT 1	
	
		SELECT  @numdocu	= numdocu			,
			@correla	= correla			,
			@ctipoper	= tipoper			,
			@fnominal	= nominal			,
			@vptirc         = vptirc			,
        		@interesc       = interesc			,
        		@reajustec      = reajustec			,
	        	@valcomu        = valcomu			,
       	 		@valcomp        = valcomp			,
			@nnominalp	= nominalp			,
			@suma		= registro			
		FROM	#TEMP
		WHERE	registro>@suma

		SET ROWCOUNT 0	


		IF @ctipoper='*'
			BREAK


		IF (SELECT dinominal - @fnominal FROM MDDI WHERE dinumdocu=@numdocu AND dicorrela=@correla) < 0
		BEGIN
			SELECT  @mensaje = 'Instrumentos No se Encuentran Disponibles en Cartera'
                        RETURN  1

		END

		IF @ctipoper='CP'
		BEGIN

			UPDATE	MDCP
			SET	cpnominal	= cpnominal  - @fnominal		,
				cpvptirc	= cpvptirc   - @vptirc			,
				cpinteresc	= cpinteresc - @interesc		,
				cpreajustc	= cpreajustc - @reajustec		,
				cpvalcomu	= cpvalcomu  - ISNULL(@valcomu,0.0)	, 
				cpcapitalc	= cpvalcomp  - ISNULL(@valcomp,0.0)	,
				cpvalcomp	= cpvalcomp  - ISNULL(@valcomp,0.0)
			WHERE	cpnumdocu=@numdocu
			AND	cpcorrela=@correla

			IF @@error<>0
			BEGIN
                                
				SELECT  @mensaje = 'No se Pudo Anular Operacion'
                                RETURN  1
				
			END			


			UPDATE	MDDI
			SET	dinominal	= dinominal  - @fnominal		,
				divptirc	= divptirc   - @vptirc			,
				dicapitalc 	= dicapitalc - ISNULL(@valcomp,0.0)	,
				diinteresc 	= diinteresc - @interesc		,
				direajustc 	= direajustc - @reajustec
			WHERE	dinumdocu=@numdocu
			AND	dicorrela=@correla
			AND	ditipoper='CP'


			IF @@error<>0
			BEGIN
				SELECT  @mensaje = 'No se Pudo Anular Operacion'
				RETURN  1
			END			

		END
		ELSE
		BEGIN
			UPDATE	MDDI 
			SET	dinominal	= dinominal - @fnominal		,
				divptirc	= divptirc  - @vptirc
			WHERE	dinumdocu=@numdocu
			AND	dicorrela=@correla
			AND	ditipoper='CI'

			IF @@error<>0
			BEGIN
				SELECT  @mensaje = 'No se Pudo Anular Operacion'
				RETURN  1
			END			

			UPDATE	MDCI 
			SET	cinominalp = cinominalp - @nnominalp
			WHERE	cinumdocu  = @numdocu
			AND	cicorrela  = @correla

			IF @@error<>0
			BEGIN
				SELECT  @mensaje = 'No se Pudo Anular Operacion'
				RETURN  1
			END

		END

		UPDATE	MDCO 
		SET	cocantcortd = cocantcortd - cvcantcort
		FROM	MDCV
		WHERE	conumdocu=@numdocu
		AND	cocorrela=@correla
		AND	cvnumdocu=@numdocu
		AND	cvcorrela=@correla
		AND	cvnumoper=@noperacion
		AND	comtocort=cvmtocort

		IF @@error<>0
		BEGIN
			SELECT  @mensaje = 'No se Pudo Anular Operacion'
			RETURN  1
		END

		CONTINUE
	END

	UPDATE	MDMO
	SET	mostatreg = 'A'
	WHERE	monumoper = @noperacion

	IF @@error <> 0 
        BEGIN		
	     	SELECT  @mensaje = 'No se Pudo Anular Operacion'
		RETURN  1
	END				

	INSERT	MDVI
	SELECT  *
	FROM	MDANT_VI
	WHERE	MDANT_VI.vinumoper = @noperacion

	IF @@error <> 0 
        BEGIN		
	     	SELECT  @mensaje = 'No se Pudo Anular Operacion'
		RETURN  1
	END				

	DELETE mdant_vi where vinumoper = @noperacion

	SELECT @mensaje = 'Operacion Fue Anulada Correctamente'
        RETURN  0

END



GO
