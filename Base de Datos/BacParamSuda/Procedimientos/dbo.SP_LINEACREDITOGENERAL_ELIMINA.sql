USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_ELIMINA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LineaCreditoGeneral_Elimina    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_ELIMINA]
 @RUTCLIENTE NUMERIC(9),
 @CODCLIENTE NUMERIC(9)
AS BEGIN
SET NOCOUNT ON
 DELETE
  FROM LINEA_GENERAL
   WHERE rut_cliente=@RUTCLIENTE 
    AND codigo_cliente=@CODCLIENTE
SET NOCOUNT OFF
END
--SELECT *  FROM LINEA_GENERAL

GO
