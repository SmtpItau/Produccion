USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEECA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEECA]
                (@emnombre1 numeric(4))
as
begin   
 select  ctcateg ,
         ctdescrip  
        from
         MDTB
      where
         ctcateg > @emnombre1
      order by
         ctdescrip
   return
end  


GO
