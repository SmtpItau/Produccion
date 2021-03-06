USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTCLIENTES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- EXEC SP_LISTCLIENTES

CREATE PROCEDURE [dbo].[SP_LISTCLIENTES] /*(@hora CHAR (10))*/
AS

BEGIN

	SET NOCOUNT ON
	
	SELECT acfecproc,
           acfecprox,
           'uf_hoy'      = CONVERT(float, 0),
           'uf_man'      = CONVERT(float, 0),
           'ivp_hoy'     = CONVERT(float, 0),
           'ivp_man'     = CONVERT(float, 0),
           'do_hoy'      = CONVERT(float, 0),
           'do_man'      = CONVERT(float, 0),
           'da_hoy'      = CONVERT(float, 0),
           'da_man'      = CONVERT(float, 0),
           acnomprop,
           'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
	       --'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
      INTO #PARAMETROS
      FROM VIEW_MDAC


	  /* RESCATA VALOR DE UF -------------------------------------------------------------- */
      UPDATE #PARAMETROS 
	     SET uf_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
        FROM VALOR_MONEDA 
       WHERE VALOR_MONEDA.vmfecha  = acfecproc
         AND VALOR_MONEDA.vmcodigo = 998

      UPDATE #PARAMETROS 
	     SET uf_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
        FROM VALOR_MONEDA 
       WHERE VALOR_MONEDA.vmfecha  = acfecprox
         AND VALOR_MONEDA.vmcodigo = 998


      /* rescata valor de ivp ------------------------------------------------------------- */
      UPDATE #PARAMETROS 
	     SET ivp_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
        FROM VALOR_MONEDA 
       WHERE VALOR_MONEDA.vmfecha  = acfecproc
         AND VALOR_MONEDA.vmcodigo = 997

      UPDATE #PARAMETROS 
	     SET ivp_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
        FROM VALOR_MONEDA 
       WHERE VALOR_MONEDA.vmfecha  = acfecprox
                   and VALOR_MONEDA.vmcodigo = 997


	  /* RESCATA VALOR DE DO -------------------------------------------------------------- */
      UPDATE #PARAMETROS 
	     SET do_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)                  
		FROM VALOR_MONEDA 
       WHERE VALOR_MONEDA.vmfecha  = acfecproc
         AND VALOR_MONEDA.vmcodigo = 994

      UPDATE #PARAMETROS 
	     SET do_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
        FROM VALOR_MONEDA 
       WHERE VALOR_MONEDA.vmfecha  = acfecprox
         AND VALOR_MONEDA.vmcodigo = 994


      /* RESCATA VALOR DE DA -------------------------------------------------------------- */
      UPDATE #PARAMETROS 
	     SET da_hoy = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
        FROM VALOR_MONEDA 
       WHERE VALOR_MONEDA.vmfecha  = acfecproc
         AND VALOR_MONEDA.vmcodigo = 995


      UPDATE #PARAMETROS 
	     SET da_man = ISNULL(VALOR_MONEDA.vmvalor, 0.0)
        FROM VALOR_MONEDA 
       WHERE VALOR_MONEDA.vmfecha  = acfecprox
         AND VALOR_MONEDA.vmcodigo = 995
  



  	  DECLARE @COUNT INT
	  
	  SET @COUNT = (SELECT COUNT(*)
					  FROM VIEW_MDAC, 
						   CLIENTE
						       LEFT JOIN 
						   CIUDAD_COMUNA ON (CLIENTE.clciudad = CIUDAD_COMUNA.cod_ciu and CLIENTE.clcomuna = CIUDAD_COMUNA.cod_com) 
							   LEFT JOIN 
						   MDTC ON (CLIENTE.clcompint = CONVERT(NUMERIC(6),MDTC.tbcodigo1))
							   LEFT JOIN  
						   MDTC a ON (CLIENTE.cltipcli = CONVERT(NUMERIC(6),a.tbcodigo1)),
						   #PARAMETROS p
					 WHERE MDTC.tbcateg  = 41
					   AND a.tbcateg     = 207
					   AND CLIENTE.clrut <> VIEW_MDAC.acrutprop )



	  IF @COUNT <> 0
		BEGIN

		  SELECT 'nomemp'      = ISNULL( VIEW_MDAC.acnomprop, ''),
				 'rutemp'      = ISNULL( ( RTRIM (CONVERT( CHAR(9), VIEW_MDAC.acrutprop ) ) + '-' + VIEW_MDAC.acdigprop ),'' ),
				 'fecpro'      = CONVERT(CHAR(10), VIEW_MDAC.acfecproc, 103),
				 'rut_cli'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), CLIENTE.clrut ) ) + '-' + CLIENTE.cldv ),'' ),
				 'cod_cli'     = ISNULL( CLIENTE.clcodigo,0),
				 'nom_cli'     = ISNULL( CLIENTE.clnombre,''),
				 'dir_cli'     = ISNULL( CLIENTE.cldirecc,''),
				 'gen_cli'     = ISNULL( CLIENTE.clgeneric,''),
				 'com_cli'     = ISNULL( CIUDAD_COMUNA.nom_ciu,''),
				 'reg_cli'     = ISNULL( CLIENTE.clregion,0),
				 'sec_cli'     = ISNULL( MDTC.tbglosa,''),
				 'tip_cli'     = ISNULL(a.tbglosa,''),
				 'fec_cli'     = CONVERT( CHAR(10),CLIENTE.clfecingr,103),
				 'cta_cli'     = ISNULL( CLIENTE.clctacte,''),                 
				 'fax_cli'     = ISNULL( CLIENTE.clfax,''),
				 'tel_cli'     = ISNULL( CLIENTE.clfono,''),
				 'acfecproc'   = CONVERT(CHAR(10),p.acfecproc, 103),   
				 'acfecprox'   = CONVERT(CHAR(10), p.acfecproc, 103),
				 'uf_hoy'      = ISNULL(p.uf_hoy,0),
				 'uf_man'      = ISNULL(p.uf_man,0),
				 'ivp_hoy'     = ISNULL(p.ivp_hoy,0),
				 'ivp_man'     = ISNULL(p.ivp_man,0),
				 'do_hoy'      = ISNULL(p.do_hoy,0),
				 'do_man'      = ISNULL(p.do_man,0),
				 'da_hoy'      = ISNULL(p.da_hoy,0),
				 'da_man'      = ISNULL(p.uf_hoy,0),
				 'acnomprop'   = CONVERT( CHAR(10),p.acnomprop),
				 'rut_empresa' = CONVERT( CHAR(10),p.rut_empresa),
				 'hora'        = CONVERT( CHAR(30),GETDATE(),108),
				 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) 
			 FROM VIEW_MDAC, 
				  CLIENTE
					  LEFT JOIN 
				  CIUDAD_COMUNA ON (CLIENTE.clciudad = CIUDAD_COMUNA.cod_ciu and CLIENTE.clcomuna = CIUDAD_COMUNA.cod_com) 
					  LEFT JOIN 
				  MDTC ON (CLIENTE.clcompint = CONVERT(NUMERIC(6),MDTC.tbcodigo1))
					  LEFT JOIN  
				  MDTC a ON (CLIENTE.cltipcli = CONVERT(NUMERIC(6),a.tbcodigo1)),
				  #PARAMETROS p
			WHERE MDTC.tbcateg  = 41
			  AND a.tbcateg     = 207
			  AND CLIENTE.clrut <> VIEW_MDAC.acrutprop 

		END

      ELSE
		
		BEGIN

		  SELECT 'nomemp'      = '',
				 'rutemp'      = '',
				 'fecpro'      = '',
				 'rut_cli'     = '',
				 'cod_cli'     = 0,
				 'nom_cli'     = '',
				 'dir_cli'     = '',
				 'gen_cli'     = '',
				 'com_cli'     = '',
				 'reg_cli'     = 0,
				 'sec_cli'     = '',
				 'tip_cli'     = '',
				 'fec_cli'     = '',
				 'cta_cli'     = '',                 
				 'fax_cli'     = '',
				 'tel_cli'     = '',
				 'acfecproc'   = '',   
				 'acfecprox'   = '',
				 'uf_hoy'      = 0,
				 'uf_man'      = 0,
				 'ivp_hoy'     = 0,
				 'ivp_man'     = 0,
				 'do_hoy'      = 0,
				 'do_man'      = 0,
				 'da_hoy'      = 0,
				 'da_man'      = 0,
				 'acnomprop'   = '',
				 'rut_empresa' = '',
				 'hora'        = '',
				 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) 

		END
 
  SET NOCOUNT OFF



END
GO
