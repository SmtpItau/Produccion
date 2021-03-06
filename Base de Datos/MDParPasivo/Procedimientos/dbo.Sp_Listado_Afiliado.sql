USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_Afiliado]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Listado_Afiliado]
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
   DECLARE      @acfecproc	CHAR	(10)	
	,	@acfecprox	CHAR	(10)	
	,	@uf_hoy		NUMERIC(21,4)  
        ,	@uf_man		NUMERIC(21,4)   
        ,	@ivp_hoy	NUMERIC(21,4)   
	,	@ivp_man	NUMERIC(21,4)   
	,	@do_hoy		NUMERIC(21,4)   
	,	@do_man		NUMERIC(21,4)   
	,	@da_hoy		NUMERIC(21,4) 
        ,       @da_man         NUMERIC(21,4)  
	,	@acnomprop	CHAR	(40)	
	,	@rut_empresa	CHAR	(12)	
	,	@hora		CHAR	(08)	
        ,       @fecha_busqueda DATETIME

        --SELECT @fecha_busqueda

	EXECUTE	Sp_Base_Del_Informe
		@acfecproc	OUTPUT
	,	@acfecprox	OUTPUT
	,	@uf_hoy		OUTPUT
        ,	@uf_man		OUTPUT
        ,	@ivp_hoy	OUTPUT
	,	@ivp_man	OUTPUT
	,	@do_hoy		OUTPUT 
	,	@do_man		OUTPUT 
	,	@da_hoy		OUTPUT
        ,       @da_man         OUTPUT
	,	@acnomprop	OUTPUT
	,	@rut_empresa	OUTPUT
	,	@hora		OUTPUT
        ,       @fecha_busqueda 

IF EXISTS(SELECT 1 FROM   LINEA_SISTEMA   A
       ,                  CLIENTE         FI
       ,                  CLIENTE         CM
           WHERE  FI.clrut = A.Rut_Cliente AND FI.clcodigo = A.Codigo_Cliente AND FI.rut_grupo = CM.clrut) --AND FI.cltipcli  = 6 AND  FI.rut_grupo = CM.clrut)
BEGIN

   SELECT 'TITULO'               =      'FILIALES BANCARIAS AL ' + CONVERT(CHAR(30),@acfecproc,103)
      ,   'FECHAPROCESO'         =      @acfecproc
      ,   'FECHAREPORTE'         =      CONVERT(CHAR(10),GETDATE(),103)
      ,   'HORAREPORTE'          =      CONVERT(CHAR(10),GETDATE(),108)
      ,   'RUTFILIAL'            =      ISNULL(CONVERT(CHAR(9),FI.Clrut),' ') + '- ' + ISNULL(FI.Cldv,' ') 
      ,   'CODIGOFILIAL'         =      ISNULL(FI.Clcodigo,' ')
      ,   'FILIAL'               =      ISNULL(FI.Clnombre,'N/A')
      ,   'TOTALASIGNADO'        =      ISNULL(SUM(A.TotalAsignado),0)
      ,   'TOTALOCUPADO'         =	ISNULL(SUM(A.TotalOcupado),0)
      ,   'TOTALDISPONIBLE'      =	CASE WHEN ISNULL(SUM(A.TotalAsignado),0) - ISNULL(SUM(A.TotalOcupado),0) < 0 THEN 0 ELSE ISNULL(SUM(A.TotalAsignado),0) - ISNULL(SUM(A.TotalOcupado),0) END
      ,   'TOTALEXCESO'          =	CASE WHEN ISNULL(SUM(A.TotalAsignado),0) - ISNULL(SUM(A.TotalOcupado),0) > 0 THEN 0 ELSE ABS(ISNULL(SUM(A.TotalAsignado),0) - ISNULL(SUM(A.TotalOcupado),0)) END
      ,   'TOTALTRASPASO'        =	ISNULL(SUM(A.TotalTraspaso),0)
      ,   'TOTALRECIBIDO'        =	ISNULL(SUM(A.TotalRecibido),0)
      ,   'SINRIESGOASIGNADO'    =	ISNULL(SUM(A.SinRiesgoAsignado),0)
      ,   'SINRIESGOOCUPADO'     =	ISNULL(SUM(A.SinRiesgoOcupado),0)
      ,   'SINRIESGODISPONIBLE'  =	CASE WHEN ISNULL(SUM(A.SinRiesgoAsignado),0) - ISNULL(SUM(A.SinRiesgoOcupado),0) < 0 THEN 0 ELSE ISNULL(SUM(A.SinRiesgoAsignado),0) - ISNULL(SUM(A.SinRiesgoOcupado),0) END
      ,   'SINRIESGOEXCESO'      =	CASE WHEN ISNULL(SUM(A.SinRiesgoAsignado),0) - ISNULL(SUM(A.SinRiesgoOcupado),0) > 0 THEN 0 ELSE ABS(ISNULL(SUM(A.SinRiesgoAsignado),0) - ISNULL(SUM(A.SinRiesgoOcupado),0)) END
      ,   'CONRIESGOASIGNADO'    =	ISNULL(SUM(A.ConRiesgoAsignado),0)
      ,   'CONRIESGOOCUPADO'     =	ISNULL(SUM(A.ConRiesgoOcupado),0)
      ,   'CONRIESGODISPONIBLE'  =	CASE WHEN ISNULL(SUM(A.ConRiesgoAsignado),0) - ISNULL(SUM(A.ConRiesgoOcupado),0) < 0 THEN 0 ELSE ISNULL(SUM(A.ConRiesgoAsignado),0) - ISNULL(SUM(A.ConRiesgoOcupado),0) END
      ,   'CONRIESGOEXCESO'	 =	CASE WHEN ISNULL(SUM(A.ConRiesgoAsignado),0) - ISNULL(SUM(A.ConRiesgoOcupado),0) > 0 THEN 0 ELSE ABS(ISNULL(SUM(A.ConRiesgoAsignado),0) - ISNULL(SUM(A.ConRiesgoOcupado),0)) END
      ,   'RUTCASAMATRIZ'        =      ISNULL(CM.Clrut,' ')
      ,   'DVCASAMATRIZ'         =      ISNULL(CM.Cldv,' ')
      ,   'CODIGOCASAMATRIZ'     =      ISNULL(CM.Clcodigo,' ')
      ,   'CASAMATRIZ'           =      ISNULL(CM.Clnombre,'N/A')

      ,   'acfecprox'            =      @acfecprox	
      ,   'uf_hoy'               =      @uf_hoy		
      ,   'uf_man'               =      @uf_man		
      ,   'ivp_hoy'              =     @ivp_hoy	
      ,   'ivp_man'              =      @ivp_man	
      ,   'do_hoy'               =      @do_hoy		
      ,   'do_man'               =      @do_man		
      ,   'da_hoy'               =      @da_hoy		
      ,   'da_man'               =      @da_man         
      ,   'acnomprop'            =      @acnomprop	
      ,   'rut_empresa'          =      @rut_empresa	
      ,   'hora'                 =      @hora		
      ,   'fecha_busqueda'       =      @fecha_busqueda  
      ,   'total'                =      CONVERT(CHAR(30),'TOTAL')

   FROM   LINEA_SISTEMA   A
      ,   CLIENTE         FI
      ,   CLIENTE         CM
   WHERE     FI.clrut = A.Rut_Cliente
         AND FI.clcodigo = A.Codigo_Cliente
         AND FI.rut_grupo = CM.clrut --FI.cltipcli  = 6 AND  FI.rut_grupo = CM.clrut
         AND (A.TotalOcupado > 0 OR A.TotalAsignado > 0)
   GROUP BY FI.Clrut
          , FI.Cldv
          , FI.Clcodigo
          , FI.Clnombre
          , CM.Clrut
          , CM.Cldv
          , CM.Clcodigo
          , CM.Clnombre

  ORDER BY [CASAMATRIZ]


END ELSE BEGIN

  SELECT  'TITULO'               =      'FILIALES BANCARIAS AL ' + CONVERT(CHAR(30),@acfecproc,103)
      ,   'FECHAPROCESO'         =      @acfecproc
      ,   'FECHAREPORTE'         =      CONVERT(CHAR(10),GETDATE(),103)
      ,   'HORAREPORTE'          =      CONVERT(CHAR(10),GETDATE(),108)
      ,   'RUTFILIAL'            =      ' '
      ,   'CODIGOFILIAL'         =      ' '
      ,   'FILIAL'               =      ' '
      ,   'TOTALASIGNADO'        =      ' '
      ,   'TOTALOCUPADO'         =	' '       
      ,   'TOTALDISPONIBLE'      =	' '   
      ,   'TOTALEXCESO'          =	' '       
      ,   'TOTALTRASPASO'        =	' '   
      ,   'TOTALRECIBIDO'        =	' '     
      ,   'SINRIESGOASIGNADO'    =	' ' 
      ,   'SINRIESGOOCUPADO'     =	' '    
      ,   'SINRIESGODISPONIBLE'  =	' '
      ,   'SINRIESGOEXCESO'      =	' '   
      ,   'CONRIESGOASIGNADO'    =	' '  
      ,   'CONRIESGOOCUPADO'     =	' '
      ,   'CONRIESGODISPONIBLE'  =	' '
      ,   'CONRIESGOEXCESO'	 =	' '
      ,   'RUTCASAMATRIZ'        =      ' '
      ,   'DVCASAMATRIZ'         =      ' '
      ,   'CODIGOCASAMATRIZ'     =      ' '
      ,   'CASAMATRIZ'           =      ' '

      ,   'acfecprox'            =      @acfecprox	
      ,   'uf_hoy'               =      @uf_hoy		
      ,   'uf_man'               =      @uf_man		
      ,   'ivp_hoy'              =      @ivp_hoy	
      ,   'ivp_man'              =      @ivp_man	
      ,   'do_hoy'               =      @do_hoy		
      ,   'do_man'               =      @do_man		
      ,   'da_hoy'               =      @da_hoy		
      ,   'da_man'               =      @da_man         
      ,   'acnomprop'            =      @acnomprop	
      ,   'rut_empresa'          =      @rut_empresa	
      ,   'hora'                 =      @hora		
      ,   'fecha_busqueda'       =      @fecha_busqueda  
      ,   'total'                =      CONVERT(CHAR(30),'NO EXISTE INFORMACION')

END
SET NOCOUNT OFF
END




GO
