USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SWITCH_OPERATIVO]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_CON_SWITCH_OPERATIVO]
       (
        @sCodigo       CHAR(30)
       )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   DECLARE @nElemento      NUMERIC(19)

   SELECT       'Sistema'        = a.Sistema,
                'Nombre'         = b.Nombre_Sistema,
                'Estado'         = a.Estado_Control,
                'Orden'          = b.orden
          INTO  #Estados
          FROM  VIEW_SWITCH_OPERATIVO a, VIEW_SISTEMA b
          WHERE a.Codigo_Control = @sCodigo      AND
                a.Sistema        = b.id_sistema  AND
                b.activo         = 'S'

   SELECT @nElemento = COUNT(*) FROM #Estados
   SELECT Sistema, Nombre, Estado, Orden, 'Reg' = @nElemento FROM #Estados ORDER BY orden

   SET NOCOUNT OFF

END



GO
