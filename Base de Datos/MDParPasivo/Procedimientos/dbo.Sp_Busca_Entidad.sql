USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Entidad]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sp_Busca_Entidad]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


   SELECT rcrut
         ,rcdv
         ,rcnombre
         ,rccodcar
     FROM ENTIDAD 
   
END



GO
