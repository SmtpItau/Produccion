USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_MDCO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_MDCO]( @numdocu NUMERIC(10),
           @numoper NUMERIC(10),
           @correla NUMERIC(3),
    @monto   NUMERIC(19,4),
    @cortes  NUMERIC(5),
    @corteso NUMERIC(5))
AS
BEGIN 
   SET NOCOUNT ON
   DECLARE @rut NUMERIC(9)
   DECLARE @sw  NUMERIC(1)
   DECLARE @cTipOper CHAR(03)
   SELECT @sw = 0
   IF EXISTS( SELECT * FROM mdcp WHERE cpnumdocu = @numdocu AND cpcorrela = @correla ) BEGIN
      SELECT @sw = 1
   END
   IF EXISTS( SELECT * FROM mdci WHERE cinumdocu = @numdocu AND cicorrela = @correla ) BEGIN
      SELECT @sw = 1
   END
   SELECT @rut = acrutprop  FROM MDAC
    IF @sw = 1 BEGIN
       IF @numdocu = @numoper BEGIN
     INSERT  MDCO ( corutcart,
           conumdocu,
    cocorrela,
    comtocort,
                  cocantcortd,
    cocantcorto)
  values (@rut,
   @numdocu,
   @correla,
   @monto,
   @cortes,
   @corteso)
       END ELSE BEGIN
          IF EXISTS( SELECT * FROM MDVI WHERE vinumdocu = @numdocu AND vinumoper = @numoper AND vicorrela = @correla ) BEGIN
  SELECT @cTipOper = 'CP'
  IF EXISTS( SELECT * FROM MDCI WHERE cinumdocu = @numdocu AND cicorrela = @correla ) BEGIN
     SELECT @cTipOper = 'CI'
  END
  INSERT  MDCV ( cvrutcart,
    cvnumdocu,
    cvcorrela,
    cvnumoper,
    cvcantcort,
    cvmtocort,
    cvstatreg,
    cvtipoper)
  values ( @rut,
    @numdocu,
    @correla,
    @numoper,
    @cortes,
    @monto,
    ' ',
    @ctipoper)
          END
      END
   END
SET NOCOUNT OFF 
END


GO
