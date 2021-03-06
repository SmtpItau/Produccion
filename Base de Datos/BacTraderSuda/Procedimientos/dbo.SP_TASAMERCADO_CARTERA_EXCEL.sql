USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASAMERCADO_CARTERA_EXCEL]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TASAMERCADO_CARTERA_EXCEL]
     (
     @fecproc datetime
     --@escenario integer
     )
as
begin
   set nocount on
 select
  tipo_operacion      ,
  rminstser           ,
  rut_emisor          ,
  rmcodigo            ,
  moneda_emision      , 
  fecha_valorizacion  ,
  inserie             ,   --1
  tasa_compra         ,
  tasa_mercado        ,
  codigo_carterasuper ,
  --rmfecvcto,
  sum ( valor_nominal ),
  sum ( valor_presente ),
  sum ( valor_mercado )
 from
   valorizacion_mercado
  ,  view_instrumento  --mdin
--  select * from  mdin
--    valorizacion_mercado
                  
--select * from view_instrumento
 where
  incodigo      = rmcodigo
 and fecha_valorizacion = @fecproc     ---fecha_proceso
-- and codigoesc     = @escenario
 group by
  tipo_operacion,
  rminstser,
  rut_emisor,
  rmcodigo,
  moneda_emision,
  fecha_valorizacion,
  inserie,
  tasa_compra,
  tasa_mercado,
  codigo_carterasuper
  --rmfecvcto,
 order by
  tipo_operacion,
  rminstser,
  rut_emisor,
  rmcodigo,
  moneda_emision,
  fecha_valorizacion,
  inserie,
  tasa_compra,
  tasa_mercado,
  codigo_carterasuper
  --rmfecvcto, 
   set nocount off
end

GO
