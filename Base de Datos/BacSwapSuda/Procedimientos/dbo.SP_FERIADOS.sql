USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FERIADOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FERIADOS] 
AS
BEGIN
SET NOCOUNT ON
       SELECT feano,
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
        FROM  
              View_FERIADO

SET NOCOUNT OFF
END
GO
