USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_CODIGO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Busca_Codigo    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
CREATE PROCEDURE [dbo].[SP_BUSCA_CODIGO]
  ( @rut_cliente  numeric(9)=0)
   
   
AS   
BEGIN
 SELECT  CLIENTE.clcodigo
               
 FROM    CLIENTE
 WHERE   (CLIENTE.clrut= @rut_cliente)
 
END 
GO
