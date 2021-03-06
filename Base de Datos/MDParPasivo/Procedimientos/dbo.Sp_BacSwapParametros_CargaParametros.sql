USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacSwapParametros_CargaParametros]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_BacSwapParametros_CargaParametros]
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   SELECT 
         CONVERT(CHAR(10),Fecha_proceso,103), 
         Nombre_entidad,
         CONVERT(CHAR(10),Fecha_proxima,103),
         Rut_entidad, 
         Digito_entidad,
         CONVERT(CHAR(10),Fecha_anterior,103)
   FROM 
          DATOS_GENERALES
  
   SET NOCOUNT OFF

END



GO
