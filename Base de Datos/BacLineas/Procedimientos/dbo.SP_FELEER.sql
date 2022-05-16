USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FELEER]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FELEER] (@feano1   NUMERIC (04,0) ,
                            @feplaza1 NUMERIC (03)   )
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
              FERIADO
        WHERE 
              feano     = @feano1  
        AND   
              feplaza   = @feplaza1 
        RETURN
SET NOCOUNT OFF
END
GO
