USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_USUARIOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_USUARIOS]
   (  
      @Usuario       CHAR(15) )
AS
BEGIN

    SET NOCOUNT ON

    SELECT Tipo_Clave   
    FROM bacparamsuda..USUARIO
    WHERE usuario = @Usuario


    RETURN 0
    SET NOCOUNT OFF

END

GO
