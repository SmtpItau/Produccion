USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERPD]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERPD]
   (   @xfecpro  CHAR(10)
   ,   @xfecprox CHAR(10)
   )
as
begin

   DECLARE @dfecpro  DATETIME
   DECLARE @dfecprox DATETIME   

   SET @dfecpro  = convert(DATETIME, @xfecpro, 103)
   SET @dfecprox = convert(DATETIME, @xfecprox, 103)
   
   SET NOCOUNT ON
    
   create table #TMP(tmcodmon numeric (3,0) ,
        tmdescrip char (30) ,
        tmvalpro numeric (18,11) ,
        tmvalprox numeric (18,11) ,
        tmcodbcch numeric (    5)   
       )
   insert into #TMP 
     select  'tmcodmon' = mncodmon ,
            'tmdescrip' = mnglosa ,
   'tmvalpro' = 0.0  ,
     'tmvalprox' = 0.0           ,
   'tmcodbcch'     = mncodbanco  
         from MDPD, VIEW_MONEDA
  where pdcodmon = mncodmon
 
   update #TMP
   set tmvalpro = vmvalor                        
   from VIEW_VALOR_MONEDA
   where vmcodigo=tmcodmon and vmfecha = @dfecpro

   update #TMP
   set tmvalprox = vmvalor
   from VIEW_VALOR_MONEDA
   where vmcodigo=tmcodmon  and vmfecha=@dfecprox

   select * from #TMP

end

GO
