USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Entidades]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create Procedure [dbo].[Sp_Leer_Entidades]
as
begin



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

   Select rcnombre,rcrut 
     from ENTIDAD 
 order by rcnombre

end





GO
