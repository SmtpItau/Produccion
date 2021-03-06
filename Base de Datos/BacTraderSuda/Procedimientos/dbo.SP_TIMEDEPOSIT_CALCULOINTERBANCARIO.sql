USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TIMEDEPOSIT_CALCULOINTERBANCARIO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TIMEDEPOSIT_CALCULOINTERBANCARIO]
 (
  @nNominal FLOAT
  ,@nMtofin FLOAT
  ,@nTasa  FLOAT
  ,@nValmon FLOAT
  ,@nBase  FLOAT
  ,@dFecven CHAR(10)
  ,@dFecpro CHAR(10)
  ,@nModal INTEGER
  ,@cCodmon CHAR(02)
 )
AS
BEGIN
 DECLARE @nRes1  FLOAT
  ,@nMt  FLOAT
  ,@nRound INTEGER
  ,@iMoneda INTEGER
  ,@nValinip NUMERIC (19,4)
SET NOCOUNT ON
 SELECT @nRound  = 4  ,
  @nValinip = @nNominal
 SELECT @iMoneda =CASE
                                  WHEN @cCodmon='UF' THEN 998
     WHEN @cCodmon='DO' THEN 994
     WHEN @cCodmon='DA' THEN 995
     ELSE 999
    END
 IF @cCodmon='$$' OR @cCodmon='CLP' --O CLP
  SELECT @nRound  = 0
 ELSE
  SELECT @nNominal = ROUND(@nNominal/vmvalor,4) FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMoneda AND @dFecpro=vmfecha
  SELECT @nMt  = @nNominal * (( @nTasa/(@nBase*100.0))*DATEDIFF(DAY,@dFecpro,@dFecven)+1.0)
  SELECT @nNominal = @nValinip
  SELECT ROUND(@nNominal,4), ROUND(@nTasa,4), ROUND(@nMt,@nRound)
SET NOCOUNT OFF
END


GO
