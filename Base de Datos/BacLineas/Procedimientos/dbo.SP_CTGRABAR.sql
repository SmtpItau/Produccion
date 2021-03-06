USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CTGRABAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


/****** Objeto:  procedimiento  almacenado dbo.SP_CTGRABAR    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_CTGRABAR    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_CTGRABAR]
                            (@ctcateg    NUMERIC( 4),
                             @ctdescrip  CHAR   (25),
                             @ctindcod   CHAR   ( 1),
        @ctindtasa  CHAR   ( 1),
        @ctindfech  CHAR   ( 1),
        @ctindvalor CHAR   ( 1),
        @ctindglosa CHAR   ( 1))
AS
BEGIN
      SET NOCOUNT ON
    IF EXISTS(SELECT 1 FROM TABLA_GENERAL_GLOBAL WHERE ctcateg = @ctcateg) BEGIN  
       UPDATE TABLA_GENERAL_GLOBAL SET ctdescrip = @ctdescrip ,
                       ctindcod  = @ctindcod  ,
         ctindtasa = @ctindtasa ,
         ctindfech = @ctindfech ,
         ctindvalor= @ctindvalor,
         ctindglosa= @ctindglosa
       WHERE ctcateg = @ctcateg
    END ELSE BEGIN
       INSERT INTO TABLA_GENERAL_GLOBAL(ctcateg   , 
   ctdescrip ,
                        ctindcod  ,
          ctindtasa ,
          ctindfech ,
          ctindvalor,
          ctindglosa
                        ) 
                        VALUES (@ctcateg   , 
    @ctdescrip ,
                          @ctindcod  ,
           @ctindtasa ,
           @ctindfech ,
           @ctindvalor,
           @ctindglosa
   )
    END
   SET NOCOUNT OFF
    SELECT 'OK'
    RETURN
END

GO
