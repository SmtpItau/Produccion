USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[view_TIPO_LIMITE]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[view_TIPO_LIMITE]
as select * from bacparamsuda..TIPO_LIMITE

GO
