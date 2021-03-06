USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_INTERPOLACION_PONDERACIONES]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_INTERPOLACION_PONDERACIONES]	(   @Moneda   NUMERIC(6,0)
							,   @Plazo    FLOAT
							,   @Tipo     CHAR(1)
							,   @iFactor  FLOAT   OUTPUT
							)
AS 
BEGIN

	DECLARE @bInterpolacion  CHAR(1)
	,	@iPuntoMenor     FLOAT
	,	@iValorMenor     FLOAT
	,	@iPuntoMayor     FLOAT
	,	@iValorMayor     FLOAT
	,	@iDifPlazo       FLOAT

	SET NOCOUNT ON

        --> Def. última hora: Extrapolación inferior y superior envairá el valor y del punto extremo
        --                    esto para evitar posibles exentricidades de los valores en el extremo

	-->     (9.1) Determina Si Debe Interpolar o No
	SET     @bInterpolacion  = 'S'
	SET     @iFactor           = 0.0
		
	IF @Tipo = 'T' BEGIN
		SELECT @iFactor		= Fpt_Factor
		,      @bInterpolacion	= 'N'
		FROM   TBL_FACTOR_PONDERACION_TASAS
		WHERE  Fpt_Id_Sistema   = 'PCS'
		AND    Fpt_Moneda       = @Moneda
		AND    Fpt_Plazo        = @Plazo
	END
	ELSE IF @Tipo = 'D' BEGIN

		SELECT @iFactor		= Fpd_Factor
		,      @bInterpolacion	= 'N'
		FROM   TBL_FACTOR_PONDERACION_DIVISAS
		WHERE  Fpd_Id_Sistema   = 'PCS'
		AND    Fpd_Moneda       = @Moneda
		AND    Fpd_Plazo        = @Plazo
	END
	   -->  Se Debe Interpolar
	IF @bInterpolacion = 'S' BEGIN--> PROCESO DE INTERPOLACIÓN :
	-->     Lee el Punto Inmediatamente Anteriro al Plazo Informado (a)
                select @iPuntoMayor = null
                select @iPuntoMenor = null
		IF @Tipo = 'T' BEGIN
			SELECT  @iPuntoMenor    = CONVERT(FLOAT,MAX(Fpt_Plazo)) --ISNULL(CONVERT(FLOAT,MAX(Fpt_Plazo)),0)
			FROM    TBL_FACTOR_PONDERACION_TASAS
			WHERE   Fpt_Id_Sistema   = 'PCS'
			AND     Fpt_Moneda       = @Moneda
			AND     Fpt_Plazo        < @Plazo
				
			-->     Lee el Punto Inmediatamente Posterior al Plazo Informado (b)
			SELECT  @iPuntoMayor    = CONVERT(FLOAT,MIN(Fpt_Plazo)) --ISNULL(CONVERT(FLOAT,MIN(Fpt_Plazo)),0)
			FROM    TBL_FACTOR_PONDERACION_TASAS
			WHERE   Fpt_Id_Sistema   = 'PCS'
			AND     Fpt_Moneda       = @Moneda
			AND     Fpt_Plazo        > @Plazo
		END
		ELSE BEGIN
			SELECT  @iPuntoMenor    = CONVERT(FLOAT,MAX(Fpd_Plazo))
			FROM    TBL_FACTOR_PONDERACION_DIVISAS
			WHERE   Fpd_Id_Sistema   = 'PCS'
			AND     Fpd_Moneda       = @Moneda
			AND     Fpd_Plazo        < @Plazo

			-->     Lee el Punto Inmediatamente Posterior al Plazo Informado (b)
			SELECT  @iPuntoMayor    = CONVERT(FLOAT,MIN(Fpd_Plazo))
			FROM    TBL_FACTOR_PONDERACION_DIVISAS
			WHERE   Fpd_Id_Sistema   = 'PCS'
			AND     Fpd_Moneda       = @Moneda
			AND     Fpd_Plazo        > @Plazo
						
		END	
			
		IF @iPuntoMenor IS NULL BEGIN
			IF @Tipo = 'T' BEGIN	
				SELECT	@iPuntoMenor    = CONVERT(FLOAT,MIN(Fpt_Plazo))
				FROM    TBL_FACTOR_PONDERACION_TASAS
				WHERE   Fpt_Id_Sistema   = 'PCS'
				AND     Fpt_Moneda       = @Moneda

                                IF NOT @iPuntoMenor IS NULL BEGIN
           			        SELECT  @iFactor    = ISNULL(Fpt_Factor,0)
                			FROM TBL_FACTOR_PONDERACION_TASAS
	                		WHERE   Fpt_Id_Sistema   = 'PCS'
		                	AND     Fpt_Moneda       = @Moneda
			                AND     Fpt_Plazo        = @iPuntoMenor
						
                                        RETURN
                                END
			END
			ELSE BEGIN                                	
				SELECT	@iPuntoMenor    = CONVERT(FLOAT,MIN(Fpd_Plazo))
				FROM    TBL_FACTOR_PONDERACION_DIVISAS
				WHERE   Fpd_Id_Sistema   = 'PCS'
				AND     Fpd_Moneda       = @Moneda

                                IF NOT @iPuntoMenor IS NULL BEGIN
           			        SELECT  @iFactor    = ISNULL(Fpd_Factor,0)
                			FROM TBL_FACTOR_PONDERACION_DIVISAS   
	                		WHERE   Fpd_Id_Sistema   = 'PCS'
		                	AND     Fpd_Moneda       = @Moneda
			                AND     Fpd_Plazo        = @iPuntoMenor
					
                                        RETURN
                                END
			END		
		END				
		IF @iPuntoMayor	IS NULL BEGIN                        
			IF @Tipo = 'T' BEGIN                              
				SELECT @iPuntoMayor    = CONVERT(FLOAT,MAX(Fpt_Plazo))
				FROM   TBL_FACTOR_PONDERACION_TASAS
				WHERE   Fpt_Id_Sistema   = 'PCS'
				AND     Fpt_Moneda       = @Moneda

                                IF NOT @iPuntoMayor IS NULL BEGIN
           			        SELECT  @iFactor    = ISNULL(Fpt_Factor,0)
                			FROM TBL_FACTOR_PONDERACION_TASAS
	                		WHERE   Fpt_Id_Sistema   = 'PCS'
		                	AND     Fpt_Moneda       = @Moneda
			                AND     Fpt_Plazo        = @iPuntoMayor
							
                                        RETURN
                                 END
			END
			ELSE BEGIN
				SELECT	@iPuntoMayor    = CONVERT(FLOAT,MAX(Fpd_Plazo))
				FROM    TBL_FACTOR_PONDERACION_DIVISAS
				WHERE   Fpd_Id_Sistema   = 'PCS'
				AND     Fpd_Moneda       = @Moneda

                                IF NOT  @iPuntoMayor IS NULL BEGIN
        			        SELECT  @iFactor    = ISNULL(Fpd_Factor,0)
                			FROM TBL_FACTOR_PONDERACION_DIVISAS
	                		WHERE   Fpd_Id_Sistema   = 'PCS'
		                	AND     Fpd_Moneda       = @Moneda
			                AND     Fpd_Plazo        = @iPuntoMayor
                                		
				        RETURN
                                END
			END
		END
								
		IF @Tipo = 'T' BEGIN
			-->     Lee el Valor al Punto Encontrado (a)
			SELECT  @iValorMenor    = ISNULL(Fpt_Factor,0)
			FROM TBL_FACTOR_PONDERACION_TASAS
			WHERE   Fpt_Id_Sistema   = 'PCS'
			AND     Fpt_Moneda       = @Moneda
			AND     Fpt_Plazo        = @iPuntoMenor
				
			-->     Lee el Valor al Punto Encontrado (b)
			SELECT  @iValorMayor    = ISNULL(Fpt_Factor,0)
			FROM    TBL_FACTOR_PONDERACION_TASAS
			WHERE   Fpt_Id_Sistema   = 'PCS'
			AND     Fpt_Moneda       = @Moneda
			AND     Fpt_Plazo        = @iPuntoMayor
		END
		ELSE BEGIN
			-->     Lee el Valor al Punto Encontrado (a)
			SELECT  @iValorMenor    = ISNULL(Fpd_Factor,0)
			FROM    TBL_FACTOR_PONDERACION_DIVISAS
			WHERE   Fpd_Id_Sistema   = 'PCS'
			AND     Fpd_Moneda       = @Moneda
			AND     Fpd_Plazo        = @iPuntoMenor
				
			-->     Lee el Valor al Punto Encontrado (b)
			SELECT  @iValorMayor    = ISNULL(Fpd_Factor,0)
			FROM    TBL_FACTOR_PONDERACION_DIVISAS
			WHERE   Fpd_Id_Sistema   = 'PCS'
			AND     Fpd_Moneda       = @Moneda
			AND     Fpd_Plazo        = @iPuntoMayor
		END
		
		--> Interpolación
		SET     @iDifPlazo       = (@iPuntoMayor - @iPuntoMenor)

                IF  NOT ( @iPuntoMenor IS NULL OR   -- MAP 20080703
                          @iPuntoMayor IS NULL OR
                          @iValorMenor IS NULL OR
                          @iValorMayor IS NULL   )   and     @iPuntoMenor <>  @iPuntoMayor      
 
        		EXEC SP_INTERPOLACION_LINEAL	@iPuntoMenor
						,	@iPuntoMayor
						,	@iValorMenor
						,	@iValorMayor
						,	@Plazo
						,	@iFactor   OUTPUT
                ELSE   
                        SELECT  @iFactor = 0 
	END
END
GO
