USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_ANU_CTR_PAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_ANU_CTR_PAS] 
(   
       @usuario	char(10),
       @pass		char(10)
)
as
begin
	if not exists(select * from text_atrib where nom_usu = @usuario and pass = @pass)
	begin
		Select '2', 'Contraseña Incorrecta'
	end		

end


GO
