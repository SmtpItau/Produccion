USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_ABREVIATURA_CLIENTE]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_ABREVIATURA_CLIENTE]
AS
SELECT
    claglosa,
    clacodigo,
    clarutcli
FROM bacparamsuda..ABREVIATURA_CLIENTE


GO
