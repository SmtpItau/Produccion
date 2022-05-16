USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasamConvencional_Buscar]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[Sp_TasamConvencional_Buscar] (@cod_pro  char(5),
					      @cod_mon	numeric(05))
as 
begin
	set nocount on
        SET DATEFORMAT dmy
	select codigo_producto, codigo_moneda, diasdesde ,diashasta ,tasaminima ,tasamaxima ,montominimo, montomaximo           
	from TASAS_MAXIMAS_CONVENCIONAL
	where codigo_producto = @cod_pro and codigo_moneda = @cod_mon
	set nocount off
end 







GO
