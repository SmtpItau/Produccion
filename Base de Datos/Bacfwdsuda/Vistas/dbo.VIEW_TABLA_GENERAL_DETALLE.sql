USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_TABLA_GENERAL_DETALLE]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_TABLA_GENERAL_DETALLE]
AS
   SELECT
 tbcateg,
 tbcodigo1,
 tbtasa,
 tbfecha,
 tbvalor,
 tbglosa,
 nemo
   FROM BACPARAMSUDA..TABLA_GENERAL_DETALLE

GO
