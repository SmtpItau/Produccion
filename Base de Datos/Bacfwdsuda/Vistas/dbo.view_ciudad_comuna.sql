USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[view_ciudad_comuna]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[view_ciudad_comuna]
AS 
   SELECT cod_pai,
          cod_ciu,
          cod_com,
          nom_ciu
   FROM   bacparamsuda..ciudad_comuna

GO
