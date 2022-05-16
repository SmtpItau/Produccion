USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTE_NUEVOFILTRO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_REPORTE_NUEVOFILTRO    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_REPORTE_NUEVOFILTRO    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
create procedure [dbo].[SP_REPORTE_NUEVOFILTRO]
as 
begin
select codigo_producto,descripcion,id_sistema
from PRODUCTO where id_sistema <> 'BTR' order by  codigo_producto
END  

GO
