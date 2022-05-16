USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_RUT_LOGO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_RUT_LOGO] (@RUTENTIDAD INT)
 AS
 BEGIN

   SET NOCOUNT ON  
   
   SELECT * FROM Contratos_ParametrosGenerales
   WHERE RutEntidad=@RUTENTIDAD
    
   SET NOCOUNT OFF  

 END
 

GO
