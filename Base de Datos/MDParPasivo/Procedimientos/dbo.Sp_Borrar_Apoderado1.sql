USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borrar_Apoderado1]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Borrar_Apoderado1]( @nrutcli     NUMERIC(10),
		 		           @nrutapo     NUMERIC(10),
					   @codigo	NUMERIC(5)=0
				    )
                                     
AS
BEGIN
  	

	SET DATEFORMAT DMY
	SET NOCOUNT ON


     IF @codigo = 0  begin
	
	     DELETE FROM CLIENTE_APODERADO WHERE aprutcli = @nrutcli AND aprutapo = @nrutapo
	     IF @@ERROR <> 0  
	      SELECT -1, 'ERROR no se puede borrar Apoderado'
      
	RETURN
     END	
	
	    DELETE FROM CLIENTE_APODERADO WHERE aprutcli = @nrutcli AND apcodcli =  @codigo		

	     IF @@ERROR <> 0  
	      SELECT -1, 'ERROR no se puede borrar Apoderado'

	



END  -- PROCEDURE


GO
