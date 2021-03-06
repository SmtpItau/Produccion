USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_LISTABANCOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_LISTABANCOS]
AS BEGIN
SET NOCOUNT ON
SELECT  
 'SUPERRUT'=STR(a.rut_cliente)+'-'+b.cldv,
 a.codigo_cliente,
 b.clnombre,
 STR(a.rut_cliente),
 b.cldv
 
 FROM LINEA_GENERAL a, CLIENTE b
 WHERE a.rut_cliente=b.clrut AND
       b.cltipemp = 1 
 
SET NOCOUNT OFF
END

GO
