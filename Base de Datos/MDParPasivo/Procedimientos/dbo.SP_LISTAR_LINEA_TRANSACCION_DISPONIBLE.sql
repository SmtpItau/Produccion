USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_LINEA_TRANSACCION_DISPONIBLE]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LISTAR_LINEA_TRANSACCION_DISPONIBLE]
    (@Codigo_Grupo           CHAR(10) = 'X',
     @usuario                CHAR(100) = ' ',
     @rutcliente             NUMERIC(12) = 0,
     @codigocliente          NUMERIC(12) = 0,
     @clasificacion_cliente  NUMERIC(12) = 0)
AS
BEGIN


    SET DATEFORMAT dmy
    -- Informe que despliega las lineas de transaccion
    -- considerando si ha afectado a las lineas

    SET NOCOUNT ON
    -- Variables del procedimiento almacenado  
    DECLARE @acfecproc   CHAR(10)
    DECLARE @acfecprox   CHAR(10)
    DECLARE @uf_hoy      FLOAT
    DECLARE @uf_man      FLOAT
    DECLARE @ivp_hoy     FLOAT
    DECLARE @ivp_man     FLOAT
    DECLARE @do_hoy      FLOAT
    DECLARE @do_man      FLOAT
    DECLARE @da_hoy      FLOAT
    DECLARE @da_man      FLOAT
    DECLARE @acnomprop   CHAR(40)
    DECLARE @rut_empresa CHAR(12)
    DECLARE @hora        CHAR(8)
    DECLARE @fecha_busqueda DATETIME

    EXECUTE SP_BASE_DEL_INFORME
            @acfecproc        OUTPUT,
            @acfecprox        OUTPUT,
            @uf_hoy           OUTPUT,
            @uf_man           OUTPUT,
            @ivp_hoy          OUTPUT,
            @ivp_man          OUTPUT,
            @do_hoy           OUTPUT,
            @do_man           OUTPUT,
            @da_hoy           OUTPUT,
            @da_man           OUTPUT,
            @acnomprop        OUTPUT,
            @rut_empresa      OUTPUT,
            @hora             OUTPUT,
            @fecha_busqueda   

    IF EXISTS( SELECT 1  FROM 
            LINEA_TRANSACCION             LT,
            PRODUCTO                      PR,
            CLIENTE                       CL,
            GRUPO_PRODUCTO                SI,
            LINEA_TRANSACCION_DETALLE     LTD,
	    DATOS_GENERALES
        WHERE 
                (LT.Codigo_Grupo    = @Codigo_Grupo OR @Codigo_Grupo = 'X')
            AND (LT.Rut_Cliente     = @rutcliente OR @rutcliente = 0)
            AND (LT.Codigo_Cliente  = @codigocliente OR @codigocliente = 0)            
            AND (LT.Rut_Cliente     = CL.Clrut)
            AND  LT.Codigo_Cliente  = CL.Clcodigo
            AND  SI.Codigo_Grupo    = LT.Codigo_Grupo
            AND  LTD.Codigo_Grupo      = LT.Codigo_Grupo                    
            AND  LTD.NumeroOperacion    = LT.NumeroOperacion
            AND  LTD.NumeroCorrelativo  = LT.NumeroCorrelativo
            AND  LTD.Tipo_Detalle       = 'L'             
            AND LT.Activo = 'S'
            AND (CL.Cltipcli               = @clasificacion_cliente OR @clasificacion_cliente = 0)
	    AND FechaVencimiento > fecha_proceso	
	    AND Linea_Transsaccion = 'LINGEN' )
        BEGIN
        SELECT
            'Clasificacion_Cliente'  = (SELECT descripcion FROM TIPO_CLIENTE WHERE Codigo_Tipo_Cliente = CL.Cltipcli),
            'Sistema'           = LT.Codigo_Grupo,
            'NombreSistema'          = SI.descripcion,
            'RutCliente'             = LTRIM(RTRIM(CONVERT(CHAR,CL.Clrut))) + ' - ' + CL.Cldv,
            'NombreCliente'          = CL.Clnombre,
            'CodigoProducto'         = LT.Codigo_Grupo,
            'NombreProducto'         = PR.descripcion,
            'MontoOperacion'         = SUM(LT.MontoTransaccion),
            'Tipo_Riesgo'            = (CASE WHEN LT.Tipo_Riesgo = 'S' THEN 'S' WHEN LT.Tipo_Riesgo = 'C' THEN 'N' ELSE ' ' END)  ,
            'DiasPromedio'           = AVG(DATEDIFF(DAY,LT.FechaInicio,LT.FechaVencimiento)),
            'CuentaProducto'         = COUNT(*),
            'Fecha_Proceso'          = @acfecproc,
            'Fecha_Proxima'          = @acfecprox,
            'UF_Hoy'                 = @uf_hoy,
            'UF_Man'                 = @uf_man,
            'IVP_Hoy'                = @ivp_hoy,
            'IVP_Man'                = @ivp_man,
            'DO_Hoy'                 = @do_hoy,
            'DO_Man'                 = @do_man,
            'Nombre_Empresa'         = @acnomprop,
            'Rut_Empresa'            = @rut_empresa,
       'Hora'                   = @hora,
            'Usuario'                = @usuario,
            'Datos'                  = 'H'
        INTO #TEMP1
        FROM
             LINEA_TRANSACCION             LT,
            PRODUCTO                      PR,
            CLIENTE                       CL,
            GRUPO_PRODUCTO                SI,
            LINEA_TRANSACCION_DETALLE     LTD,
	    DATOS_GENERALES
        WHERE 
                (LT.Codigo_Grupo    = @Codigo_Grupo OR @Codigo_Grupo = 'X')
            AND (LT.Rut_Cliente     = @rutcliente OR @rutcliente = 0)
            AND (LT.Codigo_Cliente  = @codigocliente OR @codigocliente = 0)            
            AND  LT.Rut_Cliente     = CL.Clrut
            AND  LT.Codigo_Cliente  = CL.Clcodigo
            AND  SI.Codigo_Grupo    = LT.Codigo_Grupo
            AND LT.Activo = 'S'
            AND (CL.Cltipcli               = @clasificacion_cliente OR @clasificacion_cliente = 0)
            AND  LTD.Codigo_Grupo      = LT.Codigo_Grupo                    
            AND  LTD.NumeroOperacion    = LT.NumeroOperacion
            AND  LTD.NumeroCorrelativo  = LT.NumeroCorrelativo
            AND  LTD.Tipo_Detalle       = 'L'        
            AND  LTD.Codigo_producto    = pr.codigo_producto
            AND  pr.id_sistema          = ltd.id_sistema
	    AND FechaVencimiento > fecha_proceso	 
	    AND Linea_Transsaccion = 'LINGEN'

        GROUP BY 
            LT.Codigo_Grupo,
            SI.descripcion,
            CL.Clnombre,
            PR.descripcion,
            LT.Operador,
            CL.Clrut,
            CL.Cldv,
            LT.Tipo_Riesgo,
            CL.Cltipcli

        ORDER BY
            NombreSistema,
            NombreCliente,
            NombreProducto ASC

        ----------------------------------------------------------------------------------------------
        -- Insercion de los traspasos de los sistemas
        ----------------------------------------------------------------------------------------------
        INSERT INTO #TEMP1
        SELECT 
            (SELECT descripcion FROM TIPO_CLIENTE WHERE Codigo_Tipo_Cliente = CLI.Cltipcli ),
            LTS.Codigo_Grupo,
            SIS.descripcion,
            LTRIM(RTRIM(CONVERT(CHAR,CLI.Clrut))) + ' - ' + CLI.Cldv,
            CLI.ClNombre,
            'TRASP',
            'TRASPASO A ', --+(SELECT Nombre_Sistema FROM SISTEMA WHERE ID_Sistema = LTS.SistemaRecibio),
            SUM(LTS.MontoTraspasado),
            (CASE WHEN LTS.Tipo_Riesgo = 'S' THEN 'S' WHEN LTS.Tipo_Riesgo = 'C' THEN 'N' ELSE ' ' END)  ,
            AVG(DATEDIFF(DAY,LTS.FechaInicio,LTS.FechaVencimiento)),
            COUNT(LTS.GrupoRecibio),
            @acfecproc,
            @acfecprox,
            @uf_hoy,
            @uf_man,
            @ivp_hoy,
            @ivp_man,
            @do_hoy,
            @do_man,
            @acnomprop,
            @rut_empresa,
            @hora,
            @usuario,
            'H'
        FROM LINEA_TRASPASO    LTS,
             GRUPO_PRODUCTO    SIS,
             CLIENTE           CLI,
	     DATOS_GENERALES
        WHERE 
             (LTS.Codigo_Grupo        = @Codigo_Grupo  OR @Codigo_Grupo = 'X')
          AND  LTS.Codigo_Grupo       = SIS.Codigo_Grupo
          AND  CLI.CLRut              = LTS.Rut_Cliente
	  AND  CLI.clcodigo	      = LTS.codigo_cliente
          AND (LTS.Rut_Cliente        = @rutcliente     OR @rutcliente = 0)
          AND (LTS.Codigo_Cliente     = @codigocliente  OR @codigocliente = 0)        
          AND LTS.Activo = 'S'
          AND (CLI.Cltipcli           = @clasificacion_cliente OR @clasificacion_cliente = 0)
          AND FechaVencimiento > fecha_proceso	 
        GROUP BY
            LTS.Codigo_Grupo,
            SIS.descripcion,
            CLI.ClNombre,
            CLI.Clrut,
            CLI.Cldv,
            LTS.Operador,
            LTS.Tipo_Riesgo,
             CLI.Cltipcli

        -- Presentar los resultados
        SELECT 
            Clasificacion_Cliente,
            Sistema,
            NombreSistema,
            RutCliente,
            NombreCliente,
            CodigoProducto,
            NombreProducto,
            'MontoOperacion' = SUM(MontoOperacion),
            Tipo_Riesgo,
            'DiasPromedio'   = SUM(DiasPromedio),
            'CuentaProducto' = SUM(CuentaProducto),
            Fecha_Proceso,
            Fecha_Proxima,
            UF_Hoy,
            UF_Man,
            IVP_Hoy,
            IVP_Man,
            DO_Hoy,
            DO_Man,
            Nombre_Empresa,
            Rut_Empresa,
            Hora,
            Usuario,
            Datos
        FROM #TEMP1 
        GROUP BY
            Clasificacion_Cliente,
            Sistema,
            NombreSistema,
            RutCliente,
            NombreCliente,
            CodigoProducto,
            NombreProducto,
            Tipo_Riesgo,
            Fecha_Proceso,
            Fecha_Proxima,
            UF_Hoy,
            UF_Man,
            IVP_Hoy,
            IVP_Man,
            DO_Hoy,
            DO_Man,
            Nombre_Empresa,
            Rut_Empresa,
            Hora,
            Usuario,
            Datos

        ORDER BY
            NombreSistema,
            NombreCliente,
            NombreProducto ASC

        END            
    ELSE
        SELECT 
            'Clasificacion_Cliente'  = ' ',
            'Sistema'                = ' ',
            'NombreSistema'          = ' ',
            'RutCliente'             = ' ',
            'NombreCliente'          = ' ',
            'CodigoProducto'         = ' ',
            'NombreProducto'         = ' ',
            'MontoOperacion'         = 0.0,
            'Tipo_Riesgo'            = ' ',
            'DiasPromedio'           = 0,
            'CuentaProducto'         = 0,
            'Fecha_Proceso'          = @acfecproc,
            'Fecha_Proxima'          = @acfecprox,
            'UF_Hoy'                 = @uf_hoy,
            'UF_Man'                 = @uf_man,
            'IVP_Hoy'                = @ivp_hoy,
            'IVP_Man'                = @ivp_man,
            'DO_Hoy'                 = @do_hoy,
            'DO_Man'                 = @do_man,
            'Nombre_Empresa'         = @acnomprop,
            'Rut_Empresa'            = @rut_empresa,
            'Hora'                   = @hora,
            'Usuario'                = @usuario,
            'Datos'                  = 'N'    

        SET NOCOUNT OFF
END

--dbo.SP_LISTAR_LINEA_TRANSACCION_DISPONIBLE 'x','administra',97919000,1,0

--select * from linea_transaccion where rut_cliente =97919000 and fechavencimiento >'20040809'

GO
