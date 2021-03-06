USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_BROKERS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INFORME_BROKERS]
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
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop,
	   'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
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


	SELECT  'ClRut' = ISNULL( ( RTRIM (CONVERT( CHAR(9), a.clrut ) ) + '-' + a.cldv ),'' )
	    ,   a.Clswift
	    ,	a.Clnombre
	    ,	a.Cldirecc
	    ,   a.Clfono
	    ,	a.Clfax
	    ,   'Mercado' = b.tbglosa
	    ,   'Grupo'   = b.tbglosa
	    ,   a.Clgeneric	
            ,   'rut_empresa'= CONVERT( CHAR(10),c.rut_empresa)
	    ,   'acnomprop' =  CONVERT( CHAR(10),c.acnomprop)	
		,   'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)

       FROM  CLIENTE a ,
    	     TABLA_GENERAL_DETALLE b,
	     #PARAMETROS c			
       WHERE a.clBrokers ='S'
       AND   b.tbcateg	 = 202 
       AND   a.Clmercado = b.tbcodigo1	
	  


END

-- select *  from  CLIENTE  WHERE clBrokers ='S'
-- select *  from  TABLA_GENERAL_DETALLE  WHERE  tbcateg = 202
-- select *  from  TABLA_GENERAL_DETALLE  WHERE  tbcateg = 218

GO
