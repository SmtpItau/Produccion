USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMPROBANTE_DEPOSITOPLAZO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_COMPROBANTE_DEPOSITOPLAZO] ( @xnumerooperacion numeric(10) ,
      @xsistema  char(3)  ,
      @xtipooperacion  char(5)  )
as
begin
set nocount on
declare @entidad  char(70),
 @rut      char(13),
 @direccion char(70)
        select    @entidad   = rcnombre       ,  
    @rut       = rtrim(str(rcrut))+ '-' + rcdv    ,  
    @direccion = rcdirecc       
 from     VIEW_ENTIDAD, GEN_OPERACIONES   
 where   GEN_OPERACIONES.entidad = rcrut
select           'operaciones'      = d.numero_operacion                ,
                 'monto_inicio'     = sum(monto_inicio)         ,  --1
          'monto_final'      = sum(monto_final)      ,  --2
                 'plazo'            = plazo       ,  --3
          'tasa'             = tasa       ,  --4
   'fecha_operacion'  = convert(char(10),a.fecha_operacion,103) ,  --5
          'fecha_vcto'       = convert(char(10),d.fecha_vencimiento,103)   ,  --6
          'nombre_cliente'   = clnombre          ,    --7
          'rut_cliente'      = rtrim(str(a.rut_cliente))+ '-' + cldv ,  --8
   'dieccion_cliente' = cldirecc       ,               --9 
   'sublinea'         = (case tipo_deposito when 'r' then (case mncodmon when 13  then 'DEPOSITO A PLAZO RENOVABLE EN DOLARES' 
                                     when 999 then 'DEPOSITO A PLAZO RENOVABLE EN PESOS'
                      when 998 then 'DEPOSITO A PLAZO RENOVABLE EN UNIDAD DE FOMENTO'  
                      when 994 then 'DEPOSITO A PLAZO RENOVABLE EN DOLAR OBSERVADO'   
                                      else 'DEPOSITO A PLAZO RENOBABLE'   
                             end) 
                  else (case mncodmon when 13  then 'DEPOSITO A PLAZO FIJO EN DOLARES'
                           when 999 then 'DEPOSITO A PLAZO FIJO EN PESOS' 
                          when 998 then 'DEPOSITO A PLAZO FIJO EN UNIDAD DE FOMENTO'
                    when 994 then 'DEPOSITO A PLAZO FIJO EN DOLARES OBSERVADOS'              
                    else 'DEPOSITO A PLAZO FIJO'
                    end)
         end)             ,  --10
   'razon_social'     = @entidad       ,  --11
   'rut_razon_social' = @rut       ,  --12
   'direccion_razon'  = @direccion      ,  --13
   'custodia'         = (case custodia when 'P' then 'PROPIA' 
                                                     when 'D' then 'DCV'
           when 'C' then 'CLIENTE'
                   else '--'
                         end)                                       ,               --15
   'moneda1'           = mnnemo
         from  GEN_OPERACIONES     a,
  VIEW_CLIENTE b,
  VIEW_MONEDA  c,
  GEN_CAPTACION     d 
   where  a.operacion      = @xnumerooperacion
   and a.tipo_operacion = @xtipooperacion
   and     id_sistema                     = @xsistema
   and a.rut_cliente    = clrut   
   and     d.moneda           = mncodmon
   and     d.numero_operacion = @xnumerooperacion  
   and     a.operacion      = d.numero_operacion
 
 group by d.numero_operacion ,
   d.plazo            ,
   d.tasa             ,
   a.fecha_operacion, 
   d.fecha_vencimiento,
   b.clnombre                  ,
   a.rut_cliente    ,
   b.cldv                      , 
   b.cldirecc                  ,
   c.mncodmon                  ,
   d.tipo_deposito    , 
   d.custodia  ,
   mnnemo
 
end
-- sp_comprobante_depositoplazo 1,'btr','IC'
-- select * from GEN_OPERACIONES where tipo_operacion = 'IC' order by tipo_operacion,operacion
-- select * from GEN_PAGOS_OPERACION
-- select * from VIEW_MONEDA order by mncodmon
-- select * from mdrc
-- select * from VIEW_CLIENTE
--select * from GEN_CAPTACION


GO
