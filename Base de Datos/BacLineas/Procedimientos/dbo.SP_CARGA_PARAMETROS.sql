USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_PARAMETROS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_PARAMETROS]
AS
BEGIN
set nocount on
SELECT acfecproc,
       acfecprox,
       'UF_Hoy'    = CONVERT(FLOAT, 0),
       'UF_Man'    = CONVERT(FLOAT, 0),
       'IVP_Hoy'   = CONVERT(FLOAT, 0),
       'IVP_Man'   = CONVERT(FLOAT, 0),
       'DO_Hoy'    = CONVERT(FLOAT, 0),
       'DO_Man'    = CONVERT(FLOAT, 0),
       'DA_Hoy'    = CONVERT(FLOAT, 0),
       'DA_Man'    = CONVERT(FLOAT, 0),
       acnomprop,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
  INTO #Parametros
  FROM VIEW_MDAC
/* RESCATA VALOR DE UF -------------------------------------------------------------- */
UPDATE #Parametros SET uf_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA
                 WHERE VALOR_MONEDA.vmfecha  = acfecproc
                   AND VALOR_MONEDA.vmcodigo = 998
UPDATE #Parametros SET uf_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA
                 WHERE VALOR_MONEDA.vmfecha  = acfecprox
                   AND VALOR_MONEDA.vmcodigo = 998
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */
UPDATE #Parametros SET ivp_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA
                 WHERE VALOR_MONEDA.vmfecha  = acfecproc
                   AND VALOR_MONEDA.vmcodigo = 997
UPDATE #Parametros SET ivp_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA
                 WHERE VALOR_MONEDA.vmfecha  = acfecprox
                   AND VALOR_MONEDA.vmcodigo = 997
/* RESCATA VALOR DE DO -------------------------------------------------------------- */
UPDATE #Parametros SET do_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA
                 WHERE VALOR_MONEDA.vmfecha  = acfecproc
                   AND VALOR_MONEDA.vmcodigo = 994
UPDATE #Parametros SET do_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA
                 WHERE VALOR_MONEDA.vmfecha  = acfecprox
                   AND VALOR_MONEDA.vmcodigo = 994
/* RESCATA VALOR DE DA -------------------------------------------------------------- */
UPDATE #Parametros SET da_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA
                 WHERE VALOR_MONEDA.vmfecha  = acfecproc
                   AND VALOR_MONEDA.vmcodigo = 995
UPDATE #Parametros SET da_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
                  FROM VALOR_MONEDA
                 WHERE VALOR_MONEDA.vmfecha  = acfecprox
                   AND VALOR_MONEDA.vmcodigo = 995
SELECT CONVERT(CHAR(10), acfecproc, 103),
       CONVERT(CHAR(10), acfecprox, 103),
       uf_hoy,
       uf_man,
       ivp_hoy,
       ivp_man,
       do_hoy,
       do_man,
       da_hoy,
       da_man,
       acnomprop,
       rut_empresa
 FROM #Parametros
   
END   /* FIN PROCEDIMIENTO */
--Sp_Carga_Parametros
GO
