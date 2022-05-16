USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ClienteRela2]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







create procedure [dbo].[Sp_ClienteRela2]
		(@rut 		numeric(10),
		 @codigo 	numeric(10)
		)
		 
as 
begin
	SET NOCOUNT ON
        SET DATEFORMAT dmy      

	select clnombre
	from CLIENTE
	where clrut =@rut
	AND   clcodigo = @codigo
	set nocount off
end



GO
