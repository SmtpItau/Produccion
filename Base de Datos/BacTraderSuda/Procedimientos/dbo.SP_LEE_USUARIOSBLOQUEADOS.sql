USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_USUARIOSBLOQUEADOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEE_USUARIOSBLOQUEADOS]
as
begin
  select usuario,'1',sistema 
   from gen_bloqueo 
end


GO
