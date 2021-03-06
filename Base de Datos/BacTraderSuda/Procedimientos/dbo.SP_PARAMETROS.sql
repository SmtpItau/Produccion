USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARAMETROS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PARAMETROS]
AS
BEGIN
SELECT acfecproc,
       acfecprox,
       'uf_hoy'    = CONVERT(FLOAT, 0),
       'uf_man'    = CONVERT(FLOAT, 0),
       'ivp_hoy'   = CONVERT(FLOAT, 0),
       'ivp_man'   = CONVERT(FLOAT, 0),
       'do_hoy'    = CONVERT(FLOAT, 0),
       'do_man'    = CONVERT(FLOAT, 0),
       'da_hoy'    = CONVERT(FLOAT, 0),
       'da_man'    = CONVERT(FLOAT, 0),
       acnomprop,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
  INTO #PARAMETROS
  FROM MDAC
/* RESCATA VALOR DE UF -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET uf_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
  FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
  WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
   AND VIEW_VALOR_MONEDA.vmcodigo = 998
 UPDATE #PARAMETROS SET uf_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 998
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */
 UPDATE #PARAMETROS SET ivp_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
 UPDATE #PARAMETROS SET ivp_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
/* RESCATA VALOR DE DO -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET do_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
 UPDATE #PARAMETROS SET do_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
/* RESCATA VALOR DE DA -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET da_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
 UPDATE #PARAMETROS SET da_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
SELECT 'ACFECPROC' = CONVERT(CHAR(10), acfecproc, 103),
       'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
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
       'hora' = CONVERT(varchar(10), GETDATE(), 108)
 FROM #PARAMETROS
END   /* FIN PROCEDIMIENTO */

GO
