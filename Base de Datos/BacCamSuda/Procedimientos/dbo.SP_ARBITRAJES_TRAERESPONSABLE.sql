USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ARBITRAJES_TRAERESPONSABLE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ARBITRAJES_TRAERESPONSABLE]
AS 
BEGIN
   SET NOCOUNT ON
      SELECT Id_Sistema
             ,Nombre_Sistema
      FROM VIEW_SISTEMAS_CNT
 
      WHERE operativo = 'S'
        AND gestion = 'N'
   SET NOCOUNT OFF
END 



GO
