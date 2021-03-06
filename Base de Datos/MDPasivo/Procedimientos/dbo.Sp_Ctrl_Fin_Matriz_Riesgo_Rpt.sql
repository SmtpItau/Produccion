USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ctrl_Fin_Matriz_Riesgo_Rpt]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Ctrl_Fin_Matriz_Riesgo_Rpt]
   (   @fecha_x   CHAR(10) 
   ,   @Usuario   VARCHAR(15))
AS 
BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy

  DECLARE   @fecha   DATETIME
  SELECT    @fecha   = CONVERT(DATETIME,@fecha_x,112)

  DECLARE   @acfecproc         CHAR(10)
   ,        @acfecprox         CHAR(10)
   ,        @uf_hoy            NUMERIC(21,4)
   ,        @uf_man            NUMERIC(21,4)
   ,        @ivp_hoy           NUMERIC(21,4)
   ,        @ivp_man           NUMERIC(21,4)
   ,        @do_hoy            NUMERIC(21,4)
   ,        @do_man            NUMERIC(21,4)
   ,        @da_hoy            NUMERIC(21,4)
   ,        @da_man            NUMERIC(21,4)
   ,        @acnomprop         CHAR(40)
   ,        @rut_empresa       CHAR(12)
   ,        @hora              CHAR(8)
   ,        @fecha_busqueda    DATETIME
   ,        @titulo            VARCHAR(255)
   ,	    @MonedaControl     NUMERIC(3)
  SELECT    @fecha_busqueda  = (SELECT Fecha_Proceso FROM DATOS_GENERALES)


  EXECUTE Sp_Base_Del_Informe
           @acfecproc   OUTPUT
   ,       @acfecprox   OUTPUT
   ,       @uf_hoy      OUTPUT
   ,       @uf_man      OUTPUT
   ,       @ivp_hoy     OUTPUT
   ,       @ivp_man     OUTPUT
   ,       @do_hoy      OUTPUT
   ,       @do_man      OUTPUT
   ,       @da_hoy      OUTPUT
   ,       @da_man      OUTPUT
   ,       @acnomprop   OUTPUT
   ,       @rut_empresa OUTPUT
   ,       @hora        OUTPUT     
   ,       @fecha_busqueda

   SELECT  'acfecproc'   = @acfecproc
   ,       'acfecprox'   = @acfecprox
   ,       'uf_hoy'      = @uf_hoy
   ,       'uf_man'      = @uf_man
   ,       'ivp_hoy'     = @ivp_hoy
   ,       'ivp_man'     = @ivp_man
   ,       'do_hoy'      = @do_hoy
   ,       'do_man'      = @do_man
   ,       'da_hoy'      = @da_hoy
   ,       'da_man'      = @da_man
   ,       'acnomprop'   = @acnomprop
   ,       'rut_empresa' = @rut_empresa
   ,       'hora'        = @hora
   ,       'Fech_Emi'    = CONVERT(CHAR(10),GETDATE(),103)
   ,       'Fech_Pro'    = CONVERT(CHAR(10),@acfecproc,103)
   ,       'Usuario'     = @Usuario + ' /MARGENES'
   ,       'Fech_Filtro' = CONVERT(CHAR(10),@fecha,103)  
   INTO    #BASE

   SELECT @MonedaControl = (SELECT moneda_control FROM DATOS_GENERALES)

   SELECT  'Rut_Cli'           = Rut_Cliente
   ,       'Cod_Cli'           = codigo_cliente
   ,       'Nom_Cliente'       = SPACE(100)
   ,       'Fecha_Inicio'      = CONVERT(CHAR(10),fechainicio,103)
   ,       'Fecha_Vencimiento' = CONVERT(CHAR(10),fechavencimiento,103)
   ,       'Plazo'             = DATEDIFF(DAY , fechainicio , fechavencimiento)
   ,       'Monto_Original'    = SUM(Montooriginal)
   ,       'Monto_Transaccion' = SUM(Montotransaccion)
   ,       'Tipo_Cambio'       = AVG(TipoCambio)
   ,       'Tip_Riesgo'        = Tipo_Riesgo
   ,       'Glo_Riesgo'        = CASE WHEN Tipo_Riesgo = 'C' THEN 'COMPENSACION'
                                      WHEN Tipo_Riesgo = 'E' THEN 'ENTREGA FISICA'
                                 END
   ,       'Tip_Operacion'     = Tipo_Operacion
   ,       'Cod_Producto'      = codigo_grupo
   ,       'Utilizado'         = CONVERT(NUMERIC(19,4),0)
   ,       'Plazo_Desde'       = CONVERT(NUMERIC(14,0),0)
   ,       'Plazo_Hasta'       = CONVERT(NUMERIC(14,0),0)
   ,       'Ocupado'           = CONVERT(NUMERIC(19,4),0)
   ,       'Glosa_Producto'    = SPACE(30)
   ,	   'MonedaControl'     = @MonedaControl
   ,       'NombreMonControl'  = (SELECT MNNEMO FROM MONEDA WHERE MNCODMON = @MonedaControl)
   ,       'MonedaOperacion'   = codigo_moneda 
   INTO    #OPERACIONES
   FROM    LINEA_TRANSACCION
   GROUP BY  rut_cliente 
         ,   codigo_cliente 
         ,   fechainicio 
         ,   fechavencimiento
         ,   Tipo_riesgo
         ,   Tipo_Operacion
         ,   codigo_grupo
         ,   codigo_moneda
   ORDER BY  DATEDIFF(DAY , fechainicio , fechavencimiento)

   UPDATE #OPERACIONES
   SET    Nom_Cliente = clnombre
   FROM   CLIENTE
   WHERE  Rut_Cli = clrut
   AND    Cod_Cli = clcodigo   

  
   UPDATE #OPERACIONES
   SET    Glosa_Producto = descripcion
   FROM  GRUPO_PRODUCTO
   WHERE codigo_grupo = cod_producto


   UPDATE #OPERACIONES
   SET    Utilizado = ISNULL(porcentaje,0)
   ,      Plazo_desde = dias_desde
   ,      Plazo_hasta = dias_hasta
   FROM   MATRIZ_RIESGO 
   WHERE  codigo_grupo = cod_producto
   AND    plazo BETWEEN dias_desde AND dias_hasta
   AND    codigo_moneda = monedaoperacion 

   UPDATE #OPERACIONES
   SET    Ocupado = (Monto_Original * Utilizado)/100

   IF NOT EXISTS(SELECT 1 FROM #OPERACIONES)
      SELECT  'Rut_Cli'           = ' '
      ,       'Cod_Cli'           = ' '
      ,       'Nom_Cliente'       = ' '
      ,       'Fecha_Inicio'      = ' '
      ,       'Fecha_Vencimiento' = ' '
      ,       'Plazo'             = ' '
      ,       'Monto_Original'    = ' '
      ,       'Monto_Transaccion' = ' '
      ,       'Tipo_Cambio'       = ' '
      ,       'Tip_Riesgo'        = ' '
      ,       'Glo_Riesgo'        = ' '
      ,       'Tip_Operacion'     = ' '
      ,       'Cod_Producto'      = ' '
      ,       'Utilizado'         = ' '
      ,       'Plazo_Desde'       = ' '
      ,       'Plazo_Hasta'       = ' '
      ,       'Ocupado'           = ' '
      ,       'Glosa_Producto'    = ' '
      ,	      'MonedaControl'     = @MonedaControl
      ,       'NombreMonControl'  = (SELECT MNNEMO FROM MONEDA WHERE MNCODMON = @MonedaControl)
      ,       'Monedaoperacion'   = 0
      ,       *
      FROM #BASE
   ELSE
      SELECT * FROM #OPERACIONES , #BASE
      WHERE GLOSA_PRODUCTO <> ' '
               ORDER BY
               COD_PRODUCTO   ,
               PLAZO_HASTA    ,
               NOM_CLIENTE
            
   SET NOCOUNT OFF

END 


GO
