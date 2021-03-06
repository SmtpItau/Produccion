USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCACAPTAVENCIDAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCACAPTAVENCIDAS]
                                      ( @nrutcli  numeric(9,0) ,
     @ncodcli  numeric(9,0) )
as
begin
set nocount on
 if exists(select *  from GEN_CAPTACION, MDAC where estado='V' )
 begin        
  if  @nrutcli = 0
  begin 
   select 
    'NUMOPER'=a.numero_operacion,      
    c.clnombre ,
    a.monto_inicio ,
    a.tasa  ,
    m.mnnemo ,
    convert(char(10),fecha_vencimiento,103) ,
    a.monto_final ,
    a.valor_presente ,
    a.interes_acumulado + a.interes_extra,
    a.reajuste_acumulado + a.reajuste_extra,   
    case custodia when 'D' then 'DCV' when 'P' then 'PROPIA' when 'C' then 'CLIENTE' else 'NO' end,
    rtrim(convert(char(05),a.correla_operacion))
   from
    GEN_CAPTACION a,
    MDAC  b,
    VIEW_CLIENTE  c,
    VIEW_MONEDA   m
   where
    c.clrut  = rut_cliente 
   and c.clcodigo  = codigo_rut
   and m.mncodmon  = a.moneda
   and a.estado  = 'V' 
--   and a.tipo_deposito ='r'
   and  fecha_vencimiento <=  acfecproc 
  end
  else
  begin
   select 
    'NUMOPER'=a.numero_operacion,      
    c.clnombre ,
    a.monto_inicio ,
    a.tasa  ,
    m.mnnemo ,
    convert(char(10),fecha_vencimiento,103) ,
    a.monto_final ,
    a.valor_presente ,
    a.interes_acumulado + a.interes_extra,
    a.reajuste_acumulado + a.reajuste_extra,   
   case custodia when 'D' then 'DCV' when 'P' then 'PROPIA' when 'C' then 'CLIENTE' else 'NO' end,
    rtrim(convert(char(05),a.correla_operacion))
   from
    GEN_CAPTACION a,
    MDAC  b,
    VIEW_CLIENTE  c,
    VIEW_MONEDA   m
   where
    c.clrut = rut_cliente 
   and   c.clcodigo = codigo_rut
   and a.rut_cliente = @nrutcli 
   and  a.codigo_rut = @ncodcli
   and m.mncodmon = a.moneda
   and  a.estado = 'V' 
   and  fecha_vencimiento <=  acfecproc 
 --  and a.tipo_deposito ='r'
  end
 end
 else
  SELECT 'NO', 'NO EXISTEN CAPTACIONES VENCIDAS'
 
end
-- sp_buscainterbancario 22801
-- sp_buscacaptacion 21
-- select momonpact,mnnemo from MDMO,VIEW_MONEDA 
-- select * from VIEW_CLIENTE
-- select * from GEN_CAPTACION a , MDAC b where a.fecha_vencimiento <= b.acfecproc 
-- update GEN_CAPTACION set estado = 'e'
-- execute sp_buscacaptavencidas   97004000, 1
-- sp_buscacaptavencidas 0,0
-- select numero_operacion,fecha_vencimiento, estado,* from GEN_CAPTACION
-- update  MDAC set acfecproc = '20001026'
-- select * from GEN_OPERACIONES


GO
