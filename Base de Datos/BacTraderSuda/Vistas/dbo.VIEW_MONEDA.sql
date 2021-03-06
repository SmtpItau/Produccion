USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MONEDA]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MONEDA]
AS
SELECT mncodmon ,
 mnnemo  ,
 mnsimbol ,
 mnglosa  ,
 mncodsuper ,
 mnnemsuper ,
 mncodbanco ,
 mnnembanco ,
 mnbase  ,
 mnredondeo ,
 mndecimal ,
 mncodpais ,
 mnrrda  ,
 mnfactor ,
 mnrefusd ,
 mnlocal  ,
 mnextranj ,
 mnvalor  ,
 mnrefmerc ,
 mningval ,
 mntipmon ,
 mnperiodo ,
 mnmx  ,
 mncodfox ,
 mnvalfox ,
 mncodcor ,
 codigo_pais ,
 mniso_coddes ,
 mncodcorrespC ,
 mncodcorrespV
FROM BACPARAMSUDA..MONEDA


GO
