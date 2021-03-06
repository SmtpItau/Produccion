USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_DATOS_CONTRATO_HISTORICO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LEER_DATOS_CONTRATO_HISTORICO]
   (   @nContrato   NUMERIC(9)  
   ,   @cTipoper    VARCHAR(5)  
   )  
AS  
BEGIN  

	SET NOCOUNT ON  

	SELECT	DISTINCT  
			FolioContrato		= mov.monumoper  
	  ,		A					= SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN ent.rcnombre ELSE cli.clnombre END, 1, 30)  
	  ,		De					= SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN cli.clnombre ELSE ent.rcnombre END, 1, 30)  
	  ,		FirmaCondGener		= CONVERT(CHAR(10), FechaFirmaCG_Pactos, 103) -->  CONVERT(CHAR(10), clFechaFirma_cond, 103)  
	  ,		FechaContrato		= CONVERT(CHAR(10), mov.mofecpro, 103)  
  
	  ,		Comprador			= SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN cli.clnombre ELSE ent.rcnombre END, 1, 30)  
	  ,		Vendedor			= SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN ent.rcnombre ELSE cli.clnombre END, 1, 30)  
  
	  ,		FechaCierre			= CONVERT(CHAR(10), mov.mofecpro, 103)  
  
	  ,		MonedaComVta		= mon.mnnemo  
	  ,		PrecioComVta		= Monto  
	  ,		FechaEntreValor		= CONVERT(CHAR(10), mov.mofecinip, 103) --> CONVERT(CHAR(10), mov.mofecvenp, 103)
	  ,		FormaEntreValor		= ISNULL(CASE	WHEN modcv = 'C' THEN 'EN CUSTODIA DEL CLIENTE'  
												WHEN modcv = 'P' THEN 'EN CUSTODIA PROPIA'  
												WHEN modcv = 'D' THEN 'TRASPASO EN DCV'  
											END,' ')  
	  ,		FechaPagoPrecio		= CONVERT(CHAR(10), mov.mofecinip, 103) --> CONVERT(CHAR(10), mov.mofecvenp, 103)
	  ,		FormaPagoPrecio		= SUBSTRING( fp1.glosa, 1, 17)  
  
	  ,		FechaRetroCompra	= CONVERT(CHAR(10), mov.mofecvenp, 103)  
	  ,		MonedaRetroCompra	= mon.mnnemo  
--	  ,		PrecioRetroCompra	= mov.movalvenp	--> movptran --> movalvenp --> 
	  ,		PrecioRetroCompra	= Pas.ValorRetro
	  ,		FormaEntreValorR	= ISNULL(CASE	WHEN modcv = 'C' THEN 'EN CUSTODIA DEL CLIENTE'  
												WHEN modcv = 'P' THEN 'EN CUSTODIA PROPIA'  
												WHEN modcv = 'D' THEN 'TRASPASO EN DCV'  
											END,' ')  
	  ,		FormaPagoPrecioR	= SUBSTRING( fp2.glosa, 1, 17)  
	  ,		BancoRef			= ' '  
	  ,		ValoresSub			= ' '  
	  ,		OtrasCond			= ' '  
	  ,		PP_BANCO			= SUBSTRING( ent.rcnombre, 1, 30)  
	  ,		PP_CLIENTE			= SUBSTRING( cli.clnombre, 1, 30)  
	  ,		RUT_CLIENTE			= LTRIM(RTRIM( cli.clrut )) + '-' + LTRIM(RTRIM( cli.cldv ))  
	  ,		NOMCLI				= cli.clnombre  
	  ,		CLICUSTODIO			= cli.clnombre  
	  ,		CUSTODIO			= ISNULL(CASE	WHEN modcv = 'C' THEN cli.clnombre  
												WHEN modcv = 'P' THEN ent.rcnombre  
												WHEN modcv = 'D' THEN 'DEPOSITO DE VALORES'  
											END,' ')
	  ,		SERIE				= mov.moinstser
	  ,		NOMINAL				= mov.monominal
	  ,		EMISOR				= mov.morutemi
	  ,		CODIGO				= mov.mocodigo
	  ,		FECEMI				= mov.mofecemi
	  ,		FECVEN				= mov.mofecven
	  ,		TASA				= mov.motir
	INTO	#TMP_RETORNO_PASO
	FROM	(	select	mofecpro, monumoper, motipoper, mofecinip, movalvenp, modcv
					,	morutcli, mocodcli, momonpact, moforpagi, moforpagv, mofecvenp, moinstser, monominal, morutemi, mocodigo
					,	mofecemi, mofecven, motir
				from	BacTraderSuda.dbo.MDMO with(nolock)  
				where	monumoper = @nContrato  
				and		motipoper = @cTipoper  
					union
				select	mofecpro, monumoper, motipoper, mofecinip, movalvenp, modcv
					,	morutcli, mocodcli, momonpact, moforpagi, moforpagv, mofecvenp, moinstser, monominal, morutemi, mocodigo
					,	mofecemi, mofecven, motir
				from	BacTraderSuda.dbo.MDMH with(nolock)  
				where	monumoper = @nContrato  
				and		motipoper = @cTipoper  
				and		monumoper not in(	select	monumoper 
											from	BacTraderSuda.dbo.MDMO with(nolock)  
											where	monumoper = @nContrato  
											and		motipoper = @cTipoper  
										)
			)	mov 
			INNER JOIN	(	SELECT	monumoper, Monto = SUM(movpresen)
								,	ValorRetro = SUM(movalvenp)
							FROM	BacTraderSuda.dbo.MDMO with(nolock)  
							WHERE	monumoper = @nContrato 
							AND		motipoper = @cTipoper 
							GROUP 
							BY		monumoper
								union
							SELECT	monumoper, Monto = SUM(movpresen) 
								,	ValorRetro = SUM(movalvenp)
							FROM	BacTraderSuda.dbo.MDMH with(nolock)  
							WHERE	monumoper = @nContrato 
							AND		motipoper = @cTipoper 
							and		monumoper not in(	select	monumoper 
														from	BacTraderSuda.dbo.MDMO with(nolock)  
														where	monumoper = @nContrato  
														and		motipoper = @cTipoper  
													)
							GROUP 
							BY		monumoper
						)	pas		ON pas.monumoper = @nContrato  
			LEFT  JOIN BacParamSuda.dbo.CLIENTE       cli with(nolock) ON cli.clrut    = mov.morutcli and cli.clcodigo = mov.mocodcli  
			LEFT  JOIN BacParamSuda.dbo.MONEDA        mon with(nolock) ON mon.mncodmon = mov.momonpact  
			LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO fp1 with(nolock) ON fp1.codigo   = mov.moforpagi  
			LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO fp2 with(nolock) ON fp2.codigo   = mov.moforpagv  
		,   BacParamSuda.dbo.ENTIDAD                  ent with(nolock)   
	WHERE	mov.monumoper = @nContrato  
	AND		mov.motipoper = @cTipoper  

	SELECT	/*01*/ tmp.FolioContrato  
	,		/*02*/ tmp.A  
	,		/*03*/ tmp.De  
	,		/*04*/ tmp.FirmaCondGener  
	,		/*05*/ tmp.FechaContrato  
	,		/*06*/ tmp.Comprador  
	,		/*07*/ tmp.Vendedor  
	,		/*08*/ tmp.FechaCierre  
	,		/*09*/ tmp.MonedaComVta  
	,		/*10*/ tmp.PrecioComVta  
	,		/*11*/ tmp.FechaEntreValor  
	,		/*12*/ tmp.FormaEntreValor  
	,		/*13*/ tmp.FechaPagoPrecio  
	,		/*14*/ tmp.FormaPagoPrecio  
	,		/*15*/ tmp.FechaRetroCompra  
	,		/*16*/ tmp.MonedaRetroCompra  
	,		/*17*/ tmp.PrecioRetroCompra  
	,		/*18*/ tmp.FormaEntreValorR  
	,		/*19*/ tmp.FormaPagoPrecioR  
	,		/*20*/ tmp.BancoRef  
	,		/*21*/ tmp.ValoresSub  
	,		/*22*/ tmp.OtrasCond  
	,		/*23*/ tmp.PP_BANCO  
	,		/*24*/ tmp.PP_CLIENTE  

	,		/*25*/ TipoClaseValor   = ''  
	,		/*26*/ Emisor           = emi.emgeneric  
	,		/*27*/ Serie            = ins.inserie  
	,		/*28*/ SubSerie         = tmp.SERIE

	,		/*29*/ Emision          = CONVERT(CHAR(10), tmp.FECEMI, 103)  
	,		/*30*/ Vencimiento      = CONVERT(CHAR(10), tmp.FECVEN, 103)  

	,		/*31*/ Nominal          = tmp.NOMINAL
	,		/*32*/ Tasa             = tmp.TASA
	,		/*33*/ NomCli           = tmp.NOMCLI  
	,		/*34*/ RutCli           = tmp.RUT_CLIENTE  
	,		/*35*/ CliCustodio      = tmp.CLICUSTODIO  
	,		/*36*/ Custodio         = tmp.CUSTODIO  
	from	#TMP_RETORNO_PASO tmp  
			LEFT JOIN BacParamSuda.dbo.EMISOR      emi with(nolock) ON emi.emrut    = tmp.EMISOR
			LEFT JOIN BacParamSuda.dbo.INSTRUMENTO ins with(nolock) ON ins.incodigo = tmp.CODIGO

	/*
   SELECT /*01*/ tmp.FolioContrato  
      ,   /*02*/ tmp.A  
      ,   /*03*/ tmp.De  
      ,   /*04*/ tmp.FirmaCondGener  
      ,   /*05*/ tmp.FechaContrato  
      ,   /*06*/ tmp.Comprador  
      ,   /*07*/ tmp.Vendedor  
      ,   /*08*/ tmp.FechaCierre  
      ,   /*09*/ tmp.MonedaComVta  
      ,   /*10*/ tmp.PrecioComVta  
      ,   /*11*/ tmp.FechaEntreValor  
      ,   /*12*/ tmp.FormaEntreValor  
	  ,   /*13*/ tmp.FechaPagoPrecio  
      ,   /*14*/ tmp.FormaPagoPrecio  
      ,   /*15*/ tmp.FechaRetroCompra  
      ,   /*16*/ tmp.MonedaRetroCompra  
      ,   /*17*/ tmp.PrecioRetroCompra  
      ,   /*18*/ tmp.FormaEntreValorR  
      ,   /*19*/ tmp.FormaPagoPrecioR  
      ,   /*20*/ tmp.BancoRef  
      ,   /*21*/ tmp.ValoresSub  
      ,   /*22*/ tmp.OtrasCond  
      ,   /*23*/ tmp.PP_BANCO  
      ,   /*24*/ tmp.PP_CLIENTE  
      
      ,   /*25*/ TipoClaseValor   = ''  
      ,   /*26*/ Emisor           = emi.emgeneric  
      ,   /*27*/ Serie            = ins.inserie  

      ,   /*28*/ SubSerie         = mov.moinstser  
      ,   /*29*/ Emision          = CONVERT(CHAR(10), mov.mofecemi, 103)  
      ,   /*30*/ Vencimiento      = CONVERT(CHAR(10), mov.mofecven, 103)  

      ,   /*31*/ Nominal          = mov.monominal  
      ,   /*32*/ Tasa             = mov.motir  
      ,   /*33*/ NomCli           = tmp.NOMCLI  
      ,   /*34*/ RutCli           = tmp.RUT_CLIENTE  
      ,   /*35*/ CliCustodio      = tmp.CLICUSTODIO  
      ,   /*36*/ Custodio         = tmp.CUSTODIO  
   FROM		(	SELECT	mofecemi, mofecven, monominal, moinstser, motir, morutemi, mocodigo
				FROM	BactraderSuda.dbo.MDMO with(nolock)
				WHERE	monumoper	= @nContrato
				AND		motipoper	= @cTipoper
					UNION
				SELECT	mofecemi, mofecven, monominal, moinstser, motir, morutemi, mocodigo
				FROM	BactraderSuda.dbo.MDMH with(nolock)
				WHERE	monumoper	= @nContrato
				AND		motipoper	= @cTipoper
				and		monumoper	not in(	select	monumoper 
											from	BacTraderSuda.dbo.MDMO with(nolock)  
											where	monumoper = @nContrato  
											and		motipoper = @cTipoper  
											)
			)	mov
			LEFT JOIN BacParamSuda.dbo.EMISOR      emi with(nolock) ON emi.emrut    = mov.morutemi  
			LEFT JOIN BacParamSuda.dbo.INSTRUMENTO ins with(nolock) ON ins.incodigo = mov.mocodigo  
		,   #TMP_RETORNO_PASO     tmp  
	*/

	DROP TABLE #TMP_RETORNO_PASO

END  
GO
