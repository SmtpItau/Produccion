USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ARBITRAJES_LEEMONEDAS_POS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_ARBITRAJES_LEEMONEDAS_POS]
as 
begin
   set nocount on
         select 
                mncodmon 
               ,mnnemo
               ,mnsimbol
               ,mnglosa
        
          from VIEW_MONEDAS
   set nocount off
end 



GO
