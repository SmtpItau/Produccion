USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_INSTRUMENTO]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_INSTRUMENTO]
AS
SELECT incodigo,
 inserie,
 inglosa,
 inrutemi,
 inmonemi,
 inbasemi,
 inprog,
 inrefnomi,
 inmdse,
 inmdtd,
 inmdpr,
 intipfec,
 intasest,
 intipo,
 inemision,
 ineleg,
 inlargoms,
 inedw,
 incontab, 
 intiporig,
 intotalemitido,
 insecuritytype,
 insecuritytype2
FROM  bacparamsuda..INSTRUMENTO


GO
