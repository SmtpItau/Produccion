USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_INSTRUMENTO]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_INSTRUMENTO]
AS
select incodigo,inserie,inglosa,inrutemi,inmonemi,inbasemi,inprog,inrefnomi,inmdse,inmdtd,inmdpr,intipfec,
       intasest,intipo,inemision,ineleg,inlargoms,inedw,incontab,intiporig,intotalemitido,insecuritytype,
       insecuritytype2,estado,codigo_inversion,codigo_producto
from VIEW_INSTRUMENTO
GO
