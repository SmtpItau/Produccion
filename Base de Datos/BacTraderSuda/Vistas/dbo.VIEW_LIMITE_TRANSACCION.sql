USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_LIMITE_TRANSACCION]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_LIMITE_TRANSACCION]
AS 
select * from bacparamsuda..LIMITE_TRANSACCION

GO
