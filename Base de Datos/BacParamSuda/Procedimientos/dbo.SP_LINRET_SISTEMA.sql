USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINRET_SISTEMA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LinRet_Sistema    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
CREATE PROCEDURE [dbo].[SP_LINRET_SISTEMA]
 AS BEGIN
 SET NOCOUNT ON 
 SELECT id_sistema, nombre_sistema,  operativo 
 FROM SISTEMA_CNT
 WHERE (operativo = 'S' AND gestion='N')
 SET NOCOUNT OFF
 END

GO
