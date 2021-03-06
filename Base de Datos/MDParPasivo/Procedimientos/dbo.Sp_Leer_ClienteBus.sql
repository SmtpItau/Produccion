USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_ClienteBus]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


create procedure [dbo].[Sp_Leer_ClienteBus] (
			             @crut  numeric(10,0),
				     @codigo numeric(5,0)	
				     )
as begin
set dateformat dmy
	set nocount on
		select * from CLIENTE where clrut = @crut
				      and ( clcodigo = @codigo or @codigo =0)
	set nocount off
end

GO
