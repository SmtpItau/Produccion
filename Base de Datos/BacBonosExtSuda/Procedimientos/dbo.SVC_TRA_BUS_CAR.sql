USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_TRA_BUS_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_TRA_BUS_CAR]
AS
BEGIN
	IF EXISTS(SELECT * FROM TEXT_CTR_INV WHERE TIPO_INVERSION = 1) BEGIN
		SELECT 	c.CPNUMDOCU	,	--1
			B.NOM_FAMILIA  	,	--2
			c.ID_INSTRUM	,	--3
			c.CPFECVEN	,	--4
			c.CPNOMINAL	,	--5
			c.CPTIRCOMP	,	--6
			c.cppvpcomp	,
			c.cpvalcomu	,
			a.rstirmerc	,
			a.rspvpmerc	,
			a.rsvalmerc	,
			'CODIGO CARTERA'= v.nombre_carterasuper,
			a.rscartera
		FROM 	TEXT_CTR_INV c, text_fml_inm B, text_rsu a, text_arc_ctl_dri
			,VIEW_CATEGORIA_CARTERASUPER v
		WHERE 	a.rscartera = '333'
		and	c.cpnumdocu = a.rsnumdocu
		and	c.COD_FAMILIA = B.COD_FAMILIA
		AND	SUBSTRING(c.codigo_carterasuper,1,1)  = 'N'
		and     SUBSTRING(v.nombre_carterasuper,1,1)   = SUBSTRING(c.codigo_carterasuper,1,1)  
		and	a.rsfecpro = acfecproc

	END
	ELSE BEGIN
		SELECT 'NO'
	END 
END

GO
