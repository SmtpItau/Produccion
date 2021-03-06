USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_FERIADO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEER_FERIADO]( @nAno   NUMERIC(4) ,
                                  @cPlaza NUMERIC(3) )
AS
BEGIN
     SET NOCOUNT ON
     SELECT     feano,
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
          FROM  view_feriado
          WHERE feano   = @nano       
            AND feplaza = @cplaza 
END
 



GO
