USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[view_Linea_Transaccion]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_Linea_Transaccion]
AS 
select * from bacparamsuda..Linea_Transaccion

GO
