USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTEBUS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_ClienteBus    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_ClienteBus    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
create procedure [dbo].[SP_LEER_CLIENTEBUS] (
                @crut  numeric(9,0)
         )
as
begin
 set nocount on
  select * from CLIENTE where clrut = @crut
 set nocount off
end
 
--sp_helptext sp_mdclleernombre
--select * from sysobjects where type = "p"
GO
