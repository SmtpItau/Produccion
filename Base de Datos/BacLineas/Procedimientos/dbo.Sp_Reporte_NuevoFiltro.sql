USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Reporte_NuevoFiltro]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Reporte_NuevoFiltro    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Reporte_NuevoFiltro    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
create procedure [dbo].[Sp_Reporte_NuevoFiltro]
as 
begin
select codigo_producto,descripcion,id_sistema
from PRODUCTO where id_sistema <> "BTR" order by  codigo_producto
END  






GO
