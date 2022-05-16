USE [BacParamSuda]
GO
/****** Object:  View [dbo].[view_tbl_tipogarantia]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[view_tbl_tipogarantia]
as
	select	Id		= Id
		,	Glosa	= Descripcion
		,	Orden	= Id
	from	BdBomesa.Garantia.TBL_TipoGarantia_Cnt with(nolock)
GO
