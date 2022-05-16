USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasamConvencional_FiltroProducto_BTR]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[Sp_TasamConvencional_FiltroProducto_BTR]
as 
begin
set nocount on
SET DATEFORMAT dmy
select codigo_producto,descripcion,id_sistema
from PRODUCTO where id_sistema = "BTR" order by  descripcion
set nocount off
end 










GO
