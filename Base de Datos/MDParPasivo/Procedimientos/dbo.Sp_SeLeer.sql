USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_SeLeer]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_SeLeer]
               (@semascara1   CHAR    (12))
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

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
              SERIE
       WHERE
              semascara  = @semascara1

END


GO
