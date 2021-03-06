USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GEN_CERTIFICADO_VP]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GEN_CERTIFICADO_VP] 
            (   @numero_operacion   numeric( 6) )
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
select  'fecha'        = convert(char(10),mofecpro,103)              ,
 'cliente'      = clnombre                                    ,
 'pais'        = tbglosa                                     ,
 'rut'          = rtrim(convert(char(10),clrut)) + '-' + cldv ,
 'instrumento'  = moinstser                                   ,
 'fecha_vcto'   = convert(char(10),mofecven,103)              ,
 'valor_efec'   = movalven                                    ,
 'valor_nomi'   = monominal                                   ,
 'valor_total'  = (select sum(movalven) from MDMO where monumoper = @numero_operacion),
 'forma_pago'   = glosa                                       ,
        'pagina'       = 1           ,
        'numero'       = monumoper   
into #TEMP1
from  MDMO, VIEW_FORMA_DE_PAGO, VIEW_CLIENTE  ,VIEW_TABLA_GENERAL_DETALLE
where monumoper = @numero_operacion    and
      motipoper = 'VP'                 and
      moforpagi = codigo             and
      clrut     = morutcli             and
      clcodigo  = mocodcli             and  
      tbcateg   = 180     and
      clpais    = convert(numeric(4),tbcodigo1)         
 
 
   
      select * from #TEMP1,#PARAMETROS     
end
/*(select sum(movalven) from MDMO where monumoper = @numero_operacion and motipoper = 'vi' group by movalven)*/
--select * from MDMO


GO
