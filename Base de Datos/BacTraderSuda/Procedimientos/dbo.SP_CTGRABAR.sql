USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CTGRABAR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CTGRABAR]
                            (@ctcateg    numeric( 4),
                             @ctdescrip  char   (25),
                             @ctindcod   char   ( 1),
        @ctindtasa  char   ( 1),
        @ctindfech  char   ( 1),
        @ctindvalor char   ( 1),
        @ctindglosa char   ( 1))
as
begin
      set nocount on
    if exists(select * from MDCT where ctcateg = @ctcateg) begin  
       update MDCT set ctdescrip = @ctdescrip ,
                       ctindcod  = @ctindcod  ,
         ctindtasa = @ctindtasa ,
         ctindfech = @ctindfech ,
         ctindvalor= @ctindvalor,
         ctindglosa= @ctindglosa
       where ctcateg = @ctcateg
    end else begin
       insert into MDCT(ctcateg   , 
   ctdescrip ,
                        ctindcod  ,
          ctindtasa ,
          ctindfech ,
          ctindvalor,
          ctindglosa
                        ) 
                        values (@ctcateg   , 
    @ctdescrip ,
                          @ctindcod  ,
           @ctindtasa ,
           @ctindfech ,
           @ctindvalor,
           @ctindglosa
   )
    end
   set nocount off
    select 'OK'
    return
end


GO
