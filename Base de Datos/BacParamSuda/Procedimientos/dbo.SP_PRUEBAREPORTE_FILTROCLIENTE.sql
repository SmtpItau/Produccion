USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRUEBAREPORTE_FILTROCLIENTE]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_PruebaReporte_FiltroCliente    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_PRUEBAREPORTE_FILTROCLIENTE]
as 
begin
 
 select  clrut ,cldv clcodigo,clnombre                  
 from CLIENTE WHERE clrut > 2 and clrut < 95000000  order by clnombre
 end 

GO
