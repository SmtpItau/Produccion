USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_FERIADO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_FERIADO]( @feAno   NUMERIC(4) = 0 ,
                                  @fePlaza NUMERIC(3) = 0 )
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
         FROM FERIADO
        WHERE (feano   = @feAno   OR @feAno   = 0)
          AND (feplaza = @fePlaza OR @fePlaza = 0)
SET NOCOUNT OFF    
END

GO
