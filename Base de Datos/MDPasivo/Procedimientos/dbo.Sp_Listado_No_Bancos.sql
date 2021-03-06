USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_No_Bancos]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Listado_No_Bancos]
AS
BEGIN

   SET DATEFORMAT dmy

   DECLARE @fecha_proceso DATETIME
	,  @monedacontrol NUMERIC(3)
   SELECT @fecha_proceso = fecha_proceso FROM DATOS_GENERALES

	SELECT @monedacontrol = (SELECT moneda_control FROM DATOS_GENERALES)


   IF EXISTS(SELECT 1 FROM LINEA_SISTEMA  b, CLIENTE c, GRUPO_PRODUCTO d
              WHERE b.rut_cliente      = c.clrut
                AND b.codigo_cliente   = c.clcodigo
                AND c.cltipcli         <> 1
                AND clclsbif          <> 'F'
                AND (b.totalasignado   > 0 OR b.totalocupado > 0)
                AND b.fechavencimiento > @fecha_proceso
                AND b.codigo_grupo     = d.codigo_grupo)
   BEGIN

      SELECT 'Titulo'           = 'LINEAS DE CREDITO DE NO BANCOS E INST. FINANCIERAS AL ' + CONVERT(CHAR(10), @fecha_proceso, 103)
         ,   'Rut_Cliente'      = c.clrut
         ,   'DV'               = c.cldv
         ,   'Nombre_Cliente'   = c.clnombre
         ,   'TotalLinea'       = b.totalasignado
         ,   'TotalOcupado'     = b.totalocupado
         ,   'TotalDisponible'  = CASE WHEN b.totalasignado - b.totalocupado < 0 THEN 0 ELSE b.totalasignado - b.totalocupado END
         ,   'TotalExceso'      = CASE WHEN b.totalasignado - b.totalocupado > 0 THEN 0 ELSE ABS(b.totalasignado - b.totalocupado) END
         ,   'FechaVencimiento' = b.fechavencimiento
         ,   'SinLinea'         = b.sinriesgoasignado
         ,   'SinOcupado'       = b.sinriesgoocupado
         ,   'SinDisponible'    = SinRiesgoDisponible --CASE WHEN b.sinriesgoasignado - b.sinriesgoocupado < 0 THEN 0 ELSE b.sinriesgoasignado - b.sinriesgoocupado END
         ,   'SinExceso'        = b.SinRiesgoExceso   --CASE WHEN b.sinriesgoasignado - b.sinriesgoocupado > 0 THEN 0 ELSE ABS(b.sinriesgoasignado - b.sinriesgoocupado) END
         ,   'ConLinea'         = b.conriesgoasignado
         ,   'ConOcupado'       = b.conriesgoocupado
         ,   'ConDisponible'    = ConRiesgoDisponible --CASE WHEN b.conriesgoasignado - b.conriesgoocupado < 0 THEN 0 ELSE b.conriesgoasignado - b.conriesgoocupado END
         ,   'ConExceso'        = ConRiesgoExceso     --CASE WHEN b.conriesgoasignado - b.conriesgoocupado > 0 THEN 0 ELSE ABS(b.conriesgoasignado - b.conriesgoocupado) END
         ,   'Codigo_Grupo'     = b.codigo_grupo
         ,   'Descripcion'      = d.descripcion
	 ,   'monedacontrol'	= @monedacontrol
	 ,   'nombremoneda'	= (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol)
      FROM   LINEA_SISTEMA b, CLIENTE c, GRUPO_PRODUCTO d
      WHERE  b.rut_cliente      = c.clrut
        AND  b.codigo_cliente   = c.clcodigo
        AND  c.cltipcli        <> 1
        AND  clclsbif          <> 'F'
        AND  (b.totalasignado   > 0 OR b.totalocupado > 0)
        AND  (b.fechavencimiento > @fecha_proceso OR (b.fechavencimiento <= @fecha_proceso AND b.totalocupado > 0))
        AND  b.codigo_grupo     = d.codigo_grupo
      ORDER BY Nombre_Cliente


   END ELSE BEGIN

      SELECT 'Titulo'           = 'LINEAS DE CREDITO DE NO BANCOS E INST. FINANCIERAS AL ' + CONVERT(CHAR(10), @fecha_proceso, 103)
         ,   'Rut_Cliente'      = ' '
         ,   'DV'               = ' '
         ,   'Nombre_Cliente'   = ' '
         ,   'TotalLinea'       = ' '
         ,   'TotalOcupado'     = ' '
         ,   'TotalDisponible'  = ' '
         ,   'TotalExceso'      = ' '
         ,   'FechaVencimiento' = ' '
         ,   'SinLinea'         = ' '
         ,   'SinOcupado'       = ' '
         ,   'SinDisponible'    = ' '
         ,   'SinExceso'        = ' '
         ,   'ConLinea'         = ' '
         ,   'ConOcupado'       = ' '
         ,   'ConDisponible'    = ' '
         ,   'ConExceso'        = ' '
         ,   'Codigo_Grupo'     = ' '
         ,   'Descripcion'      = ' '
	 ,   'monedacontrol'	= @monedacontrol
	 ,   'nombremoneda'	= (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol)
   END

END

GO
