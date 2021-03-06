USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADODEMONEDAS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADODEMONEDAS]
AS
BEGIN
 SET NOCOUNT ON 
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
 SELECT  mncodmon,
   mnnemo, 
   mnsimbol,
   mnglosa,
   mncodsuper,
   mncodbanco,
   'hora'          = CONVERT( CHAR(30),GETDATE(),108),
   'BANCO'  = @ACNOMPROP,
   'Logo' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)
 FROM MONEDA
 ORDER BY mncodmon
 
 SET NOCOUNT OFF
END

GO
