USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RCLEERRUT]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RCLEERRUT]
      (@rcrut1 NUMERIC (09,0))
AS
BEGIN
       SELECT rccodcar    ,
              rcrut       ,
              rcdv        ,
              rcnombre    ,
              rcnumoper   ,
              rctelefono  ,             
       rcfax       ,
              rcdirecc   
       FROM
              VIEW_ENTIDAD
       WHERE 
              rcrut  = @rcrut1
       RETURN
END
                                                                                                               

GO
