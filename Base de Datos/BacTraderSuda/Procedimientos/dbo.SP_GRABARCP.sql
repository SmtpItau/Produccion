USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARCP]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABARCP]
    (           @nrutcart					NUMERIC (09,0) = 00,         -- rut de la cartera    
		@ctipcart					NUMERIC (05,0) = 00,         -- codigo del tipo de cartera    
		@nnumdocu					NUMERIC (10,0) = 00,         -- numero del documento    
		@ncorrela					NUMERIC (03,0) = 00,         -- correlativo de la operacirn    
		@cmascara					CHAR (12) = '',              -- familia del instrumento    
		@cinstser					CHAR (12) = '',              -- serie    
		@cgenemi					CHAR (10) = '',               -- generico del emisor    
		@cnemomon					CHAR (05) = '',              -- generico de la moneda    
		@nnominal					NUMERIC (19,4) = 00,         -- nominles      
		@ntir						NUMERIC (19,4) = 00,            -- tir de compra     
--fmo 20210611 aumento 4 decimales valor par
		@npvp						NUMERIC (19,4) = 00,            -- porcentaje valor presente    freddy
--fmo 20210611 aumento 4 decimales valor par
		@nvpar						NUMERIC (19,8) = 00,           -- valor par    
		@nvptirc					FLOAT           = 00,         -- valor presente a tir de compra    
		@nnumucup					NUMERIC (03,0) = 00,         -- numero del oltimo  cuprn vencido    
		@nrutcli					NUMERIC (09,0) = 00,          -- rut del cliente    
		@ncodcli					NUMERIC (09,0)  = 00,  -- c½digo de cliente    
		@cfecpro					DATETIME = '',                -- fecha de proceso    
		@ntasest					NUMERIC (09,4) = 00,        -- tasa estimada    
		@cfecemi					DATETIME = '',              -- fecha de emisirn    
		@cfecven					DATETIME = '',              -- fecha de vencimiento    
		@cmdse						CHAR (01) = '',              -- indica si es seriado o no    
		@ncodigo					NUMERIC (05) = 00,          -- codigo de la familia    
		@cserie						CHAR (12) = '',             -- serie de la familia    
		@nmonemi					NUMERIC (03) = 00,          -- moneda del emisor    
		@nrutemi					NUMERIC (09) = 00,          -- rut del emisor    
		@ntasemi					NUMERIC (09,4) = 00,        -- tasa estimada    
		@nbasemi					NUMERIC (03) = 00,          -- base estimada    
		@ctipcust					CHAR (03) = '',            -- tipo de custodia    
		@nforpagi					NUMERIC (05) = 00,         -- forma de pago    
		@cretiro					CHAR (01) = '',             -- tipo de retiro    
		@cusuario					CHAR  (12) = '',           -- usuario    
		@cterminal					CHAR (12) = '',           -- terminal    
		@dfecpcup					DATETIME = '',             -- fecha de cup½n    
		@csi_dcv					CHAR (01) = '',             -- custodia dcv    
		@cclave_dcv					CHAR (10) = '',          -- clave dcv    
		@dconvexidad				FLOAT  = 00,           -- convexidad    
		@dduratmac					FLOAT  = 00,             -- durati¢n macaulay    
		@dduratmod					FLOAT  = 00,              -- duration modificado    
		@codigo_carterasuper		CHAR    (01) = '',    
		@tipo_cartera_financiera	CHAR (05)    = '',  --> CAMBIO LARGO DE 1 A 5 CARACTERES  
		@mercado					CHAR (01)    = '',    
		@sucursal					VARCHAR (05) = '',    
		@id_sistema					CHAR (03)    = '',    
		@fecha_pagomañana			DATETIME     = '',    
		@laminas					CHAR (01)    = '',    
		@tipo_inversion				CHAR (01)    = '',    
		@observ						CHAR (70)        ,    
		@corresponsal				CHAR (04)    = '',    
		@nvalvenc					NUMERIC(19,4)= 0 , -- Nominales      
		@CodigoLibro				CHAR (06)    = '', -- Libros    
		@nTirTran					NUMERIC(19,4) = 0,    
		@nPvpTran					NUMERIC(19,4) = 0,    
		@nVpTran					NUMERIC(19,4) = 0,    
		@Dif_Tran_MO				NUMERIC(19,4) = 0,    
		@Dif_Tran_CLP				NUMERIC(19,0) = 0,

--REQUERIMENTO LD1_035_ITAU---------------------------------------
		@Ejecutivo				INTEGER			= 0			,
		@Rentabilidad			VARCHAR (01)	= ''		,
		
		--@cTipoCustodia INTEGER = 0 , --> ya esta  en la variable @csi_dcv, es caracter 
		--@cpago_hoy CHAR(1) ='H', --> esta como fecha  
		--@nForPago  INT, --> esta en @nforpagi
		
		@comi 					CHAR(1)			='N'		,
		@dFechaCusH				CHAR(8)			='19000101'	,
		@iVolckerRule			NUMERIC(1)		= 0 
--REQUERIMENTO LD1_035_ITAU---------------------------------------  
	)
AS    
BEGIN    


	/*	
	BITACORA DE MODIFICACIONES

	FECHA INICIO	:	04-11-2015	10:15
	CAMBIOS			:	REQUERIMENTO LD1_035 CORP-ITAU - TASA DE CONTRATO
	AUTOR			:	CORPBANCA GRUPO 3
	FECHA TERMINO	:	04-11-2015	11:35
	*/

	SET NOCOUNT ON

	DECLARE @ok         CHAR (01) ,    
			@cseriado   CHAR (01) ,    
			@nvalmon   FLOAT  ,    
			@cfamilia   CHAR (10) ,    
			@j          INTEGER  ,    
			@nlutil     INTEGER  ,    
			@cTipoLchr  CHAR (01) ,    
			@nRut       NUMERIC (09,0)  ,    
			@nValcomu   NUMERIC(19,4),    
			@nValtasemi  NUMERIC(19,0)   ,    
		 @nPrimaDesc NUMERIC(19,0)    ,

--REQUERIMENTO LD1_035_ITAU---------------------------------------	 
		 @nTasaContrato NUMERIC (09,6),
		 @cSenala NUMERIC(9,0)
--REQUERIMENTO LD1_035_ITAU---------------------------------------
    
	SELECT  @ok  = '0'  ,    
			@nvalmon = 1.0  ,    
			@cmascara = '*'  ,    
			@cTipoLchr = ''  ,    
			@nRut  = acrutprop    
	FROM MDAC    

	SELECT	@cmascara = semascara    
	FROM	VIEW_SERIE    
	WHERE	seserie = @cinstser    
    
	IF substring(@cmascara,1,6) <> 'FMUTUO'    
	begin    
		IF @ncodigo = 98    
			SELECT	@cgenemi = CLGENERIC    
			FROM	VIEW_CLIENTE     
			WHERE	clrut = @nrutcli    
			AND		clcodigo = @ncodcli    
	end    
    

	IF @cmdse ='S'    
	BEGIN    
		IF @cmascara='*'    
		BEGIN    
			SELECT @cfamilia = '*'    

			IF SUBSTRING(@cinstser,1,3)='PCD' AND SUBSTRING(@cinstser,1,6)<>'PCDUS$'    
				SELECT @cfamilia='PCDUF'    
			ELSE
			BEGIN    
				SET @j = dataLENgth(@cinstser)    

				WHILE @j <>0    
				BEGIN    
					SELECT @cfamilia=inserie FROM VIEW_INSTRUMENTO WHERE inserie=SUBSTRING(@cinstser,1,@j)    

					IF @cfamilia<>'*'    
						BREAK    

					SET @j = @j-1    
				END    
			END
			    
			IF @cfamilia='*'    
			BEGIN    
				IF SUBSTRING(@cinstser,1,3)='PTF'    
					SET  @cfamilia = 'PTF'    
			END    

			IF @cfamilia='*'    
				SET  @cfamilia = 'LCHR'    

			SEt ROWCOUNT 1    

			SELECT	@nlutil = LEN(msmascara)    
			FROM	VIEW_MASCARA_INSTRUMENTO		
			WHERE msfamilia=@cfamilia    

			SET ROWCOUNT 0    

			SELECT @cmascara = '*'    
    
			SELECT	@cmascara = semascara    
			FROM	VIEW_SERIE    
			WHERE	seserie=SUBSTRING(@cinstser,1,@nlutil)    
		END    
	END ELSE    
		SELECT @cmascara = @cserie    
    
	IF @nmonemi <> 999 AND @nmonemi <> 13    
		SELECT @nvalmon = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonemi AND vmfecha=@cfecpro    
	
	IF @ncodigo=20    
	BEGIN    
		IF @nRutemi=@nRut    
		BEGIN    
			SELECT @cTipoLchr = CASE	
                                                  WHEN CHARINDEX('*',@cInstser) <> 0    THEN 'V'    
										WHEN CHARINDEX('&',@cInstser) <> 0    THEN 'F'    
										WHEN SUBSTRING(@cInstser,7,2) = '01'  THEN 'V'    
										WHEN SUBSTRING(@cInstser,7,2) <>'01'  THEN 'F'    
									END    
		END    
    
		--> Banco Estado: Rut = 97030000
		IF @nRutemi = 97030000
			SELECT @cTipoLchr = 'E'

		IF @nRutemi<>@nRut AND @nRutemi <> 97030000
			SELECT @cTipoLchr = 'O'
	END
    
	IF @nmonemi = 999     
		SELECT @nValcomu = round(@nvptirc/@nvalmon,0)    
	ELSE    
		SELECT @nValcomu = round(@nvptirc/@nvalmon,4)    
    
	--===========================================================================================    
	--    CALCULO DE NORMATIVA DE LETRAS    
	--===========================================================================================    

	IF @nRutemi = @nRut AND @ncodigo = 20     
	BEGIN    
		SELECT @nValtasemi = @nnominal * (@nvpar/100) * @nvalmon    
		SELECT @nPrimaDesc = @nvptirc - @nValtasemi        
	END ELSE 
	BEGIN    
		SELECT @nValtasemi = 0.0    
		SELECT @nPrimaDesc = 0.0    
	END
    
	-->		LD1_035 CALCULO A TASA DE CONTRATO
	               
		
	EXECUTE dbo.SP_CALCULA_TASA_CONTRATO	@cinstser
										,	@ncodigo
										,	@nnominal
										,	@ntir
										,	@cfecpro
										,	@ctipcart
										,	@nbasemi
										,	@nmonemi
										,	@ntasest
										,	@cfecemi
										,	@cfecven
										,	@ntasemi
										,	@cmdse
										,	@nvptirc
										,	0
										,	@nValComu
										,	@cfecpro
										,	@dfecpcup
										,	@nTasaContrato	OUTPUT

	-->		LD1_035 CALCULO A TASA DE CONTRATO

--REQUERIMENTO LD1_035_ITAU---------------------------------------   
 --If @nForPago = 1 Or @nrutcli = 97029000
If @nforpagi = 1 Or @nrutcli = 97029000
	SELECT @cSenala = 0
ELSE
	SELECT @cSenala = 1   

--REQUERIMENTO LD1_035_ITAU---------------------------------------
    
	------------------------------------------------------------------------------------    
	--    MDDI    
	------------------------------------------------------------------------------------    

	INSERT MDDI
	(	dirutcart  ,    
		ditipcart  ,    
		dinumdocu  ,                            
		dicorrela  ,    
		dinumdocuo  ,    
		dicorrelao  ,    
		ditipoper  ,    
		diserie   ,    
		diinstser  ,    
		digenemi  ,    
		dinemmon  ,    
		dinominal  ,                  
		ditircomp  ,    
		dipvpcomp  ,    
		divptirc  ,    
		dipvpmcd  ,    
		ditirmcd  ,    

/*18*/	divpmcd100  ,

		divpmcd   ,    
		divptirci  ,    
		difecsal  ,    
		dinumucup  ,    
		diinteresc  ,  
		direajustc  ,  
		diintereci  ,       
		direajusci  ,    
		dicapitalc  ,    
		dicapitaci  ,    
		dibase   ,    
		dimoneda  ,    
		codigo_carterasuper ,    
		tipo_cartera_financiera ,     
		mercado   ,     
		sucursal  ,     
		id_sistema  ,     
		fecha_pagomañana ,     
		laminas   ,     
		tipo_inversion   ,   --falta didcv    
  id_libro    ,

--REQUERIMENTO LD1_035_ITAU---------------------------------------
			tasa_contrato, -- campos nuevos tasa contrato
			valor_contable, -- valor contable
			tipo_rentabilidad, -- rentabilidad
			ejecutivo, -- codigo del ejecutivo
			tipo_custodia, -- custodia
			disenala
--REQUERIMENTO LD1_035_ITAU---------------------------------------

	)    
	VALUES    
	(    
		@nrutcart ,    
		@ctipcart ,    
		@nnumdocu ,    
		@ncorrela ,    
		@nnumdocu ,    
		@ncorrela ,    
		'CP'  ,    
		@cserie  ,           
		@cinstser ,    
		@cgenemi ,    
		@cnemomon ,    
		@nnominal ,    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN @ntasemi				ELSE @ntir    END , --13    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN 100.0					ELSE @npvp    END , --14    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0)	ELSE @nvptirc END ,--15    
		0.0  ,    
		0.0  ,    
/*18*/	0.0  ,
		0.0  ,    
		0.0  ,    
		@cfecven ,    
		@nnumucup ,    
		0.0  ,    
		0.0  ,    
		0.0  ,    
		0.0  ,    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END ,     
		--       @nvptirc ,    
		0.0  ,    
		@nbasemi ,    
		@nmonemi ,    
		@codigo_carterasuper ,    
		@tipo_cartera_financiera,    
		@mercado  ,    
		@sucursal  ,    
		@id_sistema  ,    
		@fecha_pagomañana ,    
		@laminas  ,    
		@tipo_inversion  ,  --FALTA didcv = @csi_dcv     
		@CodigoLibro,    
-->		LD1_035 CALCULO A TASA DE CONTRATO
	          @nTasaContrato,--  Campos nuevos Tasa contrato
			@nvptirc, -- valor contable
			@Rentabilidad, -- rentabilidad
			@Ejecutivo, -- Codigo ejecutivo
			CASE WHEN @csi_dcv ='C' THEN 1 ELSE  CASE WHEN @csi_dcv='P' THEN 2 ELSE 3 END END,--@cTipoCustodia, -- custodia
			@cSenala
-->		LD1_035 CALCULO A TASA DE CONTRATO
	)

	INSERT MDCP    
	(    
		cprutcart ,    
		cptipcart ,    
		cpnumdocu ,    
		cpcorrela ,    
		cpnumdocuo ,    
		cpcorrelao ,    
		cprutcli ,    
		cpcodcli        ,    
		cpinstser ,    
		cpmascara ,    
		cpnominal ,    
		cpfeccomp ,  --    
		cpvalcomp ,  --    
		cpvalcomu ,  --    
		cpvcompori ,    
		cpvcum100 ,      
		cptircomp ,  --    
		cptasest ,    
		cppvpcomp ,  --    
		cpvpcomp ,  --    
		cpnumucup ,    
		cpfecemi ,    
		cpfecven ,    
		cpseriado  ,    
		cpcodigo ,    
		cpvptirc ,    
		cpcapitalc ,    
		cpinteresc ,    
		cpreajustc ,    
		cpfecpcup ,    
		cpconvex ,    
		cpdurat  ,    
		cpdurmod ,    
		cpdcv  ,    
		fecha_compra_original  ,    
		valor_compra_original  ,    
		valor_compra_um_original ,    
		tir_compra_original  ,    
		valor_par_compra_original ,    
		porcentaje_valor_par_compra_original,    
		codigo_carterasuper ,     
		tipo_cartera_financiera ,     
		mercado   ,     
		sucursal  ,     
		id_sistema  ,     
		fecha_pagomañana ,     
		laminas   ,     
		tipo_inversion  ,    
		cptipoletra  ,    
		cpforpagi    ,      
		cpvalvenc    ,--valor al vcto    
		cpvaltasemi  ,    
		cpprimadesc  ,    
  id_libro    ,

--REQUERIMENTO LD1_035_ITAU---------------------------------------
			Tasa_Contrato,
			Ejecutivo,
			Tipo_Rentabilidad,
			Tipo_Custodia,
			Valor_Contable ,
			cpsenala,
			Volcker_Rule
--REQUERIMENTO LD1_035_ITAU---------------------------------------

	)    
	VALUES    
	(    
		@nrutcart   ,    
		@ctipcart   ,    
		@nnumdocu   ,    
		@ncorrela   ,    
		@nnumdocu   ,  
		@ncorrela   ,    
		@nrutcli   ,    
		@ncodcli                       ,       
		@cinstser   ,    
		@cmascara   ,    
		@nnominal   ,    
		@cfecpro   ,    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END ,    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi/@nvalmon,4)  ELSE @nValcomu END,    
		@npvp    ,     
		@nvptirc/@nnominal * 100.0 ,    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut  THEN @ntasemi ELSE @ntir END,    
		@ntasest   ,    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN 100.0  ELSE @npvp END,    
		@nvpar    ,    
		@nnumucup   ,    
		@cfecemi   ,    
		@cfecven   ,    
		@cmdse    ,    
		@ncodigo   ,    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END ,    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END ,     
		0.0    ,    
		0.0    ,    
		@dfecpcup   ,    
		@dconvexidad    ,    
		@dduratmac    ,    
		@dduratmod   ,     
		@csi_dcv   ,    
		@cfecpro   ,    
		@nvptirc   ,    
		round(@nvptirc/@nvalmon,4) ,    
		@ntir,    
		CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN 100.0 ELSE @npvp END,    
		@nvpar  ,    
		@codigo_carterasuper  ,    
		@tipo_cartera_financiera ,    
		@mercado   ,    
		@sucursal   ,    
		@id_sistema   ,    
		@fecha_pagomañana  ,    
		@laminas   ,    
		@tipo_inversion   ,    
		@cTipoLchr   ,    
		@nforpagi ,    
		@nvalvenc   ,    
		@nvptirc,--@nValtasemi,    
		@nPrimaDesc ,    
		@CodigoLibro,
--REQUERIMENTO LD1_035_ITAU---------------------------------------
			@nTasaContrato,
			@Ejecutivo,
			@Rentabilidad,
			CASE WHEN @csi_dcv ='C' THEN 1 ELSE  CASE WHEN @csi_dcv='P' THEN 2 ELSE 3 END END,--@cTipoCustodia,
			@nvptirc,
			@cSenala,
			@iVolckerRule
--REQUERIMENTO LD1_035_ITAU---------------------------------------
	)

	INSERT MDMO
	(   mofecpro ,
		morutcart ,     
		motipcart ,    
		monumdocu ,    
		mocorrela ,    
		monumdocuo ,    
		mocorrelao ,    
		monumoper ,    
		motipoper ,    
		motipopero ,    
		moinstser ,    
		momascara ,    
		mocodigo ,    
		moseriado ,    
		mofecemi ,    
		mofecven ,    
		momonemi ,    
		motasemi ,    
		mobasemi ,    
		morutemi ,    
		monominal ,    
		movpresen ,    
		monumucup ,    
		motir  ,    
		mopvp  ,    
		movpar  ,    
		motasest ,            
		moforpagi ,    
		mocondpacto ,    
		morutcli ,    
		mocodcli ,    
		motipret ,    
		mohora  ,    
		mousuario ,    
		moterminal ,    
		mocapitali ,    
		movpreseni ,    
		movalcomp ,    
		movalcomu       ,    
		moclave_dcv     ,    
		modcv           ,    
		mocodexceso ,    
		momtopfe ,    
		momtocce ,    
		fecha_compra_original  ,    
		valor_compra_original  ,    
		valor_compra_um_original ,    
		tir_compra_original  ,    
		valor_par_compra_original ,    
		porcentaje_valor_par_compra_original,    
		codigo_carterasuper ,     
		tipo_cartera_financiera ,     
		mercado   ,     
		sucursal  ,     
		id_sistema  ,     
		fecha_pagomañana ,     
		laminas   ,     
		tipo_inversion  ,    
		cuenta_corriente_inicio ,    
		cuenta_corriente_final ,    
		sucursal_inicio  ,    
		sucursal_final  ,    
		motipoletra  ,    
		moobserv    ,    
		movaltasemi  ,    
		moprimadesc ,    
		id_libro  ,    
		moTirTran  ,    
		moPvpTran  ,    
		moVPTran  ,    
		moDifTran_MO ,    
		moDifTran_CLP,
		PagoMañana,
--REQUERIMENTO LD1_035_ITAU---------------------------------------
			Tasa_Contrato,
			Ejecutivo,
			Tipo_Rentabilidad,
			Tipo_Custodia,
			Valor_Contable,
			mofecCust,
			Volcker_Rule
--REQUERIMENTO LD1_035_ITAU---------------------------------------
	)
	VALUES    
	(    
		@cfecpro ,    
		@nrutcart ,    
		@ctipcart ,    
		@nnumdocu ,    
		@ncorrela ,    
		@nnumdocu ,    
		@ncorrela ,    
		@nnumdocu ,    
		'CP'  ,    
		'CP'  ,    
		@cinstser ,    
		@cmascara ,    
		@ncodigo ,    
		@cmdse  ,    
		@cfecemi ,    
		@cfecven ,    
		@nmonemi ,    
		@ntasemi ,    
		@nbasemi ,    
		@nrutemi ,    
		@nnominal ,    
		@nvptirc ,    
		@nnumucup ,    
		@ntir  ,    
		@npvp  ,    
		@nvpar  ,    
		@ntasest ,    
		@nforpagi ,    
		@ctipcust ,    
		@nrutcli ,    
		@ncodcli ,    
		@cretiro ,    
		convert(CHAR(15),getdate(),114) ,    
		@cusuario ,    
		@cterminal ,    
		@nvptirc ,    
		@nvptirc ,    
		@nvptirc ,      
		@nValcomu       ,    
		@cclave_dcv     ,    
		@csi_dcv ,    
		0,    
		0,    
		0,    
		@cfecpro   ,    
		@nvptirc   ,    
		@nValcomu                       , -- valor compra um original    
		@ntir    ,       
		@npvp    ,    
		@nvpar    ,    
		@codigo_carterasuper ,    
		@tipo_cartera_financiera,    
		@mercado  ,    
		@sucursal  ,    
		@id_sistema  ,     
		@fecha_pagomañana ,     
		@laminas  ,     
		@tipo_inversion  ,    
		''   ,    
		''   ,    
		''   ,    
		''   ,    
		@cTipoLchr  ,    
		@observ,    
		@nValtasemi,    
		@nPrimaDesc ,    
		@CodigoLibro ,    
		@nTirTran  ,    
		@nPvpTran  ,    
		@nVpTran  ,    
		@Dif_Tran_MO ,     
		@Dif_Tran_CLP,
		CASE WHEN @fecha_pagomañana > @cfecpro THEN 'S' ELSE 'N' END,
--REQUERIMENTO LD1_035_ITAU---------------------------------------
			@nTasaContrato,
			@Ejecutivo,
			@Rentabilidad,
			CASE WHEN @csi_dcv ='C' THEN 1 ELSE  CASE WHEN @csi_dcv='P' THEN 2 ELSE 3 END END,--@cTipoCustodia,
			@nvptirc,
			@dFechaCusH,
			@iVolckerRule
--REQUERIMENTO LD1_035_ITAU---------------------------------------
	)

	IF @fecha_pagomañana > @cfecpro
	BEGIN
		INSERT INTO MDMOPM
		( mofecpro    
		, morutcart    
		, motipcart    
		, monumdocu    
		, mocorrela    
		, monumdocuo    
		, mocorrelao    
		, monumoper    
		, motipoper    
		, motipopero    
		, moinstser    
		, momascara
		, mocodigo
		, moseriado    
		, mofecemi    
		, mofecven    
		, momonemi    
		, motasemi    
		, mobasemi    
		, morutemi    
		, monominal    
		, movpresen    
		, momtps    
		, momtum    
		, momtum100    
		, monumucup    
		, motir    
		, mopvp    
		, movpar    
		, motasest    
		, mofecinip    
		, mofecvenp    
		, movalinip    
		, movalvenp    
		, motaspact    
		, mobaspact    
		, momonpact    
		, moforpagi    
		, moforpagv    
		, motipobono    
		, mocondpacto    
		, mopagohoy    
		, morutcli    
		, mocodcli    
		, motipret    
		, mohora    
		, mousuario    
		, moterminal    
		, mocapitali    
		, moINTeresi    
		, moreajusti    
		, movpreseni    
		, mocapitalp    
		, moINTeresp    
		, moreajustp    
		, movpresenp    
		, motasant    
		, mobasant    
		, movalant    
		, mostatreg    
		, movpressb    
		, modifsb    
		, monominalp    
		, movalcomp    
		, movalcomu    
		, moINTeres    
		, moreajuste    
		, moINTpac    
		, moreapac    
		, moutilidad    
		, moperdida    
		, movalven    
		, mocontador    
		, monsollin    
		, moobserv    
		, moobserv2    
		, movvista    
		, movviscom    
		, momtocomi    
		, mocorvent    
		, modcv    
		, moclave_dcv    
		, mocodexceso    
		, momtoPFE    
		, momtoCCE    
		, moINTermesc    
		, moreajumesc    
		, moINTermesvi    
		, moreajumesvi    
		, fecha_compra_original    
		, valor_compra_original    
		, valor_compra_um_original    
		, tir_compra_original    
		, valor_par_compra_original    
		, porcentaje_valor_par_compra_original    
		, codigo_carterasuper    
		, Tipo_Cartera_Financiera    
		, Mercado    
		, Sucursal    
		, Id_Sistema    
		, Fecha_PagoMañana    
		, Laminas    
		, Tipo_Inversion    
		, Cuenta_Corriente_Inicio    
		, Cuenta_Corriente_Final    
		, Sucursal_Inicio    
		, Sucursal_Final    
		, motipoletra    
		, moreserva_tecnica1    
		, movalvenc    
		, movaltasemi    
		, moprimadesc    
		, SwImpresion    
		, MtoCompraPM    
		, MtoVentaPM    
		, PagoMañana    
		, SorteoLCHR    
		, Dcrp_Confirmador    
		, Dcrp_Codigo    
		, Dcrp_Glosa    
		, Dcrp_HoraConfirm    
		, Dcrp_OperConfirm    
		, Dcrp_OpeCnvConfirm    
		, moid_libro
	-->	  LD1_035 CALCULO A TASA DE CONTRATO
		, Tasa_Contrato
		, Valor_Contable
	-->	  LD1_035 CALCULO A TASA DE CONTRATO
		, volcker_rule	--> LD1-COR-025 CARTERA VOLCKER RULE
		)
		SELECT
		  mofecpro    
		, morutcart    
		, motipcart    
		, monumdocu    
		, mocorrela    
		, monumdocuo    
		, mocorrelao    
		, monumoper    
		, motipoper    
		, motipopero    
		, moinstser    
		, momascara    
		, mocodigo    
		, moseriado    
		, mofecemi    
		, mofecven    
		, momonemi    
		, motasemi    
		, mobasemi    
		, morutemi    
		, monominal    
		, movpresen    
		, momtps    
		, momtum    
		, momtum100    
		, monumucup    
		, motir    
		, mopvp    
		, movpar    
		, motasest    
		, mofecinip    
		, mofecvenp    
		, movalinip    
		, movalvenp    
		, motaspact    
		, mobaspact    
		, momonpact    
		, moforpagi    
		, moforpagv    
		, motipobono    
		, mocondpacto    
		, mopagohoy    
		, morutcli    
		, mocodcli    
		, motipret    
		, mohora    
		, mousuario    
		, moterminal    
		, mocapitali    
		, moINTeresi    
		, moreajusti    
		, movpreseni    
		, mocapitalp    
		, moINTeresp    
		, moreajustp    
		, movpresenp    
		, motasant    
		, mobasant    
		, movalant    
		, mostatreg    
		, movpressb    
		, modifsb    
		, monominalp    
		, movalcomp    
		, movalcomu    
		, moINTeres    
		, moreajuste    
		, moINTpac    
		, moreapac    
		, moutilidad    
		, moperdida    
		, movalven    
		, mocontador    
		, monsollin    
		, moobserv    
		, moobserv2    
		, movvista    
		, movviscom    
		, momtocomi    
		, mocorvent    
		, modcv    
		, moclave_dcv    
		, mocodexceso    
		, momtoPFE    
		, momtoCCE    
		, ISNULL(moINTermesc,0)    
		, ISNULL(moreajumesc,0)    
		, ISNULL(moINTermesvi,0)    
		, ISNULL(moreajumesvi,0)    
		, fecha_compra_original    
		, valor_compra_original    
		, valor_compra_um_original    
		, tir_compra_original    
		, valor_par_compra_original    
		, porcentaje_valor_par_compra_original    
		, codigo_carterasuper    
		, Tipo_Cartera_Financiera    
		, Mercado    
		, Sucursal    
		, Id_Sistema    
		, Fecha_PagoMañana    
		, Laminas    
		, Tipo_Inversion    
		, Cuenta_Corriente_Inicio    
		, Cuenta_Corriente_Final    
		, Sucursal_Inicio    
		, Sucursal_Final    
		, motipoletra    
		, moreserva_tecnica1    
		, movalvenc    
		, movaltasemi    
		, moprimadesc    
		, SwImpresion    
		, MtoCompraPM    
		, MtoVentaPM    
		, 'S'    
		, SorteoLCHR    
		, Dcrp_Confirmador    
		, Dcrp_Codigo    
		, Dcrp_Glosa    
		, Dcrp_HoraConfirm    
		, Dcrp_OperConfirm    
		, Dcrp_OpeCnvConfirm
		, id_libro
	-->	  LD1_035 CALCULO A TASA DE CONTRATO
		, Tasa_Contrato
		, Valor_Contable
	-->	  LD1_035 CALCULO A TASA DE CONTRATO
		, volcker_rule	--> LD1-COR-025 CARTERA VOLCKER RULE
		FROM	MDMO
		WHERE	monumoper = @nnumdocu
		AND		monumdocu = @nnumdocu
		AND		mocorrela = @ncorrela
	END

	IF @cmdse = 'N'
	BEGIN    
		INSERT INTO VIEW_NOSERIE    
		(	nsrutcart ,    
			nsnumdocu ,    
			nscorrela ,    
			nsrutemi ,    
			nsmonemi ,    
			nstasemi ,    
			nsbasemi ,    
			nsfecemi ,    
			nsfecven ,    
			nsserie  ,    
			nscodigo ,    
			corresponsal     
		)    
		VALUES    
		(	@nrutcart ,    
			@nnumdocu ,    
			@ncorrela ,    
			@nrutemi ,    
			@nmonemi ,    
			@ntasemi ,    
			@nbasemi ,    
			@cfecemi ,    
			@cfecven ,    
			@cinstser ,    
			@ncodigo ,    
			@corresponsal    
		)    
	END    

	IF @@error<>0    
		SELECT @ok = '0'    

	IF @@error=0    
		SELECT @ok = '1'    

	SET NOCOUNT OFF    

	SELECT @ok    

END
GO
