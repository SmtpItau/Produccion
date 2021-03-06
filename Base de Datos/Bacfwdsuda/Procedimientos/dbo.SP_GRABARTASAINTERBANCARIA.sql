USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARTASAINTERBANCARIA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARTASAINTERBANCARIA] ( @ntasanominal NUMERIC ( 10, 04 ),
                                              @ntasauf      NUMERIC ( 10, 04 )
                                            )
AS
BEGIN
   SET NOCOUNT ON
   UPDATE view_tasa_fwd
   SET    tasa_nominal = @ntasanominal,
          tasa_uf      = @ntasauf
   FROM   mfac
   WHERE  codigo = 3         AND
          plazo  = 1         AND
          fecha  = acfecproc
   SET NOCOUNT OFF
END

GO
