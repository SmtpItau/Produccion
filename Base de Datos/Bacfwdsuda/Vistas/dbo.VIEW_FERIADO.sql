USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_FERIADO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_FERIADO]
AS  
   SELECT
  feano,
 feplaza,
 feene,
 fefeb,
 femar,
 feabr,
 femay,
 fejun,
 fejul,
 feago,
 fesep,
 feoct,
 fenov,
 fedic
   FROM BACPARAMSUDA..FERIADO

GO
