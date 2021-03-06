USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTCARTCAPTACION]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_listcartcaptacion    fecha de la secuencia de comandos: 05/04/2001 13:13:40 ******/
CREATE PROCEDURE [dbo].[SP_LISTCARTCAPTACION]
               ( @entidad numeric   (10,0) )
as
begin
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
if exists(select * from 
--   GEN_CAPTACION  a,
   VIEW_MONEDA   m,
   VIEW_CLIENTE  c,
   VIEW_ENTIDAD  r,
   MDRS rs RIGHT OUTER JOIN GEN_CAPTACION a ON  rs.rsrutcart = a.entidad
									    	and rs.rsnumdocu = a.numero_operacion
											and rs.rscorrela = a.correla_operacion
  where
         (a.estado  <> 'R' 
  and a.estado  <>     'A'
  and a.estado <> 'V')
  and m.mncodmon  = a.moneda 
  and c.clrut  = a.rut_cliente
  and c.clcodigo =  a.codigo_rut
  and     r.rcrut  =  a.entidad   
/*
  and rs.rsrutcart  =*   a.entidad
  and rs.rsnumdocu =* a.numero_operacion
  and rs.rscorrela =* a.correla_operacion
*/
  and (@entidad = 0 or a.entidad = @entidad)   )
begin  
  select 
                        'pmfecproc' = convert(char(10), pmfecproc, 103),
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
   'tipo_operacion'=a.tipo_operacion    ,
   'mnnemo'=m.mnnemo     ,
   'monto_inicio'=a.monto_inicio     ,
   'tasa'=a.tasa      ,
   'tasa_tran'=a.tasa_tran     ,
   'mnbase'=m.mnbase     ,
   'fechaini'=convert(char(10),a.fecha_operacion,103)  ,
   'fechafin'=convert(char(10),a.fecha_vencimiento,103) ,
   'plazo'=a.plazo      ,
   'monto_inicio_pesos'=a.monto_inicio_pesos    ,
   'monto_final'=a.monto_final     ,
   'valor_presente'=a.valor_presente    ,    
   'rsinteres_acumulado'=isnull(rs.rsinteres_acumulado,0)     ,
   'rsreajuste_acumulado'=isnull(rs.rsreajuste_acumulado,0)    ,   
   'rsvppresenx'=isnull(rs.rsvppresenx,0)     ,
   'clnombre'=c.clnombre     ,
   'rcnombre'=r.rcnombre      ,   
   'custodia'=case custodia when 'D' then 'DCV' when 'P' then 'PROPIA' when 'C' then 'CLIENTE' else 'NO' end,
   'estado'=a.estado,
   'fechaori'=convert(char(10),a.fecha_origen,103) 
  from 
   #PARAMETROS,
   --  REQ. 7619
   GEN_CAPTACION  a  RIGHT OUTER JOIN MDRS  rs ON rs.rsrutcart = a.entidad
                                              AND rs.rsnumdocu = a.numero_operacion
                                              AND rs.rscorrela = a.correla_operacion,                                        
   VIEW_MONEDA   m,
   VIEW_CLIENTE  c,
   VIEW_ENTIDAD  r  
--  REQ. 7619
--   MDRS  rs
  where
      (a.estado  <> 'R' 
  and a.estado  <>  'A'
  and a.estado <> 'V')
  and m.mncodmon  = a.moneda 
  and c.clrut  = a.rut_cliente
  and c.clcodigo =  a.codigo_rut
  and r.rcrut  =  a.entidad   
--  REQ. 7619
 /*and rs.rsrutcart  =*   a.entidad
  and rs.rsnumdocu =* a.numero_operacion
  and rs.rscorrela =* a.correla_operacion */
  and (@entidad = 0 or a.entidad = @entidad)
end 
else
begin  
  select 
                        'pmfecproc' = convert(char(10), pmfecproc, 103),
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
   'numoper'='',
   'tipo_operacion'='',
   'mnnemo'='',
   'monto_inicio'='',
   'tasa'='',
   'tasa_tran'='',
   'mnbase'='',
   'fechaini'='',
   'fechafin'='',
   'plazo'='',
   'monto_inicio_pesos'='',
   'monto_final'='',
   'valor_presente'='',
   'rsinteres_acumulado'='',
   'rsreajuste_acumulado'='',
   'rsvppresenx'='',
   'clnombre'='',
   'rcnombre'='',
   'custodia'='',
   'estado'='',
   'fechaori'=''
  from 
       #PARAMETROS
   end
end
/*
select * from GEN_CAPTACION
*/


GO
