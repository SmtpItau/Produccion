USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_INTRA_OVER]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TRAE_INTRA_OVER]
AS 
BEGIN
   SET NOCOUNT ON
 
 SELECT  ISNULL(acminintraday,0)  ,
  ISNULL(acmaxintraday,0)  ,
  ISNULL(acminovernight,0) ,
  ISNULL(acmaxovernight,0)
 FROM  meac
   SET NOCOUNT OFF
END



GO
