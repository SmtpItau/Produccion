USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_FERIADO]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[VIEW_FERIADO]
AS
SELECT 	 feano,
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
FROM BacParamSuda..FERIADO

--select * FROM BacParamSuda..FERIADO



GO
