USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MNLeetodo]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MNLeetodo    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MNLeetodo    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
CREATE PROCEDURE [dbo].[Sp_MNLeetodo]
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
       RETURN
SET NOCOUNT OFF
END






GO
