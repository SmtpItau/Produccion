USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Actividad_Economica]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[Sp_Busca_Actividad_Economica] 

as

BEGIN
SET NOCOUNT ON
	SELECT 	codigo	, 
 		Descripcion		
	FROM ACTIVIDAD_ECONOMICA  order by descripcion


SET NoCount OFF
END

-- Base de Datos -- 
GO
