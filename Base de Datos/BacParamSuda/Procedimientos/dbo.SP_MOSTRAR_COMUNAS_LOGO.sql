USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOSTRAR_COMUNAS_LOGO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MOSTRAR_COMUNAS_LOGO]
 AS
 BEGIN

   SET NOCOUNT ON  
   
   SELECT * FROM COMUNA c
   
   SET NOCOUNT OFF  

 END
 
GO
