USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_EJECUTIVO]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_EJECUTIVO]
AS SELECT codigo,
          nombre,
	  sucursal,
	  Monto_linea
FROM BacParamSuda..Ejecutivo


--select * from view_ejecutivo

GO
