USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[view_tabla_general_detalle]    Script Date: 11-05-2022 16:32:48 ******/
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
	FROM BACPARAMsuda..tabla_general_detalle






GO
