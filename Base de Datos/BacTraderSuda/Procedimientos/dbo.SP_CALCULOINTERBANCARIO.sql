USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULOINTERBANCARIO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALCULOINTERBANCARIO]
    (
    @nnominal FLOAT  ,
    @nmtofin FLOAT  ,
    @ntasa  FLOAT  ,
    @nvalmon FLOAT  ,
    @nbase  FLOAT  ,
    @dfecven CHAR(10) ,
    @dfecpro CHAR(10) ,
    @nmodal  INTEGER  ,
    @ccodmon CHAR(03)
    )
AS
BEGIN

DECLARE @nres1      FLOAT,
        @nmt        FLOAT,
        @nRound     INTEGER,
        @imoneda    INTEGER,
        @nvalinip   NUMERIC(19,4),
        @nvalmoneda NUMERIC(19,4),
        @mx         CHAR(1)

 SET NOCOUNT ON

 SELECT @nRound  = 4  ,
        @nvalinip = @nnominal

 SELECT @imoneda = MNCODMON,
        @mx      = (CASE WHEN MNMX = 'C' THEN 'S' ELSE 'N' END)
   FROM VIEW_MONEDA WHERE MNNEMO = @ccodmon

/*
 SELECT @imoneda = CASE
     WHEN @ccodmon='UF' THEN 998
     WHEN @ccodmon='DO' THEN 994
     WHEN @ccodmon='DA' THEN 995
     WHEN @ccodmon='USD' THEN 13
     else 999
    END
*/

 IF @mx = 'S' OR @imoneda = 999
 BEGIN
  SELECT @nRound  = (CASE WHEN @imoneda = 999 THEN 0 ELSE 4 END)
  SELECT @nmt  = @nnominal * (( @ntasa/(@nbase*100.0))*DATEDIFF(DAY,@dfecpro,@dfecven)+1.0)
  SELECT @nnominal = @nvalinip
  SELECT ROUND(@nnominal,@nRound), ROUND(@ntasa,4), ROUND(@nmt,@nRound)
 END
 ELSE
 BEGIN
  SELECT @nvalmoneda = vmvalor  FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@imoneda AND @dfecpro=vmfecha
  IF @nvalmoneda>0
     BEGIN
        SELECT @nnominal = ROUND(@nnominal/@nvalmoneda,4) -- FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@imoneda AND @dfecpro=vmfecha
        SELECT @nmt  = @nnominal * (( @ntasa/(@nbase*100.0))*DATEDIFF(DAY,@dfecpro,@dfecven)+1.0)
        SELECT @nnominal = @nvalinip
        SELECT ROUND(@nnominal,4), ROUND(@ntasa,4), ROUND(@nmt,4)
     END
 END
 SET NOCOUNT OFF
END
-- sp_calculointerbancario 2900000000, 0.0, 0.79, 1.0, 30.0, '20010524', '20010523', 1, 'CLP'
-- select 2900000000.0*((0.79/(30.0*100.0))*1.0+1.0)



GO
