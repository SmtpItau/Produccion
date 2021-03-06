USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADODESERIE]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADODESERIE]
AS
BEGIN
 SET NOCOUNT OFF
DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)
SELECT 
 @ACNOMPROP = acnomprop,
 @ACFECPROC = acfecproc,
 @ACRUTPROP = acrutprop,
 @ACDIGPROP = acdigprop
  FROM VIEW_MDAC   
 SELECT  secodigo,
  semascara,
  serutemi,
  sefecemi,
  sefecven,
  setasemi,
  setera,
  sebasemi,
  semonemi,
  secupones,
  'hora' = CONVERT(VARCHAR(10),GETDATE(),108),
  'BANCO'= @ACNOMPROP,
  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 FROM SERIE
 ORDER BY secodigo
END


GO
