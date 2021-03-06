USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_VIGENTES_POR_GRUPO]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_VIGENTES_POR_GRUPO]

		(   @Codigo_Grupo    CHAR(10) = 'X'
                ,   @rut_cliente     NUMERIC(9)
                ,   @codigo_cliente  NUMERIC(9)
                )
                 
AS               
BEGIN

  SET DATEFORMAT dmy

  DECLARE       @acfecproc		CHAR	(10)
	,	@acfecprox		CHAR	(10)
	,	@uf_hoy			NUMERIC(21,4)
        ,	@uf_man			NUMERIC(21,4)
        ,	@ivp_hoy		NUMERIC(21,4)
	,	@ivp_man		NUMERIC(21,4)
	,	@do_hoy			NUMERIC(21,4)
	,	@do_man			NUMERIC(21,4)
	,	@da_hoy			NUMERIC(21,4)
        ,       @da_man         	NUMERIC(21,4)
	,	@acnomprop		CHAR	(40)
	,	@rut_empresa		CHAR	(12)
	,	@hora			CHAR	(08)
        ,       @fecha_busqueda 	DATETIME
        ,       @Contador       	INTEGER
        ,       @TotalRegistros 	INTEGER
        ,       @NumeroOperacion	NUMERIC(10)
        ,       @Grupo           	CHAR(10)
        ,       @MontoTraspaso     	FLOAT
	,	@Monedacontrol		NUMERIC(3)
	,	@NombreMonControl	CHAR(08)



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


	SELECT @MonedaControl = (SELECT moneda_control FROM DATOS_GENERALES)

	SET NOCOUNT ON
        IF EXISTS (SELECT 1 FROM LINEA_TRANSACCION,DATOS_GENERALES WHERE (Codigo_grupo = @Codigo_grupo OR @Codigo_grupo = 'X' )
                                                     AND   Activo = 'S'
                                                     AND  (Rut_Cliente       = @rut_cliente     OR @rut_cliente     = 0 )
                                                     AND  (Codigo_Cliente    = @codigo_cliente  OR @codigo_cliente  = 0 )
						     AND  FechaVencimiento   >= fecha_proceso	
                   )
	      BEGIN
   	      SELECT   'hora_reporte'         = CONVERT(CHAR(10),GETDATE(),108   )
		      ,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   )
                      ,'fecha_proceso'        = @acfecproc
                      ,'titulo'               = CASE WHEN @Codigo_Grupo = 'X' THEN 'LINEAS VIGENTES POR GRUPO AL ' + CONVERT(CHAR(10),@acfecproc,103)
                                                ELSE 'LINEA VIGENTE POR GRUPO ' + (SELECT RTRIM(descripcion) FROM GRUPO_PRODUCTO WHERE codigo_grupo = @Codigo_grupo) + ' AL ' + CONVERT(CHAR(10),@acfecproc,103) END
                      ,'Rut_Cliente'   	      = B.clrut
	              ,'DV_Cli'               = '- ' + B.cldv
      		      ,'Nombre_Cliente'	      = B.clnombre
                      ,'Operador'	      = A.Operador
                      ,'NumeroOperacion'      = A.NumeroOperacion
                      ,'NumeroDocumento'      = A.NumeroDocumento
                      ,'Codigo_grupo'         = A.Codigo_grupo
                      ,'Descripcion'          = C.descripcion
                      ,'Tipo_Operacion'       = CASE WHEN A.Tipo_Operacion = 'C' THEN 'COMPRA'
                                                     WHEN A.Tipo_Operacion = 'V' THEN 'VENTA'
                                                     ELSE ' '
                                                     END
                      ,'Tipo_Riesgo'          = CASE WHEN A.Tipo_Riesgo    = 'S' THEN 'NO'
                                                     ELSE 'SI'
                                                     END
                      ,'FechaInicio'          = A.FechaInicio
                      ,'FechaVencimiento'     = CONVERT(CHAR(10),A.FechaVencimiento,103)
                      ,'MontoOriginal'        = A.MontoOriginal
                      ,'TipoCambio'           = A.TipoCambio
                      ,'MatrizRiesgo'         = f.factor_riesgo
                      ,'MontoTransaccion'     = A.MontoTransaccion
                      ,'Activo'               = A.Activo
                      ,'acfecprox'   = @acfecprox
	              ,'uf_hoy'               = @uf_hoy
                      ,'uf_man'               = @uf_man
                      ,'ivp_hoy'              = @ivp_hoy
	              ,'ivp_man'              = @ivp_man
	              ,'do_hoy'               = @do_hoy
	              ,'do_man'               = @do_man
	              ,'da_hoy'               = @da_hoy
                      ,'da_man'               = @da_man
	              ,'acnomprop'            = @acnomprop
	              ,'rut_empresa'          = @rut_empresa
	              ,'hora'                 = @hora
                      ,'fecha_busqueda'       = @fecha_busqueda
                      ,'total'                = CONVERT(CHAR(30),'TOTAL')
                      ,'TituloNdoc'           = 'TOTAL'
                      ,'TituloNdoc2'          = 'DIAS'
		      ,'monedacontrol'	      = @MonedaControl
		      ,'NombreMonControl'     = (SELECT MNNEMO FROM MONEDA WHERE MNCODMON = @MonedaControl)
 		       INTO #VIGENTES_SISTEMA
	               FROM   LINEA_TRANSACCION    	A,
                              CLIENTE              	B,
                              GRUPO_PRODUCTO		C,
			      LINEAS_OPERACION_FRP      F,
			      DATOS_GENERALES
				
             WHERE   (A.codigo_grupo      = @Codigo_grupo OR @Codigo_grupo = 'X')
                          AND  (A.Activo          = 'S'                             )
	                  AND  (A.rut_cliente     = B.clrut                         )
	                  AND  (A.codigo_cliente  = B.clcodigo                      )
	                  AND  (A.codigo_grupo    = C.codigo_grupo                  )
                          AND  (Rut_Cliente       = @rut_cliente     OR @rut_cliente     = 0 )
                          AND  (Codigo_Cliente    = @codigo_cliente  OR @codigo_cliente  = 0 )
			  AND  a.FechaVencimiento   >= fecha_proceso	
			  AND  a.NumeroOperacion  = F.NumeroOperacion
			  AND  a.NumeroDocumento  = F.NumeroDocumento
			  AND  a.NumeroCorrelativo= F.NumeroCorrelativo
			  AND  a.Id_Sistema	  = F.Id_Sistema
			  AND  a.Codigo_Grupo 	  = F.Codigo_Grupo 
             ORDER BY Nombre_Cliente


            SELECT @Contador = 1
            SELECT @TotalRegistros = COUNT(*) FROM #VIGENTES_SISTEMA

                WHILE @Contador <= @TotalRegistros BEGIN

                        SET ROWCOUNT @Contador

                            SELECT @NumeroOperacion = NumeroOperacion
                            ,      @Grupo           = Codigo_Grupo
                            FROM #VIGENTES_SISTEMA

                        SELECT @MontoTraspaso = ISNULL(SUM(MontoTraspasado) ,0)
                                               	FROM LINEA_TRASPASO,DATOS_GENERALES
--                                              WHERE SistemaRecibio  = @Sistema
						WHERE codigo_grupo    = @Grupo
                                                AND NumeroOperacion = @NumeroOperacion
						AND FechaVencimiento >= fecha_proceso

                        UPDATE #VIGENTES_SISTEMA SET MontoTransaccion = MontoTransaccion - @MontoTraspaso
                                    WHERE NumeroOperacion = @NumeroOperacion
                                     AND  Codigo_Grupo    = @Grupo


                        SET ROWCOUNT 0

                        SELECT @Contador = @Contador + 1

                END


	      INSERT INTO #VIGENTES_SISTEMA
   	      SELECT   'hora_reporte'         = CONVERT(CHAR(10),GETDATE(),108   )   
		      ,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   ) 
                      ,'fecha_proceso'        = @acfecproc
                      ,'titulo'               = CASE WHEN @Codigo_Grupo = 'X' THEN 'LINEAS VIGENTES POR GRUPO AL ' + CONVERT(CHAR(10),@acfecproc,103) 
                                                ELSE 'LINEA VIGENTE POR GRUPO ' + (SELECT RTRIM(descripcion) FROM GRUPO_PRODUCTO WHERE codigo_grupo = @Codigo_grupo) + ' AL ' + CONVERT(CHAR(10),@acfecproc,103) END
                      ,'Rut_Cliente'   	      = B.clrut
	              ,'DV_Cli'               = '- ' + B.cldv
      		      ,'Nombre_Cliente'	      = B.clnombre
                      ,'Operador'	      = A.Operador
                      ,'NumeroOperacion'      = A.NumeroOperacion
                      ,'NumeroDocumento'      = A.NumeroDocumento
                      ,'Codigo_Grupo   '   = A.Codigo_Grupo
                      ,'Descripcion'          = 'TRASPASO A ' + C.descripcion
                      ,'Tipo_Operacion'       = CASE WHEN A.TipoOperacion = 'C' THEN 'COMPRA'
                                                     WHEN A.TipoOperacion = 'V' THEN 'VENTA'
                                                     ELSE ' '
                                                     END
                      ,'Tipo_Riesgo'          = CASE WHEN A.Tipo_Riesgo = 'S' THEN 'NO'
                                                     ELSE 'SI'
                                                     END
                      ,'FechaInicio'          = A.FechaInicio
                      ,'FechaVencimiento'     = CONVERT(CHAR(10),A.FechaVencimiento,103)
                      ,'MontoOriginal'        = A.MontoTraspasado
                      ,'TipoCambio'           = CONVERT(FLOAT,0)
                      ,'MatrizRiesgo'         = CONVERT(FLOAT,0)
                      ,'MontoTransaccion'     = A.MontoTraspasado
                      ,'Activo'               = A.Activo

                      ,'acfecprox'            = @acfecprox
	              ,'uf_hoy'               = @uf_hoy
                      ,'uf_man'               = @uf_man
                      ,'ivp_hoy'              = @ivp_hoy
	              ,'ivp_man'              = @ivp_man
	              ,'do_hoy'               = @do_hoy
	              ,'do_man'               = @do_man
	              ,'da_hoy'               = @da_hoy
                      ,'da_man'               = @da_man
	              ,'acnomprop'            = @acnomprop
	              ,'rut_empresa'          = @rut_empresa
	              ,'hora'                 = @hora
                      ,'fecha_busqueda'       = @fecha_busqueda
                      ,'total'                = CONVERT(CHAR(30),'TOTAL')
                      ,'TituloNdoc'           = 'TOTAL'
                      ,'TituloNdoc2'          = 'DIAS'
		      ,'monedacontrol'	      = @MonedaControl
		      ,'NombreMonControl'     = (SELECT MNNEMO FROM MONEDA WHERE MNCODMON = @MonedaControl)
	               FROM   LINEA_TRASPASO       	A,
                              CLIENTE              	B,
			      GRUPO_PRODUCTO		C,
			      DATOS_GENERALES
	             WHERE     (A.Codigo_Grupo    = @Codigo_Grupo OR @Codigo_Grupo = 'X')
			  AND  (C.Codigo_Grupo    = A.Codigo_Grupo                  )
                          AND  (A.Activo          = 'S'                             )
	                  AND  (A.rut_cliente     = B.clrut                         )
	                  AND  (A.codigo_cliente  = B.clcodigo                      )
                          AND  (Rut_Cliente       = @rut_cliente     OR @rut_cliente     = 0 )
                          AND  (Codigo_Cliente    = @codigo_cliente  OR @codigo_cliente  = 0 )
			  AND  FechaVencimiento >= fecha_proceso
/***********************************************************************************************************************/
   	      SELECT   hora_reporte
		      ,fecha_reporte
	              ,fecha_proceso
                      ,titulo
                      ,Rut_Cliente
	              ,DV_Cli
      		      ,Nombre_Cliente
                      ,Operador
                      ,NumeroOperacion
                      ,NumeroDocumento
                      ,Codigo_Grupo
                      ,Descripcion
                      ,Tipo_Operacion
                      ,Tipo_Riesgo
                      ,FechaInicio
                      ,FechaVencimiento
                      ,MontoOriginal
                      ,TipoCambio
                      ,MatrizRiesgo
                      ,MontoTransaccion
                      ,Activo
                      ,acfecprox
	              ,uf_hoy
                      ,uf_man
                      ,ivp_hoy
	              ,ivp_man
	              ,do_hoy
	              ,do_man
	              ,da_hoy
                      ,da_man
	              ,acnomprop
	              ,rut_empresa
		      ,hora
                    ,fecha_busqueda
                      ,total
                      ,TituloNdoc
                      ,TituloNdoc2
		      ,MonedaControl
		      ,NombreMonControl
   			FROM #VIGENTES_SISTEMA
			ORDER BY Codigo_Grupo, Nombre_Cliente, NumeroOperacion
/***********************************************************************************************************************/
        END ELSE BEGIN

	      SELECT   'hora_reporte'         = CONVERT(CHAR(10),GETDATE(),108     )
 		      ,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103     )
                      ,'fecha_proceso'        = @acfecproc
                      ,'titulo'               = CASE WHEN @Codigo_Grupo = 'X' THEN 'LINEAS VIGENTES POR GRUPO AL ' + CONVERT(CHAR(10),@acfecproc,103)
                                                ELSE 'LINEA VIGENTE POR GRUPO ' + (SELECT RTRIM(descripcion) FROM GRUPO_PRODUCTO WHERE Codigo_grupo = @Codigo_Grupo) + ' AL ' + CONVERT(CHAR(10),@acfecproc,103) END
                      ,'Rut_Cliente'   	      = CONVERT(FLOAT,0)
	              ,'DV_Cli'               = ' '
      		      ,'Nombre_Cliente'	      = ' '
                      ,'Operador'	      = ' '
                      ,'NumeroOperacion'      = CONVERT(FLOAT,0)
                      ,'NumeroDocumento'      = CONVERT(FLOAT,0)
                      ,'Codigo_Grupo'	      = CONVERT(FLOAT,0)
                      ,'Descripcion'          = ' '
                      ,'Tipo_Operacion'       = ' '
                      ,'Tipo_Riesgo'          = ' '
                      ,'FechaInicio'          = ' '
                      ,'FechaVencimiento'     = ' '
                      ,'MontoOriginal'        = CONVERT(FLOAT,0)
                      ,'TipoCambio'           = CONVERT(FLOAT,0)
                      ,'MatrizRiesgo'         = CONVERT(FLOAT,0)
                      ,'MontoTransaccion'     = CONVERT(FLOAT,0)
                      ,'Activo'               = ' '
                      ,'acfecprox'            = @acfecprox
	              ,'uf_hoy'               = @uf_hoy
                      ,'uf_man'               = @uf_man
                      ,'ivp_hoy'              = @ivp_hoy
	              ,'ivp_man'              = @ivp_man
	              ,'do_hoy'               = @do_hoy
	              ,'do_man'               = @do_man
	              ,'da_hoy'               = @da_hoy
                      ,'da_man'               = @da_man
	              ,'acnomprop'            = @acnomprop
	              ,'rut_empresa'          = @rut_empresa
	              ,'hora'                 = @hora
                      ,'fecha_busqueda'       = @fecha_busqueda
                      ,'total'                = CONVERT(CHAR(30),'NO EXISTE INFORMACION')
                      ,'TituloNdoc'           = 'NUMERO'
                      ,'TituloNdoc2'          = 'DOCUMENTO'
		      ,'monedacontrol'	      = @MonedaControl
		      ,'NombreMonControl'     = (SELECT MNNEMO FROM MONEDA WHERE MNCODMON = @MonedaControl)

	
          END
SET NOCOUNT OFF
END


-- SP_LINEAS_VIGENTES_POR_GRUPO 'X', 0, 0






GO
