USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_USUARIOS_ROLES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_USUARIOS_ROLES]
AS
BEGIN

   SET NOCOUNT ON

   SELECT DISTINCT Usuario FROM BacParamSuda.dbo.SADP_ROLUSUARIO ORDER BY Usuario

END 
GO
