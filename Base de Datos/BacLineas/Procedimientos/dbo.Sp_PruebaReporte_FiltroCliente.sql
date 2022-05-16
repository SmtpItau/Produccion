USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_PruebaReporte_FiltroCliente]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_PruebaReporte_FiltroCliente    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
create procedure  [dbo].[Sp_PruebaReporte_FiltroCliente]
as 
begin
 
 select  clrut ,cldv clcodigo,clnombre                  
 from CLIENTE WHERE clrut > 2 and clrut < 95000000  order by clnombre
 end 






GO
