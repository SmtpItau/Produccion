USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LinRet_Producto]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_LinRet_Producto    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_LinRet_Producto    fecha de la secuencia de comandos: 14/02/2001 09:58:29 ******/
CREATE PROCEDURE [dbo].[Sp_LinRet_Producto]
 AS BEGIN
 SET NOCOUNT ON 
 SELECT codigo_producto, descripcion,id_sistema
 FROM PRODUCTO
 SET NOCOUNT OFF
 END






GO
