USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE_CONTROL_US]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE_CONTROL_US]
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS (SELECT 1 FROM VIEW_CONTROL_USUARIO) BEGIN
  SELECT * FROM VIEW_CONTROL_USUARIO ORDER BY USUARIO
 END
 ELSE BEGIN
  
  SELECT 'ERROR'
 END
 SET NOCOUNT OFF
END

GO
