USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_DATOS_CONTRATO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LEER_DATOS_CONTRATO]
   (   @nContrato   NUMERIC(9)  
   ,   @cTipoper    VARCHAR(5)  
   )  
AS  
BEGIN  

	SET NOCOUNT ON  

	SELECT	/*01*/ FolioContrato	= mov.monumoper
		,	/*02*/ A				= SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN ent.rcnombre ELSE cli.clnombre END, 1, 30)
		,	/*03*/ De				= SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN cli.clnombre ELSE ent.rcnombre END, 1, 30)
		,	/*04*/ FirmaCondGener	= CONVERT(CHAR(10), cli.FechaFirmaCG_Pactos, 103) -->  CONVERT(CHAR(10), clFechaFirma_cond, 103)
		,	/*05*/ FechaContrato	= CONVERT(CHAR(10), mov.mofecpro, 103)
		
		,	/*06*/ Comprador		= SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN cli.clnombre ELSE ent.rcnombre END, 1, 30)
		,	/*07*/ Vendedor			= SUBSTRING( CASE WHEN mov.motipoper = 'VI' THEN ent.rcnombre ELSE cli.clnombre END, 1, 30)
		
		,	/*08*/ FechaCierre		= CONVERT(CHAR(10), mov.mofecpro, 103)
		
		,	/*09*/ MonedaComVta		= mon.mnnemo
		,	/*10*/ PrecioComVta		= Pas.Monto
		
		,	/*11*/ FechaEntreValor	= CONVERT(CHAR(10), mov.mofecinip, 103) --> CONVERT(CHAR(10), mov.mofecvenp, 103)
		,	/*12*/ FormaEntreValor	= ISNULL(CASE	WHEN mov.modcv = 'C' THEN 'EN CUSTODIA DEL CLIENTE'  
													WHEN mov.modcv = 'P' THEN 'EN CUSTODIA PROPIA'  
													WHEN mov.modcv = 'D' THEN 'TRASPASO EN DCV'  
												END,' ')  
							
		,	/*13*/ FechaPagoPrecio	= CONVERT(CHAR(10), mov.mofecinip, 103) --> CONVERT(CHAR(10), mov.mofecvenp, 103)
		,	/*14*/ FormaPagoPrecio	= SUBSTRING( fp1.glosa, 1, 17)
		,	/*15*/ FechaRetroCompra	= CONVERT(CHAR(10), mov.mofecvenp, 103)
		
		,	/*16*/ MonedaRetroCompra= mon.mnnemo
--		,	/*17*/ PrecioRetroCompra= mov.movalvenp	--> movptran --> movalvenp --> 
		,	/*17*/ PrecioRetroCompra= Pas.ValorRetro
		
		,	/*18*/ FormaEntreValorR	= ISNULL(CASE	WHEN mov.modcv = 'C' THEN 'EN CUSTODIA DEL CLIENTE'  
													WHEN mov.modcv = 'P' THEN 'EN CUSTODIA PROPIA'  
													WHEN mov.modcv = 'D' THEN 'TRASPASO EN DCV'  
												END,' ')  
		,	/*19*/ FormaPagoPrecioR	= SUBSTRING( fp2.glosa, 1, 17)  
		,	/*20*/ BancoRef			= ' '
		,	/*21*/ ValoresSub		= ' '
		,	/*22*/ OtrasCond		= ' '
		,	/*23*/ PP_BANCO			= SUBSTRING( ent.rcnombre, 1, 30)
		,	/*24*/ PP_CLIENTE		= SUBSTRING( cli.clnombre, 1, 30)

		,	/*25*/ TipoClaseValor   = ''  
		,	/*26*/ Emisor           = emgeneric  
		,	/*27*/ Serie            = ins.inserie  
		,	/*28*/ SubSerie         = mov.moinstser
		,	/*29*/ Emision          = CONVERT(CHAR(10), mov.mofecemi, 103)  
		,	/*30*/ Vencimiento      = CONVERT(CHAR(10), mov.mofecven, 103)  
		,	/*31*/ Nominal          = mov.monominal  
		,	/*32*/ Tasa             = mov.motir  
		,	/*33*/ NomCli           = cli.clnombre
		,	/*34*/ RutCli           = LTRIM(RTRIM( cli.clrut )) + '-' + LTRIM(RTRIM( cli.cldv ))
		,	/*35*/ CliCustodio      = cli.clnombre
		,	/*36*/ Custodio         = ISNULL(CASE	WHEN mov.modcv = 'C' THEN cli.clnombre  
													WHEN mov.modcv = 'P' THEN ent.rcnombre  
													WHEN mov.modcv = 'D' THEN 'DEPOSITO DE VALORES'  
												END,' ')  
	FROM	(	select	mofecpro, monumoper, motipoper, mofecinip, movalvenp, modcv, mofecemi, mofecven
					,	morutcli, mocodcli, momonpact, moforpagi, moforpagv, mofecvenp, morutemi, mocodigo, moinstser, monominal, motir
				from	BacTraderSuda.dbo.MDMO with(nolock)  
				where	monumoper = @nContrato
				and		motipoper = @cTipoper
					union ALL
				select	mofecpro, monumoper, motipoper, mofecinip, movalvenp, modcv, mofecemi, mofecven
					,	morutcli, mocodcli, momonpact, moforpagi, moforpagv, mofecvenp, morutemi, mocodigo, moinstser, monominal, motir
				from	BacTraderSuda.dbo.MDMH with(nolock)  
				where	monumoper = @nContrato
				and		motipoper = @cTipoper
			)	mov

				inner join (	SELECT	monumoper, Monto = SUM(movpresen) 
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
							)	Pas		On pas.monumoper = mov.monumoper
				left join BacParamSuda.dbo.CLIENTE       cli with(nolock) ON cli.clrut    = mov.morutcli and cli.clcodigo = mov.mocodcli
				left join BacParamSuda.dbo.MONEDA        mon with(nolock) ON mon.mncodmon = mov.momonpact
				left join BacParamSuda.dbo.FORMA_DE_PAGO fp1 with(nolock) ON fp1.codigo   = mov.moforpagi
				left join BacParamSuda.dbo.FORMA_DE_PAGO fp2 with(nolock) ON fp2.codigo   = mov.moforpagv
				left join BacParamSuda.dbo.EMISOR		 emi with(nolock) ON emi.emrut    = mov.morutemi
				left join BacParamSuda.dbo.INSTRUMENTO   ins with(nolock) ON ins.incodigo = mov.mocodigo  
		,		BacParamSuda.dbo.ENTIDAD                 ent with(nolock)

END
GO
