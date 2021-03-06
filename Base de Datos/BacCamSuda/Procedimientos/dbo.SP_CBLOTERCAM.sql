USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CBLOTERCAM]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CBLOTERCAM] 
            ( 
            @FECHA_DESDE    CHAR(08) = '0',
            @FECHA_HASTA    CHAR(08) = '0'
            )
AS BEGIN
SET NOCOUNT ON
  DECLARE  @acfecproc   CHAR(10),
           @acfecprox   CHAR(10),
           @uf_hoy      FLOAT,
           @uf_man      FLOAT,
           @ivp_hoy     FLOAT,
           @ivp_man     FLOAT,
           @do_hoy      FLOAT,
           @do_man      FLOAT,
           @da_hoy      FLOAT,
           @da_man      FLOAT,
           @acnomprop   CHAR(40),
           @rut_empresa CHAR(12),
           @hora        CHAR(8),
           @oma         CHAR(3) ,
           @FECHA_PROCESO DATETIME

   EXECUTE Sp_Base_Del_Informe
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT,
           @oma         OUTPUT 

      SELECT @FECHA_PROCESO = acfecpro  FROM MEAC
   
      IF @FECHA_DESDE = '0' BEGIN
         SELECT @FECHA_DESDE = @FECHA_PROCESO
      END
      IF @FECHA_HASTA = '0' BEGIN
         SELECT @FECHA_HASTA = @FECHA_PROCESO
      END

      SELECT 'Fecha'           = CONVERT(CHAR(10),@FECHA_PROCESO,103) ,
             'Operacion'       = P.codigo_producto,
             'Numero_Operacion'= monumope,
             'Cliente'         = a.clnombre,
             'Tipo_Operacion'  = (CASE WHEN motipope = 'C' OR moaprob = 'C' THEN 'COMPRA'
                                       WHEN motipope = 'V' OR moaprob = 'V' THEN 'VENTA'
                                       ELSE '--'
                                  END),
             'Monto_MX'        = momonmo,
             'Tipo_Cambio'     = (CASE motipmer WHEN 'ARBI' THEN moparme
                                                ELSE moticam       
                                  END) ,
             'Monto_USD$'      = moussme,
             'Monto_Pesos'     = momonpe,
             'Entregamos'      = b.glosa,
             'Fecha_ValutaE'   = CONVERT(CHAR(12),movaluta1,103), 
             'Recibimos'       = c.glosa,
             'Fecha_ValutaR'   = CONVERT(CHAR(12),movaluta2,103), 
             'Estado'          = moestatus,
             'Hora'            = CONVERT(CHAR(8),GETDATE(),108) ,
             'Entidad'         = m.acnombre                     ,
             'FECHAHOY'        = CONVERT(CHAR(10), @FECHA_PROCESO, 103),
             'Fecha_Serv'      = CONVERT(CHAR(10), GETDATE(), 103),
             'acfecproc'       = @acfecproc  ,
             'acfecprox'       = @acfecprox  ,
             'uf_hoy'          = @uf_hoy     ,
             'uf_man'          = @uf_man     ,
             'ivp_hoy'         = @ivp_hoy    ,
             'ivp_man'         = @ivp_man    ,
             'do_hoy'          = @do_hoy     ,
             'do_man'          = @do_man     ,
             'da_hoy'          = @da_hoy     ,
             'da_man'          = @da_man     ,
             'pmnomprop'       = @acnomprop  ,
             'rut_empresa'     = @rut_empresa,
	     'HoraGraba'       = MoHora	     ,
	     'EstadoGraba'     = '  '

      INTO #TEMPORAL
      FROM  MEMO  ,
            VIEW_CLIENTE       AS a,
            VIEW_FORMA_DE_PAGO AS b,
            VIEW_FORMA_DE_PAGO AS c,
            MEAC               AS m,
            VIEW_PRODUCTO      AS P
      WHERE motipmer         <> 'CCBB'       AND 
            morutcli          = a.clrut      AND
            mocodcli          = a.clcodigo   AND
            moentre           = b.codigo     AND
            morecib           = c.codigo   AND
            (mofech          >= @FECHA_DESDE AND
             mofech          <= @FECHA_HASTA)AND
            P.id_sistema      = 'BCC'        AND
            P.codigo_producto = motipmer     AND
           (MOESTATUS         = ' '          OR
            MOESTATUS         = 'M') 
      UNION
      SELECT 'Fecha'           = CONVERT(CHAR(10),@FECHA_PROCESO,103) ,
             'Operacion'       = P.codigo_producto, --( SELECT glosa FROM TBTIPOSMERCADO WHERE codigo_caracter = motipmer ),
             'Numero_Operacion'= monumope,
             'Cliente'         = a.clnombre,
             'Tipo_Operacion'  = (CASE WHEN motipope = 'C' OR moaprob = 'C' THEN 'COMPRA'
                                       WHEN motipope = 'V' OR moaprob = 'V' THEN 'VENTA'
                                       ELSE '--'
                                  END),
             'Monto_MX'        = momonmo,
             'Tipo_Cambio'     = (CASE motipmer WHEN 'ARBI' THEN moparme
                                                ELSE moticam       
                                  END) ,
             'Monto_USD$'      = moussme,
             'Monto_Pesos'     = momonpe,
             'Entregamos'      = b.glosa,
             'Fecha_ValutaE'   = CONVERT(CHAR(12),movaluta1,103), 
             'Recibimos'       = c.glosa,
             'Fecha_ValutaR'   = CONVERT(CHAR(12),movaluta2,103), 
             'Estado'          = moestatus,
             'Hora'            = CONVERT(CHAR(8),GETDATE(),108) ,
             'Entidad'         = m.acnombre                     ,
             'FECHAHOY'        = CONVERT(CHAR(10),@FECHA_PROCESO, 103),
             'Fecha_Serv'      = CONVERT(CHAR(10), GETDATE(), 103),
             'acfecproc'       = @acfecproc  ,
             'acfecprox'       = @acfecprox  ,
             'uf_hoy'          = @uf_hoy     ,
             'uf_man'          = @uf_man     ,
             'ivp_hoy'         = @ivp_hoy    ,
             'ivp_man'         = @ivp_man    ,
             'do_hoy'          = @do_hoy     ,
             'do_man'          = @do_man     ,
             'da_hoy'          = @da_hoy     ,
             'da_man'          = @da_man     ,
             'pmnomprop'       = @acnomprop  ,
             'rut_empresa'     = @rut_empresa,
	     'HoraGraba'       = MoHora	     ,
	     'EstadoGraba'     = '  '
      FROM  MEMOH  ,
            VIEW_CLIENTE       AS a,
            VIEW_FORMA_DE_PAGO AS b,
            VIEW_FORMA_DE_PAGO AS c,
            MEAC               AS m,
            VIEW_PRODUCTO      AS P
      WHERE motipmer         <> 'CCBB'       AND 
            morutcli          = a.clrut      AND
            mocodcli          = a.clcodigo   AND
            moentre           = b.codigo     AND
            morecib           = c.codigo     AND
            (mofech          >= @FECHA_DESDE AND
             mofech          <= @FECHA_HASTA)AND
            P.id_sistema      = 'BCC'        AND
            P.codigo_producto = motipmer     AND
           (MOESTATUS         = ' '          OR
            MOESTATUS         = 'M') 


	UPDATE  #TEMPORAL
	SET EstadoGraba = (CASE WHEN HoraGraba BETWEEN DESDE AND HASTA THEN 'SI' ELSE 'NO' END)	
	FROM #TEMPORAL
	       INNER JOIN mdgestion..hora_producto ON sistema = 'BCC' AND Operacion = producto


      IF EXISTS(SELECT 1 FROM #TEMPORAL) BEGIN
         SELECT * FROM #TEMPORAL order by Fecha, HoraGraba
      END ELSE BEGIN
         SELECT  'Fecha'            = CONVERT(CHAR(10),@FECHA_PROCESO,103) ,
                 'Operacion'        = '',
                 'Numero_Operacion' = 0,
                 'Cliente'          = acnombre,
                 'Tipo_Operacion'   = 0,
                 'Monto_MX'         = 0,
                 'Tipo_Cambio'      = 0,
                 'Monto_USD$'       = 0,
                 'Monto_Pesos'      = 0,
                 'Entregamos'       = '',
                 'Fecha_ValutaE'    = '',
     		 'Recibimos'        = '',
                 'Fecha_ValutaR'    = '',
                 'Estado'           = '',
                 'Hora'             = CONVERT(CHAR(8),GETDATE(),108)  ,
                 'Entidad'          = acnombre,
                 'FECHAHOY'         = CONVERT(CHAR(10), @FECHA_PROCESO, 103) ,
                 'Fecha_Serv'       = CONVERT(CHAR(10), GETDATE(), 103) ,
                 'acfecproc'        = @acfecproc   ,
                 'acfecprox'        = @acfecprox   ,
                 'uf_hoy'           = @uf_hoy      ,
                 'uf_man'           = @uf_man      ,
                 'ivp_hoy'          = @ivp_hoy     ,
                 'ivp_man'          = @ivp_man     ,
                 'do_hoy'           = @do_hoy      ,
                 'do_man'           = @do_man      ,
                 'da_hoy'           = @da_hoy      ,
                 'da_man'           = @da_man      ,
                 'pmnomprop'        = @acnomprop   ,
                 'rut_empresa'      = @rut_empresa ,
  	         'HoraGraba'        = ' '	   ,
	         'EstadoGraba'      = ' '
		
         FROM MEAC
      END

SET NOCOUNT OFF
END




GO
