USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAUSR]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCAUSR](@xusuario char(12))
as
begin
  select nombre  ,
         tipo_usuario ,
         fecha_expira ,
         clave  
         from VIEW_USUARIO where usuario = @xusuario
end


GO
