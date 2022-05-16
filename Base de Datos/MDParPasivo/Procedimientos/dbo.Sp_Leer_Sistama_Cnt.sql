USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Sistama_Cnt]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Leer_Sistama_Cnt]
AS
BEGIN
	
   SET NOCOUNT ON
   SET DATEFORMAT dmy

	SELECT id_sistema
	,      nombre_sistema
        ,      operativo
        FROM   SISTEMA
	WHERE operativo = 'S' 
        AND   gestion   ='N'
	ORDER BY nombre_sistema
   SET NOCOUNT OFF
END



GO
