USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_INSTRUMENTO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_INSTRUMENTO]
AS
SELECT incodigo,inserie,inglosa,inrutemi,inmonemi,inbasemi,inprog,inrefnomi,inmdse,inmdtd,inmdpr,intipfec,
       intasest,intipo,inemision,ineleg,inlargoms,inedw,incontab,intiporig,intotalemitido,insecuritytype,
       insecuritytype2,estado,codigo_inversion,codigo_producto
FROM INSTRUMENTO
GO
