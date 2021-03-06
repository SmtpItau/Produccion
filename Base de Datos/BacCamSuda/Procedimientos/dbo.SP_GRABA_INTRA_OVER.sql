USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_INTRA_OVER]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_INTRA_OVER]( 
     @minintraday  NUMERIC(19,04) ,
     @maxintraday  NUMERIC(19,04) ,
     @minovernight  NUMERIC(19,04) ,
     @maxovernight NUMERIC(19,04) 
     )
AS 
BEGIN
 SET NOCOUNT ON
 
  UPDATE meac 
  SET  acminintraday  = @minintraday  ,
   acmaxintraday  = @maxintraday  ,
   acminovernight = @minovernight  ,
   acmaxovernight = @maxovernight
 SET NOCOUNT OFF
END

GO
