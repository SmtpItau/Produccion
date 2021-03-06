USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARTASAINTERBANCARIA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARTASAINTERBANCARIA] ( @ntasanominal NUMERIC ( 10, 04 ),
                                              @ntasauf      NUMERIC ( 10, 04 )
                                            )
AS
BEGIN   SET NOCOUNT ON

   UPDATE tasa_fwd
   SET    tasa_nominal = @ntasanominal,
          tasa_uf      = @ntasauf
   FROM   VIEW_MFAC
   WHERE  codigo = 3         AND
          plazo  = 1         AND
          fecha  = acfecproc

   SET NOCOUNT OFF
END
--SELECT * FROM VIEW_tasa_fwd
--SELECT * FROM VIEW_mEac
GO
