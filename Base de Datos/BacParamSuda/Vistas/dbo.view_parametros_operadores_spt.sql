USE [BacParamSuda]
GO
/****** Object:  View [dbo].[view_parametros_operadores_spt]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_parametros_operadores_spt]
AS 
SELECT * FROM BACCAMSUDA..parametros_operadores_spt

GO
