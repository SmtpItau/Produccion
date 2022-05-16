USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_listadodeMonedas]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_listadodeMonedas]
AS
BEGIN
 SET NOCOUNT ON 
 SELECT  mncodmon,
  mnnemo, 
  mnsimbol,
  mnglosa,
  mncodsuper,
  mncodbanco,
  'hora'       = CONVERT( CHAR(30),GETDATE(),108),
  'nombreentidad' = (SELECT rcnombre FROM entidad)
 FROM MONEDA
 ORDER BY mncodmon
 
 SET NOCOUNT OFF
END







GO
