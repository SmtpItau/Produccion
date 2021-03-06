USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELEER]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SELEER]
               (@semascara1   CHAR    (12))
AS
BEGIN
set nocount on
       SELECT secodigo                       ,
              semascara                      ,
              seserie                        ,
              serutemi                       ,
              CONVERT(CHAR(10),sefecemi,103) ,
              CONVERT(CHAR(10),sefecven,103) ,
              setasemi                       ,
              setera                         ,
              sebasemi                       ,           
       semonemi                       ,
              secupones                      ,
              sediavcup                      ,
              sepervcup                      ,
              setipvcup                      ,
              seplazo                        ,
              setipamort                     ,
              senumamort                     ,
              seffijos                       ,
              sebascup                       ,
              sedecs                         ,
              secorte
       FROM
              VIEW_SERIE
       WHERE
              semascara  = @semascara1
set nocount off
RETURN
END

GO
