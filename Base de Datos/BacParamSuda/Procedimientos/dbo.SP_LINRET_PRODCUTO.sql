USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINRET_PRODCUTO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LinRet_Prodcuto    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_LinRet_Prodcuto    fecha de la secuencia de comandos: 14/02/2001 09:58:29 ******/
CREATE PROCEDURE [dbo].[SP_LINRET_PRODCUTO]
 AS BEGIN
 SET NOCOUNT ON 
 SELECT codigo_producto, descripcion,id_sistema 
 FROM PRODUCTO
 SET NOCOUNT OFF
 END

GO
