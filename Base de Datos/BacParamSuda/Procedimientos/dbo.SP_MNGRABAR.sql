USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNGRABAR]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNGRABAR]
	(   @mncodmon1		NUMERIC(5,0)
	,   @mnnemo1		CHAR(05)
	,   @mnsimbol1		CHAR(05)
	,   @mndescrip1		CHAR(30)
	,   @mnredondeo1	NUMERIC(2,0) 
	,   @mnbase1		NUMERIC(3,0) 
	,   @mntipmon1		CHAR(01)  
	,   @mnperiodo1		NUMERIC(2,0) 
	,   @mncodsuper1	NUMERIC(3,0) 
	,   @mncodfox		CHAR(6) 
	,   @mncodcor		NUMERIC(7) 
	,   @mncodbcch		NUMERIC(3,0) 
	,   @mncodpais		NUMERIC(3,0)   
	,   @mone			NUMERIC(1,0) 
	,   @refmerc		NUMERIC(1,0) 
	,   @refusd			NUMERIC(1,0) 
	,   @mnlimite		NUMERIC(19,4) 
	,   @mncodcorrespC	NUMERIC(8)
	,   @mncodcorrespV	NUMERIC(8)
	,   @mnctacamb		CHAR(10) 
	,   @mncanasta		CHAR(2)
	,   @mniso_coddes1	CHAR(5)
	,   @mncodBancoC	NUMERIC(10)
	,   @mncodBancoV	NUMERIC(10)
	,   @MnCodDcv		INT		= 0
	,	@nDecimales		INT		= 0		--> PRD-16772
	,   @codSinacofi	CHAR(5)	= '001'	--> LD1-COR-035-Configuración BAC Corpbanca, Tema: Interfaz TCRC917-TCRC915
	,	@CodIDD			CHAR(4)	= ''	--> LD1_035_IDD
	)
AS
BEGIN

	SET NOCOUNT ON

	BEGIN TRANSACTION

	DECLARE @mnmx	CHAR(1)
		SET @mnmx	= CASE WHEN @mone = 1 THEN 'C' ELSE '' END

	IF EXISTS(	SELECT mncodmon FROM BacParamSuda.dbo.MONEDA WHERE mncodmon = @mncodmon1	)
	BEGIN
		UPDATE	BacParamSuda.dbo.MONEDA
		SET		mncodmon		= @mncodmon1
		,		mnnemo			= @mnnemo1     
		,		mnsimbol		= @mnsimbol1   
		,		mnglosa			= @mndescrip1  
		,		mnredondeo		= @mnredondeo1 
		,		mnbase			= @mnbase1     
		,		mntipmon		= @mntipmon1   
		,		mnperiodo		= @mnperiodo1  
		,		mncodsuper		= @mncodsuper1 
		,		mncodfox		= @mncodfox    
		,		mncodcor		= @mncodcor    
		,		mncodbanco		= @mncodbcch   
		,		mnmx			= @mnmx        
		,		codigo_pais		= @mncodpais   
		,		mnextranj		= @mone 
		,		mnrefusd		= @refusd
		,		mncodpais		= mncodpais       -- 0 ES LO QUE ESTABA 
		,		mnrefmerc		= @refmerc
		,		mniso_coddes	= @mniso_coddes1  --'C' 
		,		mnrrda			= CASE @refusd WHEN 1 THEN 'M' ELSE 'D' END 
		,		mnlimite		= @mnlimite
		,		mncodcorrespC	= @mncodcorrespV
		,		mncodcorrespV	= @mncodcorrespC
		,		mnctacamb		= @mnctacamb
		,		mncanasta		= @mncanasta
		,		mncodBancoC		= @mncodBancoC
		,		mncodBancoV		= @mncodBancoV
		,		MnCodDcv		= @MnCodDcv
		,		mningval		= @nDecimales		--> PRD-16772
		,		mnsinacofi		= @codSinacofi		--> LD1-COR-035-Configuración BAC Corpbanca, Tema: Interfaz TCRC917-TCRC915
		,		mncodbkb		= @CodIDD			--> LD1_035_IDD
		WHERE	mncodmon		= @mncodmon1
	END ELSE
	BEGIN
 
		INSERT INTO BacParamSuda.dbo.MONEDA
		(		mncodmon
		,		mnnemo
		,		mnsimbol
		,		mnglosa
		,		mnredondeo
		,		mnbase
		,		mntipmon
		,		mnperiodo
		,		mncodsuper
		,		mncodfox
		,		mncodcor
		,		mncodbanco
		,		codigo_pais
		,		mnmx
		,		mnextranj
		,		mnrefmerc
		,		mnrefusd
		,		mndecimal
		,		mniso_coddes
		,		mnrrda
		,		mncodcorrespC
		,		mncodcorrespV
		,		mnctacamb
		,		mncanasta
		,		mncodBancoC
		,		mncodBancoV
		,		MnCodDcv
		,		mningval			--> PRD-16772
		,		mnsinacofi			--> LD1-COR-035-Configuración BAC Corpbanca, Tema: Interfaz TCRC917-TCRC915
		,		mncodbkb			--> LD1_035_IDD
		)
      VALUES
		(		@mncodmon1
		,		@mnnemo1
		,		@mnsimbol1
		,		@mndescrip1
		,		@mnredondeo1
		,		@mnbase1
		,		@mntipmon1
		,		@mnperiodo1
		,		@mncodsuper1
		,		@mncodfox
		,		@mncodcor
		,		@mncodbcch
		,		@mncodpais
		,		@mnmx
		,		@mone
		,		@refmerc
		,		@refusd
		,		0   --> @mncodpais ** No corresponde el Codigo de Pais **
		,		@mniso_coddes1 --'C'
		,		CASE WHEN @refusd = 1 THEN 'M' ELSE 'D' END -- ''
		,		@mncodcorrespC
		,		@mncodcorrespV
		,		@mnctacamb
		,		@mncanasta
		,		@mncodBancoC
		,		@mncodBancoV
		,		@MnCodDcv
		,		@nDecimales		--> PRD-16772
		,		@codSinacofi	--> LD1-COR-035-Configuración BAC Corpbanca, Tema: Interfaz TCRC917-TCRC915
		,		@CodIDD			--> LD1_035_IDD
		)
	END

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT 'Err.'
		RETURN
	END

	--> Se agrega para crear automáticamente el registro para el control de variacion de tipo de cambio. a un 20% para las Divisas
	IF @mntipmon1 > 1 --> [1 - Tasa, 2 - Divis, 3 - Precio]
	BEGIN
		IF NOT EXISTS( SELECT 1 FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 7500 AND tbcodigo1 = @mnnemo1 and tbtasa = @mncodmon1)
		BEGIN
			INSERT	INTO BacParamSuda.dbo.TABLA_GENERAL_DETALLE
            SELECT	7500, @mnnemo1, @mncodmon1, acfecproc, 20.0, 'PORCENTAJE DE VARIACION TC CONTABLE', ''
            FROM	BacTraderSuda.dbo.MDAC with(nolock)
		END
	END

	COMMIT TRANSACTION

	SELECT 'Ok'

END
GO
