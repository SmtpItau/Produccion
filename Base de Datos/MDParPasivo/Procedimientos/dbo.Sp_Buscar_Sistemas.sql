USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Buscar_Sistemas]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_Buscar_Sistemas]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    SELECT id_sistema
    ,      nombre_sistema 
    FROM   SISTEMA
    WHERE  operativo = 'S'
    AND    gestion   = 'N'
    ORDER BY id_sistema

END 



GO
