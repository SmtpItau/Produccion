USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_CUENTA_CONTABLE]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Cuenta_Contable    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Cuenta_Contable    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BUSCA_CUENTA_CONTABLE]( @cuenta  CHAR(11)  )
AS 
BEGIN
SELECT Descripcion
  FROM PLAN_DE_CUENTA WHERE cuenta = @cuenta
END
GO
