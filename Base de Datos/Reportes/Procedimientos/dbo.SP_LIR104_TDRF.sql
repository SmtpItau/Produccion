USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIR104_TDRF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIR104_TDRF]
AS 
BEGIN 

	DECLARE @Separador      VARCHAR(1)
	SET @Separador = ';'


	DECLARE @dFecha		datetime 
		SET @dFecha		= (SELECT acfecproc FROM bactradersuda.dbo.mdac); --'2019-12-30'
	
	
	DECLARE @tblNemos		table ( instrumento char(10), mascara char(10) )

		INSERT INTO @tblNemos( instrumento )
		SELECT DISTINCT rsinstser 
		  FROM BacTraderSuda.dbo.MDRS with(nolock)
		 WHERE 
		 rsfecha = @dfecha 
		 -- rsfecha = '20020520'
		  AND  rscartera in (111,114,159) 

		/*
		SELECT 
				tdmascara				as	Nemotecnico 
		,		convert(varchar, s.sefecemi,112)	as	FechaEmision -->>CVM.20200529_AAAAMMDD
		,		s.semascara				as  Serie
		,		s.serutemi				as  RutEmisor
		,		e.emnombre				as  RazonSocial
		,		convert(varchar, s.sefecven,112)	as  FechaVencimiento -->>CVM.20200529_AAAAMMDD
		,		s.seplazo				as  PlazoEnAnos
		,		' '						as  TipoBono
		,		CASE	
					WHEN s.sepervcup =  1 THEN 'MENSUAL'
					WHEN s.sepervcup =  3 THEN 'TRIMESTRAL'
					WHEN s.sepervcup =  6 THEN 'SEMESTRAL'
					WHEN s.sepervcup = 12 THEN 'ANUAL'
				END						as  PeriodicidadCupon
		,		s.secupones				as  NCupones
		,		m.mnnemo				as  Moneda		
		,		s.setotalemitido		as  Nominal
		,		s.setasemi				as  TasaInteres
		,		s.sebasemi				as  Base
		,		t.tdcupon				as  NumeroFlujo
		,		convert(varchar, t.tdfecven,112)	as  FechaVencimientoCupón -->>CVM.20200529_AAAAMMDD
		,		t.tdflujo				as  'Flujo'
		,		t.tdamort				as 'Amortización(BASE100)'
		,		t.tdinteres				as 'Interés (BASE 100)'
		  FROM bacparamsuda.dbo.tabla_desarrollo  t with(nolock)
		 INNER 
		  JOIN @tblNemos n on 
			n.instrumento = tdmascara  
		 INNER 
		  JOIN bacparamsuda.dbo.serie  s
			ON s.semascara  =  n.instrumento 
		  LEFT
		  JOIN BacParamSuda.dbo.EMISOR e
			ON e.emrut = s.serutemi 
		  LEFT 
		  JOIN bacparamsuda.dbo.moneda m
			on m.mncodmon = s.semonemi
		*/
	
	
	/*ACTUALIZACION POR FORMATO DECIMAL 20210630
	SELECT 
		convert(varchar,tdmascara)							+ @Separador +						 
		convert(varchar,convert(varchar, s.sefecemi,112))	+ @Separador + 			 
		convert(varchar,s.semascara)						+ @Separador + 						 
		convert(varchar,s.serutemi)							+ @Separador + 						 
		convert(varchar,e.emnombre)							+ @Separador + 						 
		convert(varchar,convert(varchar, s.sefecven,112))	+ @Separador + 			 
		convert(varchar,s.seplazo)							+ @Separador + 						 
		convert(varchar,' ')								+ @Separador + 	
		convert(varchar,CASE	
					WHEN s.sepervcup =  1 THEN 'MENSUAL'
					WHEN s.sepervcup =  3 THEN 'TRIMESTRAL'
					WHEN s.sepervcup =  6 THEN 'SEMESTRAL'
					WHEN s.sepervcup = 12 THEN 'ANUAL'
				END)								+ @Separador + 				 
		convert(varchar,s.secupones	)						+ @Separador + 					 
		convert(varchar,m.mnnemo)							+ @Separador + 						 	
		convert(varchar,cast(s.setotalemitido as decimal))	+ @Separador + 				 
		convert(varchar,cast(s.setasemi as decimal))		+ @Separador + 						 
		convert(varchar,s.sebasemi)							+ @Separador + 						 
		convert(varchar,t.tdcupon)							+ @Separador + 						 
		convert(varchar,convert(varchar, t.tdfecven,112))	+ @Separador + 				
		convert(varchar,cast(t.tdflujo as decimal))			+ @Separador + 						 
		convert(varchar,cast(t.tdamort as decimal))			+ @Separador + 						 
		convert(varchar,cast(t.tdinteres	 as decimal))	+ @Separador 
		as REG_SALIDA
	FROM bacparamsuda.dbo.tabla_desarrollo  t with(nolock)
	INNER 
	JOIN @tblNemos n on 
	n.instrumento = tdmascara  
	INNER 
	JOIN bacparamsuda.dbo.serie  s
	ON s.semascara  =  n.instrumento 
	LEFT
	JOIN BacParamSuda.dbo.EMISOR e
	ON e.emrut = s.serutemi 
	LEFT 
	JOIN bacparamsuda.dbo.moneda m
	on m.mncodmon = s.semonemi
	*/
	
		
	SELECT 
		convert(varchar,tdmascara)							+ @Separador +						 
		convert(varchar,convert(varchar, s.sefecemi,112))	+ @Separador + 			 
		convert(varchar,s.semascara)						+ @Separador + 						 
		convert(varchar,s.serutemi)							+ @Separador + 						 
		convert(varchar,e.emnombre)							+ @Separador + 						 
		convert(varchar,convert(varchar, s.sefecven,112))	+ @Separador + 			 
		convert(varchar,s.seplazo)							+ @Separador + 						 
		convert(varchar,' ')								+ @Separador + 	
		convert(varchar,CASE	
					WHEN s.sepervcup =  1 THEN 'MENSUAL'
					WHEN s.sepervcup =  3 THEN 'TRIMESTRAL'
					WHEN s.sepervcup =  6 THEN 'SEMESTRAL'
					WHEN s.sepervcup = 12 THEN 'ANUAL'
					ELSE CONVERT(VARCHAR,s.sepervcup)
				END)								+ @Separador + 				 
		convert(varchar,s.secupones	)						+ @Separador + 					 
		convert(varchar,m.mnnemo)							+ @Separador + 						 	
		convert(varchar,cast(s.setotalemitido as numeric(19,4)))	+ @Separador + 				 
		convert(varchar,cast(s.setasemi as numeric(19,4)))		+ @Separador + 						 
		convert(varchar,s.sebasemi)							+ @Separador + 						 
		convert(varchar,t.tdcupon)							+ @Separador + 						 
		convert(varchar,convert(varchar, t.tdfecven,112))	+ @Separador + 				
		convert(varchar,cast(t.tdflujo as numeric(19,4)))			+ @Separador + 						 
		convert(varchar,cast(t.tdamort as numeric(19,4)))			+ @Separador + 						 
		convert(varchar,cast(t.tdinteres	 as numeric(19,4)))	+ @Separador 
		as REG_SALIDA
	FROM bacparamsuda.dbo.tabla_desarrollo  t with(nolock)
	INNER 
	JOIN @tblNemos n on 
	n.instrumento = tdmascara  
	INNER 
	JOIN bacparamsuda.dbo.serie  s
	ON s.semascara  =  n.instrumento 
	LEFT
	JOIN BacParamSuda.dbo.EMISOR e
	ON e.emrut = s.serutemi 
	LEFT 
	JOIN bacparamsuda.dbo.moneda m
	on m.mncodmon = s.semonemi


END
GO
