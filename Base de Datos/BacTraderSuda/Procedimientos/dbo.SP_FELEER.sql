USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FELEER]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FELEER] (@feano1   numeric (04,0) ,
                            @feplaza1 numeric (03)   )
as
begin
       select feano,
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
        from  
              VIEW_FERIADO
        where 
              feano     = @feano1  
        and   
              feplaza   = @feplaza1 
        return
end
GO
