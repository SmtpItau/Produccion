USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACTRASRECEPLINCRE_AYUDACLIENTE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacTrasRecepLinCre_AyudaCliente    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[SP_BACTRASRECEPLINCRE_AYUDACLIENTE] (@clrut   NUMERIC(9,0))
AS BEGIN
 SET NOCOUNT ON
 SELECT  clrut, 
  cldv, 
  clcodigo,
  clnombre  
 
 FROM CLIENTE
  WHERE clrut=@clrut
 SET NOCOUNT OFF
END
GO
