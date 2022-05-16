USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasamConvencional_Buscar]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TasamConvencional_Buscar    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
create procedure [dbo].[Sp_TasamConvencional_Buscar] (@cod_pro  char(5),
           @cod_mon numeric(05))
as 
begin
 set nocount on
 select codigo_producto, codigo_moneda, diasdesde ,diashasta ,tasaminima ,tasamaxima ,montominimo, montomaximo           
 from TASAS_MAXIMAS_CONVENCIONAL
 where codigo_producto = @cod_pro and codigo_moneda = @cod_mon
 set nocount off
end 






GO
