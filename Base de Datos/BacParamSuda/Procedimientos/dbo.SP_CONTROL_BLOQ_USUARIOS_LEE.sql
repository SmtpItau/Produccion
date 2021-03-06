USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_LEE]
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS (SELECT 1 FROM VIEW_CONTROL_USUARIO ) BEGIN
  SELECT View_Control_Usuario.*, View_Sistema_Cnt.nombre_sistema,  View_Sistema_Cnt.id_sistema 
                 FROM VIEW_CONTROL_USUARIO, VIEW_SISTEMA_CNT
   WHERE VIEW_SISTEMA_CNT.id_sistema = VIEW_CONTROL_USUARIO.id_sistema
   ORDER BY usuario
 END
 ELSE BEGIN
 
  SELECT 'ERROR'
 END
 SET NOCOUNT OFF
END
GO
