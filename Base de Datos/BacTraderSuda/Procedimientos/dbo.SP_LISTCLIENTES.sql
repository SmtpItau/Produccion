USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTCLIENTES]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LISTCLIENTES] /*(@hora char (10))*/
 as
 begin
 select acfecproc,
         acfecprox,
         'uf_hoy'    = convert(float, 0),
         'uf_man'    = convert(float, 0),
         'ivp_hoy'   = convert(float, 0),
         'ivp_man'   = convert(float, 0),
         'do_hoy'    = convert(float, 0),
         'do_man'    = convert(float, 0),
         'da_hoy'    = convert(float, 0),
         'da_man'    = convert(float, 0),
         acnomprop,
       'rut_empresa' = rtrim(convert(char(10),acrutprop)) + '-' + acdigprop
  into #PARAMETROS
  from MDAC
/* rescata valor de uf -------------------------------------------------------------- */
update #PARAMETROS set uf_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
update #PARAMETROS set uf_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
/* rescata valor de ivp ------------------------------------------------------------- */
update #PARAMETROS set ivp_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
update #PARAMETROS set ivp_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
/* rescata valor de do -------------------------------------------------------------- */
update #PARAMETROS set do_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)  --  REQ. 7619
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
update #PARAMETROS set do_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
/* rescata valor de da -------------------------------------------------------------- */
update #PARAMETROS set da_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 995
update #PARAMETROS set da_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 995
  select 'nomemp'     = isnull( MDAC.acnomprop, ''),
         'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
         'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
  'rut_cli'    = isnull( ( rtrim (convert( char(9), VIEW_CLIENTE.clrut ) ) + '-' + VIEW_CLIENTE.cldv ),'' ),
  'cod_cli'    = isnull( VIEW_CLIENTE.clcodigo,0),
         'nom_cli'    = isnull( VIEW_CLIENTE.clnombre,''),
         'dir_cli'    = isnull( VIEW_CLIENTE.cldirecc,''),
  'gen_cli'    = isnull( VIEW_CLIENTE.clgeneric,''),
         'com_cli'    = isnull( VIEW_CIUDAD_COMUNA.nom_ciu,''),
         'reg_cli'    = isnull( VIEW_CLIENTE.clregion,0),
         'sec_cli'    = isnull( MDTC.tbglosa,''),
  'tip_cli'    = isnull(a.tbglosa,''),
  'fec_cli'    = convert( char(10),VIEW_CLIENTE.clfecingr,103),
         'cta_cli'    = isnull( VIEW_CLIENTE.clctacte,''),                 
         'fax_cli'    = isnull( VIEW_CLIENTE.clfax,''),
         'tel_cli'    = isnull( VIEW_CLIENTE.clfono,''),
  'acfecproc'  = convert(char(10),p.acfecproc, 103),   
         'acfecprox'  =  convert(char(10), p.acfecproc, 103),
         'uf_hoy'     =  isnull(p.uf_hoy,0),
         'uf_man'     =  isnull(p.uf_man,0),
         'ivp_hoy'    =  isnull(p.ivp_hoy,0),
         'ivp_man'    =  isnull(p.ivp_man,0),
         'do_hoy'     =  isnull(p.do_hoy,0),
         'do_man'     =  isnull(p.do_man,0),
         'da_hoy'     =  isnull(p.da_hoy,0),
         'da_man'     =  isnull(p.uf_hoy,0),
         'acnomprop'  =  convert( char(10),p.acnomprop),
         'rut_empresa'=  convert( char(10),p.rut_empresa),
   'hora'       =  convert( char(30),getdate(),108)
 
  from MDAC
--  REQ. 7619       
     , VIEW_CLIENTE LEFT OUTER JOIN VIEW_CIUDAD_COMUNA ON VIEW_CLIENTE.clciudad = VIEW_CIUDAD_COMUNA.cod_ciu 
                                                      AND VIEW_CLIENTE.clcomuna = VIEW_CIUDAD_COMUNA.cod_com 
                    LEFT OUTER JOIN MDTC ON VIEW_CLIENTE.clcompint = convert(numeric(6),MDTC.tbcodigo1) 
                                        AND MDTC.tbcateg = 41 
                    LEFT OUTER JOIN MDTC a  ON VIEW_CLIENTE.cltipcli = convert(numeric(6),a.tbcodigo1)
                                           AND a.tbcateg = 207 
--     , VIEW_CIUDAD_COMUNA 
--     , MDTC
--     , MDTC a
     , #PARAMETROS p
  where 
--  REQ. 7619
  -- VIEW_CLIENTE.clciudad *= VIEW_CIUDAD_COMUNA.cod_ciu  
  -- and VIEW_CLIENTE.clcompint *= convert(numeric(6),MDTC.tbcodigo1)
  -- and MDTC.tbcateg = 41
  -- and VIEW_CLIENTE.cltipcli *= convert(numeric(6),a.tbcodigo1)
  -- and a.tbcateg = 207
  -- and VIEW_CLIENTE.clcomuna *= VIEW_CIUDAD_COMUNA.cod_com   and
     VIEW_CLIENTE.clrut <> MDAC.acrutprop 
 end
-- sp_listclientes
--  sp_helptext sp_listclientes
--select * from VIEW_VALOR_MONEDA where VIEW_VALOR_MONEDA.vmcodigo = 997


GO
