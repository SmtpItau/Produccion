USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_ESTADO_SWITCH]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CON_ESTADO_SWITCH]
       (
        @sSistema      CHAR(03),
        @cCierreMes    CHAR(01) = '0'
       )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT DMY 

   DECLARE @sNombreSistema  VARCHAR(50)

   SELECT @sNombreSistema = Nombre_Sistema FROM SISTEMA WHERE id_sistema = @sSistema

   SELECT       'Sistema'     = a.Sistema,
                'Nombre'      = b.Nombre_Sistema,
                'Estado'      = a.Estado_Control,
                'Codigo'      = a.Codigo_Control,
                'Orden'       = (CASE @cCierreMes WHEN '1' THEN a.Orden_Especial ELSE a.Orden END),
                'Descripcion' = a.Descripcion,
                'Activo'      = b.activo,
                'SWITCH'      = Reproceso
          INTO  #Leer_Estado
          FROM  SWITCH_OPERATIVO a, SISTEMA b
          WHERE --(a.sistema    = @sSistema        OR  @sSistema    = ' ')   AND
                a.sistema     = b.id_sistema    AND
--                b.activo      = 'S'            -- AND
                a.reproceso  <> '3'		

--   IF @sSistema = 'SCE'
--   BEGIN
--      DELETE #Leer_Estado
--
--      INSERT INTO  #Leer_Estado
--      SELECT       'Sistema'     = a.Sistema,
--                   'Nombre'      = b.Nombre_Sistema,
--                   'Estado'      = a.Estado_Control,
--                   'Codigo'      = a.Codigo_Control,
--                   'Orden'       = (CASE @cCierreMes WHEN '1' THEN a.Orden_Especial ELSE a.Orden END),
--                   'Descripcion' = a.Descripcion,
--                   'Activo'      = b.activo,
--                   'SWITCH'      = Reproceso
--             FROM  VIEW_SWITCH_OPERATIVO a, VIEW_SISTEMA b
--             WHERE a.sistema     = @sSistema       AND
--                   a.sistema     = b.id_sistema    AND
--                   a.reproceso  <> '3'
--
--   END ELSE BEGIN
--      UPDATE       #Leer_Estado
--             SET   Estado             = a.Estado_Control
--             FROM  VIEW_SWITCH_OPERATIVO a
--             WHERE a.sistema          = 'SCE'               AND
--                   a.codigo_control  <> 'BLOQUEO'           AND
--                   a.Codigo_Control   = #Leer_Estado.Codigo AND
--                   a.reproceso  <> '3'
--
--   END 

	IF @sSistema <> 'SCE'
	BEGIN
		DELETE #Leer_Estado WHERE (Codigo ='BLOQUEO' OR Codigo ='INICIO' OR Codigo ='FIN') AND Sistema <> @sSistema
	END

   SELECT DISTINCT 'Status'  = 'OK',
                   'Mensaje' = ' ',
                   Sistema,
                   'Nombre'  = ' ',
--                   Sistema,
--                   Nombre,
                   Estado,                   Codigo,
                   Orden,
                   Descripcion,
                   'S',--Activo,
                   SWITCH
          FROM     #Leer_Estado
          ORDER BY Orden 

   SET NOCOUNT OFF

END














GO
