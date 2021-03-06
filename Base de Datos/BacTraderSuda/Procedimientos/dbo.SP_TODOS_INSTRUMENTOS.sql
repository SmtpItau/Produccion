USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TODOS_INSTRUMENTOS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TODOS_INSTRUMENTOS]
AS
BEGIN
SELECT  inserie  ,  --1
 inglosa  ,  --2
 incodigo ,  --3
 inprog  ,  --4
 inrefnomi ,  --5
 inrutemi ,  --6
 inmonemi ,  --7
 inbasemi ,  --8
 intasest ,  --9
 intipo  ,  --10
 inmdse  ,  --11
 inmdpr  ,  --12
 inmdtd  ,  --13
 intipfec  ,  --14
 inemision ,  --15
 ineleg  ,  --16
 incontab   --17
FROM VIEW_INSTRUMENTO 
ORDER BY inglosa
END

GO
