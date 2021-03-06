USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LCRLEER]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LCRLEER]
       (    @ccodigo     char(10)     )
as
begin
   set nocount on
   /*=======================================================================*/
   /*=======================================================================*/
   if @ccodigo <> '' begin
      if not exists( select * from mdlcr where lcrcodigo = @ccodigo ) begin
         SELECT 'ER', -1, 0
         set nocount off
         return 0
      end
   end
   /*=======================================================================*/
   /*=======================================================================*/
          select   lcrcodigo,
                   lcrvalor,
                   lcrtipo
          from     mdlcr
          where    lcrcodigo = @ccodigo or
                   @ccodigo  = ' '
          order by lcrtipo, lcrcodigo
   set nocount off
end


GO
