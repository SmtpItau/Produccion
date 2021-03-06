USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAPASWORD]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAPASWORD] (@usuario CHAR(15)
   ) 
AS
BEGIN
 SET NOCOUNT ON
   DECLARE @Largo_Clave     INT
   DECLARE @Tipo_Clave     CHAR(1)
   DECLARE @reset_psw     CHAR(1)
 SELECT  @Largo_Clave = Largo_Clave,
           @Tipo_Clave  = Tipo_Clave,
           @reset_psw   = reset_psw
 FROM USUARIO
 WHERE usuario = @usuario
 SET NOCOUNT OFF
END
--- Sp_Buscapasword 'ADMINISTRA'
--- SELECT * FROM USUARIO
GO
