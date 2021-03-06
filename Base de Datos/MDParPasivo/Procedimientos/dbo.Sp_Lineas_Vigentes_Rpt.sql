USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Vigentes_Rpt]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Lineas_Vigentes_Rpt]
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


IF EXISTS(SELECT 1 FROM LINEA_SISTEMA)
                         
BEGIN

   SELECT 'TITULO'               =      'LINEAS DE CREDITO VIGENTES POR SISTEMA AL ' + CONVERT(CHAR(30),@acfecproc,103)
      ,   'FECHAPROCESO'         =      @acfecproc
      ,   'FECHAREPORTE'         =      CONVERT(CHAR(10),GETDATE(),103)
      ,   'HORAREPORTE'          =      CONVERT(CHAR(10),GETDATE(),108)
      ,   'IDSISTEMA'            =      ISNULL(A.codigo_grupo,' ')
      ,   'SISTEMA'              =      ISNULL(C.Nombre_Sistema,' ')
      ,   'RUTFILIAL'            =      ISNULL(FI.Clrut,' ') 
      ,   'DVFILIAL'             =      '- ' + ISNULL(FI.Cldv,' ')
      ,   'CODIGOFILIAL'         =      ISNULL(FI.Clcodigo,' ')
      ,   'FILIAL'               =      ISNULL(FI.Clnombre,'N/A')
      ,   'TOTALASIGNADO'        =      ISNULL(SUM(A.TotalAsignado),0)
      ,   'MONTOTRANSADO'        =      ISNULL(SUM(B.MontoOriginal),0)
      ,   'MONTOCONTABLE'        =      CONVERT(NUMERIC(21,4),0)
      ,   'MONTOOCUPADO '        =      CONVERT(NUMERIC(21,4),0)
      ,   'MONTOTRASPASADO'      =	ISNULL(SUM(A.TotalTraspaso),0)    
      ,   'TOTALOCUPADO'         =	ISNULL(SUM(A.TotalOcupado),0)        
      ,   'TOTALRECIBIDO'        =	ISNULL(SUM(A.TotalRecibido),0)         
      ,   'OCUPADOREAL'          =      ISNULL(SUM(B.MontoTransaccion),0)
      ,   'DIFERENCIA'           =      CONVERT(NUMERIC(21,4),0)
      ,   'PONDERADO'            =      CONVERT(NUMERIC(21,4),0)
      --,   'OCUPADOREAL'          =      ISNULL(ISNULL(SUM(A.TotalOcupado),0) - ISNULL(SUM(A.TotalRecibido),0),0)
      
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
      ,   'total'                =      CONVERT(CHAR(30),'TOTAL')
   INTO #TMP

   FROM   LINEA_SISTEMA       A
      ,   LINEA_TRANSACCION   B
      ,   SISTEMA         C
      ,   CLIENTE             FI
      
    
   WHERE  FI.clrut      = A.Rut_Cliente 
      AND FI.clcodigo   = A.Codigo_Cliente 
      AND A.Rut_Cliente = B.Rut_Cliente 
      AND C.Id_Sistema  = B.Id_Sistema
      AND a.codigo_grupo  = B.codigo_grupo
      AND B.Activo      = 'S'
--      AND A.Id_Sistema  = C.Id_Sistema
      AND C.Operativo   = 'S'
 
-- select * from LINEA_TRANSACCION  
-- select * from LINEA_sistema

   GROUP BY a.codigo_grupo 
          , C.Nombre_Sistema
          , FI.Clrut
          , FI.Cldv
          , FI.Clcodigo
          , FI.Clnombre
            
   UPDATE #TMP SET
            DIFERENCIA = CASE WHEN TOTALOCUPADO <> 0 THEN (OCUPADOREAL + TOTALRECIBIDO) - TOTALOCUPADO 
                         ELSE 0 END
          , PONDERADO  = (MONTOOCUPADO / MONTOTRANSADO) * 100
            
   SELECT * FROM #TMP
                   
END ELSE BEGIN

  SELECT  'TITULO'               =      'LINEAS DE CREDITO VIGENTES POR SISTEMA AL ' + CONVERT(CHAR(30),@acfecproc,103)
      ,   'FECHAPROCESO'         =      @acfecproc
      ,   'FECHAREPORTE'         =      CONVERT(CHAR(10),GETDATE(),103)
      ,   'HORAREPORTE'          =      CONVERT(CHAR(10),GETDATE(),108)
      ,   'IDSISTEMA'            =      ' '
      ,   'SISTEMA'              =      ' '
      ,   'RUTFILIAL'            =      ' '
      ,   'DVFILIAL'             =      ' '
      ,   'CODIGOFILIAL'         =      ' '
      ,   'FILIAL'               =      ' '
      ,   'TOTALASIGNADO'        =      ' '
      ,   'MONTOTRANSADO'        =      ' '
      ,   'MONTOCONTABLE'        =      ' '
      ,   'MONTOOCUPADO '        =      ' '
      ,   'MONTOTRASPASADO'      =	' '
      ,   'TOTALOCUPADO'         =	' '
      ,   'TOTALRECIBIDO'        =	' '
      ,   'OCUPADOREAL'          =      ' '
      ,   'DIFERENCIA'           =      ' '
      ,   'PONDERADO'            =      ' '

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
