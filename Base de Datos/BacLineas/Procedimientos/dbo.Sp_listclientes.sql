USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_listclientes]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_listclientes] /*(@hora CHAR (10))*/
 AS
 BEGIN
 SET NOCOUNT ON
 SELECT acfecproc,
         acfecprox,
         'uf_hoy'    = CONVERT(float, 0),
         'uf_man'    = CONVERT(float, 0),
         'ivp_hoy'   = CONVERT(float, 0),
         'ivp_man'   = CONVERT(float, 0),
         'do_hoy'    = CONVERT(float, 0),
         'do_man'    = CONVERT(float, 0),
         'da_hoy'    = CONVERT(float, 0),
         'da_man'    = CONVERT(float, 0),
         acnomprop,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + "-" + acdigprop
  into #PARAMETROS
  FROM VIEW_MDAC
/* rescata valor de uf -------------------------------------------------------------- */
UPDATE #PARAMETROS SET uf_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE VALOR_MONEDA.vmfecha  = acfecproc
                   and VALOR_MONEDA.vmcodigo = 998
UPDATE #PARAMETROS SET uf_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE VALOR_MONEDA.vmfecha  = acfecprox
                   and VALOR_MONEDA.vmcodigo = 998
/* rescata valor de ivp ------------------------------------------------------------- */
UPDATE #PARAMETROS SET ivp_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE VALOR_MONEDA.vmfecha  = acfecproc
                   and VALOR_MONEDA.vmcodigo = 997
UPDATE #PARAMETROS SET ivp_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE VALOR_MONEDA.vmfecha  = acfecprox
                   and VALOR_MONEDA.vmcodigo = 997
/* rescata valor de do -------------------------------------------------------------- */
UPDATE #PARAMETROS SET do_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE VALOR_MONEDA.vmfecha  = acfecproc
                   and VALOR_MONEDA.vmcodigo = 994
UPDATE #PARAMETROS SET do_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE VALOR_MONEDA.vmfecha  = acfecprox
                   and VALOR_MONEDA.vmcodigo = 994
/* rescata valor de da -------------------------------------------------------------- */
UPDATE #PARAMETROS SET da_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE VALOR_MONEDA.vmfecha  = acfecproc
                   and VALOR_MONEDA.vmcodigo = 995
UPDATE #PARAMETROS SET da_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA 
                 WHERE VALOR_MONEDA.vmfecha  = acfecprox
                   and VALOR_MONEDA.vmcodigo = 995
  SELECT 'nomemp'     = ISNULL( VIEW_MDAC.acnomprop, ''),
                'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), VIEW_MDAC.acrutprop ) ) + "-" + VIEW_MDAC.acdigprop ),"" ),
                'fecpro'     = CONVERT(CHAR(10), VIEW_MDAC.acfecproc, 103),
  'rut_cli'    = ISNULL( ( RTRIM (CONVERT( CHAR(9), CLIENTE.clrut ) ) + "-" + CLIENTE.cldv ),"" ),
  'cod_cli'    = ISNULL( CLIENTE.clcodigo,0),
                'nom_cli'    = ISNULL( CLIENTE.clnombre,''),
                'dir_cli'    = ISNULL( CLIENTE.cldirecc,''),
  'gen_cli'    = ISNULL( CLIENTE.clgeneric,''),
                'com_cli'    = ISNULL( CIUDAD_COMUNA.nom_ciu,''),
                'reg_cli'    = ISNULL( CLIENTE.clregion,0),
                'sec_cli'    = ISNULL( MDTC.tbglosa,''),
  'tip_cli'    = ISNULL(a.tbglosa,''),
  'fec_cli'    = CONVERT( CHAR(10),CLIENTE.clfecingr,103),
                'cta_cli'    = ISNULL( CLIENTE.clctacte,''),                 
                'fax_cli'    = ISNULL( CLIENTE.clfax,''),
                'tel_cli'    = ISNULL( CLIENTE.clfono,''),
  'acfecproc'  = CONVERT(CHAR(10),p.acfecproc, 103),   
         'acfecprox' =  CONVERT(CHAR(10), p.acfecproc, 103),
         'uf_hoy'    =  ISNULL(p.uf_hoy,0),
         'uf_man'    =  ISNULL(p.uf_man,0),
         'ivp_hoy'   =  ISNULL(p.ivp_hoy,0),
         'ivp_man'   =  ISNULL(p.ivp_man,0),
         'do_hoy'    =  ISNULL(p.do_hoy,0),
         'do_man'    =  ISNULL(p.do_man,0),
         'da_hoy'    =  ISNULL(p.da_hoy,0),
         'da_man'    =  ISNULL(p.uf_hoy,0),
         'acnomprop' =  CONVERT( CHAR(10),p.acnomprop),
                'rut_empresa'= CONVERT( CHAR(10),p.rut_empresa),
  'hora'       = CONVERT( CHAR(30),GETDATE(),108)
 
         FROM VIEW_MDAC, CLIENTE, CIUDAD_COMUNA ,MDTC, MDTC a, #PARAMETROS p
  WHERE CLIENTE.clciudad *= CIUDAD_COMUNA.cod_ciu  
  and CLIENTE.clcompint *= CONVERT(NUMERIC(6),MDTC.tbcodigo1)
  and MDTC.tbcateg = 41
  and CLIENTE.cltipcli *= CONVERT(NUMERIC(6),a.tbcodigo1)
  and a.tbcateg = 207
  and CLIENTE.clcomuna *= CIUDAD_COMUNA.cod_com 
  and CLIENTE.clrut <> VIEW_MDAC.acrutprop 
 
  SET NOCOUNT OFF
 end
-- sp_listclientes
--  sp_helptext sp_listclientes
----SELECT * FROM CIUDAD_COMUNA






GO
