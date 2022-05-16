USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTERELA2]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CLIENTERELA2    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
create procedure [dbo].[SP_CLIENTERELA2]
  (@rut   numeric(10),
   @codigo  numeric(10)
  )
   
as 
begin
 set nocount on
 select clnombre
 from CLIENTE
 where clrut =@rut
 AND   clcodigo = @codigo
 set nocount off
end

GO
