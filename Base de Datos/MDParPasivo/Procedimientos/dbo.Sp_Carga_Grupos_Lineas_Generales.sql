USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Grupos_Lineas_Generales]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Carga_Grupos_Lineas_Generales]
AS
BEGIN

SET NOCOUNT ON 
SET DATEFORMAT dmy

   SELECT    codigo_grupo
   ,         descripcion
   FROM      GRUPO_PRODUCTO
   ORDER BY  descripcion

SET NOCOUNT OFF

END




GO
