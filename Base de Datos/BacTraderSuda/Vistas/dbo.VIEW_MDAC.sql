USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MDAC]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MDAC]
AS

	SELECT * FROM BacTraderSuda.dbo.mdac with(nolock)-- Base de Datos --
GO
