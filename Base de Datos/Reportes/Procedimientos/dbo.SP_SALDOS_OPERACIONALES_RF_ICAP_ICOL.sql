USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_OPERACIONALES_RF_ICAP_ICOL]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_SALDOS_OPERACIONALES_RF_ICAP_ICOL]
(
	@FECHA DATE=NULL,
	@OPCION INT = 0
)
AS
BEGIN
/*
	INTERFAP SALDOS OPERACIONALES RENTA FIJA 
	RSILVA.
*/
SET NOCOUNT ON
SET DATEFORMAT YMD

DECLARE @FECHA_PROC_FILTRO DATE
DECLARE @FECHA_INI_FILTRO	DATE 


IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 ACFECPROC FROM BACTRADERSUDA.DBO.MDAC WITH(NOLOCK))
	SET @FECHA = @FECHA_PROC_FILTRO
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')

DECLARE @FECHA_AUX			DATE
DECLARE @FIN_ESPECIAL		BIT = 'FALSE'
DECLARE @FIN_SEMANA			BIT = 'FALSE'

/********************************************************/
/* VERIFICACION FIN DE MES ESPECIAL Y FECHA				*/
/********************************************************/
--SET @FECHA_PROC_FILTRO = '2017-07-31'

EXEC BACTRADERSUDA.DBO.SP_TRAENEXTHABIL @FECHA_PROC_FILTRO,6,@FECHA_AUX OUTPUT

IF DATEPART(WEEKDAY,@FECHA_PROC_FILTRO) IN (6,1,7) BEGIN
	SET @FIN_SEMANA = 'TRUE'	
END
IF @FIN_SEMANA = 'TRUE' BEGIN
	IF MONTH(@FECHA_PROC_FILTRO)<>MONTH(@FECHA_AUX) BEGIN
		SET @FIN_ESPECIAL = 'TRUE'
	END 
END



IF OBJECT_ID('TEMPDB..##CARTERA_RF_ICOL_TRD') IS NOT NULL BEGIN	
	DROP TABLE ##CARTERA_RF_ICOL_TRD

	IF @OPCION<>0 BEGIN
		PRINT 'BORRANDO ##CARTERA_RF_ICOL_TRD'
	END	
END 


CREATE TABLE ##CARTERA_RF_ICOL_TRD
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
	
/*E*/	serie				varchar(20),
/*F*/	nemo				varchar(10),
/*G*/	rsvppresen			numeric(19,4),
/*H*/	rsfecinip			date,
/*I*/	rstasemi			numeric(19,4),
/*J*/	rsbasemi			numeric(19,4),
/*K*/	ds_corridos		    numeric(19,4) default (0),
/*L*/	interes_acum		numeric(19,4) default (0),
)


/*COLOCACIONES TRADING*/
/* e-j */
INSERT INTO ##CARTERA_RF_ICOL_TRD
SELECT 
MDRS.rsnumoper,					-- ajuste de campos para temporal
MDRS.rsnumdocu,					-- ajuste de campos para temporal
MDRS.rscorrela,					-- ajuste de campos para temporal
MDRS.rstipopero,				-- ajuste de campos para temporal
view_moneda.mncodmon,			-- ajuste de campos para temporal
'ICOL',							-- ajuste de campos para temporal

/*E*/	VIEW_INSTRUMENTO.inserie, 
/*F*/	VIEW_MONEDA.mnnemo, 
/*G*/	MDRS.rsvppresen, 
/*H*/	MDRS.rsfecinip, 
/*I*/	MDRS.rstasemi, 
/*J*/	MDRS.rsbasemi,
/*K*/   datediff(dd,@fecha_aux,MDRS.rsfecinip),
/*L*/	rsvppresen*rstasemi/100/rsbasemi*datediff(dd,@fecha_aux,MDRS.rsfecinip)

FROM bactradersuda.dbo.MDRS MDRS, 
bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO, 
bactradersuda.dbo.VIEW_MONEDA VIEW_MONEDA
WHERE MDRS.rscodigo = VIEW_INSTRUMENTO.incodigo
AND	MDRS.rsmonemi = VIEW_MONEDA.mncodmon
AND	((MDRS.rsfecha=@FECHA_PROC_FILTRO)
AND	(MDRS.rstipoper='dev')
AND	(MDRS.rscartera='121')
AND	(MDRS.codigo_carterasuper='t')
AND	(VIEW_INSTRUMENTO.inserie='icol'))





/* OTRAS COLOCACIONES */
IF OBJECT_ID('TEMPDB..##CARTERA_RF_ICOL') IS NOT NULL BEGIN	
	DROP TABLE ##CARTERA_RF_ICOL
	IF @OPCION<>0 BEGIN
		PRINT 'BORRANDO ##CARTERA_RF_ICOL'
	END
END 


CREATE TABLE ##CARTERA_RF_ICOL
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
	
/*N*/	serie				varchar(20),
/*O*/	nemo				varchar(10),
/*P*/	rsfecinip			date,
/*Q*/	rsvalcomp			numeric(19,4),
/*R*/	rstasemi			numeric(19,4),
/*S*/	rsbasemi			numeric(19,4),
/*T*/	ds_corridos		    numeric(19,4) default (0),
/*U*/	interes_acum		numeric(19,4) default (0),
/*V*/	criterio			varchar(100)
)

/* N-V*/
/*COLOCACION INTERFANCARIAS*/
INSERT INTO ##CARTERA_RF_ICOL
SELECT 
MDRS.rsnumoper,					-- ajuste de campos para temporal
MDRS.rsnumdocu,					-- ajuste de campos para temporal
MDRS.rscorrela,					-- ajuste de campos para temporal
MDRS.rstipopero,				-- ajuste de campos para temporal
view_moneda.mncodmon,			-- ajuste de campos para temporal
'ICOL',							-- ajuste de campos para temporal

/*N*/	 VIEW_INSTRUMENTO.inserie
/*O*/	,VIEW_MONEDA.mnnemo
/*P*/	,MDRS.rsfecinip
/*Q*/	,MDRS.rsvalcomp
/*R*/	,MDRS.rstasemi
/*S*/	,MDRS.rsbasemi
/*T*/	,datediff(dd,@fecha_aux,MDRS.rsfecinip)
/*U*/	,rsvalcomp*rstasemi/100/rsbasemi*datediff(dd,@fecha_aux,MDRS.rsfecinip)
/*V*/	,ltrim(rtrim(inserie))+ltrim(rtrim(mnnemo))
FROM 
bactradersuda.dbo.MDRS MDRS
,	bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO
,	bactradersuda.dbo.VIEW_MONEDA VIEW_MONEDA
WHERE MDRS.rscodigo = VIEW_INSTRUMENTO.incodigo
AND	MDRS.rsmonemi = VIEW_MONEDA.mncodmon
AND	((MDRS.rsfecha=@FECHA_PROC_FILTRO)
AND	(MDRS.rstipoper='dev')
AND	(MDRS.rscartera='121')
AND	(MDRS.codigo_carterasuper='p')
AND	(VIEW_INSTRUMENTO.inserie='icol'))


/* CAPTACIONES INTERBANCARIAS BANCO ESTADO. */
IF OBJECT_ID('TEMPDB..##CARTERA_RF_ICAP_BE') IS NOT NULL BEGIN	
	DROP TABLE ##CARTERA_RF_ICAP_BE
	IF @OPCION<>0 BEGIN
		PRINT 'BORRANDO ##CARTERA_RF_ICAP_BE'
	END
END 


CREATE TABLE ##CARTERA_RF_ICAP_BE
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
	
/*X*/	serie				varchar(20),
/*Y*/	nemo				varchar(5),
/*Z*/	rsvalcomp			numeric(19,4),
/*AA*/	rsvppresen			numeric(19,4),
/*AB*/	rsfecinip			date,
/*AC*/	rstasemi			numeric(19,4),
/*AD*/	rsbasemi			numeric(19,4),
/*AE*/	ds_corridos		    numeric(19,4) default (0),
/*AF*/	interes_acum		numeric(19,4) default (0),
/*AG*/	criterio			varchar(100)
)

/*X-AD*/
INSERT INTO ##CARTERA_RF_ICAP_BE
SELECT 
		MDRS.rsnumoper,					-- ajuste de campos para temporal
		MDRS.rsnumdocu,					-- ajuste de campos para temporal
		MDRS.rscorrela,					-- ajuste de campos para temporal
		MDRS.rstipopero,				-- ajuste de campos para temporal
		view_moneda.mncodmon,			-- ajuste de campos para temporal
		'ICAP',							-- ajuste de campos para temporal
/*X*/	VIEW_INSTRUMENTO.inserie, 
/*Y*/	VIEW_MONEDA.mnnemo, 
/*Z*/	MDRS.rsvalcomp, 
/*AA*/	MDRS.rsvppresen, 
/*AB*/	MDRS.rsfecinip, 
/*AC*/	MDRS.rstasemi, 
/*AD*/	MDRS.rsbasemi,
/*AE*/	datediff(dd,@fecha_aux,MDRS.rsfecinip),
/*AF*/	rsvalcomp*rstasemi/100/rsbasemi*datediff(dd,@fecha_aux,MDRS.rsfecinip),
/*AG*/	ltrim(rtrim(inserie))+ltrim(rtrim(mnnemo))
FROM bactradersuda.dbo.MDRS MDRS, 
bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO, 
bactradersuda.dbo.VIEW_MONEDA VIEW_MONEDA
WHERE MDRS.RSCODIGO = VIEW_INSTRUMENTO.INCODIGO
AND	MDRS.RSMONEMI = VIEW_MONEDA.MNCODMON
AND	((MDRS.RSFECHA=@FECHA_PROC_FILTRO)
AND	(MDRS.RSTIPOPER='DEV')
AND	(MDRS.RSCARTERA='121')
AND	(VIEW_INSTRUMENTO.INSERIE='ICAP')
AND	(MDRS.RSRUTCLI=97030000))






/*CAPTACIONES INTERBANCARIAS OTROS BANCOS.*/

IF OBJECT_ID('TEMPDB..##CARTERA_RF_ICAP') IS NOT NULL BEGIN	
	DROP TABLE ##CARTERA_RF_ICAP
		IF @OPCION<>0 BEGIN
		PRINT 'BORRANDO ##CARTERA_RF_ICAP'
	END
END 


CREATE TABLE ##CARTERA_RF_ICAP
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
	
/*AI*/	serie				varchar(20),
/*AJ*/	nemo				varchar(5),
/*AK*/	rsfecinip			date,

/*AL*/	rsvalcomp			numeric(19,4),
/*AM*/	rsvppresen			numeric(19,4),
/*AN*/	rstir				numeric(19,4),

/*AO*/	rsbasemi			numeric(19,4),
/*AP*/	rsreajuste_acumcp	numeric(19,4),
/*AQ*/	ds_corridos		    numeric(19,4) default (0),

/*AR*/	ints				numeric(19,4) default (0),
/*AS*/	criteriop			varchar(100),
/*AT*/	criterio2			varchar(100)
)


/* CAPTACIONES INTERBANCARIAS AI-AP*/
INSERT INTO ##CARTERA_RF_ICAP
SELECT 
		MDRS.rsnumoper,					-- ajuste de campos para temporal
		MDRS.rsnumdocu,					-- ajuste de campos para temporal
		MDRS.rscorrela,					-- ajuste de campos para temporal
		MDRS.rstipopero,				-- ajuste de campos para temporal
		view_moneda.mncodmon,			-- ajuste de campos para temporal
		'ICAP',							-- ajuste de campos para temporal

/*AI*/	VIEW_INSTRUMENTO.inserie, 
/*AJ*/	VIEW_MONEDA.mnnemo, 
/*AK*/	MDRS.rsfecinip, 

/*AL*/	MDRS.rsvalcomp, 
/*AM*/	MDRS.rsvppresen, 
/*AN*/	MDRS.rstir, 

/*AO*/	MDRS.rsbasemi, 
/*AP*/	MDRS.rsreajuste_acumcp,
/*AQ*/	datediff(dd,@fecha_aux,MDRS.rsfecinip),

/*AR*/	rsvalcomp*rstir/100/rsbasemi*datediff(dd,@fecha_aux,MDRS.rsfecinip),
/*AS*/	ltrim(rtrim(inserie))+ltrim(rtrim(mnnemo)),
/*AT*/  (case 
			when mnnemo<>'CLP' then inserie+'MX'
			else '-'
		 end)
FROM bactradersuda.dbo.MDRS MDRS, 
bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO, 
bactradersuda.dbo.VIEW_MONEDA VIEW_MONEDA
WHERE MDRS.rscodigo = VIEW_INSTRUMENTO.incodigo
AND	MDRS.rsmonemi = VIEW_MONEDA.mncodmon
AND	((MDRS.rsfecha=@FECHA_PROC_FILTRO)
AND	(MDRS.rstipoper='dev')
AND	(VIEW_INSTRUMENTO.inserie='icap')
AND	(MDRS.rsrutcli<>97030000))
ORDER BY VIEW_MONEDA.mnnemo





/* REDESCUENTO BANCO CENTRAL	AV-BB */
IF OBJECT_ID('TEMPDB..##CARTERA_RF_RDBCCH') IS NOT NULL BEGIN	
	DROP TABLE ##CARTERA_RF_RDBCCH
	IF @OPCION<>0 BEGIN
		PRINT 'BORRANDO ##CARTERA_RF_RDBCCH'
	END
END 

CREATE TABLE ##CARTERA_RF_RDBCCH
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
	
/*AV*/	serie				varchar(20),
/*AW*/	nemo				varchar(5),
/*AX*/	rsvalcomp			numeric(19,4),
/*AY*/	rsinteres			numeric(19,4),
/*AZ*/	rsinteres_acum		numeric(19,4),
/*BA*/	rsreajuste			numeric(19,4),
/*BB*/	rsreajuste_acum		numeric(19,4)

)

INSERT INTO ##CARTERA_RF_RDBCCH
SELECT 
		MDRS.rsnumoper,					-- ajuste de campos para temporal
		MDRS.rsnumdocu,					-- ajuste de campos para temporal
		MDRS.rscorrela,					-- ajuste de campos para temporal
		MDRS.rstipopero,				-- ajuste de campos para temporal
		view_moneda.mncodmon,			-- ajuste de campos para temporal
		'ICOL',							-- ajuste de campos para temporal
/*AV*/	VIEW_INSTRUMENTO.INSERIE, 
/*AW*/	VIEW_MONEDA.MNNEMO, 
/*AX*/	MDRS.RSVALCOMP, 
/*AY*/	MDRS.RSINTERES, 
/*AZ*/	MDRS.RSINTERES_ACUM, 
/*BA*/	MDRS.RSREAJUSTE, 
/*BB*/	MDRS.RSREAJUSTE_ACUM
FROM BACTRADERSUDA.DBO.MDRS MDRS, 
BACTRADERSUDA.DBO.VIEW_INSTRUMENTO VIEW_INSTRUMENTO, 
BACTRADERSUDA.DBO.VIEW_MONEDA VIEW_MONEDA
WHERE MDRS.RSCODIGO = VIEW_INSTRUMENTO.INCODIGO
AND	MDRS.RSMONEMI = VIEW_MONEDA.MNCODMON
AND	((MDRS.RSFECHA=@FECHA_PROC_FILTRO)
AND	(MDRS.RSTIPOPER='DEV')
AND	(MDRS.RSCARTERA='130')
AND	(MDRS.CODIGO_CARTERASUPER='P')
AND	(VIEW_INSTRUMENTO.INSERIE='ICOL'))



IF @OPCION<>0 BEGIN	
	SELECT CONCEPTO = 'ICOL TRADING', * FROM ##CARTERA_RF_ICOL_TRD
	SELECT CONCEPTO = 'ICOL OTROS', * FROM ##CARTERA_RF_ICOL
	SELECT CONCEPTO = 'ICAP BANCO ESTADO', * FROM ##CARTERA_RF_ICAP_BE
	SELECT CONCEPTO = 'ICAP OTROS', * FROM ##CARTERA_RF_ICAP
	SELECT CONCEPTO = 'ICOL REDESCUENTO BANCO CENTRAL', * from ##CARTERA_RF_RDBCCH
END
END 
GO
