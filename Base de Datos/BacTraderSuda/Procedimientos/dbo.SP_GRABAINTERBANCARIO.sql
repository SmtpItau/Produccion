USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAINTERBANCARIO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAINTERBANCARIO]
				(
				@nNumoper	NUMERIC (10,0)	,
				@dfecpro	CHAR	(10)	,
				@nrutcar	NUMERIC (09,0)	,
				@ntipcar	NUMERIC (05,0)	,
				@stipope	CHAR	(10)	,
				@dfecven	CHAR	(10)	,
				@nmtoini	NUMERIC (19,4)	,
				@nvalmon	NUMERIC (19,2)	,
				@ntasa		NUMERIC (19,5)	,
				@nmtofin	NUMERIC (19,4)	,
				@nbase		NUMERIC (03,0)	,
				@ncodmon	NUMERIC (03,0)	,
				@nforpai	NUMERIC (05,0)	,
				@nforpav	NUMERIC (05,0)	,
				@spago		CHAR	(01)	,
				@nrutcli	NUMERIC	(09,0)	,
				@ncodcli	NUMERIC	(09,0)	,
				@stipret	CHAR	(01)	, 
				@susuari	CHAR	(12)	,
				@observ		CHAR	(70)    ,
                                @valuta		CHAR    (10)	,
				@id_Libro	CHAR    (06)	,
				@id_AreaResp	CHAR	(10),

--ITAU----------------------------------------------
				@Ejecutivo   INTEGER = 0,
				@Sucursal  VARCHAR(05) = '',
				@Rentabilidad   VARCHAR (01) = '',
				@nmtoini_um NUMERIC(19,4),
				@Codigo_Interfaz NUMERIC (5),
				@GARANTIA  CHAR(1),
				@correla   INTEGER,
				@Ind1446	CHAR(01) =  ''
--ITAU----------------------------------------------
				)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ncodigo	NUMERIC (03,0)	,
		@snemo		CHAR	(05)	,
		@nnominalp	NUMERIC (03,0)	,
		@nvmoneda	NUMERIC (19,4)

	SELECT	@nnominalp	= 0.0	,
		@nvmoneda	= 0.0

	IF @ncodmon=8
	BEGIN
		SELECT @nvmoneda = vmvalor FROM VIEW_VALOR_MONEDA WHERE @ncodmon=vmcodigo AND @dfecven=vmfecha
		IF @nvmoneda=0
			SELECT	@nnominalp = 982.0 --* uf desconocida
		ELSE
			SELECT	@nnominalp = 981.0 --* uf conocida
	END

	SELECT	@ncodigo	= incodigo
	FROM	VIEW_INSTRUMENTO
	WHERE	inserie=@stipope

	SELECT	@snemo	= mnnemo
	FROM	VIEW_MONEDA 
	WHERE	mncodmon=@ncodmon

	INSERT INTO MDPA VALUES(0,@nnumoper,0,0)

	BEGIN TRANSACTION

	INSERT INTO
	MDMO
		(
		mofecpro		,
		morutcart   		,
		motipcart   		,
		monumdocu   		,
		mocorrela   		,
		motipoper   		,
		moinstser   		,
		momascara   		,
		mocodigo   		,
		moseriado   		,
		mofecemi   		,
		mofecven   		,
		momonemi   		,
		mobasemi   		,
		monominal   		,
		movpresen   		,
		motir    		,
		mofecinip   		,
		mofecvenp   		,
		movalinip   		,
		movalvenp   		,
		motaspact   		,
		mobaspact   		,
		momonpact   		,
		moforpagi   		,
		moforpagv   		,
		mopagohoy   		,
		morutcli   		,
		mocodcli   		,
		motipret   		,
		mohora    		,
		mousuario   		,
		moterminal   		,
		movalcomp   		,
		monumdocuo   		,
		mocorrelao   		,
		monumoper   		,
		motipopero   		,
		monominalp		,
		moobserv		,
		id_libro		,
		id_sistema,
--ITAU----------------------------------------------

		Tipo_Rentabilidad,
		Ejecutivo,
		Valor_Contable,
		Codigo_Interfaz,
		mogarantia,
		moind1446

--ITAU----------------------------------------------		
		)
	VALUES
		(
		@dfecpro   		,
		@nrutcar   		,
		@ntipcar   		,
		@nnumoper   		,
		1    		,
		'IB'    	,
		@stipope   	,
		@stipope   	,
		@ncodigo   	,
		'N'    		,
		@dfecpro   	,
		@dfecven   	,
		@ncodmon   	,
		@nbase    	,
		@nmtofin   	,
		@nmtoini   	,
		@ntasa    	,
		@dfecpro   	,
		@dfecven   	,
		@nmtoini   	,
		@nmtofin   	,
		@ntasa    	,
		@nbase    	,
		@ncodmon   	,
		@nforpai   	, 
		@nforpav   	,
		@spago    	,
		@nrutcli   	,
		@ncodcli   	,
		@stipret   	,
		CONVERT(CHAR(15),GETDATE(),108) ,
		@susuari   	,
		'TERMINAL 1'   	,
		@nmtoini   	,
		@nnumoper	,
		1		,
		@nnumoper	,
		'IB'    	,
		@nnominalp	,
		@observ		,
		@id_Libro	,
		@id_AreaResp,

--ITAU----------------------------------------------
		@Rentabilidad,
		@Ejecutivo,
		@nmtoini,
		@Codigo_Interfaz,
		@GARANTIA,
		@Ind1446
--ITAU----------------------------------------------
		)

	IF @@error<>0
	BEGIN
		SET NOCOUNT OFF
		SELECT	'ERR'
		ROLLBACK TRANSACTION
		RETURN
	END
 
	INSERT INTO
	MDCI	(
		cirutcart   	,
		citipcart   	,
		cinumdocu   	,
		cicorrela   	,
		cirutcli   	,
		cicodcli   	,
		ciinstser   	,
		cimascara   	,
		cinominal   	,
		cifeccomp   	,
		civalcomp   	,
		civalcomu   	,
		citircomp   	,
		citaspact   	,
		cibaspact   	,
		cimonpact   	,
		cimonemi   	,
		cifecemi   	,
		cifecven   	,
		cifecinip   	,
		cifecvenp   	,
		civalinip   	,
		civalvenp   	,
		ciseriado   	,
		cicodigo   	,
		cicapitalc   	,
		ciinteresc   	,
		cireajustc   	,
		cicapitalci   	,
		ciinteresci   	,
		cireajustci   	,
		ciforpagi   	,
		ciforpagv   	,
		civptirc   	,
		civptirci   	,
		cinominalp	,
		id_libro	,
		id_sistema,

--ITAU----------------------------------------------
		Tipo_Rentabilidad,
		Ejecutivo,
		Sucursal,
		Valor_Contable,
		cigarantia,
		ciind1446

--ITAU----------------------------------------------
	
		)
	VALUES
		(
		@nrutcar   	,
		@ntipcar   	,
		@nnumoper   	,
		1    		,
		@nrutcli   	,
		@ncodcli   	,
		@stipope   	,
		@stipope   	,
		@nmtofin   	,
		@dfecpro   	,
		@nmtoini   	,
		@nmtoini   	,
		@ntasa    	,
		@ntasa    	,
		@nbase    	,
		@ncodmon   	,
		@ncodmon   	,
		@dfecpro   	,
		@dfecven   	,
		@dfecpro   	,
		@dfecven   	,
		@nmtoini   	,
		@nmtofin   	,
		'N'    		,
		@ncodigo   	,
		@nmtoini   	,
		0    		,
		0    		,
		@nmtoini   	,
		0    		,
		0    		,
		@nforpai   	,
		@nforpav   	,
		@nmtoini   	,
		@nmtoini   	,
		@nnominalp	,
		@id_Libro	,
		@id_AreaResp,

--ITAU----------------------------------------------
		@Rentabilidad,
		@Ejecutivo,
		@Sucursal,
		@nmtoini,
		@GARANTIA,
		@Ind1446
--ITAU----------------------------------------------
		)

	IF @@error<>0
	BEGIN
		SET NOCOUNT OFF		ROLLBACK TRANSACTION
		SELECT	'ERR'
		RETURN
	END

--	UPDATE MDAC set acnumoper = @nnumoper + 1

	IF @@ERROR<>0
	BEGIN
		SET NOCOUNT OFF
		ROLLBACK TRANSACTION
		SELECT	'ERR'
		RETURN
	END

	COMMIT TRANSACTION
	SET NOCOUNT OFF
	SELECT @nnumoper
END

GO
