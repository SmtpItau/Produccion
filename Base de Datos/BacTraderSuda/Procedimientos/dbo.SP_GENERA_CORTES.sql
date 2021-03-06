USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_CORTES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GENERA_CORTES]
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @numdocu	NUMERIC(10,0),
		@numoper	NUMERIC(10,0),
		@correla	NUMERIC(05,0),
		@codigo		INTEGER,
		@mascara	CHAR(12),
		@instser	CHAR(12),	
		@nominal	FLOAT,	
		@xnomin		FLOAT,
		@seriado	CHAR(01),
		@ncortes	float,
		@montocorte	FLOAT,
		@rutcart	NUMERIC(10,0), 
		@fecproc	DATETIME


	DELETE FROM mdco  

	DELETE FROM mdcv

	SELECT @rutcart=acrutprop, @fecproc=acfecproc FROM mdac with (nolock)

	DECLARE cursor_cartera	SCROLL CURSOR FOR
	SELECT	cpnumdocu,
		cpcorrela,
		cpmascara,
		cpinstser,
		cpcodigo,
		cpnominal,
		cpseriado
	 FROM mdcp a 
    LEFT JOIN (SELECT  monumdocu , mocorrela, momascara, moinstser, sum(monominal) AS monominal	
		 FROM mdmo 
  	        WHERE motipoper in ('VP','VI')
	 	  AND mocodigo NOT IN (9 ,11,13,14) 
	     GROUP BY monumdocu , mocorrela, momascara, moinstser) b
           ON cpnumdocu=monumdocu
          AND cpcorrela=mocorrela
        WHERE cpnominal+isnull(monominal,0)>0 
	  AND cpcodigo NOT IN (9 ,11,13,14) 
	UNION 
	SELECT	cinumdocu,
		cicorrela,
		cimascara,
		ciinstser,
		cicodigo,
		cinominal,
		ciseriado
	FROM	mdci
	WHERE	cinominal>0
	  AND  cicodigo NOT IN (9 ,11,13,14) 
	  AND  cimascara not in ('ICAP','ICOL')
	ORDER BY cpnumdocu, cpcorrela,cpinstser
   
	OPEN cursor_cartera

	FETCH FIRST FROM cursor_cartera
	INTO	@numdocu,
		@correla,
		@mascara,
		@instser,
		@codigo ,
		@nominal,
		@seriado
  
	WHILE @@fetch_status = 0 
	BEGIN

	     /* ________________________________________________________________________________________________________
		Busco la cantidad del corte por serie 
		========================================================================================================= 
	     	Se debe realizar un tratamiento  distinto para  los  seriados y no  seriados
	        Para los papeles seriados se busca el corte minimo establecido en las series
	        para  los  no  seriados  se  establece  que  el papel es  de  un solo  corte				  
		--------------------------------------------------------------------------------------------------------- */

		IF @seriado = 'S' 
		BEGIN
			SET @montocorte= isnull( (SELECT ISNULL(secorte,1.0) FROM view_serie with(nolock) WHERE semascara=@mascara) , 0 )
			IF @nominal<>0 BEGIN
				SET @montocorte = isnull( CASE @montocorte WHEN 0 THEN (@nominal/10.0) ELSE @montocorte END , 0 )
				SET @ncortes= isnull( (@nominal/@montocorte) , 0 )
			END ELSE BEGIN
				SET @ncortes= isnull( ( CASE @montocorte WHEN 0 THEN 1 ELSE @montocorte  END/10.0),  0 )
			END

		END
		ELSE  
		BEGIN
			SET @montocorte = isnull( @nominal, 0 )
			SET @ncortes=1.0
		END
	     -- **********************************************************************************************************

		IF @montocorte =0 BEGIN
			SET @montocorte = @ncortes 
			SET @ncortes =0
		END

		INSERT INTO 
		MDCO(	corutcart,	
			conumdocu,
			cocorrela,
			comtocort,
			cocantcortd,
			cocantcorto)
		VALUES(
			@rutcart,
			@numdocu,
			@correla,
			@montocorte,
			@ncortes,
			@ncortes )
		
		FETCH NEXT FROM cursor_cartera
		INTO	@numdocu,
			@correla,
			@mascara,
			@instser,
			@codigo,
			@nominal,
			@seriado
	END
     -- _______________________
     -- Fin definicion de Corte
     -- ***********************	
	CLOSE cursor_cartera
	DEALLOCATE cursor_cartera


     /* ****************************************************************************************************************************************
	Reviso tablas de Ventas con Pacto / FLI 
        **************************************************************************************************************************************** */
	DECLARE cursor_ventas	SCROLL CURSOR FOR
	SELECT	vinumdocu,	
		vinumoper,
		vicorrela,
		vimascara,
		viinstser,
		vicodigo,
		vinominal,
		viseriado
	FROM	mdvi with(nolock)
	WHERE	vinominal>0
	  AND   vicodigo NOT IN (9 ,11,13,14) 
     UNION		
	SELECT  monumdocu, 
		monumoper, 
	        mocorrela,
		momascara,
		moinstser,
		mocodigo,
               (monominal-panominal),
		moseriado
	  FROM mdmo a with(nolock) 
    INNER JOIN 	  (SELECT pafecpro, panumdocu, panumoper, pacorrela, SUM(panominal) AS panominal 
		     FROM  pagos_fli with(nolock) 	
		    WHERE  pafecpro=@fecproc	
	 	 GROUP BY pafecpro,panumdocu, panumoper, pacorrela) b
	    ON b.panumdocu=monumdocu 
	   AND b.panumoper=monumoper 
	   AND b.pacorrela=mocorrela
	   AND b.pafecpro=mofecpro
    	 WHERE a.motipoper='FLI'
	   AND (monominal-panominal)>0
	   AND a.mostatreg=''	
     UNION
	SELECT  monumdocu, 
		monumoper, 
	        mocorrela,
		momascara,
		moinstser,
		mocodigo,
                monominal,
		moseriado
	  FROM mdmo a  with(nolock)
  	 WHERE motipoper='VP'
	   AND a.mostatreg=''
           AND mocodigo NOT IN (9 ,11,13,14) 
	ORDER BY vinumdocu, vicorrela, viinstser
   
	OPEN cursor_ventas

	FETCH FIRST FROM cursor_ventas
	INTO	@numdocu,
		@numoper,
		@correla,
		@mascara,
		@instser,
		@codigo ,
		@nominal,
		@seriado
  
	WHILE @@fetch_status = 0 
	BEGIN

	     /* ________________________________________________________________________________________________________
		Busco la cantidad del corte por serie 
		========================================================================================================= 
	     	Se debe realizar un tratamiento  distinto para  los  seriados y no  seriados
	        Para los papeles seriados se busca el corte minimo establecido en las series
	        para  los  no  seriados  se  establece  que  el papel es  de  un solo  corte				  
		--------------------------------------------------------------------------------------------------------- */
		IF @seriado = 'S' 
		BEGIN
			SET @montocorte=(SELECT ISNULL(secorte,1.0) FROM view_serie with(nolock) WHERE semascara=@mascara)
			IF @nominal<>0 BEGIN
				SET @montocorte = CASE @montocorte WHEN 0 THEN (@nominal/10.0) ELSE @montocorte END
				SET @ncortes= (@nominal/@montocorte)
			END ELSE BEGIN
				SET @ncortes= ( CASE @montocorte WHEN 0 THEN 1 ELSE @montocorte  END/10.0)
			END
		END
		ELSE  
		BEGIN
			SET @ncortes=@nominal
			SET @montocorte=1.0
		END
	     -- **********************************************************************************************************
		
		INSERT INTO 
		MDCV(	cvrutcart,
			cvnumdocu,
			cvcorrela,
			cvnumoper,
			cvcantcort,
			cvmtocort,
			cvstatreg,
			cvtipoper)
		VALUES(
			@rutcart,
			@numdocu,
			@correla,
			@numoper,
			@ncortes,
			@montocorte,
			'',
			'')

		UPDATE MDCO 
		SET	cocantcorto= cocantcorto+ @ncortes
		WHERE conumdocu = @numdocu
 	   	  AND cocorrela = @correla
			

		FETCH NEXT FROM cursor_ventas
		INTO	@numdocu,
			@numoper,
			@correla,
			@mascara,
			@instser,
			@codigo ,
			@nominal,
			@seriado
	END
     -- _______________________
     -- Fin definicion de Corte
     -- ***********************	
	CLOSE cursor_ventas
	DEALLOCATE cursor_ventas
	
	SET NOCOUNT OFF

	IF @@NESTLEVEL =1 BEGIN
--		SELECT * FROM mdco 
--		SELECT * FROM mdcv
                SELECT 'OK' 
	END
	ELSE 
		RETURN

END

GO
