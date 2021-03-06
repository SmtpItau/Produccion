USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SEGRABAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SEGRABAR]
                             (@secodigo1   NUMERIC (03,0) ,
                              @semascara1  CHAR    (10)   ,
                              @seserie1    CHAR    (12)   ,
                              @serutemi1   NUMERIC (09)   ,        
                       @sefecemi1   DATETIME       ,
                              @sefecven1   DATETIME       ,
                              @setasemi1   NUMERIC (09,4) ,
                              @setera1     NUMERIC (09,4) ,                   
                @sebasemi1   NUMERIC (03,0) ,
                              @semonemi1   NUMERIC (03,0) ,
                              @secupones1  NUMERIC (03,0) ,
                              @sediavcup1  NUMERIC (02,0) ,                              
         @sepervcup1  NUMERIC (02,0) ,
                              @setipvcup1  CHAR    (01)   ,
                              @seplazo1    NUMERIC (06,0) ,
                              @setipamort1 NUMERIC (01,0) ,
                              @senumamort1 NUMERIC (03,0) ,
                              @seffijos1   CHAR    (01)   ,
                              @sebascup1   NUMERIC (07,0) ,
                              @sedecs1     NUMERIC (02,0) ,
                              @secorte1    NUMERIC (19,4) )
AS
BEGIN
set nocount on
       IF @sefecemi1 = '' SELECT @sefecemi1 = NULL
       IF @sefecven1 = '' SELECT @sefecven1 = NULL
       IF EXISTS(SELECT semascara FROM VIEW_SERIE WHERE semascara = @semascara1)
            UPDATE VIEW_SERIE SET secodigo   = @secodigo1   ,
                            semascara  = @semascara1  ,
                            seserie    = @seserie1    ,
                            serutemi   = @serutemi1   ,
                            sefecemi   = @sefecemi1   ,                         
       sefecven   = @sefecven1   ,
                            setasemi   = @setasemi1   ,
                            setera     = @setera1     ,
                            sebasemi   = @sebasemi1   ,
                            semonemi   = @semonemi1   ,
                            secupones  = @secupones1  ,
                            sediavcup  = @sediavcup1  ,
                            sepervcup  = @sepervcup1  ,
                            setipvcup  = @setipvcup1  ,                      
       seplazo    = @seplazo1    ,
                            setipamort = @setipamort1 ,
                            senumamort = @senumamort1 ,
                            seffijos   = @seffijos1   ,
                            sebascup   = @sebascup1   ,
                            sedecs     = @sedecs1     ,
                            secorte    = @secorte1
            WHERE   semascara  = @semascara1
       ELSE
            INSERT INTO VIEW_SERIE   (   secodigo     , semascara   ,  seserie     , serutemi     ,
                                      sefecemi     , sefecven    , setasemi    , setera       ,
                                      sebasemi     , semonemi    , secupones   , sediavcup    ,
                                      sepervcup    , setipvcup   , seplazo     , setipamort   ,
                                      senumamort   , seffijos    , sebascup    , sedecs       ,
                                      secorte   )
                           VALUES (   @secodigo1   , @semascara1 , @seserie1   , @serutemi1   ,
                                      @sefecemi1   , @sefecven1  , @setasemi1  , @setera1     ,
                                      @sebasemi1   , @semonemi1  , @secupones1 , @sediavcup1  ,
                                      @sepervcup1  , @setipvcup1 , @seplazo1   , @setipamort1 ,
                                      @senumamort1 , @seffijos1  , @sebascup1  , @sedecs1     ,
                                      @secorte1 )
SELECT 'OK'
set nocount off
END

GO
