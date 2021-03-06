USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_CORTES]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_TRAE_CORTES]
AS BEGIN

	SET NOCOUNT ON
	DECLARE @FECHA_PROCESO DATETIME
	DECLARE @FECHA_ANT DATETIME

	SELECT 	@FECHA_PROCESO = acfecproc ,
		@FECHA_ANT     = acfecante 
	FROM 	MFAC
 
	SELECT  TnumOper    = cornumoper,
		TNombre     = ISNULL((SELECT clNombre FROM VIEW_CLIENTE WHERE clrut = (SELECT cacodigo FROM MFCA where canumoper = cornumoper ) ),''),
		TCliente    = UPPER((SELECT acnomprop FROM MFAC)),
		TcorFecIco  = ISNULL((CASE WHEN CORCORRELA = 1 	
					   THEN (SELECT	cafecha 
						 FROM 	mfca 
						 WHERE 	canumoper = cornumoper ) 
					   ELSE (SELECT b.corfecvcto 
						 FROM 	cortes b 
						 WHERE 	b.corcorrela = a.corcorrela - 1 and 
							a.cornumoper = b.cornumoper)  
					END),''),
		TCorFecVen  = corfecvcto,
		TCorFecProc = (SELECT acfecproc FROM MFAC),
		TObserv     = ( SELECT b.vmvalor FROM mfac a, view_valor_moneda b, view_valor_moneda c WHERE  b.vmfecha = a.acfecproc AND b.vmcodigo = a.accodmondolobs AND c.vmfecha  = a.acfecproc AND c.vmcodigo = a.accodmondolobs),
		TValUf      = ( SELECT c.vmvalor FROM mfac a, view_valor_moneda b, view_valor_moneda c WHERE  b.vmfecha = a.acfecproc AND b.vmcodigo = a.accodmondolobs AND c.vmfecha  = a.acfecproc AND c.vmcodigo = a.accodmonuf),
		TValPe      = corresclp,
		TValUfe     = correscnv,
		TUFFin      = cormontocomp,
		TUfRes      = corsalAcum,
		TSaldo1     = corsaldoAcu,
		TSaldo      = corsalAcum,
		TUtili      = (CASE WHEN cormontocomp <> 0 THEN 1 ELSE 0 END),
		TFecIni     = ISNULL((SELECT cafecha FROM MFCA WHERE canumoper = cornumoper ),0),
		TTipOpe     = ISNULL((SELECT catipoper FROM MFCA WHERE canumoper = cornumoper ),0),
		TMonTotUs   = ISNULL((SELECT camtomon1 FROM MFCA WHERE canumoper = cornumoper ),0),
		TCompAnt    = ISNULL((CASE WHEN corcorrela > 1 	
					   THEN (SELECT b.corresclp + b.cointeresac + b.correajac
						 FROM 	cortes b 
						 WHERE 	b.corcorrela = a.corcorrela - 1 and 
							a.cornumoper = b.cornumoper)  
					   ELSE 0
					END),0)
	FROM  	CORTES a
--	WHERE 	corfecvcto = @FECHA_PROCESO AND  
	WHERE 	corfecvcto > @FECHA_ANT AND
		corfecvcto <= @FECHA_PROCESO AND  
		cornumoper <>0

	SET NOCOUNT OFF

END

-- SELECT * FROM CORTES WHERE 	corfecvcto > @FECHA_ANT AND  corfecvcto <= '20031117' AND  cornumoper <>0
-- 

GO
