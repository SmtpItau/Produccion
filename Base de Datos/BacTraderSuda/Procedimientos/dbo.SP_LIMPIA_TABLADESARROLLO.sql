USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA_TABLADESARROLLO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LIMPIA_TABLADESARROLLO]
               (@xmascara char(12))
as
begin
   
      set nocount on
         delete VIEW_TABLA_DESARROLLO 
          where tdmascara = @xmascara
         select 'OK'
      set nocount off
end

GO
