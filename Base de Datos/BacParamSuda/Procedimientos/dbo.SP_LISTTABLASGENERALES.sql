USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTTABLASGENERALES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTTABLASGENERALES]
 AS 
 BEGIN
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
UPDATE #Parametros SET uf_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecproc
                   AND MDVM.vmcodigo = 998
UPDATE #Parametros SET uf_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecprox
                   AND MDVM.vmcodigo = 998
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */
UPDATE #Parametros SET ivp_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecproc
                   AND MDVM.vmcodigo = 997
UPDATE #Parametros SET ivp_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecprox
                   AND MDVM.vmcodigo = 997
/* RESCATA VALOR DE DO -------------------------------------------------------------- */
UPDATE #Parametros SET do_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecproc
                   AND MDVM.vmcodigo = 994
UPDATE #Parametros SET do_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecprox
                   AND MDVM.vmcodigo = 994
/* RESCATA VALOR DE DA -------------------------------------------------------------- */
UPDATE #Parametros SET da_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecproc
                   AND MDVM.vmcodigo = 995
UPDATE #Parametros SET da_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecprox
                   AND MDVM.vmcodigo = 995
   IF EXISTS( SELECT 1 FROM VIEW_MDAC, TABLA_GENERAL_DETALLE
		LEFT JOIN  TABLA_GENERAL_GLOBAL ON TABLA_GENERAL_DETALLE.tbcateg = TABLA_GENERAL_GLOBAL.ctcateg
                 WHERE LTRIM(RTRIM(TABLA_GENERAL_DETALLE.tbglosa)) <> ''
            ) BEGIN
      SELECT 'ACFECPROC' = CONVERT(CHAR(10), #parametros.acfecproc, 103),
             'ACFECPROX' = CONVERT(CHAR(10), #parametros.acfecprox, 103),
             uf_hoy,
             uf_man,
             ivp_hoy,
             ivp_man,
             do_hoy,
             do_man,
             da_hoy,
             da_man,
             #parametros.acnomprop,
             rut_empresa,
             'hora' = CONVERT(varchar(10), GETDATE(), 108),
             'nomemp'     = ISNULL( VIEW_MDAC.acnomprop, ''),
             'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), VIEW_MDAC.acrutprop ) ) + '-' + VIEW_MDAC.acdigprop ),'' ),
             'fecpro'     = CONVERT(CHAR(10), VIEW_MDAC.acfecproc, 103),
             'codTab'     = ISNULL(TABLA_GENERAL_DETALLE.tbcateg,0),
             'glosa'      = ISNULL( TABLA_GENERAL_GLOBAL.ctdescrip,''),
             'Tipmant'    = space(1),
             'codigo'     = ISNULL( TABLA_GENERAL_DETALLE.tbcodigo1,'0'),
             'tcglosa'    = ISNULL( TABLA_GENERAL_DETALLE.tbglosa,''),
			 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
        FROM 
             VIEW_MDAC, 
			 TABLA_GENERAL_DETALLE 
			 LEFT JOIN TABLA_GENERAL_GLOBAL ON TABLA_GENERAL_DETALLE.tbcateg = TABLA_GENERAL_GLOBAL.ctcateg 
		   , #parametros
        WHERE 
             LTRIM(RTRIM(TABLA_GENERAL_DETALLE.tbglosa)) <> ''
        ORDER BY 
 TABLA_GENERAL_DETALLE.tbcateg, TABLA_GENERAL_DETALLE.tbcodigo1 END
   ELSE BEGIN
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
             'hora' = CONVERT(varchar(10), GETDATE(), 108),
             'nomemp'     = '         ',
             'rutemp'     = '         ',
             'fecpro'     = '         ',
             'codTab'     = '         ',
             'glosa'      = '         ',
             'Tipmant'    = '         ',
             'codigo'     = '         ',
             'tcglosa'    = '         ',
			 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
        FROM 
             #parametros
   END
 END

GO
