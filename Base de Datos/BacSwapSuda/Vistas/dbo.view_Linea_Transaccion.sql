USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_Linea_Transaccion]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_Linea_Transaccion]
AS 
select * from bacparamsuda..Linea_Transaccion

GO
