USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MANTENCION_DE_CORTES_TRAENUMOPE]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MANTENCION_DE_CORTES_TRAENUMOPE]
AS
BEGIN
      SET NOCOUNT ON
            SELECT dinumdocu,diserie,diinstser FROM MDDI ORDER BY dinumdocu
            
      SET NOCOUNT OFF
END      

GO
