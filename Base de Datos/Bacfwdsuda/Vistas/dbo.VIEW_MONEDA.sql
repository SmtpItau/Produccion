USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_MONEDA]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_MONEDA]
AS
   SELECT 
        mncodmon,
 mnnemo,
 mnsimbol,
 mnglosa,
 mncodsuper,
 mnnemsuper,
 mncodbanco,
 mnnembanco,
 mnbase,
 mnredondeo,
 mndecimal,
 mncodpais,
 mnrrda,
 mnfactor,
 mnrefusd,
 mnlocal,
 mnextranj,
 mnvalor,
 mnrefmerc,
 mningval,
 mntipmon,
 mnperiodo,
 mnmx,
 mncodfox,
 mnvalfox,
 mncodcor,
 codigo_pais,
 mniso_coddes,
 mncanasta
   FROM BACPARAMSUDA..MONEDA


GO
