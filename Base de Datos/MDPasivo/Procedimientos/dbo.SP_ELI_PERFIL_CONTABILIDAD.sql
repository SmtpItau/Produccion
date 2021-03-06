USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_PERFIL_CONTABILIDAD]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_ELI_PERFIL_CONTABILIDAD]
               ( @isistema          CHAR(3)
               , @icodigo_producto  CHAR(5)
               , @icodigo_operacion CHAR(5)
               )
AS
BEGIN 
   
   SET NOCOUNT ON
   SET DATEFORMAT dmy

   DELETE FROM PARAMETRIA_CONTABLE   WHERE id_sistema        = @isistema
                                     AND codigo_producto   = @icodigo_producto
                                     AND codigo_operacion  = @icodigo_operacion
   

   SET NOCOUNT OFF

END




GO
