USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_CONTROL_USUARIO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_CONTROL_USUARIO]
AS
   SELECT 
 usuario         ,
 id_sistema      ,
 nombre          ,
 terminal        ,
 bloqueado
   FROM BACPARAMSUDA..CONTROL_USUARIO

GO
