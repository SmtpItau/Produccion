USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMatrizAtribuciones_LeeInstrumento]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_BacMatrizAtribuciones_LeeInstrumento] ( @cEstado CHAR(10) )

AS BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy
  
	SELECT DISTINCT
		I.incodigo, 
		I.inserie, 
		I.inglosa, 
		I.inrutemi,
	       	I.inmonemi, 
		I.inbasemi, 
		I.inprog, 
		I.inrefnomi,
	       	I.inmdse, 
		I.inmdtd, 
		I.inmdpr, 
		I.intipfec,
	       	I.intasest, 
		I.intipo, 
		I.inemision, 
		I.ineleg,
	       	I.inlargoms, 
		I.inedw, 
		I.incontab, 
		I.intiporig,
	       	I.intotalemitido, 
		I.insecuritytype, 
		I.insecuritytype2 
		INTO #TEMPORAL
	       FROM INSTRUMENTO I
		WHERE NOT EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO M WHERE M.INCODIGO = I.INCODIGO)


	IF @cEstado <> "N" BEGIN

	INSERT INTO #TEMPORAL
	SELECT DISTINCT
		I.incodigo, 
		I.inserie, 
		I.inglosa, 
		I.inrutemi,
	       	I.inmonemi, 
		I.inbasemi, 
		I.inprog, 
		I.inrefnomi,
	       	I.inmdse, 
		I.inmdtd, 
		I.inmdpr, 
		I.intipfec,
	       	I.intasest, 
		I.intipo, 
		I.inemision, 
		I.ineleg,
	       	I.inlargoms, 
		I.inedw, 
		I.incontab, 
		I.intiporig,
	       	I.intotalemitido, 
		I.insecuritytype, 
		I.insecuritytype2 

	       FROM INSTRUMENTO I
--		WHERE 	AND   M.codigo_control = @cEstado
		WHERE EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO M WHERE M.INCODIGO = I.INCODIGO AND M.CODIGO_CONTROL = @cEstado)

	END

	
SELECT * FROM #TEMPORAL
ORDER BY INCODIGO
   SET NOCOUNT OFF

END






GO
