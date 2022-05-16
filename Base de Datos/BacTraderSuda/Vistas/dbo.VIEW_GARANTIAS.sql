USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_GARANTIAS]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[VIEW_GARANTIAS]
AS
	SELECT * 
	FROM BDBOMESA.garantia.TBL_DetalleCarteraGarantia with(nolock)
	where Instrumento <> 'EFECTIVO'

GO
