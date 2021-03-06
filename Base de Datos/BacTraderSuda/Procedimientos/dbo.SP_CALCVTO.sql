USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCVTO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALCVTO]( @fnominal float             ,
                             @ftasemi  float             ,
                             @fbasemi  float             ,
                             @dfecemi  datetime          ,
                             @dfecven  datetime          ,
                             @fnomiven float    output   )
as
begin
      declare @fplazo float
      select  @fplazo   = datediff( day, @dfecemi, @dfecven )
      select  @fnomiven = @fnominal * power(1.0+@ftasemi/100.0,@fplazo/@fbasemi)
      return
end


GO
