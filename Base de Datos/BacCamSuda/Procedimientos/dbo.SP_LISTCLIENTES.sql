USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTCLIENTES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTCLIENTES] /*(@Hora char (10))*/
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
                  FROM VIEW_VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecproc
                   AND MDVM.vmcodigo = 998
UPDATE #Parametros SET uf_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VIEW_VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecprox
                   AND MDVM.vmcodigo = 998
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */
UPDATE #Parametros SET ivp_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VIEW_VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecproc
                   AND MDVM.vmcodigo = 997
UPDATE #Parametros SET ivp_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VIEW_VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecprox
                   AND MDVM.vmcodigo = 997
/* RESCATA VALOR DE DO -------------------------------------------------------------- */
UPDATE #Parametros SET do_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VIEW_VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecproc
                   AND MDVM.vmcodigo = 994
UPDATE #Parametros SET do_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VIEW_VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecprox
                   AND MDVM.vmcodigo = 994
/* RESCATA VALOR DE DA -------------------------------------------------------------- */
UPDATE #Parametros SET da_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VIEW_VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecproc
                   AND MDVM.vmcodigo = 995
UPDATE #Parametros SET da_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VIEW_VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = acfecprox
                   AND MDVM.vmcodigo = 995
  SELECT 'nomemp'     = ISNULL( VIEW_MDAC.acnomprop, ''),
                'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), VIEW_MDAC.acrutprop ) ) + '-' + VIEW_MDAC.acdigprop ),'' ),
                'fecpro'     = CONVERT(CHAR(10), VIEW_MDAC.acfecproc, 103),
  'Rut_Cli'    = ISNULL( ( RTRIM (CONVERT( CHAR(9), VIEW_CLIENTE.clrut ) ) + '-' + VIEW_CLIENTE.cldv ),'' ),
  'Cod_Cli'    = ISNULL( VIEW_CLIENTE.clcodigo,0),
                'Nom_Cli'    = ISNULL( VIEW_CLIENTE.clnombre,''),
                'Dir_Cli'    = ISNULL( VIEW_CLIENTE.cldirecc,''),
  'Gen_Cli'    = ISNULL( VIEW_CLIENTE.clgeneric,''),
                'Com_Cli'    = ISNULL( VIEW_CIUDAD_COMUNA.nom_ciu,''),
                'Reg_Cli'    = ISNULL( VIEW_CLIENTE.clregion,0),
                'Sec_Cli'    = ISNULL( VIEW_TABLA_GENERAL_DETALLE.tbglosa,''),
  'Tip_Cli'    = ISNULL(a.tbglosa,''),
  'Fec_Cli'    = CONVERT( CHAR(10),VIEW_CLIENTE.clfecingr,103),
                'Cta_Cli'    = ISNULL( VIEW_CLIENTE.clctacte,''),                 
                'Fax_Cli'    = ISNULL( VIEW_CLIENTE.clfax,''),
                'Tel_Cli'    = ISNULL( VIEW_CLIENTE.clfono,''),
  'acfecproc'  = CONVERT(CHAR(10),p.acfecproc, 103),   
         'acfecprox' =  CONVERT(CHAR(10), p.acfecproc, 103),
         'UF_Hoy'    =  ISNULL(P.uf_hoy,0),
         'UF_Man'    =  ISNULL(P.uf_man,0),
         'IVP_Hoy'   =  ISNULL(P.ivp_hoy,0),
         'IVP_Man'   =  ISNULL(P.ivp_man,0),
         'DO_Hoy'    =  ISNULL(P.do_hoy,0),
      'DO_Man'    =  ISNULL(P.do_man,0),
         'DA_Hoy'    =  ISNULL(P.da_hoy,0),
         'DA_Man'    =  ISNULL(P.uf_hoy,0),
         'acnomprop' =  CONVERT( CHAR(10),p.acnomprop),
                'rut_empresa'= CONVERT( CHAR(10),p.rut_empresa),
  'hora'       = CONVERT( CHAR(30),GETDATE(),108)
 
  FROM VIEW_MDAC, 
		VIEW_CLIENTE LEFT OUTER JOIN VIEW_CIUDAD_COMUNA ON VIEW_CLIENTE.clciudad = VIEW_CIUDAD_COMUNA.cod_ciu 
				AND VIEW_CLIENTE.clcomuna = VIEW_CIUDAD_COMUNA.cod_com 
		LEFT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE ON VIEW_CLIENTE.clcompint = CONVERT(NUMERIC(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1) AND VIEW_TABLA_GENERAL_DETALLE.tbcateg = 41
		LEFT OUTER JOIN VIEW_TABLA_GENERAL_DETALLE a ON VIEW_CLIENTE.cltipcli = CONVERT(NUMERIC(6),a.tbcodigo1) AND a.tbcateg = 207, 
		#parametros p
  WHERE VIEW_CLIENTE.clrut <> VIEW_MDAC.acrutprop 

	/*
	  FROM VIEW_MDAC, VIEW_CLIENTE, VIEW_CIUDAD_COMUNA ,VIEW_TABLA_GENERAL_DETALLE, VIEW_TABLA_GENERAL_DETALLE a, #parametros p
	  WHERE VIEW_CLIENTE.clciudad *= VIEW_CIUDAD_COMUNA.cod_ciu  
	  AND VIEW_CLIENTE.clcompint *= CONVERT(NUMERIC(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)
	  AND VIEW_TABLA_GENERAL_DETALLE.tbcateg = 41
	  AND VIEW_CLIENTE.cltipcli *= CONVERT(NUMERIC(6),a.tbcodigo1)
	  AND a.tbcateg = 207
	  AND VIEW_CLIENTE.clcomuna *= VIEW_CIUDAD_COMUNA.cod_com 
	  AND VIEW_CLIENTE.clrut <> VIEW_MDAC.acrutprop 
	*/

 END

GO
