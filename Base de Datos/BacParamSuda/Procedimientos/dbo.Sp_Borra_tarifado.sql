USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borra_tarifado]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Borra_tarifado]
AS 
BEGIN  
	DELETE tarifado_tasa
END
GO
