USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_RF_PACTOS_INGRESOS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_RF_PACTOS_INGRESOS]
	(	@FECHA DATETIME	)
AS
BEGIN

	SET NOCOUNT ON   

	 
	/*-----------------------------------------------------------------------------*/
	/*-----------------------------------------------------------------------------*/
	/* OBJETIVOS     : PACTOS RENTA FIJA                                           */
	/* AUTOR         : ROBERTO MORA DROGUETT                                       */
	/* FECHA CRACION : 14/03/2016                                                  */
	/*-----------------------------------------------------------------------------*/
	/*-----------------------------------------------------------------------------*/

	--	BITACORA DE MODIFICACIONES
	/*------------------------------------------------------------------------------*/
	/*	Id Modificacion	:	1.01	(TAG de Modificacion)							*/
	/*	Modificacion	:	Adrian Gonzalez											*/
	/*	Fecha			:	24-11-2016												*/
	/*	Motivo			:	Errores en Columnas										*/
	/*		T	:	Costo Total de Captacion : Se debe Informar la tasa del pacto	*/
	/*		U	:	Modalidad Origen : Modificar segun hoja de modalidad			*/
	/*		V	:	Informar Destino												*/
	/*		W	:	Informar Cuenta Cosif											*/
	/*------------------------------------------------------------------------------*/



	/*-----------------------------------------------------------------------------*/
	/* DECLARACION DE VARIABLES                                                    */
	/*-----------------------------------------------------------------------------*/
	DECLARE	@QUERY             VARCHAR(MAX)
		,	@CNPJ              VARCHAR(20)
		,	@COD_PAIS          INT
		,	@COD_CONTRA        INT

	/*-----------------------------------------------------------------------------*/
	/* CREACION DE ESTRUCTURA DE TABLA DINAMICA                                    */
	/*-----------------------------------------------------------------------------*/
	CREATE TABLE #MDVI
	(vinumoper					NUMERIC
	,vicorrela					NUMERIC
	,virutcli					NUMERIC
	,vicodcli					NUMERIC
	,vifecinip					DATETIME
	,vifecvenp					DATETIME
	,vimonpact					NUMERIC
	,vivalinip					NUMERIC
	,vivalvenp					NUMERIC
	,vinumdocu					NUMERIC			/*(1.01)*/
	,vitaspact					NUMERIC(6,4)	/*(1.01)*/ 
	)

	/*-----------------------------------------------------------------------------*/
	/* DECLARACION DE VARIABLES DE CURSOR                                          */
	/*-----------------------------------------------------------------------------*/
	DECLARE @CUR_vinumoper		NUMERIC
	,		@CUR_vicorrela		NUMERIC
	,		@CUR_virutcli		NUMERIC
	,		@CUR_vicodcli		NUMERIC
	,		@CUR_vifecinip		DATETIME
	,		@CUR_vifecvenp		DATETIME
	,		@CUR_vimonpact		NUMERIC
	,		@CUR_vivalinip		NUMERIC
	,		@CUR_vivalvenp		NUMERIC
	,		@CUR_vinumdocu		NUMERIC			/*(1.01)*/
	,		@CUR_vitaspact		NUMERIC(6,4)	/*(1.01)*/ 


	/*-----------------------------------------------------------------------------*/
	/* CREACION DE TABLA SEGUN FECHA MDVI                                          */
	/*-----------------------------------------------------------------------------*/
	SET @QUERY	= 'INSERT INTO #MDVI '
	SET @QUERY	= @QUERY + 'SELECT '
	SET @QUERY	= @QUERY + 'vinumoper' 
	SET @QUERY	= @QUERY + ',vicorrela' 
	SET @QUERY	= @QUERY + ',virutcli'
	SET @QUERY	= @QUERY + ',vicodcli'
	SET @QUERY	= @QUERY + ',vifecinip'
	SET @QUERY	= @QUERY + ',vifecvenp'
	SET @QUERY	= @QUERY + ',vimonpact'
	SET @QUERY	= @QUERY + ',vivalinip'
	SET @QUERY	= @QUERY + ',vivalvenp'
	SET @QUERY	= @QUERY + ',vinumdocu'			/*(1.01)*/
	SET @QUERY	= @QUERY + ',vitaspact'			/*(1.01)*/
	SET @QUERY  = @QUERY + ' FROM bactradersuda.dbo.MDVI' + SUBSTRING(CONVERT(CHAR(8),@FECHA,112),5,4)
	SET @QUERY  = @QUERY + ' WHERE vifecinip='
	SET @QUERY  = @QUERY + ''''
	SET @QUERY  = @QUERY +  convert(char(10), @FECHA, 111)
	SET @QUERY  = @QUERY +   ''''
	EXEC (@QUERY)

	/*-----------------------------------------------------------------------------*/
	/* CREACION DE SALIDA DE REGISTROS                                             */
	/*-----------------------------------------------------------------------------*/
	DECLARE @SALIDA TABLE
	(	Nr_controle_dado_institucion_financeira			VARCHAR(20)
	,	Tipo_Operacion									VARCHAR(02) 
	,	Identificador_Captacion							VARCHAR(20)
	,	Data_de_Captacion								VARCHAR(10)
	,	CNJP											VARCHAR(20)
	,	Pais											VARCHAR(05)
	,	Credor											VARCHAR(01)
	,	Indicador_de_operacion_intraconglomerado		VARCHAR(01)
	,	Indicador_de_operacion_intragrupo_financeiro	VARCHAR(01)
	,	Moneda											VARCHAR(03)
	,	Valor_da_captacion								NUMERIC
	,	Indicador_de_Captacion_vencimento_de_principal	VARCHAR(01)
	,	Data_de_vencimento_prevista_parcela_principal	VARCHAR(10)
	,	valor_previsto_para_parcela_de_principal		NUMERIC
	,	Tipo_de_Juros									VARCHAR(05)
	,	Codigo_da_taxa_pos_fixada						NUMERIC
	,	Spread_da_taxa_pos_fixada						NUMERIC
	,	Custo_total_na_data_da_captacion				NUMERIC
	,	Modalidad										NUMERIC			/*(1.01)*/
	,	Destinacion										VARCHAR(05)     
	,	Conta_Cosif										VARCHAR(20)
	,	Observaciones									VARCHAR(100)
	,	TasaPacto										NUMERIC(6,4)	/*(1.01)*/
	)

	/*-----------------------------------------------------------------------------*/
	/* DECLARACION DE VARIABLES DE SALIDA                                          */
	/*-----------------------------------------------------------------------------*/
    DECLARE @Nr_controle_dado_institucion_financeira        VARCHAR(20) -- 769+01+no.operacion + correlativo concatenado /* 1.01 (se le agregara a la llave el no.documento) */
           ,@Tipo_Operacion                                 VARCHAR(02) 
           ,@Identificador_Captacion                        varchar(20)  -- no.contrato + correlativo
           ,@Data_de_Captacion                              varchar(10)  -- formato debe ser dd/mm/yyyy
           ,@CNJP                                           VARCHAR(20) 
           ,@Pais                                           VARCHAR(05) -- codigos de pais pais.cod_swift (para archivos BACEN)
           ,@Credor                                         VARCHAR(01)
           ,@Indicador_de_operacion_intraconglomerado       VARCHAR(01)
           ,@Indicador_de_operacion_intragrupo_financeiro   VARCHAR(01)
           ,@Moneda                                         VARCHAR(03)
           ,@Valor_da_captacion                             NUMERIC
           ,@Indicador_de_Captacion_vencimento_de_principal VARCHAR(01)  -- S  y por consiguiente el valor del campo valor_da_captacion se debe replicar en el campo valor_previsto_para_parcela_principal
           ,@Data_de_vencimento_prevista_parcela_principal  VARCHAR(10)     -- formato debe ser dd/mm/yyyy
           ,@valor_previsto_para_parcela_de_principal       NUMERIC      -- valor_da_captacion
           ,@Tipo_de_Juros                                  VARCHAR(05)
           ,@Codigo_da_taxa_pos_fixada                      NUMERIC
           ,@Spread_da_taxa_pos_fixada                      NUMERIC
           ,@Custo_total_na_data_da_captacion               NUMERIC
		   ,@Modalidad										NUMERIC			/*(1.01)*/
           ,@Destinacion                                    VARCHAR(05)     
           ,@Conta_Cosif                                    VARCHAR(20)  -- agregar cosif 
           ,@Observaciones                                  VARCHAR(100)
		   ,@TasaPacto										NUMERIC(6,4)	/*(1.01)*/
		   
		--	mostrar operaciones del día

	/*-----------------------------------------------------------------------------*/
	/* CURSOR DE CONTABILIDAD SOLO ARBITRAJES                                      */
	/*-----------------------------------------------------------------------------*/
	DECLARE CURSOR_OPERACIONES	CURSOR LOCAL FOR
    SELECT	vinumoper			-- ltrim(rtrim(vinumoper))ltrim(rtrim(vicorrela))  /*1.01 [ ltrim(rtrim( vinumdocu )) ]*/
		,	vicorrela
		,	virutcli                
		,	vicodcli                
		,	vifecinip               
		,	vifecvenp               
		,	vimonpact               
		,	vivalinip  
		,	vivalvenp
		,	vinumdocu					/*(1.01)*/
		,	vitaspact					/*(1.01)*/
	FROM	#MDVI

	OPEN CURSOR_OPERACIONES
    FETCH NEXT FROM CURSOR_OPERACIONES 
		INTO	@CUR_vinumoper   
		,		@CUR_vicorrela
		,		@CUR_virutcli    
		,		@CUR_vicodcli    
		,		@CUR_vifecinip   
		,		@CUR_vifecvenp   
		,		@CUR_vimonpact   
		,		@CUR_vivalinip 
		,		@CUR_vivalvenp
		,		@CUR_vinumdocu			/*(1.01)*/
		,		@CUR_vitaspact			/*(1.01)*/

	/*-----------------------------------------------------------------------------*/
	/* INICIO DE CICLO CONTABLE                                                    */
	/*-----------------------------------------------------------------------------*/
	WHILE @@FETCH_STATUS  = 0 
	BEGIN

		/*----------------------------------------------------------------------*/
		/* ASIGNACION DE VALORES POR DEFECTO                                    */
		/*----------------------------------------------------------------------*/
		SELECT	@Nr_controle_dado_institucion_financeira        =	'769' + '01' 
																+	ltrim(rtrim(str(@CUR_vinumoper)))
																+	ltrim(rtrim(str(@CUR_vinumdocu)))		/*(1.01)*/
																+	ltrim(rtrim(str(@CUR_vicorrela)))

			,	@Tipo_Operacion                                 =	'I'
			,	@Identificador_Captacion                        =	ltrim(rtrim(str(@CUR_vinumoper)))
																+	ltrim(rtrim(str(@CUR_vicorrela)))
																
			,	@Data_de_Captacion                              =	convert(char(10),@CUR_vifecinip,103)

			,	@CNJP                                           =	'12262596000187'	/*(1.01)*/

			,	@Pais                                           =	''
			,	@Credor                                         =	''

			,	@Indicador_de_operacion_intraconglomerado       =	'N'					/*(1.01)*/
			
			,	@Indicador_de_operacion_intragrupo_financeiro   =	''
			,	@Moneda                                         =	''
			,	@Valor_da_captacion                             =	@CUR_vivalinip
			,	@Indicador_de_Captacion_vencimento_de_principal =	'S'
			,	@Data_de_vencimento_prevista_parcela_principal  =	convert(char(10),@CUR_vifecvenp,103)
			,	@valor_previsto_para_parcela_de_principal       =	@CUR_vivalinip
			,	@Tipo_de_Juros                                  =	'PRE'
			,	@Codigo_da_taxa_pos_fixada                      =	999
			,	@Spread_da_taxa_pos_fixada                      =	0
			,	@Custo_total_na_data_da_captacion               =	@CUR_vivalvenp
			,	@Modalidad										=	'4'
			,	@Destinacion                                    =	'999'
			,	@Conta_Cosif                                    =	'0'
			,	@Observaciones                                  =	'348001002'	/*'811502090'*/		/*(1.01)*/
			,	@TasaPacto										=	@CUR_vitaspact

		/*(1.01)*/
		set @Observaciones = isnull(( select ctaDefecto from BacParamSuda.dbo.tbl_defecto_CtaBanco_cosif where archivo = 1 ), '348001002')
		
		if @Observaciones is null
			set @Observaciones = '348001002'
		/*(1.01)*/
		

		/*----------------------------------------------------------------------*/
		/* CUENTA COSIF                                                         */
		/*----------------------------------------------------------------------*/
		SELECT	@Conta_Cosif            = COSIF
		FROM	REPORTES.DBO.CODIGOS_COSIF(LTRIM(RTRIM(@Observaciones)))

        /*----------------------------------------------------------------------*/
        /* SE EXTRAEN DATOS DEL CLIENTE                                         */
        /*----------------------------------------------------------------------*/
		SELECT	@CNPJ       = '12262596000187' /*CNPJ*/			/*(1.01)*/
			,	@COD_PAIS   = CLPAIS 
			,	@COD_CONTRA = clcod_contra		
		FROM	BacParamSuda.DBO.CLIENTE 
		WHERE	CLRUT		= @CUR_virutcli
		AND		CLCODIGO	= @CUR_vicodcli

		/*(1.01)*/
		/*	SE AGREGA EL SIGUIENTE CODIGO, PARA DETERMINAR LA RELACION AL BANCO, cuanod el indicador de fusion no indica relacion */
			--> Clrelacion = 3 Relacion por Propiedad
			--> Clrelacion = 2 Relacion por Gestion
			--> Clrelacion = 1 No Relacionado
			--> Clrelacion = 0 Sin Defi

		if (@COD_CONTRA <> 3)
		begin 
			SET @COD_CONTRA		=	isnull((	SELECT  clrelacion
												FROM	BacParamSuda.dbo.cliente with(nolock)
												WHERE (	(clnombre like '%Itau%') or (clnombre like '%Corpbanca%'))
												and		clrut		= @CUR_virutcli
												and		clcodigo	= @CUR_vicodcli
											), 0)
		end
		/*(1.01)*/


		/*(1.01)*/
		set @Modalidad = isnull(( select modalidad from BacParamSuda.dbo.tbl_modalidad_cosif where cosif = @Conta_Cosif), 9);
		if @Modalidad is null
			set @Modalidad = 9;
		/*(1.01)*/


        /*----------------------------------------------------------------------*/
        /* CODIGO DE CNPJ                                                       */
        /*----------------------------------------------------------------------*/
		IF @CNJP = ''
		BEGIN
			SET @CNJP = '12262596000187' /*@CUR_virutcli*/	/*(1.01)*/ 
		END

        /*----------------------------------------------------------------------*/
        /* CODIGO DE PAIS                                                       */
        /*----------------------------------------------------------------------*/
		SELECT @Pais = cod_swift FROM BACPARAMSUDA.DBO.PAIS WHERE CODIGO_PAIS = @COD_PAIS

        /*----------------------------------------------------------------------*/
        /* CODIGO DE MONEDA                                                     */
        /*----------------------------------------------------------------------*/
		IF @CUR_vimonpact = 998 
		BEGIN
			SET @Moneda = 'CLF'
		END ELSE 
		BEGIN
			SET @Moneda	= ISNULL((SELECT mnnemo FROM BacParamSuda.DBO.MONEDA WHERE mncodmon = @CUR_vimonpact ), 'CLP') 
		END

		/*----------------------------------------------------------------------*/
		/* INDICADORES                                                          */
		/*----------------------------------------------------------------------*/
		SET @Indicador_de_operacion_intraconglomerado       = CASE WHEN @COD_CONTRA >= 3 THEN 'S' ELSE 'N' END /*(1.01)*/  -- Se agrega el ">" 
		SET @Indicador_de_operacion_intragrupo_financeiro   = CASE WHEN @COD_CONTRA >= 3 THEN 'S' ELSE 'N' END /*(1.01)*/  -- Se agrega el ">" 

		/*----------------------------------------------------------------------*/
		/* INGRESO DE REGISTROS                                                 */
		/*----------------------------------------------------------------------*/
		INSERT INTO @SALIDA
		(	Nr_controle_dado_institucion_financeira			,	Tipo_Operacion
		,	Identificador_Captacion							,	Data_de_Captacion
		,	CNJP											,	Pais
		,	Credor											,	Indicador_de_operacion_intraconglomerado
		,	Indicador_de_operacion_intragrupo_financeiro	,	Moneda
		,	Valor_da_captacion								,	Indicador_de_Captacion_vencimento_de_principal 
		,	Data_de_vencimento_prevista_parcela_principal	,	valor_previsto_para_parcela_de_principal
		,	Tipo_de_Juros									,	Codigo_da_taxa_pos_fixada
		,	Spread_da_taxa_pos_fixada						,	Custo_total_na_data_da_captacion
		,	Modalidad			/*(1.01)*/ 
		,	Destinacion										,	Conta_Cosif
		,	Observaciones									,	TasaPacto
		)
		VALUES                                  
		(	@Nr_controle_dado_institucion_financeira		,	@Tipo_Operacion
		,	@Identificador_Captacion						,	@Data_de_Captacion
		,	@CNJP											,	@Pais
		,	@Credor											,	@Indicador_de_operacion_intraconglomerado
		,	@Indicador_de_operacion_intragrupo_financeiro	,	@Moneda
		,	@Valor_da_captacion								,	@Indicador_de_Captacion_vencimento_de_principal 
		,	@Data_de_vencimento_prevista_parcela_principal	,	@valor_previsto_para_parcela_de_principal
		,	@Tipo_de_Juros									,	@Codigo_da_taxa_pos_fixada
		,	@Spread_da_taxa_pos_fixada						,	@Custo_total_na_data_da_captacion
		,	@Modalidad			/*(1.01)*/ 
		,	@Destinacion									,	@Conta_Cosif
		,	@Observaciones									,	@TasaPacto
		)

		FETCH NEXT FROM CURSOR_OPERACIONES 
		INTO	@CUR_vinumoper   
			,	@CUR_vicorrela
			,	@CUR_virutcli    
			,	@CUR_vicodcli    
			,	@CUR_vifecinip   
			,	@CUR_vifecvenp   
			,	@CUR_vimonpact   
			,	@CUR_vivalinip 
			,	@CUR_vivalvenp  
			,	@CUR_vinumdocu			/*(1.01)*/
			,	@CUR_vitaspact			/*(1.01)*/
			
	END

	CLOSE CURSOR_OPERACIONES
	DEALLOCATE CURSOR_OPERACIONES


	/*-----------------------------------------------------------------------------*/
	/* SALIDA DE REGISTROS                                                         */
	/*-----------------------------------------------------------------------------*/
	SELECT	Nr_controle_dado_institucion_financeira
		,	Tipo_Operacion
		,	Identificador_Captacion
		,	Data_de_Captacion
		,	CNJP
		,	Pais
		,	Credor
		,	Indicador_de_operacion_intraconglomerado
		,	Indicador_de_operacion_intragrupo_financeiro
		,	Moneda
		,	Valor_da_captacion
		,	Indicador_de_Captacion_vencimento_de_principal
		,	Data_de_vencimento_prevista_parcela_principal 
		,	valor_previsto_para_parcela_de_principal
		,	Tipo_de_Juros
		,	Codigo_da_taxa_pos_fixada
		,	Spread_da_taxa_pos_fixada
		,	Custo_total_na_data_da_captacion  = TasaPacto		/*(1.01)*/ 
--		,	Modalidad											/*(1.01)*/	--> Se entrega con esta modificacion comentada
		,	Destinacion
		,	Conta_Cosif
		,	Observaciones
	FROM	@SALIDA

END
GO
