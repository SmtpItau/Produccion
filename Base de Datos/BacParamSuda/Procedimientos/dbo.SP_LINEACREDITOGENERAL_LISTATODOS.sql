USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_LISTATODOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_LineaCreditoGeneral_ListaTodos    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_LISTATODOS]
AS BEGIN
SET NOCOUNT ON
SELECT  
 'SUPERRUT'=STR(a.rut_cliente)+'-'+b.cldv,
 a.codigo_cliente,
 b.clnombre,
 STR(a.rut_cliente),
 b.cldv
 
 FROM LINEA_GENERAL a, CLIENTE b
 WHERE a.rut_cliente=b.clrut 
 
SET NOCOUNT OFF
END

GO
