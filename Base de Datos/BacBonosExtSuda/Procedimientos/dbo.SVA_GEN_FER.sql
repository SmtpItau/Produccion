USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_GEN_FER]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_GEN_FER]
( 
      @feano1   numeric (04,0) ,
      @feplaza1 numeric (03)   
)
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
              feplaza	= @feplaza1 
        return
end

GO
