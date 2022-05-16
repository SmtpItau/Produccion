USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CANJES_FORMAPAGO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CANJES_FORMAPAGO] 
AS 
BEGIN
   
      SELECT  codigo
             ,glosa
             ,perfil
             ,glosa2
             ,diasvalor
       FROM 
             VIEW_FORMA_DE_PAGO  
       ORDER BY perfil
END 



GO
