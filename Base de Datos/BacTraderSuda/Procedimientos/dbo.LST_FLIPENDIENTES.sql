USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[LST_FLIPENDIENTES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LST_FLIPENDIENTES]
AS 
BEGIN
	DECLARE @dFecha		DATETIME;


	SET @dFecha=(SELECT acfecproc FROM MDAC);

	SET NOCOUNT ON;
	
/*	SELECT z.panumoper, SUM(pavpresen) AS pavpresen
	  INTO #testPoral
	  FROM pagos_fli z
	   AND pafecpro = @dfecha 
      GROUP BY z.panumoper;
*/


	SELECT  panumoper			as panumoper
	,	SUM( ROUND(pavpresen*margen,0)) as pavpresen
	  INTO #testPoral
	  FROM ( SELECT panumoper,  
			painstser, 
			SUM(pavpresen) AS pavpresen,  
			(CASE WHEN momtopfe = 0 THEN 1 ELSE momtopfe END) AS Margen 
	  	   FROM pagos_fli pa
		  INNER 
		   JOIN mdmo m
		     ON pa.panumdocu=monumdocu
		    AND pa.panumoper=monumoper
		    AND pa.pacorrela=mocorrela
		  WHERE motipoper='FLI'
		    AND pa.paptipopago='S' 
		    AND pa.pafecpro = @dfecha 
                  GROUP 
                     BY pa.panumoper, pa.painstser, momtopfe) Pagosx
	 GROUP 
	    BY panumoper

	SELECT  monumoper			as Monumoper
	,	SUM( ROUND(movpresen*margen,0)) as MontoFli
  	  INTO #testmov
	  FROM  (SELECT m.monumoper,  
			moinstser, 
			SUM(movpresen) AS movpresen,  
			(CASE WHEN momtopfe = 0 THEN 1 ELSE momtopfe END) AS Margen 
	  	   FROM mdmo m
		  WHERE motipoper='FLI'
                  GROUP 
                     BY m.monumoper, moinstser, momtopfe) Texts 
 	 GROUP 
	    BY monumoper

	
	SELECT monumoper, ISNULL(MontoFli,0) , isnull(pavpresen,0)
	  FROM #testMov
	  LEFT 
	  JOIN #testporal
	    ON monumoper=panumoper
	 INNER		 
	  JOIN (SELECT DISTINCT monumoper as NumOper
		  FROM mdmo
		 INNER
		  JOIN mdvi 
		    ON vinumoper=monumoper
		   AND vinumdocu=monumdocu	
		   AND vicorrela=mocorrela
		 WHERE motipoper='FLI') FLIS
	    ON monumoper=flis.NumOper

END

GO
