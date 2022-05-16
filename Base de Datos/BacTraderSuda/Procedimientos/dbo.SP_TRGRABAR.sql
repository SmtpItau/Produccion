USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRGRABAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRGRABAR]
    (@trfecha DATETIME ,
    @trserie CHAR (12) ,
    @trvaldes NUMERIC (05,2) ,
    @trvalhas NUMERIC (05,2) ,
    @trtasas NUMERIC (07,4)  ,
    @tremisor NUMERIC (10,0) )
AS
BEGIN
SET NOCOUNT ON
 INSERT MDTR
   (
   trfecha  ,
   trserie  ,
   trvaldes ,
   trvalhas ,
   trtasas         ,
   tremisor        
   )
 VALUES
   (
   @trfecha ,
   @trserie ,
   @trvaldes ,
   @trvalhas ,
   @trtasas        ,
   @tremisor
   )
SELECT 'OK'
SET NOCOUNT OFF
END


GO
