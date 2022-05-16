USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_AYUDACLIENTE]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LineaCreditoGeneral_AyudaCliente    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_AYUDACLIENTE]
AS BEGIN
 SET NOCOUNT ON
 SELECT 'RUT'=STR(clrut) + '-' + cldv, clcodigo,clnombre,STR(clrut),cldv  FROM CLIENTE
 SET NOCOUNT OFF
END

GO
