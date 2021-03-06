USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FINDBASE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FINDBASE]
AS
BEGIN
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
 mniso_coddes
  FROM 
   MONEDA
  WHERE 
   ISNULL(mnmx,'')<> 'C' OR mncodmon IN(13)
 
END
-- Sp_FindBase '$$'
 --  select * from mdpa
GO
