USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCCLEERRUT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDCCLEERRUT](@ccrut     NUMERIC(9,0),   
    @ccrutcod     CHAR   (  1)
          )
AS
BEGIN
set nocount on
   SELECT       ccrut                               ,
         ccrutcod                            ,
                CCMONEDA       ,
  CCBANCO                             ,
         CCCUENTA                            ,
  CCCSWIFT           ,
  CCCSUC         ,
  CCCODIGO 
   
          FROM  mecc    WHERE ccrut     = @ccrut
                         and  ccrutcod  = @ccrutcod
SET NOCOUNT OFF
END 
GO
