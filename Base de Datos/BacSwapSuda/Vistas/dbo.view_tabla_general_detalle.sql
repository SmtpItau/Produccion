USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_tabla_general_detalle]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_tabla_general_detalle]
AS
	SELECT
		TBCATEG,
		TBCODIGO1,
		TBTASA,
		TBFECHA,
		TBVALOR,
		TBGLOSA,
		NEMO
	FROM bacparamsuda..tabla_general_detalle

GO
