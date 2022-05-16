USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DATOS_COMERCIO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_DATOS_COMERCIO]
AS
BEGIN
 SET NOCOUNT ON
 SELECT  comercio
  ,concepto
  ,glosa
 FROM 
  VIEW_CODIGO_COMERCIO
 SET NOCOUNT OFF
END



GO
