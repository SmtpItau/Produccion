USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_PAP_CONT]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_PAP_CONT]
    ( @nNumoper NUMERIC (9,0) ,
     @cTipo  CHAR(01))
AS
BEGIN
SET NOCOUNT ON
 DECLARE @nNumero NUMERIC (2,0) ,
  @nNumMax NUMERIC (2,0)
 IF @cTipo='P'
  SELECT @nNumero = papapimp FROM MDPA WHERE @nNumoper=panumoper
 ELSE
  SELECT @nNumero = paconimp FROM MDPA WHERE @nNumoper=panumoper
 SELECT @nNumMax = ac_maxpap FROM MDAC
 IF @nNumero<@nNumMax
  SELECT @nNumero = 1
 ELSE
  SELECT @nNumero  = 0
 IF @cTipo='P'
  UPDATE MDPA
  SET papapimp = papapimp + 1
  WHERE @nNumoper = panumoper
 ELSE
  UPDATE MDPA
  SET paconimp = paconimp + 1
  WHERE @nNumoper=panumoper
 SELECT @nNumero
SET NOCOUNT OFF
END

GO
