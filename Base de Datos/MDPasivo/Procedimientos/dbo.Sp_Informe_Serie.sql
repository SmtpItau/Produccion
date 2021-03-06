USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Informe_Serie]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Informe_Serie] 
      (   @tdmascara1  CHAR(12)   )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	
       SELECT  --SERIE'=S.serie 
               'MASCARA'	= T.tdmascara
	,      'CUPON'		= T.tdcupon
	,      'FECHAVCTO_T'	= CONVERT(CHAR(10),T.tdfecven,103)
        ,      'INTERES'	= CONVERT(NUMERIC(19,4),T.tdinteres)
 	,      'AMORTIZACION'	= CONVERT(NUMERIC(19,4),T.tdamort)
	,      'FLUJO'		= CONVERT(NUMERIC(19,4),T.tdflujo)
	,      'SALDO'		= CONVERT(NUMERIC(19,4),T.tdsaldo)
        ,      'CODIGO'	        = S.secodigo
	,      'SEMASCARA'	= S.semascara
	,      'SERIE'		= S.seserie
	,      'RUT'		= S.serutemi
	,      'FECHAEMISION'	= convert(char(10),S.sefecemi,103)
	,      'FECHAVCTO_S'	= convert(char(10),S.sefecven,103)
	,      'TASAEMISIÒN'	= S.setasemi
	,      'TERA'		= S.setera
        ,      'MONEDA'  	= (SELECT mnnemo FROM MONEDA WHERE S.semonemi=mncodmon)
	,      'BASE'		= S.sebasemi
	,      'CUPONES'	= S.secupones
	,      'PLAZO'		= S.seplazo
        ,      'NOMBRE'	        = emnombre
        ,      'FECHAPROCESO'	= convert(char(10),M.fecha_proceso,103)
	,      'FAMILIA'	        = I.inserie
	,      'HORA_EMISION'	= CONVERT(CHAR(10),GETDATE(),108)
        ,      'dv_cliente'     = emdv
        ,      'fech_emi'       = CONVERT(CHAR(10),GETDATE(),103)
	INTO	#TABLA_DESAR
        FROM    TABLA_DESARROLLO	T
        ,       SERIE 		 	S
	,	INSTRUMENTO	        I
	,	EMISOR  
        ,       DATOS_GENERALES         M
        WHERE   tdmascara 	= S.seserie
	AND 	S.seserie 	= LTRIM(RTRIM(@tdmascara1))
	AND	S.serutemi 	= emrut
	AND	S.secodigo 	= I.incodigo

       ORDER BY tdcupon


	SELECT * FROM #TABLA_DESAR

SET NOCOUNT OFF
END





GO
