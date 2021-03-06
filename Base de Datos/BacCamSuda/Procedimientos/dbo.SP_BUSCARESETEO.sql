USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCARESETEO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCARESETEO] (@usuario CHAR(15)) 
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @reset_psw     CHAR(1)
 SELECT  Largo_Clave,
  Tipo_Clave,
           reset_psw
 FROM bacparamsuda..USUARIO
 WHERE usuario = @usuario
 SET NOCOUNT OFF
END
/*
 sp_helptext Sp_Valida_Ingreso_Usuario
  sp_buscareseteo 'JUANP'
select * from bacparamsuda..usuario
select * from view_control_usuario
select * from view_usuario_activo
select * from view_gen_privilegios
*/



GO
