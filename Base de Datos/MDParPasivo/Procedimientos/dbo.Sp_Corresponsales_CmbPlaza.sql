USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Corresponsales_CmbPlaza]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





create procedure [dbo].[Sp_Corresponsales_CmbPlaza]

as 
begin
	set nocount on
        SET DATEFORMAT dmy
	
	select codigo_plaza,glosa,codigo_pais
	from PLAZA 
  
	
	set nocount off
end 




GO
