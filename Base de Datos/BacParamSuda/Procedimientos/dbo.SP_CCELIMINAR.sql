USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CCELIMINAR]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CCELIMINAR] (
                                  @ccrut   NUMERIC(9,0) ,
      @ccrutcod char (1)
                                 )
AS
  BEGIN
       DELETE  FROM mecc WHERE ccrut = @ccrut and ccrutcod = @ccrutcod
  END
GO
