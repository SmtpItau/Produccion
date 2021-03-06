USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTMOVCAPTACION]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTMOVCAPTACION]
                  ( @entidad numeric(10,0) )
as
begin
declare @dfecproc datetime
select 'pmfecproc' = acfecproc,
       'pmfecprox' = acfecprox,
       'uf_hoy'    = convert(float, 0),
       'uf_man'    = convert(float, 0),
       'ivp_hoy'   = convert(float, 0),
       'ivp_man'   = convert(float, 0),
       'do_hoy'    = convert(float, 0),
       'do_man'    = convert(float, 0),
       'da_hoy'    = convert(float, 0),
       'da_man'    = convert(float, 0),
       'pmnomprop' = acnomprop,
       'rut_empresa' = rtrim(convert(char(10),acrutprop)) + '-' + acdigprop
  into #PARAMETROS
  from MDAC
/* rescata valor de uf -------------------------------------------------------------- */
update #PARAMETROS set uf_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
update #PARAMETROS set uf_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
/* rescata valor de ivp ------------------------------------------------------------- */
update #PARAMETROS set ivp_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
update #PARAMETROS set ivp_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
/* rescata valor de do -------------------------------------------------------------- */
update #PARAMETROS set do_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
update #PARAMETROS set do_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
/* rescata valor de da -------------------------------------------------------------- */
update #PARAMETROS set da_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 995
update #PARAMETROS set da_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 995
 
 select @dfecproc = acfecproc from MDAC 
if exists(select * from
          GEN_CAPTACION  a,
  VIEW_MONEDA   m,
          VIEW_CLIENTE  c,
  VIEW_ENTIDAD  r
  where
   a.estado  <> 'A' 
  and m.mncodmon  = a.moneda 
  and c.clrut  = a.rut_cliente
  and c.clcodigo =  a.codigo_rut
  and     r.rcrut  =  a.entidad  
  and a.fecha_operacion = @dfecproc
  and (@entidad = 0 or a.entidad = @entidad)   )
begin
        select 'pmfecproc' = convert(char(10), pmfecproc, 103),
               'pmfecprox' = convert(char(10), pmfecprox, 103),
                uf_hoy,
                uf_man,
                ivp_hoy,
                ivp_man,
                do_hoy,
                do_man,
                da_hoy,
                da_man,
                pmnomprop,
                rut_empresa,
                'hora' = convert(varchar(10), getdate(), 108),
  'numoper'=rtrim(convert(char(10),a.numero_operacion))+'-'+rtrim(convert(char(10),a.correla_operacion)),      
  a.tipo_operacion    ,
  m.mnnemo     ,
  a.monto_inicio     ,
  a.tasa      ,
  a.tasa_tran     ,
  m.mnbase     ,
  'fechaini'=convert(char(10),a.fecha_operacion,103),
  'fechafin'=convert(char(10),a.fecha_vencimiento,103),
  a.plazo      ,
  a.monto_inicio_pesos    ,
  a.monto_final     ,
  a.valor_presente    ,    
  0        ,
  0       ,   
  a.valor_presente    ,
  c.clnombre     ,
  r.rcnombre      ,   
  custodia=case custodia when 'D' then 'DCV' when 'P' then 'PROPIA' when 'C' then 'CLIENTE' else 'NO' end,
  'fechaori'=convert(char(10),a.fecha_origen,103) 
  from 
  GEN_CAPTACION  a,
  VIEW_MONEDA   m,
          VIEW_CLIENTE  c,
  VIEW_ENTIDAD  r,
                #PARAMETROS
  where
   a.estado  <> 'A' 
  and m.mncodmon  = a.moneda 
  and c.clrut  = a.rut_cliente
  and c.clcodigo =  a.codigo_rut
  and     r.rcrut  =  a.entidad  
  and a.fecha_operacion = @dfecproc
  and (@entidad = 0 or a.entidad = @entidad)  
end 
else
begin
        select 'pmfecproc' = convert(char(10), pmfecproc, 103),
               'pmfecprox' = convert(char(10), pmfecprox, 103),
                uf_hoy,
                uf_man,
                ivp_hoy,
                ivp_man,
                do_hoy,
                do_man,
                da_hoy,
                da_man,
                pmnomprop,
                rut_empresa,
                'hora' = convert(varchar(10), getdate(), 108),
  'numoper'               = '',
  'a.tipo_operacion'      = '',
  'm.mnnemo'              = '',
  'a.monto_inicio'        = '',
  'a.tasa'         = '',
  'a.tasa_tran'           = '',
  'm.mnbase'              = '',
  'fechaini'              = '',
  'fechafin'              = '',
  'a.plazo'         = '',
  'a.monto_inicio_pesos'  = '',
  'a.monto_final'         = '',
  'a.valor_presente'      = '',
  0         ,
  0                      ,   
  'a.valor_presente'      = '',
  'c.clnombre'            = '',
  'r.rcnombre'            = '',
  custodia                = '',
  fechaori                = ''
  from 
                #PARAMETROS
   end 
end
/* sp_listmovcaptacion 0
*/


GO
