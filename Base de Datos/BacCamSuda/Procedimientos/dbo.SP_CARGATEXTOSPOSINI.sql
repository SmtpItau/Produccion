USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGATEXTOSPOSINI]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGATEXTOSPOSINI]
AS
BEGIN
  
  
  SELECT info_posic
        ,info_utili
  FROM meac
END

GO
