USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_RESUMEN_MEXTRANJERA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_RESUMEN_MEXTRANJERA]
AS
BEGIN
 SET NOCOUNT ON
 --declaracion de variables locales 
 DECLARE @fecproc DATETIME
 --recupero la fecha de proceso
 SELECT  @fecproc = acfecproc
 FROM  mdac
 SELECT  partida, glosa, monto_exigible, monto_ocupado, @fecproc AS fecproc
  FROM  tbtr_mnl_me --rtecnica_mextranjera
 ORDER BY partida
 SET NOCOUNT OFF
END

GO
