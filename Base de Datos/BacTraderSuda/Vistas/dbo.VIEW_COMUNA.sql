USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_COMUNA]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_COMUNA]
AS SELECT codigo_comuna
      ,   codigo_ciudad
      ,   nombre
      FROM BACPARAMsuda..COMUNA

GO
