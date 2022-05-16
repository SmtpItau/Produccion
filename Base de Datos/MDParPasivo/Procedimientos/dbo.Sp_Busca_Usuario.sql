USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Usuario]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Busca_Usuario]
   (@Usuario CHAR(15))
AS 
BEGIN
	SET NOCOUNT ON
        SET DATEFORMAT dmy
	SELECT 'X' = usuario FROM USUARIO WHERE usuario = @Usuario 
                 	
SET NOCOUNT OFF
END
 



GO
