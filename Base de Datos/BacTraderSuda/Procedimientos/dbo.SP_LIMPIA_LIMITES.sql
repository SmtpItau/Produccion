USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA_LIMITES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LIMPIA_LIMITES]
as
begin
   set nocount on
      update MD_ART84 set monto_ocupado = 0
      update MD_EMISOR_INST_PLAZO set monto_ocupado  = 0
   select 'OK'
   set nocount off
end

GO
