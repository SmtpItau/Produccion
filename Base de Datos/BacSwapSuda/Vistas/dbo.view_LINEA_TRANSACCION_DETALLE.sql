USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_LINEA_TRANSACCION_DETALLE]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_LINEA_TRANSACCION_DETALLE]
AS 
select * from bacparamsuda..LINEA_TRANSACCION_DETALLE

GO
