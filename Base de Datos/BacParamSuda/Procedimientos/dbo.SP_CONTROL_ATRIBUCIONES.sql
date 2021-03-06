USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_ATRIBUCIONES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_ATRIBUCIONES]
   (   @gsBac_user   VARCHAR(15)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @xRol       VARCHAR(15)

   SELECT  @xRol       = Rol
   FROM    BacParamSuda.dbo.USUARIO usr
           LEFT JOIN BacParamSuda.dbo.GEN_TIPOS_USUARIO tip ON tip.Tipo_Usuario = usr.tipo_usuario
   WHERE   usr.usuario = @gsBac_user

   SELECT  CASE WHEN @xRol = 'INGRESADOR' THEN 'False' ELSE 'True' END 

END
GO
