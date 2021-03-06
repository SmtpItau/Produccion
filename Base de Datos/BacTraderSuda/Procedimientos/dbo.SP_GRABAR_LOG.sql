USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_LOG]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAR_LOG]
                              ( @xsistema  char(3)  ,
    @xusuario  char(10) ,
    @xfechaproc  datetime ,
    @xevento  char(255) )
as
begin
      set nocount on
      insert into VIEW_LOG_USUARIO  ( logsistema  ,
      loguser   ,
      logfecha  ,
      logfechaapp  ,
      loghora   ,
      logevento  )
    values ( @xsistema  ,
      @xusuario  ,
      convert(char(10),getdate(),112),
      @xfechaproc  ,
      convert(char(10),getdate(),108),
      @xevento  )
if @@error <> 0 begin
   set nocount off
   SELECT 'NO'
end
set nocount off
SELECT 'SI'
end
     

GO
