USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_VALIDA_OPERACION_DRV]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RIEFIN_VALIDA_OPERACION_DRV]
	(	@Id_Sistema		VARCHAR(3)
	,	@NumOp			NUMERIC(10)
	)	
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @EXISTE AS INT
	SET @EXISTE =0

			-->======= Determina si es operación generada en CHile o NY =========--
		   DECLARE @EsOperacionNY as char(2)
		   SET @EsOperacionNY = 'No'
 			IF exists (select 1 from BACBONOSEXTNY..text_mvt_dri where monumoper = @NumOp)
						set @EsOperacionNY = 'Si'

			IF exists (select 1 from BacSwapNY..CARTERA where numero_operacion = @NumOp)
						set @EsOperacionNY = 'Si'

			IF exists (select * from BacFWDNY..MFCA where canumoper = @NumOp)
						set @EsOperacionNY = 'Si'
			--===================================================================--
	
	IF @Id_Sistema ='BFW' 
	BEGIN 
		
		IF @EsOperacionNY = 'No'
		BEGIN
				SELECT @EXISTE =1
				FROM BacfwdSuda..mfca  Ca
				INNER JOIN BacParamSuda..Cliente Cl ON	Ca.cacodigo = Cl.Clrut 
													and Ca.cacodcli = Cl.Clcodigo
				WHERE (Ca.canumoper =@NumOp)
		
				IF @EXISTE =0 
				BEGIN
					SELECT -1, 'No existe operación en cartera'	
				END
		
				IF @EXISTE =1 
				BEGIN
					SELECT Cl.Clnombre
					,	   Ca.cafecvcto
					FROM BacfwdSuda..mfca  Ca
					INNER JOIN BacParamSuda..Cliente Cl ON	Ca.cacodigo = Cl.Clrut 
														and Ca.cacodcli = Cl.Clcodigo
					WHERE (Ca.canumoper =@NumOp)	
				END 
		END

		IF @EsOperacionNY = 'Si'
		BEGIN
				SELECT @EXISTE =1
				FROM BacFWDNY..mfca  Ca
				INNER JOIN BacParamSuda..Cliente Cl ON	Ca.cacodigo = Cl.Clrut 
													and Ca.cacodcli = Cl.Clcodigo
				WHERE (Ca.canumoper =@NumOp)
		
				IF @EXISTE =0 
				BEGIN
					SELECT -1, 'No existe operación en cartera'	
				END
		
				IF @EXISTE =1 
				BEGIN
					SELECT Cl.Clnombre
					,	   Ca.cafecvcto
					FROM BacFWDNY..mfca  Ca
					INNER JOIN BacParamSuda..Cliente Cl ON	Ca.cacodigo = Cl.Clrut 
														and Ca.cacodcli = Cl.Clcodigo
					WHERE (Ca.canumoper =@NumOp)	
				END 
		END

	END 	
		

	IF @Id_Sistema ='PCS' 
	BEGIN
		IF @EsOperacionNY = 'No'
		BEGIN
				SELECT @EXISTE =1
				FROM BacSwapSuda..Cartera Ca
								INNER JOIN BacParamSuda..Cliente Cl ON	Ca.rut_cliente = Cl.Clrut 
																	and Ca.codigo_cliente = Cl.Clcodigo
				WHERE (Ca.numero_operacion = @NumOp)
		
				IF @EXISTE =0 
				BEGIN
					SELECT -1, 'No existe operación en cartera'	
				END
		
				IF @EXISTE =1 
				BEGIN
					SELECT DISTINCT Cl.Clnombre
					,				Ca.fecha_termino
					FROM BacSwapSuda..Cartera Ca
									INNER JOIN BacParamSuda..Cliente Cl ON	Ca.rut_cliente = Cl.Clrut 
																		and Ca.codigo_cliente = Cl.Clcodigo
					WHERE (Ca.numero_operacion = @NumOp)
				END 
		END

		IF @EsOperacionNY = 'Si'
		BEGIN
				SELECT @EXISTE =1
				FROM BacSwapNY..Cartera Ca
								INNER JOIN BacParamSuda..Cliente Cl ON	Ca.rut_cliente = Cl.Clrut 
																	and Ca.codigo_cliente = Cl.Clcodigo
				WHERE (Ca.numero_operacion = @NumOp)
		
				IF @EXISTE =0 
				BEGIN
					SELECT -1, 'No existe operación en cartera'	
				END
		
				IF @EXISTE =1 
				BEGIN
					SELECT DISTINCT Cl.Clnombre
					,				Ca.fecha_termino
					FROM BacSwapNY..Cartera Ca
									INNER JOIN BacParamSuda..Cliente Cl ON	Ca.rut_cliente = Cl.Clrut 
																		and Ca.codigo_cliente = Cl.Clcodigo
					WHERE (Ca.numero_operacion = @NumOp)
				END 
		END
		
		
	END 
		
		
	IF @Id_Sistema ='OPT' 
	BEGIN
		
		SELECT @EXISTE =1
		FROM	Lnkopc.CbmdbOpc.dbo.cadetcontrato CaN
				INNER JOIN Lnkopc.CbmdbOpc.dbo.CaEncContrato CaE ON	CaE.CaNumContrato = CaN.CaNumContrato 
				INNER JOIN Lnkopc.CbmdbOpc.dbo.OpcionEstructura OpE ON	OpE.OpcEstCod = CaE.CaCodEstructura 
				INNER JOIN Bacparamsuda..Cliente  Cl ON	CaE.CaRutCliente = Cl.Clrut 
												   AND  CaE.CaCodigo =Cl.Clcodigo
		WHERE  (CaN.CaNumContrato   = @NumOp)
		
		IF @EXISTE =0 
		BEGIN
			SELECT -1, 'No existe operación en cartera'	
		END
		
		IF @EXISTE =1 
		BEGIN
			SELECT	Cl.Clnombre 
			,		CaN.CaFechaVcto
			FROM	Lnkopc.CbmdbOpc.dbo.cadetcontrato CaN
					INNER JOIN Lnkopc.CbmdbOpc.dbo.CaEncContrato CaE ON	CaE.CaNumContrato = CaN.CaNumContrato 
					INNER JOIN Lnkopc.CbmdbOpc.dbo.OpcionEstructura OpE ON	OpE.OpcEstCod = CaE.CaCodEstructura 
					INNER JOIN Bacparamsuda..Cliente  Cl ON	CaE.CaRutCliente = Cl.Clrut 
													   AND  CaE.CaCodigo =Cl.Clcodigo
			WHERE (CaN.CaNumContrato  = @NumOp)
		END 
		
	END
		
	IF @Id_Sistema ='BTR'
	BEGIN
		SELECT @EXISTE =1
		FROM Bactradersuda..mddi  Md
				INNER JOIN BacParamSuda..Cliente Cl ON	Md.dirutcart = Cl.Clrut 
													AND Md.ditipcart = Cl.Clcodigo
				
		WHERE  (Md.dinumdocu   = @NumOp)AND	Md.dinominal <> 0
		
		IF @EXISTE =0 
		BEGIN
			SELECT -1, 'No existe operación relacionada en cartera'	
		END
		
		IF @EXISTE =1 
		BEGIN
			SELECT Cl.Clnombre
			FROM Bactradersuda..mddi  Md
					INNER JOIN BacParamSuda..Cliente Cl ON	Md.dirutcart = Cl.Clrut 
														AND Md.ditipcart = Cl.Clcodigo
			WHERE  (Md.dinumdocu   = @NumOp)AND	Md.dinominal <> 0
		END 		
	END
	
	
	IF   @Id_Sistema ='BEX'	
	BEGIN
		
		CREATE TABLE #TemBex
		( 	mofecpago 		DATETIME
		,	monumdocu		NUMERIC(10, 0)
		,	cod_nemo		CHAR(20)
		,	monominal		NUMERIC(19, 4)
		,	mofecpcup 		DATETIME	)		

		
		IF @EsOperacionNY = 'No'
				BEGIN	
								
					INSERT INTO #TemBex (mofecpago,monumdocu,cod_nemo,monominal,mofecpcup)
					(SELECT	mofecpago
					,		monumdocu
					,		cod_nemo
					,		monominal 
					,		mofecpcup 
					FROM	BacBonoSextSuda..text_ctr_cpr 
					WHERE	mofecpcup > (SELECT acfecprox FROM BacBonoSextSuda..text_arc_ctl_dri) --'20110823' 
					and		motipoper = 'CP' and monominal > 0
					UNION
					SELECT	mofecpago = cpfecpago
					,		monumdocu = cpnumdocu
					,		cod_nemo
					,		monominal = cpnominal 
					,		mofecpcup = cpfecpcup 
					FROM	BacBonoSextSuda..TEXT_CTR_INV 
					WHERE	cpfecpcup > (SELECT acfecprox FROM BacBonoSextSuda..text_arc_ctl_dri) and Cpnominal > 0)
	
	
					SELECT @EXISTE =1
					FROM   #TemBex
					WHERE  (monumdocu  = @NumOp)
		
					IF @EXISTE =0 
					BEGIN
						SELECT -1, 'No existe operación relacionada en cartera'	
					END
		
					IF @EXISTE =1 
					BEGIN
						SELECT	cod_nemo
						FROM	#TemBex
						WHERE  (monumdocu  = @NumOp)
					END 	
		END	
	

		IF @EsOperacionNY = 'Si'
				BEGIN	
								
					INSERT INTO #TemBex (mofecpago,monumdocu,cod_nemo,monominal,mofecpcup)
					(SELECT	mofecpago
					,		monumdocu
					,		cod_nemo
					,		monominal 
					,		mofecpcup 
					FROM	BacBonoSextNY..text_ctr_cpr 
					WHERE	mofecpcup > (SELECT acfecprox FROM BacBonoSextNY..text_arc_ctl_dri) --'20110823' 
					and		motipoper = 'CP' and monominal > 0
					UNION
					SELECT	mofecpago = cpfecpago
					,		monumdocu = cpnumdocu
					,		cod_nemo
					,		monominal = cpnominal 
					,		mofecpcup = cpfecpcup 
					FROM	BacBonoSextNY..TEXT_CTR_INV 
					WHERE	cpfecpcup > (SELECT acfecprox FROM BacBonoSextNY..text_arc_ctl_dri) and Cpnominal > 0)
	
	
					SELECT @EXISTE =1
					FROM   #TemBex
					WHERE  (monumdocu  = @NumOp)
		
					IF @EXISTE =0 
					BEGIN
						SELECT -1, 'No existe operación relacionada en cartera'	
					END
		
					IF @EXISTE =1 
					BEGIN
						SELECT	cod_nemo
						FROM	#TemBex
						WHERE  (monumdocu  = @NumOp)
					END 	
		END	


	END
	
END
SET NOCOUNT OFF

GO
