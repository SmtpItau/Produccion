USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_PAIS]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[VIEW_PAIS]
AS
SELECT 	codigo_pais,
        nombre,
        COD_BCCH 
FROM BacParamSuda..Pais



GO
