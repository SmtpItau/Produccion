USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_USUARIO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_LEER_USUARIO]
            ( @codigo varchar(20) = '')
as
begin
     set nocount on
     select usuario, nombre, tipo_usuario 
       from VIEW_USUARIO
      where @codigo = '' or @codigo = usuario
      order by nombre
end
GO
