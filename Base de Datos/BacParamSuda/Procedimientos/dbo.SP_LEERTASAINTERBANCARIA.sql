USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERTASAINTERBANCARIA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEERTASAINTERBANCARIA]
AS
BEGIN
   SET NOCOUNT ON
   SELECT tasa_nominal,
          tasa_uf
   FROM   tasa_fwd,
          view_mfac
   WHERE  codigo = 3         AND
          plazo  = 1         AND
          fecha  = acfecproc
   SET NOCOUNT OFF
END

GO
