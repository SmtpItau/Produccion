USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CIUDAD]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_CIUDAD]
AS SELECT codigo_ciudad
      ,   codigo_region
      ,   nombre
      FROM BACPARAMsuda..CIUDAD

GO
