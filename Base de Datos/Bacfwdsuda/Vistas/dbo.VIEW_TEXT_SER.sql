USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_TEXT_SER]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[VIEW_TEXT_SER]
AS

SELECT Cod_familia,
       cod_nemo,
       fecha_vcto,
       nom_nemo,
       monemi
FROM  bacbonosextsuda..TEXT_SER


GO
