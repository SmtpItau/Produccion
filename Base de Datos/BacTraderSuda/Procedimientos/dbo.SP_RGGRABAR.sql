USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RGGRABAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RGGRABAR]
    (@rgvaldes NUMERIC (05,2) ,
    @rgvalhas NUMERIC (05,2) ,
    @rgfinicio DATETIME , /* Fecha de inicio */
    @rgffin  DATETIME   /* Fecha de termino  */)
AS
BEGIN  
set nocount on
      
 INSERT MDRG 
   (rgvaldes ,
   rgvalhas ,
   rgfinic  ,
   rgfvenc  )
 VALUES  (@rgvaldes ,
   @rgvalhas ,
   @rgfinicio ,
   @rgffin )
SELECT 'OK'
set nocount off
END

GO
