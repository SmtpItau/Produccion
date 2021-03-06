USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_Bancos]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Listado_Bancos]
   (   @bloqueado     CHAR(1)
   ,   @institucion   NUMERIC(5)
   )   
AS
BEGIN

   SET DATEFORMAT dmy

   DECLARE @fecha_proceso  DATETIME
   DECLARE @moneda         NUMERIC(03)

   SELECT @fecha_proceso  = Fecha_Proceso
   FROM DATOS_GENERALES

   SELECT @bloqueado = CASE WHEN @bloqueado = 'B' THEN 'S' ELSE @bloqueado END

   SELECT @Moneda  = (SELECT MONEDA_CONTROL FROM DATOS_GENERALES)

   IF EXISTS(SELECT 1 FROM LINEA_SISTEMA g, CLIENTE c, GRUPO_PRODUCTO d
             WHERE  g.rut_cliente = c.clrut AND g.codigo_cliente = c.clcodigo
               and (c.cltipcli  = @Institucion OR @Institucion = 0)
               and (g.bloqueado = @bloqueado   OR (@bloqueado = 'V' AND g.fechavencimiento < @fecha_proceso) or @bloqueado =  ' ')
               AND  d.codigo_grupo = g.codigo_grupo)
   BEGIN

      SELECT 'titulo'           = CASE WHEN @bloqueado = ' ' THEN 'LINEAS DE CREDITO DE BANCOS E INST.FINANCIERAS'
                                       WHEN @bloqueado = 'S' THEN 'LINEAS DE CREDITO BLOQUEADAS'
                                       ELSE 'LINEAS DE CREDITO VENCIDAS'
                                  END  + ' AL ' + CONVERT(CHAR(10), @fecha_proceso, 103) 
         ,   'Rut_Cliente'      = c.clrut             
         ,   'DV'               = '- ' + c.cldv
         ,   'Nombre_Cliente'   = c.clnombre    
         ,   'TotalLinea'       = g.totalasignado
         ,   'TotalOcupado'     = g.totalocupado
         ,   'TotalDisponible'  = g.totaldisponible
         ,   'TotalExceso'      = g.totalexceso
         ,   'FechaVencimiento' = g.fechavencimiento
         ,   'codigo_grupo'     = g.codigo_grupo
         ,   'descripcion'      = d.descripcion
         ,   'Moneda'           = @Moneda
         ,   'NombreMoneda'     = (SELECT MNNEMO FROM MONEDA WHERE MNCODMON = @moneda)
      FROM   LINEA_SISTEMA  g
         ,   CLIENTE        c
         ,   GRUPO_PRODUCTO d
      WHERE  g.rut_cliente    = c.clrut
        AND  g.codigo_cliente = c.clcodigo
        AND (c.cltipcli     = @Institucion OR @Institucion = 0)
        AND (g.bloqueado    = @bloqueado   OR (@bloqueado = 'V' AND g.fechavencimiento < @fecha_proceso) or @bloqueado = ' ') 
        AND  d.codigo_grupo = g.codigo_grupo
        ORDER BY Nombre_Cliente

   END ELSE BEGIN

      SELECT 'titulo'           = CASE WHEN @bloqueado = ' ' THEN 'LINEAS DE CREDITO DE BANCOS E INST.FINANCIERAS'
                                       WHEN @bloqueado = 'S' THEN 'LINEAS DE CREDITO BLOQUEADAS'
                                       ELSE 'LINEAS DE CREDITO VENCIDAS'
                                  END  + ' AL ' + CONVERT(CHAR(10), @fecha_proceso, 103) 
         ,   'Rut_Cliente'      = ' '       
         ,   'DV'               = ' '
         ,   'Nombre_Cliente'   = ' '
         ,   'TotalLinea'       = ' '
         ,   'TotalOcupado'     = ' '
         ,   'TotalDisponible'  = ' '
         ,   'TotalExceso'      = ' '
         ,   'FechaVencimiento' = ' '
         ,   'codigo_grupo'     = ' '
         ,   'descripcion'      = ' '
         ,   'Moneda'           = @Moneda
         ,   'NombreMoneda'     = (SELECT MNNEMO FROM MONEDA WHERE MNCODMON = @moneda)
   
   END

END

GO
