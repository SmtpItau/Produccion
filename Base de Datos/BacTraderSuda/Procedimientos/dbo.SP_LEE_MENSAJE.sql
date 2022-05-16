USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_MENSAJE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEE_MENSAJE]
               (@xusuario  char(10))
as
begin
       select  user_rte  ,
  mensaje   ,
  correla   ,
  tipo   ,
  convert(char(10),fecha,103),
  hora  
 from BAC_MENSAJE 
       where user_envia = @xusuario
end


GO
