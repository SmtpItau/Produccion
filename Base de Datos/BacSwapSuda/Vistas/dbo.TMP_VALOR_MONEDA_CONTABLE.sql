USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[TMP_VALOR_MONEDA_CONTABLE]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[TMP_VALOR_MONEDA_CONTABLE]
AS
select * from bacparamsuda.dbo.VALOR_MONEDA_CONTABLE 
where fecha= '20100813'

GO
