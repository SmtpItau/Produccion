USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTTABLASGENERALES]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_listtablasgenerales    fecha de la secuencia de comandos: 05/04/2001 13:13:40 ******/
CREATE PROCEDURE [dbo].[SP_LISTTABLASGENERALES]
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
update #PARAMETROS set do_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
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
   if exists( select * from MDAC
                 --  REQ. 7619
                   , VIEW_TABLA_GENERAL_DETALLE LEFT OUTER JOIN MDTB ON VIEW_TABLA_GENERAL_DETALLE.tbcateg = MDTB.ctcateg 
                 --, MDTB
                 where 
                 --  REQ. 7619
                   /*VIEW_TABLA_GENERAL_DETALLE.tbcateg *= MDTB.ctcateg 
                   and*/ ltrim(rtrim(VIEW_TABLA_GENERAL_DETALLE.tbglosa)) <> ''
            ) begin
      select 'acfecproc' = convert(char(10), #PARAMETROS.acfecproc, 103),
             'acfecprox' = convert(char(10), #PARAMETROS.acfecprox, 103),
             uf_hoy,
             uf_man,
             ivp_hoy,
             ivp_man,
             do_hoy,
             do_man,
             da_hoy,
             da_man,
             #PARAMETROS.acnomprop,
             rut_empresa,
             'hora' = convert(varchar(10), getdate(), 108),
             'nomemp'     = isnull( MDAC.acnomprop, ''),
             'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
             'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
             'codtab'     = isnull( VIEW_TABLA_GENERAL_DETALLE.tbcateg,0),
             'glosa'      = isnull( MDTB.ctdescrip,''),
             'tipmant'    = space(1),
             'codigo'     = isnull( VIEW_TABLA_GENERAL_DETALLE.tbcodigo1,'0'),
             'tcglosa'    = isnull( VIEW_TABLA_GENERAL_DETALLE.tbglosa,'')
        from 
             MDAC
        --  REQ. 7619
           , VIEW_TABLA_GENERAL_DETALLE LEFT OUTER JOIN MDTB ON VIEW_TABLA_GENERAL_DETALLE.tbcateg = MDTB.ctcateg 
        --   , MDTB
           , #PARAMETROS
        where 
        --  REQ. 7619 
        /*   VIEW_TABLA_GENERAL_DETALLE.tbcateg *= MDTB.ctcateg 
        and*/ltrim(rtrim(VIEW_TABLA_GENERAL_DETALLE.tbglosa)) <> ''
        order by 
             VIEW_TABLA_GENERAL_DETALLE.tbcateg, VIEW_TABLA_GENERAL_DETALLE.tbcodigo1 end
   else begin
      select 'acfecproc' = convert(char(10), acfecproc, 103),
             'acfecprox' = convert(char(10), acfecprox, 103),
             uf_hoy,
             uf_man,
             ivp_hoy,
             ivp_man,
             do_hoy,
             do_man,
             da_hoy,
             da_man,
             acnomprop,
             rut_empresa,
             'hora' = convert(varchar(10), getdate(), 108),
             'nomemp'     = '         ',
             'rutemp'     = '         ',
             'fecpro'     = '         ',
             'codtab'     = '         ',
             'glosa'      = '         ',
             'tipmant'    = '         ',
             'codigo'     = '         ',
             'tcglosa'    = '         '
        from 
             #PARAMETROS
   end
 end


GO
