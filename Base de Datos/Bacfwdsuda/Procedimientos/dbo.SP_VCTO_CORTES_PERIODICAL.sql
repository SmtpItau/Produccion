USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VCTO_CORTES_PERIODICAL]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VCTO_CORTES_PERIODICAL]
		(	@numero_operacion 	NUMERIC(10,00) 	,
			@dfecha   		DATETIME 	,
			@nmtoinicial  		NUMERIC(21,04) 	,
			@nmoneda  		NUMERIC(03,00) 	,
			@ctipo   		CHAR(01) 	,
			@nvaloruf  		NUMERIC(12,4) 	,
			@nvalorusd  		NUMERIC(12,4)
		)
WITH RECOMPILE
AS
BEGIN 
	SET NOCOUNT ON
	DECLARE @nprecio_dia    		FLOAT  		,
		@ncorrela_actual  		NUMERIC(3) 	,
		@ncorrela_anterior  		NUMERIC(3) 	,
		@nsaldo_acumulado   		NUMERIC(21,00) 	,
		@nprecio_pactado   		FLOAT  		,
		@fecha_corte_actual   		DATETIME 	,
		@fecha_corte_anterior   	DATETIME 	,
		@nmonto_pactado_um  		NUMERIC(21,04) 	,
		@nmonto_dia_um   		NUMERIC(21,04) 	,
		@nmonto_compensado_um   	NUMERIC(21,04) 	,
		@nmonto_compensado_pesos  	NUMERIC(21,00) 	,
		@ndias_corte    		NUMERIC(04,00) 	,
		@ntasa_tab    			NUMERIC(12,04) 	,
		@base    			NUMERIC(10) 	,
		@nfactor    			NUMERIC(12,06) 	,
		@nvalor_anterior_uf   		NUMERIC(21,04) 	,
		@nvalor_anterior_pesos  	NUMERIC(21,00)	,
		@nvalor_uf_siguiente  		NUMERIC(12,04)


	DECLARE @FECHA_ANT DATETIME

	SELECT 	@FECHA_ANT     = acfecante 
	FROM 	MFAC

	SELECT 	@nvalor_uf_siguiente 	= ISNULL(@nvalor_uf_siguiente ,1)

	IF EXISTS(  	SELECT  *
			FROM 	cortes 
			WHERE 	cornumoper = @numero_operacion AND 
				corfecvcto >	@FECHA_ANT     AND  
				CONVERT(CHAR(8),corfecvcto,112)<= CONVERT(CHAR(8),@dfecha,112) )

				--CONVERT(CHAR(8),corfecvcto,112)= CONVERT(CHAR(8),@dfecha,112) )
		BEGIN

			SELECT 	@nprecio_pactado 	= corprecio 		,
				@fecha_corte_actual 	= corfecvcto 		,
				@ncorrela_actual  	= corcorrela		,
				@ntasa_tab		= (cortastab/100)	,
				@base			= corbase
			FROM 	cortes 
			WHERE 	cornumoper = @numero_operacion AND 
				corfecvcto >	@FECHA_ANT     AND  
--				CONVERT(CHAR(8),corfecvcto,112)= CONVERT(CHAR(8),@dfecha,112) 
				CONVERT(CHAR(8),corfecvcto,112)<= CONVERT(CHAR(8),@dfecha,112) 
			------------------------------------------------------
			--Cálculo del Valor Spot del Día
			------------------------------------------------------
--select @nvaloruf 'uf'
			IF @nmoneda = 998 --UF
				EXECUTE Sp_Div @nvalorusd , @nvaloruf , @nprecio_dia OUTPUT 
			ELSE
			    	SELECT @nprecio_dia = @nvalorusd 

			-------------------------------------------------
			--Montos en Unidad Monetaria de la Compensación
			-------------------------------------------------

--select @nmtoinicial * @nprecio_pactado, @nvaloruf
			SELECT @nmonto_pactado_um = @nmtoinicial * @nprecio_pactado
			SELECT @nmonto_dia_um = @nmtoinicial * @nprecio_dia

			IF @ctipo = 'C' BEGIN
				SELECT @nmonto_compensado_um = @nmonto_dia_um - @nmonto_pactado_um
                        END
			ELSE  BEGIN
				SELECT @nmonto_compensado_um = @nmonto_pactado_um - @nmonto_dia_um
                        END

			-----------------------------------------------
			--Monto de la Compensación en PESOS
			-----------------------------------------------


			IF @nmoneda = 998 --UF
				SELECT @nmonto_compensado_pesos = ROUND( @nmonto_compensado_um * @nvaloruf , 0 )
			ELSE
				SELECT @nmonto_compensado_pesos = ROUND( @nmonto_compensado_um , 0 )
  
			IF @ncorrela_actual  > 1
				BEGIN
					SELECT 	@ncorrela_anterior 	= @ncorrela_actual - 1
					SELECT  @fecha_corte_anterior 	= corfecvcto,
						@nsaldo_acumulado 	= corsaldo + cointeresac + correajac
					FROM    cortes
  					WHERE   cornumoper = @numero_operacion AND
						@ncorrela_actual-1 = corcorrela 

				END
--select @fecha_corte_anterior , @fecha_corte_actual, @numero_operacion
			SELECT 	@ndias_corte = DATEDIFF( dd , @fecha_corte_anterior , @fecha_corte_actual )
			EXECUTE sp_div @ntasa_tab , @ndias_corte , @nfactor OUTPUT
			SELECT 	@nvalor_anterior_pesos 	= @nsaldo_acumulado
			EXECUTE sp_div @nvalor_anterior_pesos , @nvaloruf , @nvalor_anterior_uf OUTPUT
			SELECT @nvalor_anterior_uf = ROUND( @nvalor_anterior_uf , 4 )

--			SELECT @nvalor_anterior_uf 	= ISNULL( ROUND( @nsaldo_acumulado * (1 + ( @nfactor / @base ) ) , 4 ) , 0 )
--			SELECT @nvalor_anterior_pesos 	= ISNULL( ROUND( @nvalor_anterior_uf * @nvaloruf , 4 ) ,0 )

--			SELECT 'MEB', @nvalor_anterior_pesos,@nvalor_anterior_uf,@nmonto_compensado_pesos,@nmonto_compensado_pesos-@nvalor_anterior_pesos


 			UPDATE 	cortes 
			SET 	cormontocomp 	= ISNULL( @nmonto_pactado_um , 0 ) 					,
				cormontodia 	= ISNULL( @nmonto_dia_um , 0 )       						,
				corpreciodia 	= ISNULL( @nprecio_dia , 0 )        						,
				correscnv 	= ISNULL( @nmonto_compensado_um , 0)       					,
				corsaldo 	= ISNULL( @nmonto_compensado_pesos , 0 )     					,
				corsaldoAcu 	= ISNULL( ROUND( @nmonto_compensado_pesos - @nvalor_anterior_pesos , 0 ) , 0 ) 	, 
				corsalAcum 	= ISNULL( ROUND( @nmonto_compensado_um - @nvalor_anterior_uf , 4 ) , 0 ) 	,
--				correajac 	= ISNULL( @nvalor_anterior_pesos , 0 )						,
				corresclp 	= ISNULL( @nmonto_compensado_pesos , 0 ) 
			WHERE 	cornumoper 	= @numero_operacion AND 
--				CONVERT(CHAR(8),corfecvcto,112)= CONVERT(CHAR(8),@dfecha,112)
				corfecvcto >	@FECHA_ANT     AND  
				CONVERT(CHAR(8),corfecvcto,112)<= CONVERT(CHAR(8),@dfecha,112) 

		END

	SET NOCOUNT OFF

END  

-- sp_devengamiento '20000620', '20000619', '20000621', '20000630', '20000531', 'NO', 'NO', 15435.79, 15436.81, 15447.1, 533.03, 0, 516.58

-- SELECT * FROM CORTES WHERE CORCORRELA = 2
-- UPDATE CORTES SET correajac = 0 WHERE CORCORRELA = 2

GO
