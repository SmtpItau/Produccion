USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[TMP_CARTERARES]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[TMP_CARTERARES]
as
select * from bacswapsuda.dbo.carterares where Fecha_Proceso = '20100826'
UNION ALL
select * from bacswapsuda.dbo.carterares where Fecha_Proceso = '20100813'

GO
