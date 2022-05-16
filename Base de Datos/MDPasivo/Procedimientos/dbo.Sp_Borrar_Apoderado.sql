USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borrar_Apoderado]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_Borrar_Apoderado]( @nrutcli     NUMERIC(9)
				    )
                                     
AS
BEGIN


	SET DATEFORMAT DMY
	SET NOCOUNT ON


     DELETE FROM CLIENTE_APODERADO WHERE aprutcli = @nrutcli 
		

     IF @@ERROR <> 0  
        SELECT -1, 'ERROR no se puede borrar Apoderado'

END  -- PROCEDURE





GO
