USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LisTClientes]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_LisTClientes]
 AS
 BEGIN


   SET NOCOUNT ON
   SET DATEFORMAT dmy

	SELECT fecha_proceso,
       		fecha_proxima,
       		'UF_Hoy'    = CONVERT(FLOAT, 0),
       		'UF_Man'    = CONVERT(FLOAT, 0),
       		'IVP_Hoy'   = CONVERT(FLOAT, 0),
       		'IVP_Man'   = CONVERT(FLOAT, 0),
       		'DO_Hoy'    = CONVERT(FLOAT, 0),
       		'DO_Man'    = CONVERT(FLOAT, 0),
       		'DA_Hoy'    = CONVERT(FLOAT, 0),
       		'DA_Man'    = CONVERT(FLOAT, 0),
       		nombre_entidad,
                'rut_empresa' = RTRIM(CONVERT(CHAR(10),rut_entidad)) + "-" + digito_entidad
  INTO #Parametros
  FROM DATOS_GENERALES


/* RESCATA VALOR DE UF -------------------------------------------------------------- */
UPDATE #Parametros SET uf_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = fecha_proceso
                   AND MDVM.vmcodigo = 998


UPDATE #Parametros SET uf_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = fecha_proxima
                   AND MDVM.vmcodigo = 998

/* RESCATA VALOR DE IVP ------------------------------------------------------------- */

UPDATE #Parametros SET ivp_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = fecha_proceso
                   AND MDVM.vmcodigo = 997

UPDATE #Parametros SET ivp_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = fecha_proxima
                   AND MDVM.vmcodigo = 997

/* RESCATA VALOR DE DO -------------------------------------------------------------- */

UPDATE #Parametros SET do_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA  MDVM
                 WHERE MDVM.vmfecha  = fecha_proceso
                   AND MDVM.vmcodigo = 994

UPDATE #Parametros SET do_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = fecha_proxima
                   AND MDVM.vmcodigo = 994

/* RESCATA VALOR DE DA -------------------------------------------------------------- */

UPDATE #Parametros SET da_hoy = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = fecha_proceso
                   AND MDVM.vmcodigo = 995

UPDATE #Parametros SET da_man = ISNULL(MDVM.vmvalor, 0.0)
                  FROM VALOR_MONEDA MDVM
                 WHERE MDVM.vmfecha  = fecha_proxima
                   AND MDVM.vmcodigo = 995


	 SELECT 'nomemp'     = ISNULL( AC.nombre_entidad, ' '),
                'rutemp'     = ISNULL( ( RTRIM (CONVERT( CHAR(9), AC.rut_entidad ) ) + "-" + AC.digito_entidad ),"" ),
                'fecpro'     = CONVERT(CHAR(10), AC.fecha_proceso, 103),
		'Rut_Cli'    = ISNULL( ( RTRIM (CONVERT( CHAR(9), CLIENTE.clrut ) ) + "-" + CLIENTE.cldv ),"" ),
		'Cod_Cli'    = ISNULL( CLIENTE.clcodigo,0),
                'Nom_Cli'    = ISNULL( CLIENTE.clnombre,' '),
                'Dir_Cli'    = ISNULL( CLIENTE.cldirecc,' '),
		'Gen_Cli'    = ISNULL( CLIENTE.clgeneric,' '),
                'Com_Cli'    = ISNULL( comuna.nombre,' '),
                'Reg_Cli'    = ISNULL( (SELECT REGION.nombre FROM REGION WHERE REGION.codigo_region = CLIENTE.clregion ),' ' ),
                'Sec_Cli'    = ISNULL( c.descripcion,' '),
		'Tip_Cli'    = ISNULL( b.descripcion,' '),
		'Fec_Cli'    = CONVERT( CHAR(10),CLIENTE.clfecingr,103),
                'Cta_Cli'    = ISNULL( CLIENTE.clctacte,' '),                 
                'Fax_Cli'    = ISNULL( CLIENTE.clfax,' '),
                'Tel_Cli'    = ISNULL( CLIENTE.clfono,' '),
		'acfecproc'  = CONVERT(CHAR(10), p.fecha_proceso, 103),   
       		'acfecprox' =  CONVERT(CHAR(10), p.fecha_proxima, 103),
       		'UF_Hoy'    =  ISNULL(P.uf_hoy,0),
       		'UF_Man'    =  ISNULL(P.uf_man,0),
       		'IVP_Hoy'   =  ISNULL(P.ivp_hoy,0),
       		'IVP_Man'   =  ISNULL(P.ivp_man,0),
       		'DO_Hoy'    =  ISNULL(P.do_hoy,0),
    		'DO_Man'    =  ISNULL(P.do_man,0),
       		'DA_Hoy'    =  ISNULL(P.da_hoy,0),
       		'DA_Man'    =  ISNULL(P.uf_hoy,0),
       		'acnomprop' =  CONVERT( CHAR(10),p.nombre_entidad),
                'rut_empresa'= CONVERT( CHAR(10),p.rut_empresa),
		'hora'       = CONVERT( CHAR(30),GETDATE(),108)
	
         FROM DATOS_GENERALES AC
            , CLIENTE
            , COMUNA 
            , TIPO_CLIENTE b
            , SECTOR_ECONOMICO c
            , #parametros p
            
	 WHERE CLIENTE.clciudad *= COMUNA.codigo_ciudad
		AND (CLIENTE.clsector *= c.Codigo_Sector)
		AND (CLIENTE.cltipcli *= b.Codigo_Tipo_Cliente)
		AND CLIENTE.clcomuna *= COMUNA.codigo_comuna


   SET NOCOUNT OFF

 END





GO
