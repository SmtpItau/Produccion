USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCTAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALCTAS]( @fvan     float             ,
                             @fnomiven float             ,
                             @fbasemi  float             ,
                             @dfeccal  datetime          ,
                             @dfecven  datetime          ,
                             @ftir     float    output   )
as
begin
      declare @fplazo float
      select @fplazo = datediff( day, @dfeccal, @dfecven )
      if @fplazo <> 0.0
         select @ftir = (power((@fvan/@fnomiven),(@fbasemi/@fplazo))-1.0)*100.0
      return
end


GO
