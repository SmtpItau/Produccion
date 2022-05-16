USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MDAPODERADO]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  vista dbo.view_mdapoderado    fecha de la secuencia de comandos: 05/04/2001 9:20:53 ******/
CREATE VIEW [dbo].[VIEW_MDAPODERADO]
AS 
 SELECT aprutcli ,
  apdvcli  ,
  apcodcli ,
  aprutapo ,
  apdvapo  ,
  apnombre ,
  apcargo  ,
  apfono
 FROM  BACPARAMSUDA..CLIENTE_APODERADO

GO
