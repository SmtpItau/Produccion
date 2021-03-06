USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_SISTEMA_DISPONIBLE]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[SP_LINEA_SISTEMA_DISPONIBLE]
    (@usuario                CHAR(100)    = ' ',
     @sistema                CHAR(10)     = 'X',
     @rutcliente             NUMERIC(12)  = 0,
     @codigocliente          NUMERIC(12)  = 0,
     @clasificacion_cliente  NUMERIC(12)  = 0)
AS
BEGIN

    SET NOCOUNT ON
    SET DATEFORMAT dmy
    
    -- Variables del procedimiento almacenado  
    DECLARE @acfecproc      CHAR(10)
    DECLARE @acfecprox      CHAR(10)
    DECLARE @uf_hoy         FLOAT
    DECLARE @uf_man         FLOAT
    DECLARE @ivp_hoy        FLOAT
    DECLARE @ivp_man        FLOAT
    DECLARE @do_hoy         FLOAT
    DECLARE @do_man         FLOAT
    DECLARE @da_hoy         FLOAT
    DECLARE @da_man         FLOAT
    DECLARE @acnomprop      CHAR(40)
    DECLARE @rut_empresa    CHAR(12)
    DECLARE @hora           CHAR(8)
    DECLARE @fecha_busqueda DATETIME
    DECLARE @monedacontrol  NUMERIC(03)
    DECLARE @pais           NUMERIC(03)
    DECLARE @plaza          NUMERIC(03)
    DECLARE @fecha_2_dia    DATETIME
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

 
     SELECT @monedacontrol = moneda_control ,
            @pais          = codigo_pais,
            @plaza         = codigo_plaza
     FROM DATOS_GENERALES
 
     CREATE TABLE #TEMP1( FECHA    DATETIME )  
    
     INSERT INTO #TEMP1 EXEC SP_CON_FECHA_FERIADO @PAIS , @PLAZA , @acfecprox , 2    --PROXIMO HABIL            
     SELECT @FECHA_2_dia = ( SELECT FECHA FROM #TEMP1 )

    
	IF EXISTS(SELECT 1 FROM LINEA_SISTEMA LS, CLIENTE CL, GRUPO_PRODUCTO SI WHERE CL.Clcodigo = LS.Codigo_Cliente AND CL.Clrut = LS.Rut_Cliente AND SI.codigo_grupo = LS.codigo_grupo AND LS.TotalAsignado > 0)
	BEGIN

		IF EXISTS (SELECT 1 FROM LINEA_SISTEMA LS, CLIENTE CL, GRUPO_PRODUCTO SI WHERE CL.Clcodigo = LS.Codigo_Cliente
        											AND (LS.codigo_grupo = @sistema OR @sistema = 'X')
											        AND (LS.Rut_Cliente = @rutcliente OR @rutcliente = 0)
										        	AND (LS.Codigo_Cliente = @codigocliente OR @codigocliente = 0)
											        AND CL.Clrut = LS.Rut_Cliente
										        	AND SI.codigo_grupo  = LS.codigo_grupo
											        AND LS.TotalAsignado > 0
												AND (CL.Cltipcli = @clasificacion_cliente OR @clasificacion_cliente = 0))
		BEGIN
		        SELECT 
        		    'Clasificacion_Cliente'  = (SELECT descripcion FROM TIPO_CLIENTE WHERE Codigo_Tipo_Cliente = CL.Cltipcli ),
	        	    'Sistema'                = SI.DESCRIPCION,
	        	    'Rut_Cliente'            = RTRIM(LTRIM(CONVERT(CHAR,LS.Rut_Cliente))) + ' - ' + CL.Cldv,
		            'Nombre_Cliente'         = CL.ClNombre,
        		    'TotalLinea'             = LS.TotalAsignado,
		            'TotalOcupado'           = LS.TotalOcupado,
        		    'TotalDisponible'        = (CASE WHEN (LS.TotalAsignado-LS.TotalOcupado) <= 0 
                		                        THEN 0 
                        		                ELSE (LS.TotalAsignado-LS.TotalOcupado) 
                                		        END),
		            'TotalExceso'            = (CASE WHEN (LS.TotalAsignado-LS.TotalOcupado) <= 0 
        		                                THEN (LS.TotalOcupado-LS.TotalAsignado) 
                		                        ELSE 0 
                        		                END),
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
		            'Datos'                  = 'H',
			    'monedacontrol'	     = @monedacontrol,
			    'nombremoneda'	     = (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol),
                            'Desocupada_1_dia'       =  ISNULL((SELECT SUM(a.montotransaccion) 
                                                        FROM LINEA_TRANSACCION_DETALLE a ,LINEA_TRANSACCION b
                                                        WHERE tipo_detalle = 'L' AND linea_transsaccion = 'LINGEN'
                                                        AND  a.numerooperacion = b.numerooperacion
                                                        AND  a.numerodocumento = b.numerodocumento 
                                                        AND  a.numerocorrelativo = b.numerocorrelativo
                                                        AND  (FechaVencimiento > CONVERT(DATETIME,@acfecproc) and FechaVencimiento <= CONVERT(DATETIME,@acfecprox))
                                                        AND  B.rut_cliente = ls.rut_cliente
                                                        AND  B.codigo_cliente = ls.codigo_cliente
                                                        AND  B.codigo_grupo = ls.codigo_grupo),0),
                            'Desocupada_2_dia'       = ISNULL((SELECT SUM(a.montotransaccion) 
                                                        FROM LINEA_TRANSACCION_DETALLE a ,LINEA_TRANSACCION b
                                                        WHERE tipo_detalle = 'L' AND linea_transsaccion = 'LINGEN'
                                                        AND  a.numerooperacion = b.numerooperacion
                                                        AND  a.numerodocumento = b.numerodocumento 
                                                        AND  a.numerocorrelativo = b.numerocorrelativo
                                                        AND  (FechaVencimiento > CONVERT(DATETIME,@acfecprox) and FechaVencimiento <= @fecha_2_dia)
                                                        AND  B.rut_cliente = ls.rut_cliente
                                                        AND  B.codigo_cliente = ls.codigo_cliente
                                                        AND  B.codigo_grupo = ls.codigo_grupo),0),
                            'fecha_vcto'             = CONVERT(CHAR(10),FechaVencimiento,103) 
        		FROM
	        	    LINEA_SISTEMA                    LS,
	        	    CLIENTE                          CL,
		            GRUPO_PRODUCTO                   SI
        		WHERE
		            CL.Clcodigo                           = LS.Codigo_Cliente
        		AND (LS.codigo_grupo                      = @sistema OR @sistema = 'X')
	        	AND (LS.Rut_Cliente                       = @rutcliente OR @rutcliente = 0)
	        	AND (LS.Codigo_Cliente                    = @codigocliente OR @codigocliente = 0)
		        AND CL.Clrut       			  = LS.Rut_Cliente
        		AND SI.codigo_grupo                       = LS.codigo_grupo
		        AND LS.TotalAsignado                      > 0
		        AND (CL.Cltipcli                          = @clasificacion_cliente OR @clasificacion_cliente = 0)
                        AND CL.Clrut				  <> 98000900
        		ORDER BY
		            SI.DESCRIPCION,
        		    CL.ClNombre,
	        	    Clasificacion_Cliente ASC

		END
		ELSE
		BEGIN
		        SELECT 
			    'Clasificacion_Cliente'  = ' ',
        		    'Sistema'       = ' ',
	        	    'Rut_Cliente'        = ' ',
		            'Nombre_Cliente'     = ' ',
			    'TotalLinea'         = 0.0,
        		    'TotalOcupado'       = 0.0,
		            'TotalDisponible'    = 0.0,
        		    'TotalExceso'        = 0.0,
	        	    'Fecha_Proceso'      = @acfecproc,
	        	    'Fecha_Proxima'      = @acfecprox,
		            'UF_Hoy'             = @uf_hoy,
        		    'UF_Man'             = @uf_man,
		            'IVP_Hoy'            = @ivp_hoy,
        		    'IVP_Man'            = @ivp_man,
	        	    'DO_Hoy'             = @do_hoy,
	        	    'DO_Man'             = @do_man,
		            'Nombre_Empresa'     = @acnomprop,
        		    'Rut_Empresa'        = @rut_empresa,
		            'Hora'               = @hora,
        		    'Usuario'            = @usuario,
	        	    'Datos'              = 'N',
			    'monedacontrol'	 = @monedacontrol,
			    'nombremoneda'	 = (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol),
                            'Desocupada_1_dia'       = 0.0,
                            'Desocupada_2_dia'       = 0.0,
                            'fecha_vcto'             = CONVERT(CHAR(10),'') 

		END

	END
	ELSE
	BEGIN
        	-- Parte Vacia
	        SELECT 
		    'Clasificacion_Cliente'  =' ',
        	    'Sistema'            = ' ',
	            'Rut_Cliente'        = ' ',
	            'Nombre_Cliente'     = ' ',
		    'TotalLinea'         = 0.0,
        	    'TotalOcupado'       = 0.0,
	            'TotalDisponible'    = 0.0,
        	    'TotalExceso'        = 0.0,
	            'Fecha_Proceso'      = @acfecproc,
        	    'Fecha_Proxima'      = @acfecprox,
	            'UF_Hoy'             = @uf_hoy,
        	    'UF_Man'             = @uf_man,
	            'IVP_Hoy'            = @ivp_hoy,
        	    'IVP_Man'            = @ivp_man,
	            'DO_Hoy'             = @do_hoy,
        	    'DO_Man'             = @do_man,
	            'Nombre_Empresa'     = @acnomprop,
        	    'Rut_Empresa'        = @rut_empresa,
	            'Hora'               = @hora,
        	    'Usuario'            = @usuario,
	            'Datos'              = 'N',
		    'monedacontrol'	     = @monedacontrol,
		    'nombremoneda'	     = (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol),
                    'Desocupada_1_dia'       = 0.0,
                    'Desocupada_2_dia'       = 0.0,
                    'fecha_vcto'             = CONVERT(CHAR(10),'') 

	END

END










GO
