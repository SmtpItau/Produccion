USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_PRODUCTO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_PRODUCTO]
AS
 SELECT * FROM bacparamsuda..PRODUCTO
 WHERE id_sistema = 'BFW' 




GO
