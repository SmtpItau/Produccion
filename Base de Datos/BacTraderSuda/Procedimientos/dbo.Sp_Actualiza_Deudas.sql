USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Actualiza_Deudas]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Actualiza_Deudas]
AS

/*LD1-COR-035 LIMITE DE ENDEUDAMIENTO*/



/***********************************************************************
NOMBRE         : dbo.Sp_Actualiza_Deudas.StoredProcedure.sql
AUTOR          : SONDA (Unidad de Desarrollo)
FECHA CREACION : 09/08/2011
DESCRIPCION    : Migracion a SQL 2008
HISTORICO DE CAMBIOS
FECHA        AUTOR           DESCRIPCION  
20140507	jcamposd	se leera desde las nuevas tablas de forward adicionalmente solo se calculara contra el 1.5 no se 
llevara a pesos 
----------------------------------------------------------------------


**********************************************************************/

BEGIN
	SET NOCOUNT ON

	DECLARE	@x    		INTEGER		,
		@iContador 	INTEGER		,
		@CAN_REG        INTEGER		,
		@nNumdocu	NUMERIC	(10,0)	,
		@nNumoper	NUMERIC	(10,0)	,
		@nCorrela	NUMERIC	(03,0)	,
		@cSistema	CHAR	(03)	,
		@nMonto		NUMERIC	(19,2)	,
		@nMtoGara	NUMERIC	(19,2)	,
		@cInstser       CHAR	(10)	,
		@nRutcli	NUMERIC	(09,0)	,
		@nNominal       NUMERIC	(19,4)	,
		@nCodcli	NUMERIC	(09,0)	,
		@dFecpro	DATETIME	,
		@nDO_Obs	NUMERIC	(19,4)	,
		@nUF_Hoy	NUMERIC	(19,4)	,
		@nPFwp_Perd_Dif	NUMERIC	(07,4)
		,@dfechaAnterior	DATETIME

	CREATE	TABLE
	#TEMPO
		(
		sistema		CHAR	(03)	NOT NULL	,
		numoper		NUMERIC	(10,0)	NOT NULL	,
		monto		NUMERIC	(19,2)	NOT NULL	,
		rutcli		NUMERIC	(09,0)	NOT NULL	,
		codcli		NUMERIC	(09,0)	NOT NULL	,
		garantia	CHAR	(01)	NOT NULL	,
		mtogara		NUMERIC	(19,4)	NOT NULL	,
		registro	INTEGER IDENTITY(1,1) NOT NULL	,
		serie		CHAR	(05)	NOT NULL
		)

	CREATE	TABLE
	#GARANTIAS
		(
		numdocu		NUMERIC	(10,0)	NOT NULL	,
		numoper		NUMERIC	(10,0)	NOT NULL	,

		correla		NUMERIC	(03,0)	NOT NULL	,
		nominal		NUMERIC	(19,4)	NOT NULL	,
		instser		CHAR	(10)	NOT NULL	,
		vpresen		NUMERIC	(19,0)	NOT NULL	,
		registro	INTEGER IDENTITY(1,1) NOT NULL
		)

	SELECT	@dFecpro	= acfecproc
			,@dfechaAnterior = acfecante
	FROM	MDAC WITH(NOLOCK)

	SELECT	@nDO_Obs		= ISNULL(vmvalor,0) FROM view_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=@dFecpro
	SELECT	@nUF_Hoy		= ISNULL(vmvalor,0) FROM view_VALOR_MONEDA WHERE vmcodigo=998 AND vmfecha=@dFecpro

	SELECT	@nPFwp_Perd_Dif		= ROUND(PFwp_Perd_Dif/100,4)
	FROM	BACPARAMSUDA..ENDEUDAMIENTO with(nolock)


	--BEGIN TRANSACTION

		UPDATE	VIEW_CONTROL_LIMITES_GENERALES
		SET	Numero_operacion	= 0
		WHERE	DATEADD(DAY,plazo,Fecha_Exceso)<=@dFecpro AND Codigo_Tipo_Limite=2 AND Codigo_Limite=1 AND
			(Tipo_Operacion='ICAP' OR Tipo_Operacion='C' OR Tipo_Operacion='V')

		IF @@error<>0
		BEGIN
			--ROLLBACK TRANSACTION
			--RETURN
			SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ACTUALIZACION VIEW_CONTROL_LIMITES_GENERALES'
			SET NOCOUNT OFF
			RETURN
		END

		DELETE	VIEW_CONTROL_LIMITES_GENERALES WHERE Numero_operacion=0

		IF @@error<>0
		BEGIN
			--ROLLBACK TRANSACTION
			--RETURN
			SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ACTUALIZACION VIEW_CONTROL_LIMITES_GENERALES'
			SET NOCOUNT OFF
			RETURN
			
		END

		INSERT	INTO
		#TEMPO
			(
			sistema					,
			numoper					,
			monto					,
			rutcli					,
			codcli					,
			mtogara					,
			garantia				,
			serie
			)
		SELECT
			'BTR'					,
			cinumdocu				,
			civalinip				,
			cirutcli				,
			clcodigo				,
			0.0					,
			'N'					,
			'CI'
		FROM	MDCI WITH(NOLOCK)
			INNER JOIN VIEW_CLIENTE ON
				clrut		=cirutcli 
				AND clcodigo=cicodcli 
				AND cicodigo=993 --ICAP
				AND cltipcli in(1,2)
			INNER JOIN BACPARAMSUDA..LIMITE_TOTAL_ENDEUDAMIENTO WITH(NOLOCK) ON
				rut_cliente=cirutcli 
				AND codigo_cliente=cicodcli 
		WHERE DATEDIFF(DAY,@dfecpro,cifecvenp)<=365 
				AND cifecvenp>@dfecpro
				AND estado = 1 --nuevo filtro igualando contra reporte			

		-- Captaciones a Plazo

		INSERT	INTO
		#TEMPO
			(
			sistema					,
			numoper					,
			monto					,
			rutcli					,
			codcli					,
			mtogara					,
			garantia				,
			serie
			)
		SELECT
			'BTR'					,
			Numero_Operacion		,
			monto_inicio_pesos		,
			rut_cliente				,
			codigo_rut				,
			0.0						,
			'N'					,
			tipo_operacion
		FROM	GEN_CAPTACION WITH(NOLOCK)
			INNER JOIN VIEW_CLIENTE ON				
				clrut		 = rut_cliente 
				AND clcodigo = codigo_rut 
				AND cltipcli IN(1,2)
		WHERE	DATEDIFF(DAY,@dfecpro,fecha_vencimiento)<= 365 
			AND fecha_vencimiento > @dfecpro
			AND tipo_operacion = 'CAP' 
			AND estado< > 'A' 			


		IF @@error<>0
		BEGIN
			--ROLLBACK TRANSACTION
			--RETURN
			SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN SELECCIONAR CAPTACIONES'
			SET NOCOUNT OFF
			RETURN			
		END

		--+++se suman a petición de Benjamin las ventas con pacto 20140721

		INSERT	INTO
		#TEMPO
			(
			sistema					,
			numoper					,
			monto					,
			rutcli					,
			codcli					,
			mtogara					,
			garantia				,
			serie
			)
		SELECT
			'BTR'					,
			vinumdocu				,
			vivalinip				,
			virutcli				,
			clcodigo				,
			0.0					,
			'N'					,
			'VI'
		FROM MDVI WITH(NOLOCK)
			INNER JOIN VIEW_CLIENTE ON
				clrut		=virutcli 
				AND clcodigo=vicodcli 
				AND cltipcli in(1,2)
			INNER JOIN BACPARAMSUDA..LIMITE_TOTAL_ENDEUDAMIENTO WITH(NOLOCK) ON
				rut_cliente=virutcli 
				AND codigo_cliente=vicodcli 
		WHERE	vifecvenp > @dfecpro 
			AND  DATEDIFF(DAY,@dfecpro,vifecvenp) <= 365 
			
		-----se suman a petición de Benjamin las ventas con pacto 20140721
		
		INSERT	INTO
		#TEMPO

			(
			sistema					,
			numoper					,
			monto				        ,
			rutcli					,
			codcli					,
			mtogara					,
			garantia				,
			serie
			)
		SELECT 
			'BFW'
			,[Numero_operación]
			,[Monto] *@nPFwp_Perd_Dif			
			,[Rut_Contraparte]
			,[Codigo_cliente]
			,0.0	
			,'N'	
			,[Tipo_operación]			
		FROM BACPARAMSUDA..mfca_Findur WITH(NOLOCK)
			INNER JOIN BACPARAMSUDA..CLIENTE WITH(NOLOCK) ON
				clrut=[Rut_Contraparte] 
				AND clcodigo=[Codigo_cliente] 
				AND cltipcli in(1,2)
			INNER JOIN MDAC WITH(NOLOCK) ON
				[Fecha_vencimiento]>acfecproc									
		WHERE	fecha_proceso = @dfechaAnterior
			AND DATEDIFF(DAY,[Fecha_proceso] ,[Fecha_vencimiento])<=365 
			AND [Tipo_negocio] IN (1,3)
			AND [MTM_proyectado] < 0
				

		IF @@error<>0
		BEGIN
			--ROLLBACK TRANSACTION
			--RETURN
			SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN SELECCIONAR FORWARD'
			SET NOCOUNT OFF
			RETURN						
		END


		UPDATE	#TEMPO
		SET	mtogara	= mtogara + ISNULL((SELECT SUM(Monto_Linea) FROM VIEW_CONTROL_LIMITES_GENERALES WHERE numoper=Numero_Operacion AND Tipo_Operacion=serie AND Codigo_Tipo_Limite=2 AND Codigo_Limite=1),0)

		IF @@error<>0
		BEGIN
			--ROLLBACK TRANSACTION
			--RETURN
			SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN CALCULAR MONTO OTORGAMIENTO'
			SET NOCOUNT OFF
			RETURN						
		END

		UPDATE	VIEW_LIMITE_TOTAL_ENDEUDAMIENTO SET outstanding = 0.0

		IF @@error<>0
		BEGIN
			--ROLLBACK TRANSACTION
			--RETURN
			SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ACTUALIZAR OUTSTANDING'
			SET NOCOUNT OFF
			RETURN						
		END



		IF (SELECT COUNT(*) FROM #TEMPO)>0

		BEGIN
			SELECT	@x		= 1	,
				@iContador	= 0

			SELECT  @CAN_REG =  COUNT(*) FROM #TEMPO

			WHILE @x<=@CAN_REG

			BEGIN

				SET ROWCOUNT @X
				SELECT	@cSistema	= sistema	,
					@nMonto		= monto   	,
					@nRutcli	= rutcli	,
					@nCodcli	= codcli	,
					@iContador	= registro      ,
					@nMtoGara      = (select sum(ValorPresente) from view_garantias where NumeroOperacionInstrumento =numoper)
				FROM	#TEMPO
--				WHERE	registro>@iContador
				WHERE	registro=@X
				SET ROWCOUNT 0	

				IF @cSistema='*'
					BREAK
				IF @nMonto<0
					SELECT	@nMonto	= 0

				UPDATE	VIEW_LIMITE_TOTAL_ENDEUDAMIENTO
				SET	outstanding	= outstanding + @nMonto
				WHERE	rut_cliente=@nRutcli AND codigo_cliente=@nCodcli

				IF @@error<>0
				BEGIN
					--ROLLBACK TRANSACTION
					--RETURN
					SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN CALCULAR OUTSTANDING'
					SET NOCOUNT OFF
					RETURN			
				END

				SELECT @X = @X + 1

			END
		END

		INSERT	INTO
		#GARANTIAS

			(
			numdocu				,
			numoper				,
			correla				,
			nominal				,
			instser				,
			vpresen
			)
		SELECT
			NumeroOperacionInstrumento	,
			NumeroOperacionInstrumento	,
			CorrelativoInstrumento,
			Nominal		,
			'ANULA'				,
			ValorPresente

		FROM	VIEW_GARANTIAS
		WHERE	FechaVencimiento<=@dFecpro

		IF (SELECT COUNT(*) FROM #GARANTIAS)>0

		BEGIN
			SELECT	@x		= 1	,
				@iContador	= 0

			WHILE @x=1
			BEGIN
				SELECT	@cInstser='*'

				SET ROWCOUNT 1
				SELECT	@cInstser	= instser	,
			       		@nNumdocu	= numdocu	,
			       		@nNumoper	= numoper	,
					@nCorrela       = correla	,
					@nNominal	= nominal	,
					@iContador	= registro
				FROM	#GARANTIAS
				WHERE	registro>@iContador
				SET ROWCOUNT 0

				IF @cInstser='*'
					BREAK

				UPDATE	MDDI
				SET	dinomigarantia	= dinomigarantia - @nNominal
				WHERE	dinumdocu=@nNumdocu AND dicorrela=@nCorrela

				IF @@ERROR<>0
				BEGIN
					--ROLLBACK TRANSACTION
					--SELECT	1, ''La Disponibilidad de Garantias No pudo Actulizarse, La operación NO fue Anulada''
					--RETURN
					SELECT 'ESTADO' = 'NO', 'MSG' = 'La Disponibilidad de Garantias No pudo Actulizarse, La operación NO fue Anulada'
					SET NOCOUNT OFF
					RETURN						
				END

				UPDATE	MDCO
				SET	cocantcortd	= cocantcortd + cvcantcort
				FROM	MDCV 
				WHERE	conumdocu=@nNumdocu AND cocorrela=@nCorrela AND cvnumdocu=@nNumdocu AND cvcorrela=@nCorrela AND
					cvnumoper=@nNumoper AND comtocort=cvmtocort

				IF @@ERROR<>0
				BEGIN
					--ROLLBACK TRANSACTION
					--SELECT	1, ''La Disponibilidad de Cortes Garantias No pudo Actulizarse, La operación NO fue Anulada''
					--RETURN
					SELECT 'ESTADO' = 'NO', 'MSG' = 'La Disponibilidad de Cortes Garantias No pudo Actulizarse, La operación NO fue Anulada'
					SET NOCOUNT OFF
					RETURN						
				END

				DELETE	MDCV WHERE cvnumoper=@nNumoper

				IF @@ERROR<>0
				BEGIN
					--ROLLBACK TRANSACTION
					--SELECT	1, ''Cortes Vendidos para Garantias No pudo Actulizarse, La operación NO fue Anulada''
					--RETURN
					SELECT 'ESTADO' = 'NO', 'MSG' = 'Cortes Vendidos para Garantias No pudo Actulizarse, La operación NO fue Anulada'
					SET NOCOUNT OFF
					RETURN											
				END

				DELETE VIEW_GARANTIAS WHERE NumeroOperacionInstrumento=@nNumoper

				IF @@ERROR<>0
				BEGIN
					--ROLLBACK TRANSACTION
					--SELECT	1, ''La Garantia No pudo Actulizarse, La operación NO fue Anulada''
					--RETURN
					SELECT 'ESTADO' = 'NO', 'MSG' = 'La Garantia No pudo Actulizarse, La operación NO fue Anulada'
					SET NOCOUNT OFF
					RETURN																
				END

				DELETE	VIEW_CONTROL_LIMITES_GENERALES
				WHERE	Codigo_Tipo_Limite=2 AND Codigo_Limite=1 AND Numero_operacion=@nNumoper

				IF @@ERROR<>0
				BEGIN
					--ROLLBACK TRANSACTION
					--SELECT	1, ''Control de Limites No pudo Actulizarse, La operación NO fue Anulada''
					--RETURN
					SELECT 'ESTADO' = 'NO', 'MSG' = 'Control de Limites No pudo Actulizarse, La operación NO fue Anulada'
					SET NOCOUNT OFF
					RETURN																
					
				END
			END
		END

	--COMMIT TRANSACTION
	--SELECT	0,''OK''
	--SET NOCOUNT OFF

	SELECT 'ESTADO' = 'SI', 'MSG' = 'Actualización de deudas realizado en forma correcta'
	SET NOCOUNT OFF
	RETURN																
	

END

-- Base de Datos --
GO
