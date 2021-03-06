USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERES_REAJUSTE_PERIODICAL]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERES_REAJUSTE_PERIODICAL]
		(	@numero_operacion 	NUMERIC(10,00) 	,
			@dfecha   		DATETIME 	,
			@nmoneda  		NUMERIC(03,00) 	,
			@ctipo   		CHAR(01) 	,
			@nvaloruf  		NUMERIC(12,4) 	,
			@nvalorusd  		NUMERIC(12,4) 	,
			@fecha_prox		DATETIME
		)
WITH RECOMPILE
AS
BEGIN 
	SET NOCOUNT ON
	DECLARE @ncorrela_actual  		NUMERIC(3) 	,
		@nsaldo_acumulado   		NUMERIC(21,04) 	,
		@fecha_corte_actual   		DATETIME 	,
		@ndias_corte    		NUMERIC(04,00) 	,
		@ntasa_tab    			NUMERIC(12,04) 	,
		@base    			NUMERIC(10) 	,
		@nfactor    			FLOAT		,
		@nvalor_anterior_uf   		NUMERIC(21,04) 	,
		@nvalor_uf_siguiente  		NUMERIC(12,04)	,
		@intereses			NUMERIC(21,00)	,
		@reajustes			NUMERIC(21,00)

	SELECT  @nvalor_uf_siguiente = a.vmvalor
	FROM	view_valor_moneda	a,
		mfac			b
	WHERE	@fecha_prox 	= a.vmfecha		AND
		b.accodmonuf	= a.vmcodigo

	SELECT 	@nvalor_uf_siguiente 	= @nvaloruf --ISNULL(@nvalor_uf_siguiente ,1)



	IF EXISTS(  	SELECT  *
			FROM 	cortes 
			WHERE 	cornumoper 			=  @numero_operacion AND 
				CONVERT(CHAR(8),corfecvcto,112) < CONVERT(CHAR(8),@dfecha,112) AND
				corestado	= 0 )
		BEGIN
               DECLARE @correla	NUMERIC(10)	,
	                @numero     NUMERIC(10)	,
                        @dfechavcto     DATETIME	,
	                @cont	INT		,
	                @reg	INT

                      SELECT @reg  = 0,
	                     @cont = 0
                    
                        SELECT 	* /* correscnv 		,
				 corfecvcto 		,
				 corcorrela		,
				 (cortastab/100)	,
				 corbase */
                        INTO   #cortes              
			FROM 	cortes
			WHERE 	cornumoper = @numero_operacion 					AND 
				CONVERT(CHAR(8),corfecvcto,112)< CONVERT(CHAR(8),@dfecha,112) 	AND
				corestado	= 0
 
                         SELECT @reg  = COUNT(*)	,
	                        @cont = 1
                         FROM   #cortes 
	
                         WHILE @reg >= @cont
    	                  BEGIN

		               SET ROWCOUNT @cont
			 
		              SELECT	@correla = 0
                    
			      SELECT 	@nsaldo_acumulado 	= correscnv 		,
			         	@fecha_corte_actual 	= corfecvcto 		,
			         	@ncorrela_actual  	= corcorrela		,
				         @ntasa_tab		= (cortastab/100)	,
				         @base			= corbase               
			      FROM 	#cortes   
			      WHERE 	cornumoper = @numero_operacion 					AND 
				      CONVERT(CHAR(8),corfecvcto,112)< CONVERT(CHAR(8),@dfecha,112) 	AND
				      corestado	= 0
                              SET ROWCOUNT 0
-- sp_devengamiento '20031117', '20031114', '20031118', '20031130', '20031031', 'NO', 'NO', 16984.43, 16981.03, 16966.31, 624.61, 626.55, 628.1
                         SELECT @cont = @cont + 1
		
                        SELECT @dfechavcto = ISNULL (corfecvcto, @dfecha)
                        FROM 	cortes   
			WHERE 	cornumoper = @numero_operacion
                          AND   corcorrela = @ncorrela_actual + 1 

			SELECT  @nvalor_anterior_uf = a.vmvalor
			FROM	view_valor_moneda	a,
				mfac			b
			WHERE	@fecha_corte_actual 	= a.vmfecha		AND
				b.accodmonuf		= a.vmcodigo

              		--********************************************************
			--* Calculo de Reajustes  
			--********************************************************  
			SELECT @reajustes 	= ISNULL( ROUND( @nsaldo_acumulado  * ( @nvalor_uf_siguiente - @nvalor_anterior_uf ) , 0 ) ,0 )

			--********************************************************
			--* Calculo de Intereses
			--********************************************************  
                        IF @dfechavcto < @fecha_prox BEGIN
         		   SELECT @ndias_corte = DATEDIFF( dd , @fecha_corte_actual , @dfechavcto )
                        END
                        ELSE BEGIN
                           SELECT @ndias_corte = DATEDIFF( dd , @fecha_corte_actual , @fecha_prox )
                        END   
			EXECUTE sp_div @ntasa_tab , @base , @nfactor OUTPUT
			SELECT @intereses 	= ISNULL( ROUND( @nsaldo_acumulado * @ndias_corte * @nfactor * @nvalor_uf_siguiente , 0 ) , 0 )

--select @ndias_corte ,@fecha_corte_actual , @fecha_prox, @numero_operacion

 			UPDATE 	cortes 
			SET 	correajac 	= @reajustes	,
				cointeresac	= @intereses
			WHERE 	cornumoper 	= @numero_operacion 				AND 
				CONVERT(CHAR(8),corfecvcto,112) < CONVERT(CHAR(8),@dfecha,112)	AND
				corestado	= 0                                             AND
                                corcorrela      = @ncorrela_actual    

                  END

      DROP table #cortes 

		END

	SET NOCOUNT OFF

END  


-- dbo.sp_interes_reajuste_periodical 2332 , '20011025', 998 ,  'V',    16191.6700 ,    712.3500 ,  '20011025' 
-- dbo.sp_interes_reajuste_periodical 2531 , '20000104', 998 ,  'c',    15065.99 ,    527.70 ,  '20000105' 

-- select * from cortes
-- select * from MFCa
-- sp_devengamiento '20000620', '20000619', '20000621', '20000630', '20000531', 'NO', 'NO', 15435.79, 15436.81, 15447.1, 533.03, 0, 516.58



GO
