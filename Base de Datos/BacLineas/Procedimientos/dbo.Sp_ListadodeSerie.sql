USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ListadodeSerie]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_ListadodeSerie]
AS
BEGIN
 SET NOCOUNT OFF
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
  'nombreentidad' = (SELECT rcnombre FROM entidad )
 FROM SERIE
 ORDER BY secodigo
END







GO
