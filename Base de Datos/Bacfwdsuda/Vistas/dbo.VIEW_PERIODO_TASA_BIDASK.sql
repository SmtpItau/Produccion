USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_PERIODO_TASA_BIDASK]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_PERIODO_TASA_BIDASK]
AS
   SELECT 
        pecodigo,
 peperiodo,
 penumero,
 petipo,
 peglosa
   FROM BACPARAMSUDA..PERIODO_TASA_BIDASK

GO
