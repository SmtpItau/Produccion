USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERTASAINTERBANCARIA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERTASAINTERBANCARIA]
AS
BEGIN
   SET NOCOUNT ON
   SELECT tasa_nominal,
          tasa_uf
   FROM   view_tasa_fwd,
          mfac
   WHERE  codigo = 3         AND
          plazo  = 1         AND
          fecha  = acfecproc
   SET NOCOUNT OFF
END

GO
