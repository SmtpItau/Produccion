USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoGeneral_ListaFiliales]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_LineaCreditoGeneral_ListaFiliales]
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
       b.cltipemp <> 1 
 
SET NOCOUNT OFF
END






GO
