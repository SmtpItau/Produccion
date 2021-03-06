USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREAMOVDIA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CREAMOVDIA]  
	(	@nfecmov	DATETIME	)
AS  
BEGIN  
  
   SET NOCOUNT ON  
	select		catipcar	=	CASE	WHEN Forward.cacodpos1 = 13								THEN 3
										WHEN Forward.cacodpos1 = 2 and Forward.var_moneda2 > 0	THEN 12
										ELSE Forward.cacodpos1
									END  
		,		canumoper	=	Forward.Contrato
		,		canumcli	=	Cliente.clnombre
		,		catipope	=	CASE	WHEN Forward.catipoper = 'C' THEN 'COMPRA    ' ELSE 'VENTA     ' END
		,		cacodmon	=	Moneda1.mnnemo
		,		cacodcnv	=	CASE	WHEN Forward.cacodpos1 = 2 and Forward.var_moneda2 > 0 THEN 'CLP' 
										ELSE														Moneda2.mnnemo 
								END

		,		camtomex	=	CASE	WHEN Forward.cacodpos1 = 2 and Forward.var_moneda2 > 0 THEN Forward.MontoMex
										ELSE Forward.camtomon1 
								END
		,		Impreso		=	dbo.Fn_Estatus_Impreso( 'BFW', Forward.Contrato )
		,		Comder		=	dbo.Fn_Estatus_Comder('BFW', Forward.Contrato)
	from		
				(	select		canumoper,	cacodpos1, var_moneda2, catipoper, camtomon1, catipcam, capremon1
					,			cacodigo,	cacodcli, cacodmon1, cacodmon2
					,			MontoMex	= camtomon1 * catipcam * capremon1
					,			Contrato	= CASE	WHEN var_moneda2 > 0 THEN var_moneda2 ELSE canumoper END
					from		BacFwdSuda.dbo.Mfca with(nolock)
					where		cafecha		= @nfecmov --> @dFecha
					and			cacodpos1	In(1,2,3,10,11,12,13,14)
					and	not	(	cacodpos1	= 1 
						and		var_moneda2 > 0
							)

					union

					select		canumoper,	cacodpos1, var_moneda2, catipoper, camtomon1, catipcam, capremon1
					,			cacodigo,	cacodcli, cacodmon1, cacodmon2
					,			MontoMex	= camtomon1 * catipcam * capremon1
					,			Contrato	= CASE	WHEN var_moneda2 > 0 THEN var_moneda2 ELSE canumoper END
					from		BacFwdSuda.dbo.MfcaH
					where		cafecha		= @nfecmov	-->	@dFecha
					and			cacodpos1	In(1,2,3,10,11,12,13,14)
					and	not	(	cacodpos1	= 1 
						and		var_moneda2 > 0
							)
				)	Forward
				inner join	(	select	clrut, clcodigo, clnombre 
								from	BacParamSuda.dbo.Cliente with(nolock)
							)	Cliente	On	Cliente.clrut		= Forward.cacodigo and Cliente.clcodigo	= Forward.cacodcli
				left join	(	select	mncodmon, mnnemo
								from	BacParamSuda.dbo.Moneda	with(nolock)
							)	Moneda1	On	Moneda1.mncodmon	= Forward.cacodmon1

  				left join	(	select	mncodmon, mnnemo
								from	BacParamSuda.dbo.Moneda	with(nolock)
							)	Moneda2	On	Moneda2.mncodmon	= Forward.cacodmon2
END

GO
