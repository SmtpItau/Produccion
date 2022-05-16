USE [Reportes]
GO
/****** Object:  View [dbo].[VIEW_DCE_CONTRATO]    Script Date: 16-05-2022 10:35:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_DCE_CONTRATO]
AS

    SELECT DISTINCT TPD.dce_tipo, TPD.dce_contrato_dce, TPD.dce_contrato 
    FROM dbo.TBL_PROCESO_DCE TPD
    WHERE TPD.dce_estado = 'A'

GO
