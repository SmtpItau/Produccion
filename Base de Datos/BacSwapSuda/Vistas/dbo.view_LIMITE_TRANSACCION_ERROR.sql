USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_LIMITE_TRANSACCION_ERROR]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_LIMITE_TRANSACCION_ERROR]
AS 
select * from bacparamsuda..LIMITE_TRANSACCION_ERROR

GO
