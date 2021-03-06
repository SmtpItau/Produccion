USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCINI]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALCINI]( @fnomiven float             ,
                             @ftir     float             ,
                             @fbasemi  float             ,
                             @dfeccal  datetime          ,
                             @dfecven  datetime          ,
                             @fnomiini float    output   )
as
begin
      declare @fplazo float
      select  @fplazo   = datediff( day, @dfeccal, @dfecven )
      select  @fnomiini = @fnomiven / power( (1.0+@ftir/100.0),(@fplazo/@fbasemi) )
      return
end


GO
