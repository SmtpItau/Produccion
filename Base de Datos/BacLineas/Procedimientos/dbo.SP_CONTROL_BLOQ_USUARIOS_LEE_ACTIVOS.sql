USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE_ACTIVOS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE_ACTIVOS]
AS
BEGIN
 SET NOCOUNT ON
            SELECT * FROM VIEW_USUARIO_ACTIVO ORDER BY terminal 
 SET NOCOUNT OFF
END






GO
