USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_TRAE_TIR_HISTORICA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_TRAE_TIR_HISTORICA] ( @RENTABILIDAD CHAR(5) = '')
AS BEGIN

SET NOCOUNT ON

	SELECT 	'RUTCAT'      = cprutcart,
		'RUTCLI'      = cprutcli,
		'NOMCLI'      = ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = cprutcli AND cpcodcli = Clcodigo ),''),
		'NUMDOCU'     = cpnumdocu,
		'SERIE'       = cpinstser,
		'CONTRATO'    = ISNULL(numero_contrato,0),
		'TIPOCARTERA' = cptipcart,
		'TIPORENTA'   = ISNULL(tipo_rentabilidad,0),
		'NOMINAL'     = cpnominal,
		'SERIADO'     = cpseriado,
		'CORRELA'     = cpcorrela,
		'RUTEMISOR'   = 0,
		'EMISOR'      = SPACE(50)
	INTO #PASO
        FROM MDCP
	WHERE ((tipo_rentabilidad = @RENTABILIDAD) OR (@RENTABILIDAD = '')) and (cpnominal>0 or EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela))

  UPDATE #PASO SET RUTEMISOR = nsrutemi FROM VIEW_NOSERIE WHERE NUMDOCU = nsnumdocu and CORRELA = nscorrela  and SERIADO='N'
  UPDATE #PASO SET RUTEMISOR = serutemi FROM VIEW_SERIE   WHERE SERIE = seserie and SERIADO='S'  
  UPDATE #PASO SET EMISOR    = emnombre FROM VIEW_EMISOR  WHERE RUTEMISOR = emrut

SET NOCOUNT OFF

  SELECT * FROM #PASO


END


-- Base de Datos --

GO
