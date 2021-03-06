USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MENSAJE]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MENSAJE]
                                       (@xusr_envia            char(10)  ,
                                        @xusr_rte              char(10)  ,
                                        @xmensaje              char(255) ,
                                        @xtipo                 numeric(4,0) ,
     @fecha         datetime  ,
     @hora         char(10)  )
as 
begin
set nocount on
  declare @xcorrela  float  
  select @xcorrela =  isnull(max(correla),0) + 1 from BAC_MENSAJE
  insert into BAC_MENSAJE values(@xusr_envia,@xmensaje,@xusr_rte,@xcorrela ,@xtipo, @fecha, @hora)
select 'OK'
set nocount off
end

GO
