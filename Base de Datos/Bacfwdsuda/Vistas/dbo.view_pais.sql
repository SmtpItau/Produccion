USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[view_pais]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_pais]
AS 
   SELECT 
 codigo_pais,
 nombre
   FROM BACPARAMSUDA..PAIS

GO
