USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_APODERADO1]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BORRAR_APODERADO1]( @nrutcli     NUMERIC(9),
				       @ncodigo     NUMERIC(9)	
				    )
                                     
AS
BEGIN
  
     SET NOCOUNT ON	
     DELETE FROM CLIENTE_APODERADO WHERE aprutcli = @nrutcli AND apcodcli = @ncodigo

     IF @@ERROR <> 0  
        SELECT -1, 'ERROR no se puede borrar Apoderado'

     SET NOCOUNT OFF

END  


-- SELECT * FROM CLIENTE_APODERADO 
GO
