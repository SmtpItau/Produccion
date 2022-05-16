USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDCC]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_MDCC](@nrutcli     NUMERIC(9,0),   
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
