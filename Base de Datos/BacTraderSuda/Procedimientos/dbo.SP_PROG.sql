USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROG]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PROG]
                         (   @ctcateg     NUMERIC( 4),
                             @ctdescrip   CHAR   (25),
                             @ctindcod    CHAR   ( 1),
        @ctindtasa   CHAR   ( 1),
        @ctindfech   CHAR   ( 1),
        @ctindvalor  CHAR   ( 1),
        @ctindglosa  CHAR   ( 1)
)
AS
BEGIN
       INSERT INTO MDCT( ctcateg     ,
                             ctdescrip   ,
                             ctindcod    ,
        ctindtasa   ,
        ctindfech   ,
        ctindvalor  ,
        ctindglosa     
    ) 
                    VALUES ( @ctcateg     ,
                             @ctdescrip   ,
                             @ctindcod    ,
        @ctindtasa   ,
        @ctindfech   ,
        @ctindvalor  ,
        @ctindglosa  
    ) 
dump transaction BacTrader with no_log
    
    RETURN
END

GO
