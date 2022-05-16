USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_TRASEMISORES]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_SBIF_TRASEMISORES]
 AS
 BEGIN
       SELECT   ISNULL(emrut,0), ISNULL(emglosa,''), ISNULL(embonos,'')
       FROM     VIEW_EMISOR
       RETURN
 END

GO
