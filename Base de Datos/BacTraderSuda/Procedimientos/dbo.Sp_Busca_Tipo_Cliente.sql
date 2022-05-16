USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Tipo_Cliente]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[Sp_Busca_Tipo_Cliente] 

as


BEGIN
SET NOCOUNT ON
	SELECT 	codigo	, 
 		Descripcion		
	FROM TIPO_CLIENTE  order by descripcion


SET NoCount OFF
END
-- Base de Datos --
GO
