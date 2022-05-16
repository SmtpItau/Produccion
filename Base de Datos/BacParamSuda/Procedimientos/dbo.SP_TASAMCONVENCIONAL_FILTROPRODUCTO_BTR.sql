USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASAMCONVENCIONAL_FILTROPRODUCTO_BTR]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TASAMCONVENCIONAL_FILTROPRODUCTO_BTR    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_TASAMCONVENCIONAL_FILTROPRODUCTO_BTR    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
create procedure [dbo].[SP_TASAMCONVENCIONAL_FILTROPRODUCTO_BTR]
as 
begin
set nocount on
select codigo_producto,descripcion,id_sistema
from PRODUCTO where id_sistema = 'BTR' order by  descripcion
set nocount off
end 

GO
