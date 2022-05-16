USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DATOS_MONEDA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_DATOS_MONEDA]
AS
BEGIN
 SET NOCOUNT ON
 SELECT   0
  ,mncodmon  --mncodsuper
  ,mnsimbol
  ,mnglosa
 FROM  VIEW_MONEDA
 WHERE  mnmx = 'C'
 ORDER BY mncodmon
 SET NOCOUNT OFF
END



GO
