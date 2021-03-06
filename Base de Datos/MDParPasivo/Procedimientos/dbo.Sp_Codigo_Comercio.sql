USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Codigo_Comercio]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Codigo_Comercio]
   (
         @gscodigo    NUMERIC(5)
      ,  @gsdigito    NUMERIC(5)
   )
AS
BEGIN

   SET NOCOUNT OFF
   SET DATEFORMAT dmy
	
      SELECT CONVERT(CHAR(10) , GETDATE() , 112) 
      ,      comercio
--      ,      concepto
      ,      glosa
      ,      tipo_documento
      ,      codigo_oma
--      ,      codigo_planilla
--      ,      tipo_registro
--      ,      codigo_validacion
      FROM   CODIGO_COMERCIO
      WHERE  codigo_oma       =   @gscodigo
      AND   (tipo_documento   =   @gsdigito OR tipo_documento   =   0)

   SET NOCOUNT ON
END



GO
