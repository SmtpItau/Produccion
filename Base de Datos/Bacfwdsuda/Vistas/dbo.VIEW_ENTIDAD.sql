USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_ENTIDAD]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_ENTIDAD]
AS SELECT 
 rccodcar ,
 rcrut  ,
 rcdv  ,
 rcnombre ,
 rcnumoper ,
 rctelefono ,
 rcfax  ,
 rcdirecc
   FROM BACPARAMSUDA..ENTIDAD

GO
