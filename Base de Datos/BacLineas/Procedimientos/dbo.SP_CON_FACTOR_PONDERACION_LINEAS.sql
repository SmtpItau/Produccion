USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_FACTOR_PONDERACION_LINEAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_FACTOR_PONDERACION_LINEAS]  (	@Id_Sistema	CHAR(03)
						  ,	@idMoneda	CHAR(08)= ''
                                                  ,     @Tipo           CHAR(1) = ''	-- T = TASAS -- D = DIVISAS
						  ,	@Plazo   	FLOAT   = -1111
						  )
AS
BEGIN

	SET NOCOUNT ON

	IF NOT EXISTS(SELECT 1 FROM BACPARAMSUDA..MONEDA WHERE mnnemo = @idMoneda) AND @idMoneda <> '' BEGIN
		SELECT	'ERR'
		,	-999		,	-999
		,	-999
		,	-999
		,	''
		,	''
		RETURN 999
	END

	IF @idMoneda <> '' BEGIN -- UNA MONEDA EN ESPECIAL

		IF @Tipo = 'T' BEGIN -- TASAS
			SELECT	FPT_Id_Sistema
			,	FPT_Moneda			,	FPT_Plazo
			,	FpT_Factor
			,	(CASE WHEN @IdMoneda = 'BRL' THEN 'BRL' ELSE ISNULL(mnnemo,'') END)
			,	(CASE WHEN @IdMoneda = 'BRL' THEN 'BRL' ELSE ISNULL(mnglosa,'') END)
			FROM	TBL_FACTOR_PONDERACION_TASAS
			,       BACPARAMSUDA..MONEDA                                                              
			WHERE   Fpt_Id_Sistema	= @Id_Sistema
			AND	(Fpt_Plazo	= @Plazo OR @Plazo = -1111)
			AND     MnNemo          = @IdMoneda 
			AND	Fpt_Moneda	= 	CASE WHEN @IdMoneda IN ('CLP','UF','USD') 
								THEN mncodmon
								ELSE 444 
							END
			ORDER
			BY	FPT_Id_Sistema
			,	FPT_Moneda			,	FPT_Plazo
		END
		ELSE IF @Tipo = 'D' BEGIN -- DIVISAS		
					
			SELECT	FPD_Id_Sistema
			,	FPD_Moneda			,	FPD_Plazo
			,	FPD_Factor
			,	(CASE WHEN @IdMoneda = 'BRL' THEN 'BRL' ELSE ISNULL(mnnemo,'') END)
			,	(CASE WHEN @IdMoneda = 'BRL' THEN 'BRL' ELSE ISNULL(mnglosa,'') END)
			FROM	TBL_FACTOR_PONDERACION_DIVISAS
			,       BACPARAMSUDA..MONEDA                                                              
			WHERE   Fpd_Id_Sistema	= @Id_Sistema
			AND	(Fpd_Plazo	= @Plazo OR @Plazo = -1111)
			AND     MnNemo          = @IdMoneda 
			AND	Fpd_Moneda	= 	CASE WHEN @IdMoneda IN ('CLP','EUR','JPY','GBP','CAD','USD')
								THEN mncodmon
								ELSE 444
							END
			ORDER
			BY	FPd_Id_Sistema
			,	FPd_Moneda			,	FPd_Plazo
		END		
	END
	ELSE BEGIN -- TODAS LAS MONEDAS
				
		CREATE TABLE #TEMP_EXCEL
		(	Fpl_Id_Sistema      CHAR(03)     
		,	Fpl_Moneda          NUMERIC(5,0) 
		,	Fpl_Plazo           FLOAT        
		,	Fpl_Factor          FLOAT        
		,	MonNemo             CHAR(8)
		,	MonGlosa            CHAR(75)
		)

		IF @Tipo = 'T' BEGIN		-- TASAS		
						
			INSERT #TEMP_EXCEL
			SELECT	FPT_Id_Sistema
			,	FPT_Moneda			,	FPT_Plazo
			,	FPT_Factor
			,	'MonNemo'	= 'BRL'   
			,	'MonGlosa'	= CHAR(75)
			FROM	TBL_FACTOR_PONDERACION_TASAS
			WHERE	Fpt_Id_Sistema	= @Id_Sistema
			AND	Fpt_Moneda	=  444

			INSERT INTO #TEMP_EXCEL
			SELECT	FPt_Id_Sistema
			,	FPt_Moneda			,	FPt_Plazo
			,	FPt_Factor
			,	(CASE WHEN Fpt_Moneda = 444 THEN 'BRL' ELSE ISNULL(mnnemo,'') END)   AS MonNemo
			,	(CASE WHEN Fpt_Moneda = 444 THEN 'BRL' ELSE ISNULL(mnglosa,'') END)  AS MonGlosa
			FROM	TBL_FACTOR_PONDERACION_TASAS
			,	BACPARAMSUDA..MONEDA
			WHERE	Fpt_Id_Sistema	= @Id_Sistema
			AND	MnNemo		IN ('CLP','UF','USD')
			AND	Fpt_Moneda	=  mncodmon
			ORDER
			BY	Fpt_Moneda
			,	Fpt_Plazo
		END
		ELSE IF @Tipo = 'D' BEGIN	-- DIVISAS
					
			INSERT #TEMP_EXCEL
			SELECT	FPD_Id_Sistema
			,	FPD_Moneda			,	FPD_Plazo
			,	FPD_Factor
			,	'MonNemo'	= 'BRL'   
			,	'MonGlosa'	= CHAR(75)
			FROM	TBL_FACTOR_PONDERACION_DIVISAS
			WHERE	Fpd_Id_Sistema	= @Id_Sistema
			AND	Fpd_Moneda	=  444
							
			INSERT INTO #TEMP_EXCEL
			SELECT	FPD_Id_Sistema
			,	FPD_Moneda			,	FPD_Plazo
			,	FPD_Factor
			,	(CASE WHEN Fpd_Moneda = 444 THEN 'BRL' ELSE ISNULL(mnnemo,'') END)   AS MonNemo
			,	(CASE WHEN Fpd_Moneda = 444 THEN 'BRL' ELSE ISNULL(mnglosa,'') END)  AS MonGlosa
			FROM	TBL_FACTOR_PONDERACION_DIVISAS
			,	BACPARAMSUDA..MONEDA
			WHERE	Fpd_Id_Sistema  =  @Id_Sistema
			AND	MnNemo          IN ('CLP','EUR','JPY','GBP','CAD','USD')
			AND	Fpd_Moneda  =  mncodmon
			ORDER  
			BY	Fpd_Moneda
			,	Fpd_Plazo
		END
         
		SELECT	Fpl_Id_Sistema      
		,	Fpl_Moneda          
		,	Fpl_Plazo           
		,	Fpl_Factor          
		,	MonNemo
		,	MonGlosa            
		FROM   #TEMP_EXCEL
		ORDER  
		BY	MonNemo
		,	Fpl_Plazo
	END
		
	SET NOCOUNT OFF	END
GO
