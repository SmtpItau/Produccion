USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_MOVDIARIO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_MOVDIARIO] 
AS 
SELECT * FROM bacswapsuda..MOVDIARIO where estado <> 'C'

GO
