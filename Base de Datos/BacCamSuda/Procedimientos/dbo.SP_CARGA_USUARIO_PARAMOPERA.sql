USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_USUARIO_PARAMOPERA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_USUARIO_PARAMOPERA]
AS
BEGIN
   SELECT usuario
         ,nombre
    FROM VIEW_USUARIO
END



GO
