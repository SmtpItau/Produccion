USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[MONEDA]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[MONEDA]
AS
	SELECT * FROM BacParamSuda.dbo.MONEDA with(nolock) -- Base de Datos --
GO
