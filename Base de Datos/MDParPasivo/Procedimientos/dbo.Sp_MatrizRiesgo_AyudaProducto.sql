USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MatrizRiesgo_AyudaProducto]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[Sp_MatrizRiesgo_AyudaProducto]
	(@id_sistema char(3))
as begin
SET DATEFORMAT dmy
set nocount on
	select  codigo_producto,
	 	descripcion,
		id_sistema
		 from PRODUCTO where id_sistema=@id_sistema order by codigo_producto 
set nocount off
end


--SP_HELP PRODUCTO








GO
