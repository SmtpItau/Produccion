USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_BUSCA_SW]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_BUSCA_SW] 
 (
  @Codpro char(5) ,
  @Moneda char(5)
)
 as begin
 set nocount on
  select 
  Codigo_Producto,
  moneda   ,
  DiasDesde  ,
  DiasHasta  ,
  Porcentaje
  from  matriz_riesgo_swap 
  where codigo_producto = @codpro 
    and moneda = @moneda
  order by diasdesde
 set nocount off
end

GO
