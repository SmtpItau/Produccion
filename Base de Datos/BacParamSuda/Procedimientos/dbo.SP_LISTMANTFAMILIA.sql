USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTMANTFAMILIA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTMANTFAMILIA]
 AS
 BEGIN
--SET NOCOUNT ON
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
        INTO 
             #Parametros
        FROM 
             VIEW_MDAC
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
         SELECT
             'nomemp'     = ISNULL( MDAC.acnomprop, ''),
             'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
             'fecpro'     = CONVERT(CHAR(10), MDAC.acfecproc, 103),
             'Codigo'     = ISNULL(INSTRUMENTO.incodigo,0),
             'Serie'      = ISNULL(INSTRUMENTO.inserie,''),
             'Glosa'      = ISNULL(INSTRUMENTO.inglosa,''),
             'RutEmisor'  = ISNULL(INSTRUMENTO.inrutemi,0),
             'Rutemi'     = Space(11),
             'Nomemi'     = Space(40),
             'Codmon'     = ISNULL(INSTRUMENTO.inmonemi,0),
             'monemi'     = Space(5),
             'Desmonemi'  = Space(40),              
      'basemi'     = ISNULL(INSTRUMENTO.inbasemi,0),
             'Prog'       = ISNULL(INSTRUMENTO.inprog,''),
             'RefNominal' = ISNULL(INSTRUMENTO.inrefnomi,''),
             'Mdse'       = ISNULL(INSTRUMENTO.inmdse,''),
             'Mdtd'       = ISNULL(INSTRUMENTO.inmdtd,''),
  'Mdpr'       = ISNULL(INSTRUMENTO.inmdpr,''),
  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
         INTO #temp FROM VIEW_MDAC MDAC, INSTRUMENTO ORDER BY INSTRUMENTO.inserie
  UPDATE #temp SET rutemi    =  CONVERT(CHAR(9),ISNULL(mdem.emrut,0)) +'-' + ISNULL(mdem.emdv,''),nomemi    =  ISNULL(mdem.emnombre,'')
                FROM EMISOR mdem WHERE #temp.rutemisor = mdem.emrut
     
         UPDATE #temp SET monemi    =  ISNULL(moneda.mnnemo,''), desmonemi =  ISNULL(moneda.mnGLOSA,''),basemi    =  ISNULL(moneda.mnbase,0)     
                FROM CLIENTE, MONEDA WHERE #temp.codmon    = MONEDA.mncodmon
--SET NOCOUNT OFF
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
             nomemp,
             rutemp,
             fecpro,
             codigo,
             serie,
             glosa,
             rutemi,
             nomemi,
             codmon,
             monemi,
             desmonemi,
             basemi,
             prog,
             refnominal,
             mdse,
             mdpr,
			 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
         FROM #temp, #parametros
 END
-- Sp_LisTMantFamilia


GO
