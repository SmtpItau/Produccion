USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INVEXETERIOR_AYUDACLIENTE]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_InvExeterior_AyudaCliente    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_InvExeterior_AyudaCliente    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_INVEXETERIOR_AYUDACLIENTE]
AS BEGIN
 SET NOCOUNT ON
 SELECT 'RUT'=STR(CLRUT) + '-' + CLDV, CLCODIGO,CLNOMBRE,STR(CLRUT),CLDV  FROM CLIENTE
 SET NOCOUNT OFF
END
GO
