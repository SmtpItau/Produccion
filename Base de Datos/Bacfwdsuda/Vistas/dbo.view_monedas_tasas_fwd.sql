USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[view_monedas_tasas_fwd]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_monedas_tasas_fwd]
AS
SELECT *
FROM bacparamsuda..monedas_tasas_fwd

GO
