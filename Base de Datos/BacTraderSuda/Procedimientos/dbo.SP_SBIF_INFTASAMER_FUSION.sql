USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_INFTASAMER_FUSION]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_INFTASAMER_FUSION] 
(
	@dFecProc CHAR(10)
)
AS
BEGIN

	DECLARE	@UF_HOY  	FLOAT, 
			@IVP_HOY 	FLOAT, 
			@DO_HOY  	FLOAT, 
			@DA_HOY  	FLOAT,
			@tc_rep_cnt CHAR(01),
			@DO_TC  	FLOAT

	SELECT @UF_HOY  = ISNULL(vmvalor, 0.0000) FROM VIEW_VALOR_MONEDA, mdac WHERE vmfecha  = acfecproc AND vmcodigo = 998
	SELECT @IVP_HOY = ISNULL(vmvalor, 0.0000) FROM VIEW_VALOR_MONEDA, mdac WHERE vmfecha  = acfecproc AND vmcodigo = 997
	SELECT @DO_HOY  = ISNULL(vmvalor, 0.0000) FROM VIEW_VALOR_MONEDA, mdac WHERE vmfecha  = acfecproc AND vmcodigo = 994
	SELECT @DA_HOY  = ISNULL(vmvalor, 0.0000) FROM VIEW_VALOR_MONEDA, mdac WHERE vmfecha  = acfecproc AND vmcodigo = 995
	SELECT @DO_TC   = ISNULL(Tipo_Cambio,0)  FROM BacParamSuda..VALOR_MONEDA_CONTABLE,MDAC WHERE Codigo_Moneda = 994 AND Fecha = ACFECPROC
	--SELECT @DO_TC = ISNULL(vmvalor_tcrc,0)  FROM VIEW_VALOR_MONEDA,MDAC	 WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROC /*Dolar T/C Rep. Contable */
	SELECT @DO_TC	= ISNULL(@DO_TC,0)
	
	IF @DO_TC=0 
	BEGIN
		SELECT @tc_rep_cnt = 'N'   /* SE OCUPA T/C OBS */
	END 
	ELSE 
	BEGIN
		SELECT @tc_rep_cnt = 'S'   /* SE OCUPA T/C REP CONTABLE */
	END

	IF EXISTS(SELECT * FROM tasa_mercado WHERE fecha_proceso = CONVERT(DATETIME,@dFecProc)) 
	BEGIN
		SELECT 
			'fecha_proceso'		= Convert(CHAR(10),fecha_proceso,103),
       		'Hora'				= CONVERT(CHAR(10),GETDATE(),108),
      		 tminstser,			  
      		'Emisor'			= (SELECT top 1 emnombre FROM view_Emisor WHERE emgeneric = tmgenemis),
       		'Moneda'			= Isnull((SELECT mnnemo FROM View_moneda WHERE mncodmon = tmmonemis),''),
       		'tmfecvcto'			= convert(CHAR(10),tmfecvcto,103),
       		'Factor'			= 0,
       		tasa_mercado,
       		'NomProp'			= acnomprop,
       		'RutProp'			= Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
       		'UF'				= @uf_hoy,
       		'IVP'				= @IVP_HOY,
      		'DOLAR_OBS'			= @DO_HOY,
       		'DOLAR_ACU'			= @DA_HOY,
			ID_NIVEL_DE_RIESGO	= 0 --> NULL 

		--tasa_mercado.tmrutemis

	   FROM	 tasa_mercado, mdac
	   WHERE fecha_proceso = CONVERT(DATETIME,@dFecProc)

	END
	ELSE 
	BEGIN

		SELECT 
			'fecha_proceso'		= Convert(CHAR(10),acfecproc,103),
       		'Hora'				= CONVERT(CHAR(10),GETDATE(),108),
        	tminstser			= convert(char(12),' '),
       		'Emisor'			= convert(char(40),' '),
       		'Moneda'			= convert(char(8),' '),
       		tmfecvcto			= CONVERT(CHAR(10),CONVERT(DATETIME,'19000101'), 103),
       		'Factor'			= 0 ,
       		tasa_mercado		= convert(numeric(8,4),0),
       		'NomProp'			= acnomprop,
       		'RutProp'			= Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
       		'UF'				= @uf_hoy,
       		'IVP'				= @IVP_HOY,
       		'DOLAR_OBS'			= @DO_HOY,
       		'DOLAR_ACU'			= @DA_HOY,
			ID_NIVEL_DE_RIESGO	= 0 --> NULL

	   FROM mdac


	END
END




-- Base de Datos --
GO
