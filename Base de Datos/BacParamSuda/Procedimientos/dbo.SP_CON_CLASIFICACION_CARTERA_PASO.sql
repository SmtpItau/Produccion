USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CLASIFICACION_CARTERA_PASO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_CLASIFICACION_CARTERA_PASO]
                                                (	@IdSistema		CHAR(03)
						,	@Tipo_movimiento	CHAR(05)	= ''
						,	@Tipo_Operacion		CHAR(05)	= ''
						,	@NumOpe			NUMERIC(10,0)	= 0
						,	@NumDocu		NUMERIC(10,0)	= 0
						,	@NumCorrela		NUMERIC(03,0)	= 0
						,	@EstadoCobertura	CHAR(5)		= 'DCBTO'
						)
AS 
BEGIN

	SET NOCOUNT ON 

	DECLARE	@Tipo_Instrumento	INTEGER
	,	@Moneda			INTEGER
	,	@Tipo_Emisor		INTEGER
	,	@Origen_Emisor		INTEGER
	,	@Objeto_Cubierto	INTEGER
	,	@Contraparte		NUMERIC(9)
	,	@Desde			INTEGER
	,	@Hasta			INTEGER
	,	@Cartera_Super		CHAR(10)
	,	@SubCartera_Super	CHAR(10)
	,	@Sw                	CHAR(01)

	DECLARE @NA_Tipo_Intrumento	CHAR(01) 
	,	@NA_Tipo_Emisor		CHAR(01)
	,	@NA_Origen_Emisor	CHAR(01)
	,	@NA_Cubierto		CHAR(01)
	,	@NA_Contraparte		CHAR(01)
	,	@NA_Moneda		CHAR(01)
	,	@NA_Desde_Hasta		CHAR(01)
	,	@NA_SubCartera		CHAR(01)
	,	@NA_TipoMovimiento	CHAR(01)
	,	@NA_TipoOperacion	CHAR(01)

	SELECT	@Tipo_Instrumento	= 0
	,	@Moneda			= 0
	,	@Tipo_Emisor		= 0
	,	@Origen_Emisor		= 0
	,	@Objeto_Cubierto	= 0
	,	@Contraparte		= 0
	,	@Desde			= 0
	,	@Hasta			= 0
	,	@Cartera_Super		= ''
	,	@SubCartera_Super	= ''

	IF @IdSistema	= 'BTR' 
        BEGIN

		SELECT	@NA_TipoMovimiento	= 'F'
		,	@NA_TipoOperacion	= 'F'
		,	@NA_Moneda		= 'V'
		,	@NA_Desde_Hasta		= 'V'
		,	@NA_SubCartera		= 'V'
		,	@NA_Contraparte		= 'V'
		,	@NA_Cubierto		= CASE WHEN @Tipo_movimiento <> 'TMF' THEN 'V' ELSE 'F' END


		IF NOT EXISTS(SELECT 1 FROM BACTRADERSUDA..MDRS , BACTRADERSUDA..MDAC 
							WHERE	rsfecha		= acfecproc
							AND	rsnumdocu	= @NumDocu
							AND	rscorrela	= @NumCorrela
							AND	rsnumoper	= @NumOpe
--							AND	rsfecvcto	= acfecproc
							AND	rstipoper	= 'DEV'		) BEGIN

                        SELECT @Sw = 0
			SELECT	DISTINCT 
                                @Sw                     = 1
			,	@Tipo_Instrumento	= incodigo
			,	@Cartera_Super		= codigo_carterasuper
			,	@Tipo_Emisor		= CASE WHEN emtipo NOT IN (1,2) THEN 0 ELSE emtipo END 
			,	@Origen_Emisor		= (CASE WHEN emrut = '97023000' THEN 1 
								ELSE (CASE	WHEN emtipo <> 2 THEN 0 
										ELSE emtipo END) 
								END )
			,	@Objeto_Cubierto	= ISNULL(CASE	WHEN @EstadoCobertura = 'CBTO'  THEN 1  
									WHEN @EstadoCobertura = 'DCBTO' THEN 2 END,0)
 			FROM	BACTRADERSUDA..MDDI
			,	BACPARAMSUDA..EMISOR
			,	BACPARAMSUDA..INSTRUMENTO			
                         WHERE	dinumdocu	= @NumDocu
			AND	dicorrela	= @NumCorrela
			AND	dinumdocuo	= @NumDocu
			AND	dicorrelao	= @NumCorrela
			AND	emgeneric	= digenemi
			AND	inserie		= diserie

                        IF  @Sw =0  
                        BEGIN
                            
    	        		SELECT	DISTINCT 
		    	        	@Tipo_Instrumento	= incodigo
     			        ,	@Cartera_Super		= codigo_carterasuper
	        		,	@Tipo_Emisor		= CASE WHEN emtipo NOT IN (1,2) THEN 0 ELSE emtipo END 
		        	,	@Origen_Emisor		= (CASE WHEN emrut = '97023000' THEN 1 
			        	       				ELSE (CASE	WHEN emtipo <> 2 THEN 0 
						        				ELSE emtipo END) 
				        				END )
        			,	@Objeto_Cubierto	= ISNULL(CASE	WHEN @EstadoCobertura = 'CBTO'  THEN 1  
									WHEN @EstadoCobertura = 'DCBTO' THEN 2 END,0)
 	        		FROM	BACTRADERSUDA..MDMO
		        	,	BACPARAMSUDA..EMISOR
               			,	BACPARAMSUDA..INSTRUMENTO
	        		WHERE	monumoper	= @NumOpe
                                AND     monumdocu	= @NumDocu
		        	AND	mocorrela	= @NumCorrela
		        	AND	emrut    	= morutemi
                                AND	incodigo	= mocodigo

                        END
                        
		END
		ELSE BEGIN 	-- LOS PAPELES VENCIDOS HOY NO SE ENCUENTRAN EN LA MDDI 
				-- POR LO CUAL SE VA A BUSCAR EL DEVENGO DE AYER

			SELECT	DISTINCT 
				@Tipo_Instrumento	= rscodigo
			,	@Cartera_Super		= codigo_carterasuper
			,	@Tipo_Emisor		= CASE WHEN emtipo NOT IN (1,2) THEN 0 ELSE emtipo END 
			,	@Origen_Emisor		= (CASE WHEN emrut = '97023000' THEN 1 
								ELSE (CASE	WHEN emtipo <> 2 THEN 0 
										ELSE emtipo END) 
								END )
			,	@Objeto_Cubierto	= ISNULL(CASE	WHEN @EstadoCobertura = 'CBTO'  THEN 1  
									WHEN @EstadoCobertura = 'DCBTO' THEN 2 END,0)
 			FROM	BACTRADERSUDA..MDRS
			,	BACPARAMSUDA..EMISOR
			,	BACTRADERSUDA..MDAC
			WHERE	rsfecha		= acfecproc 
			AND	rsnumdocu	= @NumDocu
			AND	rscorrela	= @NumCorrela
			AND	rsnumoper	= @NumOpe
			AND	emrut		= rsrutemis
			AND	rstipoper	= 'DEV'	
		END

		IF @Tipo_Instrumento = 15 BEGIN -- BONO ////// LA VARIABLE @Tipo_Instrumento SE REUTILIZA MAS ABAJO
--			PRINT 'BONO'
			SELECT	@NA_Tipo_Intrumento	= 'F'
			,	@NA_Tipo_Emisor		= 'F'
			,	@NA_Origen_Emisor	= 'V'

		END
		ELSE IF @Tipo_Instrumento = 20 BEGIN -- LETRA
--			PRINT 'LETRA'
			SELECT	@NA_Tipo_Intrumento	= 'F'
			,	@NA_Tipo_Emisor		= 'V'
			,	@NA_Origen_Emisor	= 'F'
		END
		ELSE BEGIN
--			PRINT 'NI BONO NI LETRA'
			SELECT	@NA_Tipo_Intrumento	= 'F'
			,	@NA_Tipo_Emisor		= 'F'
			,	@NA_Origen_Emisor	= 'V'
		END

		SELECT	@Tipo_Instrumento	= CASE	WHEN @Tipo_Instrumento <> 15 THEN 0 
							ELSE 15 END
	END ELSE 

        IF @IdSistema = 'BEX' 
        BEGIN

		SELECT	@NA_TipoMovimiento	= 'F'
		,	@NA_TipoOperacion	= 'F'
		,	@NA_Tipo_Emisor		= 'F'
		,	@NA_Cubierto		= CASE WHEN @Tipo_movimiento <> 'TMF' THEN 'V' ELSE 'F' END
		,	@NA_Moneda		= 'V'
		,	@NA_Desde_Hasta		= 'V'
		,	@NA_SubCartera		= 'V'
		,	@NA_Contraparte		= 'V'
		,	@NA_Tipo_Intrumento	= 'V'
		,	@NA_Origen_Emisor	= 'V'

		SELECT  @Cartera_Super		= A.codigo_carterasuper
		,	@Tipo_Emisor		= emtipo
		,	@Objeto_Cubierto	= ISNULL(CASE WHEN @EstadoCobertura = 'CBTO'  THEN 1  
							      WHEN @EstadoCobertura = 'DCBTO' THEN 2 
                                                         END,0)
 		FROM	BACBONOSEXTSUDA..TEXT_CTR_INV	A
		,	BACPARAMSUDA..EMISOR		
                WHERE	cpnumdocu	= CASE WHEN @Tipo_Operacion   = 'VCP' THEN @NumOpe ELSE @NumDocu    END
		AND	cpcorrelativo	= CASE WHEN @Tipo_movimiento <> 'VP'  THEN 1       ELSE @NumCorrela END
		AND	emcodigo	= cpcodemi
		AND	emrut		= cprutemi
	END

	DECLARE @CodClas	CHAR(10)
	
	SELECT	TOP 1 @CodClas	= CodigoCartera
	FROM	BACPARAMSUDA..TBL_CLASIFICACION_CARTERA_INSTRUMENTO
	WHERE	id_Sistema		= @IdSistema	
	AND	(@NA_TipoMovimiento	= 'V'	OR Tipo_movimiento	 = @Tipo_movimiento	)
	AND	(@NA_TipoOperacion	= 'V'	OR Tipo_operacion	 = @Tipo_Operacion	)
	AND	(@NA_Tipo_Intrumento	= 'V'	OR TipoInstrumento	 = @Tipo_Instrumento	)
	AND	(@NA_Moneda		= 'V'	OR Moneda		 = @Moneda		)
	AND	(@NA_Tipo_Emisor	= 'V'	OR TipoEmisor		 = @Tipo_Emisor		)
	AND	(@NA_Origen_Emisor	= 'V'	OR OrigenEmision	 = @Origen_Emisor	)
	AND	(@NA_Cubierto		= 'V'	OR ObjetoCubierto	 = @Objeto_Cubierto	)
	AND	(@NA_Contraparte	= 'V'	OR Contraparte		 = @Contraparte		)
	AND	(@NA_Desde_Hasta	= 'V'	OR (Desde		>= @Desde	AND Hasta	<= @Hasta ))
	AND	 CarteraNormativa	= @Cartera_Super
	AND	(@NA_SubCartera		= 'V'	OR SubcarteraNormativa	 = @SubCartera_Super	)


	SET NOCOUNT OFF
	RETURN ISNULL(@CodClas,0)

END


GO
