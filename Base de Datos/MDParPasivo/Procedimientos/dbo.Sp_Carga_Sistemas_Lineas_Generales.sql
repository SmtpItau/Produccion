USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Sistemas_Lineas_Generales]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Carga_Sistemas_Lineas_Generales]
AS BEGIN

SET NOCOUNT ON 
SET DATEFORMAT dmy

   SELECT    id_sistema
   ,         nombre_sistema
   ,         operativo
   ,         gestion
   FROM      SISTEMA
   WHERE     operativo    = 'S'
   AND       gestion      = 'N'
   ORDER BY  id_sistema

SET NOCOUNT OFF

END




GO
