USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[View_Cliente_Apoderado]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[View_Cliente_Apoderado]
AS
	SELECT * FROM BACPARAMsuda..CLIENTE_APODERADO

GO
