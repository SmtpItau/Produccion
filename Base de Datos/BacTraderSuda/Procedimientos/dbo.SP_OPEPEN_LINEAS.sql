USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPEPEN_LINEAS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_OPEPEN_LINEAS]
AS
BEGIN
 SET NOCOUNT ON
 
 SELECT COUNT(*) FROM MDMO WHERE mostatreg='P' OR (mostatreg='R' and motipoper <> 'TM')
 
 SET NOCOUNT OFF 
END


GO
