USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_leer_forward_mensuales]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_leer_forward_mensuales]
	(	@dIniMes	datetime
	,	@dFinMes	datetime
	)
as
begin

	/*
	declare @dIniMes	datetime;	set	@dIniMes = '20150817'	--> 20150801'
	declare @dFinMes	datetime;	set @dFinMes = '20150817'
	*/

	SELECT	CaFechaProceso			= Forward.cafecha
		,	canumoper				= Forward.canumoper
		,	clrut					= clie.Rut
		,	Cldv					= clie.Dv
		,	Clnombre				= clie.Nombre
		,	cafecha					= Forward.cafecha
		,	catipoper				= Forward.catipoper
		,	catipmoda				= Forward.catipmoda
		,	Moneda					= mon.mnnemo
		,	Conversion				= cnv.mnnemo
		,	camtomon1				= Forward.camtomon1
		,	camtomon2				= Forward.camtomon2
		,	capremon1				= Forward.capremon1
		,	catipcam				= Forward.catipcam
		,	cafecvcto				= Forward.cafecvcto
		,	cacodpos1				= Forward.cacodpos1
		,	caoperador				= Forward.caoperador
		,	ValorRazonableActivo	= Forward.ValorRazonableActivo
		,	ValorRazonablePasivo	= Forward.ValorRazonablePasivo
		,	fRes_Obtenido			= Forward.fRes_Obtenido
		,	catasaufclp				= Forward.catasaufclp
		,	fVal_Obtenido			= Forward.fVal_Obtenido
		,	cacodcart				= Forward.cacodcart
		,	cafecEfectiva			= Forward.cafecEfectiva
		,	ClPais					= clie.IdPais
		,	NombrePais				= clie.Pais
		,	NumSpot					= Movto.numerospot
	FROM	(	select	monumoper,numerospot,moestado from BacFwdSuda.dbo.mfmo with(nolock) where mofecha between @dIniMes and @dFinMes AND moestado <> 'A'
				union
				select	monumoper,numerospot,moestado from BacFwdSuda.dbo.mfmoh with(nolock) where mofecha between @dIniMes and @dFinMes AND moestado <> 'A'
			)	Movto

			left join
			(	select	canumoper, cafecha, cafecvcto, catipoper, catipmoda, camtomon1, camtomon2, capremon1, catipcam, cacodpos1
					,	caoperador,	ValorRazonableActivo, ValorRazonablePasivo, fRes_Obtenido, catasaufclp, fVal_Obtenido, cacodcart, cafecEfectiva
					,	cacodigo, cacodcli, cacodmon1, cacodmon2
				from	BacFwdSuda.dbo.mfca with(nolock)
				where	canumoper IN(	select	monumoper 
										from	BacFwdSuda.dbo.mfmo with(nolock) 
										where	mofecha between @dIniMes and @dFinMes
											union
										select	monumoper 
										from	BacFwdSuda.dbo.mfmoh with(nolock) 
										where	mofecha between @dIniMes and @dFinMes
									)
					union
				select	canumoper, cafecha, cafecvcto, catipoper, catipmoda, camtomon1, camtomon2, capremon1, catipcam, cacodpos1
					,	caoperador,	ValorRazonableActivo, ValorRazonablePasivo, fRes_Obtenido, catasaufclp, fVal_Obtenido, cacodcart, cafecEfectiva
					,	cacodigo, cacodcli, cacodmon1, cacodmon2
				from	BacFwdSuda.dbo.mfcah with(nolock)
				where	canumoper IN(	select	monumoper 
										from	BacFwdSuda.dbo.mfmo with(nolock) 
										where	mofecha between @dIniMes and @dFinMes
											union
										select	monumoper 
										from	BacFwdSuda.dbo.mfmoh with(nolock) 
										where	mofecha between @dIniMes and @dFinMes
									)
			)	Forward	On Forward.canumoper = Movto.monumoper

			left join
			(	select	Rut		= clrut
					,	Codigo	= clcodigo
					,	Nombre	= clnombre
					,	Dv		= cldv
					,	IdPais	= Pais.Id
					,	Pais	= pais.Pais
				from	BacParamSuda.dbo.cliente with(nolock)
						left join
						(	select	Id		= codigo_pais
								,	Pais	= nombre
							from	BacParamSuda.dbo.pais with(nolock)
						)	pais	On pais.id	= clpais
			)	clie	On	clie.Rut	= Forward.cacodigo
						and	clie.Codigo	= Forward.cacodcli

			left join
			(	select	mncodmon, mnnemo
				from	bacparamsuda.dbo.moneda with(nolock)
			)	mon		On mon.mncodmon	= Forward.cacodmon1

			left join
			(	select	mncodmon, mnnemo
				from	bacparamsuda.dbo.moneda with(nolock)
			)	cnv		On cnv.mncodmon	= Forward.cacodmon2

	ORDER
	BY		Forward.canumoper

end
GO
