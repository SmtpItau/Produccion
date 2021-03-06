USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_OPERACIONES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_OPERACIONES]	(	@OP		CHAR(05)	= ''
					,	@desde		CHAR(10)	= '20000101'
					,	@hasta		CHAR(10)	= '20000101'
					,	@usuario	CHAR(15)	= ''
					,	@codigo		FLOAT		= 0
					,	@rut		FLOAT		= 0
					,	@codcli		FLOAT		= 0
					,	@Cat_Libro	CHAR(06) 	= ''
					,	@Id_Libro	CHAR(06)	= ''
					) 
     
AS
BEGIN

-- ******************************
-- TAG MPNG20060301
-- Se descartan de este reporte 
-- las operaciones TM
-- ******************************

SET NOCOUNT ON

DECLARE @ACNOMPROP	CHAR(40)
,	@ACFECPROC	CHAR(10)
,	@ACRUTPROP	NUMERIC (9)
,	@ACDIGPROP	CHAR(1)
,	@Glosa_Libro	CHAR(50)

	SELECT	@ACNOMPROP = acnomprop,
		@ACFECPROC = acfecproc,
		@ACRUTPROP = acrutprop,
		@ACDIGPROP = acdigprop
	FROM	MDAC               

	IF  @id_libro = '' BEGIN
		SELECT @Glosa_libro = '< TODOS >'	
	END 
	ELSE BEGIN
		SELECT	@Glosa_libro	= tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	tbcateg		= @Cat_Libro 
		AND	tbcodigo1	= @Id_Libro
	END
		
	SELECT	morutcli	,
		nombre		= clnombre	, 
		moinstser	,
		Fecha_inicio 	= (CASE	WHEN motipoper IN ('CP','VP','FLI')                      THEN mofecpro
					WHEN motipoper IN ('VI','CI','IB','RC','RV','RCA','RVA') THEN mofecinip END) ,
		Fecha_venc	= (CASE WHEN motipoper IN ('CP','VP','FLI')                      THEN mofecven
					WHEN motipoper IN ('VI','CI','IB','RC','RV','RCA','RVA') THEN mofecvenp END) ,
		momonemi	,
		Monto_inicio	= (CASE WHEN motipoper IN ('CP','VP','FLI')                      THEN movalcomp
					WHEN motipoper IN ('VI','CI','IB','RC','RV','RCA','RVA') THEN movalinip END) ,
		Monto_venc	= (CASE	WHEN motipoper IN ('CP','VP','FLI')                       THEN movalven
					WHEN motipoper IN ('VI','CI','IB','RC','RV','RCA','RVA') THEN movalvenp END) ,
		tipo		= (CASE	WHEN motipoper = 'IB' THEN moinstser else motipoper END),
		mousuario	,
		'DV'		= cldv		,
		'Hora'		= CONVERT(CHAR(10),GETDATE(),108)	,
		mnnemo		,
		monumoper	,
		'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = moid_libro),'No Especificado')	,
		'Glosa_Libro'	= @Glosa_Libro		
	,	MOTIPOPER
	,	'CarteraNorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 1111 AND tbcodigo1 = codigo_carterasuper),'No Especificado')	
	,	mocorrela
	,	monumdocu
	INTO	#Temp
	FROM	MDMH
	,	VIEW_CLIENTE
	,	VIEW_MONEDA
	WHERE	clrut		=  morutcli 
	AND	clcodigo	=  mocodcli
	AND	mofecpro	BETWEEN @desde	AND  @hasta
	AND	(mocodigo	=  @codigo	OR  @codigo	 = 0)
	AND	((morutcli	=  @rut		AND mocodcli	 = @codcli)	OR (@rut = 0 AND @codcli =0))
	AND	((CASE WHEN @op IN ('ICAP', 'ICOL') THEN moinstser ELSE motipoper END) =  @op		OR  @op		 = '') 
	AND	motipOper	<> 'TM' -- TAG MPNG20060301
	AND	(mousuario	=  @usuario	OR  @usuario	 = '')
	AND	mncodmon   	=  momonemi
	AND	(moid_libro	=  @id_libro	OR @id_libro	 = '')
		 
 	SELECT	*
	,	'ENTIDAD'	= @ACNOMPROP 
	,'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	FROM	#Temp
	ORDER
	BY	Fecha_inicio 
	,	monumoper
	,	monumdocu
	,	mocorrela

 SET NOCOUNT OFF
END


GO
