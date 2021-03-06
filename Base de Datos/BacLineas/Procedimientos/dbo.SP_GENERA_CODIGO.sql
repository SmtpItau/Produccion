USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_CODIGO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_GENERA_CODIGO    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
CREATE PROCEDURE [dbo].[SP_GENERA_CODIGO]
  (@CODPAIS CHAR(10)
  )
AS
BEGIN 
 SET NOCOUNT OFF
 SELECT  mncodmon,
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
 FROM MONEDA
 WHERE  mnvalfox=@CODPAIS
 SET NOCOUNT ON
END
GO
