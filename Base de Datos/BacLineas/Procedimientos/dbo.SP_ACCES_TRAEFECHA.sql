USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACCES_TRAEFECHA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACCES_TRAEFECHA]
AS
BEGIN
 
 SET NOCOUNT ON
 SELECT  acfecante,
  acfecproc,
  acfecprox
 FROM VIEW_MDAC
 SET NOCOUNT OFF
END
GO
