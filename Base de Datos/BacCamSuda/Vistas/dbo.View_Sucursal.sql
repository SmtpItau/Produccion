USE [BacCamSuda]
GO
/****** Object:  View [dbo].[View_Sucursal]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[View_Sucursal]
AS
SELECT  Codigo_Sucursal,
 Nombre
FROM bacparamsuda..Sucursal


GO
