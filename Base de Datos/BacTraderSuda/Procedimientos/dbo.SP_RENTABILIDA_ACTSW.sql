USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDA_ACTSW]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDA_ACTSW]
AS
BEGIN
 UPDATE mdac SET acsw_ges = '1'
END


GO
