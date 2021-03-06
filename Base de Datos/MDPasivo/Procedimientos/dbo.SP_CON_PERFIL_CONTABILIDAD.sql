USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_PERFIL_CONTABILIDAD]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_PERFIL_CONTABILIDAD](
                                                 @icodigo_operacion   CHAR(3) )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

      SELECT '','',
             codigo_operacion
           , concepto_programa
           , numero_secuencia
           , moneda
           , centro_origen
           , centro_destino
           ,  concepto_contable
           ,  tipo_monto
       FROM PARAMETRIA_CONTABLE
       WHERE       codigo_operacion = @icodigo_operacion
            
       ORDER BY
             codigo_operacion
           , concepto_programa
           , numero_secuencia

   SET NOCOUNT OFF

END


GO
