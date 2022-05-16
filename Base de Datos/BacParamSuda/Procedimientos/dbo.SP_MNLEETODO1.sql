USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNLEETODO1]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNLEETODO1]
AS
BEGIN
SET NOCOUNT ON
       SELECT mncodmon,
  mnnemo,
  mnsimbol,
  mnglosa,
  mncodsuper,
  mnnemsuper,
  mncodbanco,
  mnnembanco,
  mnbase,
  mnredondeo,
  mndecimal,
  mncodpais,
  mnrrda,
  mnfactor,
  mnrefusd,
  mnlocal,
  mnextranj,
  mnvalor,
  mnrefmerc,
  mningval,
  mntipmon,
  mnperiodo,
  mnmx,
  mncodfox,
  mnvalfox,
  mncodcor,
  codigo_pais,
  mniso_coddes
       FROM
               MONEDA
 ---WHERE  mnextranj <> 1
       RETURN
SET NOCOUNT OFF
END

GO
