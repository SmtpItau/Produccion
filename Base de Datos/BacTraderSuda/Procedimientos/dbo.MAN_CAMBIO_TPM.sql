USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[MAN_CAMBIO_TPM]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[MAN_CAMBIO_TPM]( 	@tpm		FLOAT		, 
					@numoper 	NUMERIC(10,0)	,
					@fecfm  	DATETIME 	)
AS 
BEGIN

	DECLARE @fecpro 	DATETIME
	,	@fecini 	DATETIME ;



	SET @fecpro = (SELECT acfecproc FROM mdac);

	SET @fecini = (SELECT MIN(vifecinip) FROM mdvi WHERE vinumoper = @numoper);

	SELECT DISTINCT mofecpro,motaspact
	  FROM mdmh
	 WHERE monumoper =@numoper 
	   AND motipoper='VI'
      ORDER BY mofecpro

	BEGIN TRANSACTION

	UPDATE mdvi
	   SET vivalvenp=ROUND(vivalinip * (((vitaspact/ (vibaspact *100.0))*DATEDIFF(d,vifecinip,vifecvenp)) + 1),0),
               viintacumvi=(ROUND(vivalinip * (((vitaspact/ (vibaspact *100.0))*DATEDIFF(d,vifecinip,vifecvenp)) + 1),0)-ROUND(vivalinip *(((vitaspact/ (vibaspact * 100.0))*DATEDIFF(d,vifecinip,@FECPRO)) + 1),0))
	 WHERE vinumoper =@numoper


	SELECT 	ROUND(vivalinip * (((vitaspact/ (vibaspact *100.0))*DATEDIFF(d,vifecinip,vifecvenp)) + 1),0) AS Valor_Final,
		(ROUND(vivalinip * (((vitaspact/ (vibaspact *100.0))*DATEDIFF(d,vifecinip,vifecvenp)) + 1),0)-ROUND(vivalinip *(((vitaspact/ (vibaspact * 100.0))*DATEDIFF(d,vifecinip,acfecproc)) +1),0))   AS Intacum
	  FROM mdvi
    INNER JOIN mdac ON virutcart=acrutprop
	 WHERE vinumoper =@numoper


	-- Esta sentencia muestra el valor de la tasa del pacto
        -- sentencia se debe cambiar por un UPDATE  para la MDMH

	SELECT motaspact
	  FROM mdmh
	 WHERE monumoper =@numoper 
	   AND motipoper='VI'

	UPDATE mdmh
	   SET motaspact = @TPM
	 WHERE monumoper =@numoper  
	   AND motipoper='VI'

	-- Esta sentencia muestra el nuevo valor final
        -- sentencia se debe cambiar por un UPDATE  para la MDMH

	SELECT 	ROUND(movalinip * (((motaspact/ (mobaspact *100.0))*DATEDIFF(d,mofecinip,mofecvenp)) + 1),0)
	  FROM mdmh
	 WHERE monumoper =@numoper 
	   AND motipoper='VI'

	UPDATE mdmh
	   SET movalvenp = ROUND(movalinip * (((motaspact/ (mobaspact *100.0))*DATEDIFF(d,mofecinip,mofecvenp)) + 1),0)
	 WHERE monumoper =@numoper 
	   AND motipoper='VI'

	UPDATE mdrs
	   SET rstaspact=@tpm
	,      rstasemi=@tpm
	 WHERE RSFECHA BETWEEN @fecini AND @fecpro 
	   AND rsnumoper=@numoper  
	   AND rscartera=115

	SELECT 	rsvalinip,
		ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecprox)) + 1),0) AS rsvppresenx,
		ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecvtop)) + 1),0) AS rsvalvtop1,
		rsvalvtop,
		(ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecprox)) + 1),0) -	rsvalinip) ASIntereses_Acumulados,
		ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecctb)) + 1),0) AS rsvppresen,
		(ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecprox)) + 1),0) -ROUND(rsvalinip *(((rstaspact/ (rsbasemi * 100.0))*DATEDIFF(d,rsfecinip,rsfecctb)) +1),0) ) as Interes_diario,
		CASE WHEN MONTH(rsfecinip)=MONTH(@fecpro)	THEN (ROUND(rsvalinip * (((rstaspact/(rsbasemi * 100.0))*DATEDIFF(d,rsfecinip,@FECFM)) + 1),0)-rsvalinip)
			ELSE (ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecprox)) + 1),0)-rsvalinip) END
	  FROM mdrs
         WHERE rsfecha BETWEEN @fecini AND @fecpro 
	   AND rsnumoper=@numoper 
	   AND rscartera=115

	UPDATE mdrs
	SET	rsvppresenx=ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecprox)) + 1),0),
		rsvalvtop=ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecvtop)) + 1),0),
		rsinteres_acum=(ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecprox)) + 1),0)-rsvalinip),
		rsvppresen=ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecctb)) + 1),0),
		rsinteres=(ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecprox)) + 1),0) -ROUND(rsvalinip *(((rstaspact/ (rsbasemi * 100.0))*DATEDIFF(d,rsfecinip,rsfecctb)) + 1),0)),
		rsintermes=CASE WHEN MONTH(rsfecinip)=MONTH(@fecpro) THEN (ROUND(rsvalinip *(((rstaspact/ (rsbasemi * 100.0))*DATEDIFF(d,rsfecinip,@FECFM)) +1),0) -rsvalinip)
				ELSE (ROUND(rsvalinip * (((rstaspact/ (rsbasemi *100.0))*DATEDIFF(d,rsfecinip,rsfecprox)) + 1),0)-rsvalinip) END
	  FROM mdrs
         WHERE rsfecha BETWEEN @fecini AND @fecpro 
	   AND rsnumoper=@numoper 
           AND rscartera = 115

	COMMIT TRANSACTION

END 
/* man_cambio_TPM 0.5,  74246, '20090731'	
74246
74261
74398 */

-- SELECT distinct vinumoper  FROM MDVI WHERE vinumoper IN (    74440, 74441 , 74444 , 74453 , 74449 , 74454 , 74452 , 74447 , 74446 , 74433 ,74451 , 74448 , 74445 , 74261 , 74246 , 74398 )

GO
