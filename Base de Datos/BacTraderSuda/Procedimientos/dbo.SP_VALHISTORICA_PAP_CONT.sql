USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALHISTORICA_PAP_CONT]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALHISTORICA_PAP_CONT]
    (  @nnumoper NUMERIC(09,00) ,
       @ctipo  CHAR(01))
AS
BEGIN
 DECLARE @nnumero NUMERIC (02,0) ,
  @nnummax NUMERIC (02,0)
 SELECT @nnumero = 1
 IF @cTipo='P'
  SELECT @nnumero = papapimp FROM MDPA WHERE @nnumoper=panumoper
 ELSE
  SELECT @nnumero = paconimp FROM MDPA WHERE @nnumoper=panumoper
 SELECT @nnummax = ac_maxpap FROM MDAC
 IF @nnumero<@nnummax
  SELECT @nnumero = 1
 ELSE
  SELECT @nnumero  = 0
    
 IF @cTipo='P'
  UPDATE MDPA
  SET papapimp = CASE 
     WHEN @nnumero=0 THEN 1
     ELSE papapimp+1
       END
  WHERE @nnumoper=panumoper
 ELSE
  UPDATE MDPA
  SET paconimp = CASE 
     WHEN @nnumero=0 THEN 1
     ELSE paconimp+1
       END
  WHERE @nNumoper=panumoper
 
 SELECT @nnumero = CASE @nnumero WHEN 0 THEN 1 ELSE @nnumero END
 SELECT @nNumero
END

GO
