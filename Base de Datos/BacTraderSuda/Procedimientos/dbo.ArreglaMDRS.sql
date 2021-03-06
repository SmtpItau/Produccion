USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[ArreglaMDRS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--
 
CREATE PROCEDURE [dbo].[ArreglaMDRS]
AS 

DECLARE  
			@fNominal		FLOAT
		,	@fValComu		FLOAT
		,	@feccal			CHAR(10)
		,	@fReajuste		FLOAT		
		,	@fInteres		FLOAT		
		,	@numdocu		NUMERIC(10,0)
		,	@correla		INT 
		,   @fmt			FLOAT



	DECLARE @iRow	NUMERIC(10,0)
	DECLARE @iTotal	NUMERIC(10,0) 
		SET @iRow	= 1
		SET @iTotal = (SELECT MAX(Registro) FROM dbo.CarteraArreglo); 
	
	WHILE (@iRow <=@iTotal)
	BEGIN

		--> carga de Resgistro 			
		SELECT
				@numdocu		= numdocu	,	 
				@correla		= correla	,
				@fValComu		= capital	,				
				@fNominal		= Nominal	, 
				@feccal			= convert(char(10),DATEADD(DAY,1,convert(DATETIME,fecha,111)),112)	, 
				@feccal			= fecha,
				@fReajuste		= reajuste 	,	
				@fInteres		= interes,
				@fmt			= vp			
		 FROM dbo.CarteraArreglo
		WHERE Registro = @irow
		
		
		
		
		SELECT	@feccal , 
				( rsnominal / @fNominal),
				ROUND(  @fInteres  * ( rsnominal / @fNominal) ,0) , 
				 rsinteres, @fInteres, @fmt,rsvppresen,      rsvppresenx ,@fNominal, rsnominal,*
				  FROM mdrs WHERE rsfecha = @feccal AND rsnumdocu = @numdocu AND rscorrela = @correla AND rstipoper='DEV'
				
		IF @@ROWCOUNT =1 --> Solo un registro				
		BEGIN 
		
			UPDATE mdrs 
			   SET	rsinteres   = @fInteres		, 
					rsreajuste  = @fReajuste	, 
					rsvalcomu   = @fValComu		
			 WHERE rsfecha = @feccal 
			   AND rsnumdocu = @numdocu 
			   AND rscorrela = @correla 
			   AND rstipoper='DEV'
		END
		ELSE BEGIN

			UPDATE mdrs 
			   SET	rsinteres   = ROUND(  @fInteres  * ( rsnominal / @fNominal) ,0) 	, 
					rsreajuste  = ROUND(  @fReajuste * ( rsnominal / @fNominal) ,0) 	, 
					rsvalcomu   = ROUND(  @fValComu  * ( rsnominal / @fNominal) ,0) 	
			 WHERE rsfecha = @feccal 
			   AND rsnumdocu = @numdocu 
			   AND rscorrela = @correla 
			   AND rstipoper='DEV'
			
		END   
		
		SET @iRow = @iRow + 1
				   		
	END 
GO
