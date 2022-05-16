USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEUSR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEUSR]
            (@xusuario char(15))
as
begin
  select clave, nombre, tipo_usuario, fecha_expira 
   from VIEW_USUARIO 
  where usuario = @xusuario
end

GO
