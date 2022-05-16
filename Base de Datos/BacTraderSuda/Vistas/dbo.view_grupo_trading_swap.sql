USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[view_grupo_trading_swap]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[view_grupo_trading_swap]
as select 
Codigo_Limite	,
Codigo_Grupo	,
Tramo_Desde	,
Tramo_Hasta	,
Descripcion                    

from bacparamsuda..grupo_trading_swap

GO
