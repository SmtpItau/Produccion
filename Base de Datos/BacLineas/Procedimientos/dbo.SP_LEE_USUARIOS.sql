USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_USUARIOS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_USUARIOS]
   (  
      @Usuario       CHAR(15) )
AS
BEGIN

    SET NOCOUNT ON

    SELECT Tipo_Clave   
    FROM bacparamsuda.dbo.USUARIO
    WHERE usuario = @Usuario


    RETURN 0
    SET NOCOUNT OFF

END
GO
