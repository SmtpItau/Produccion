USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_GRABARMDTM1]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_GRABARMDTM1]
     (@cSerie  CHAR (10) ,
     @cFecvcto  DATETIME ,
     @cEmisor CHAR (10) ,
     @nMonemis NUMERIC (03) ,
     @nTasa  NUMERIC (12,7) ,
     @nNewTasa NUMERIC (12,7) )
AS
BEGIN
set nocount on
 UPDATE MDTM1
 SET TmNewFactor = @nNewtasa
 WHERE tminstser=@cSerie AND tmfecvcto=@cFecvcto AND tmgenemis=@cEmisor AND
  tmmonemis=@nMonemis
SELECT 'OK'
set nocount off
END

GO
