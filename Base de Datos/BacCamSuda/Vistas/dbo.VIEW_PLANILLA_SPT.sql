USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_PLANILLA_SPT]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[VIEW_PLANILLA_SPT]
as
	select * from BacParamSuda.dbo.Planilla_Spt
GO
