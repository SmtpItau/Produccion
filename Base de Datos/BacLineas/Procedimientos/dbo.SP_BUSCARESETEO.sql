USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCARESETEO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCARESETEO] 
               (
               @usuario CHAR(15)
               ) 
AS
BEGIN
 SET NOCOUNT ON
    DECLARE @reset_psw     CHAR(1)

    SELECT Largo_Clave
    ,      Tipo_Clave
    ,      reset_psw
	FROM Bacparamsuda.dbo.USUARIO  /* FROM VIEW_USUARIO  ==> Corregido por no existir campo reset_psw en la vista */
     WHERE usuario = @usuario

 SET NOCOUNT OFF
END
GO
