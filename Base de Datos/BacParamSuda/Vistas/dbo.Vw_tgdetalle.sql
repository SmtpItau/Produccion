USE [BacParamSuda]
GO
/****** Object:  View [dbo].[Vw_tgdetalle]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[Vw_tgdetalle]
as

	select  Codigo	 = convert(numeric, tgd.tbcodigo1) 
	,		Glosa2	 = convert(char(15), ltrim(rtrim( fpa.glosa  )) ) 
					 + space(1) 
					 + convert(char(25), ltrim(rtrim( cor.nombre )) ) 

	,		fpCodigo = fpa.glosa
	,		CoNombre = cor.nombre
	,		Glosa	 = convert(char(15), substring( ltrim(rtrim( fpa.codigo )), 1, 3) + Replicate (' ', 3 - len(substring( ltrim(rtrim( fpa.codigo )), 1, 3)) ) 
								 + '-' + substring( ltrim(rtrim( fpa.perfil )), 1, 5) + Replicate (' ', 5 - len(substring( ltrim(rtrim( fpa.perfil )), 1, 5)) )
								 + ' ' + case when diasvalor = 0 then 'HOY' when diasvalor = 1 then ' 24' when diasvalor = 2 then ' 48' when diasvalor = 3 then ' 72'
										      else '  ' end
								 + ' / ' 
					                   )
					+ convert(char(25),  ' ' 
									   + substring( ltrim(rtrim( cor.codigo_contable )), 1, 4) + Replicate(' ', 4 - len(substring( ltrim(rtrim( cor.codigo_contable )), 1, 4)) )
								 + '-' + ltrim(rtrim( cor.nombre ))
									   )


	from	BacParamSuda.dbo.Tabla_General_Detalle		tgd
			inner join BacParamSuda.dbo.Forma_de_pago	fpa	on fpa.codigo			= tgd.tbtasa
			inner join BacParamSuda.dbo.corresponsal	cor on cor.rut_cliente		= 97023000 
														   and cor.codigo_contable  = tgd.tbvalor
	where	tgd.tbcateg			 = 400
	and		cor.codigo_contable  not in ('', 0)
GO
