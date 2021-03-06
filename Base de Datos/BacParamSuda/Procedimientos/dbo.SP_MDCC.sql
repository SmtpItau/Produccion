USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCC]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDCC](@nrutcli     NUMERIC(9,0),   
       @ncodcli     NUMERIC(9,0)
      )
AS
BEGIN
set nocount on
 SELECT       ccrut       ,
                     ccrutcod    ,
       ccmoneda    ,
       ccbanco     ,
       cccuenta    ,
              cccswift    ,
               cccsuc      ,
                   cccodigo
 
           FROM  mecc    WHERE ccrut     = @nrutcli
                          and  ccrutcod  = @ncodcli
SET NOCOUNT OFF
END 

GO
