USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_LINEA_CHEQUEAR]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create VIEW [dbo].[VIEW_LINEA_CHEQUEAR]
as
select * from bacparamsuda..LINEA_CHEQUEAR

GO
