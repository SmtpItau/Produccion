USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NEMO_CLIENTE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_NEMO_CLIENTE] --'aaaa'
  (
   @nemo char(4)
  )
as
begin
 
 if exists(select 1 from VIEW_CLIENTE a,
           VIEW_SINACOFI b
                   where b.datatec = @nemo
                            and a.clrut = b.clrut
   )
 begin
  select   a.clrut 
   ,a.clcodigo
   ,a.clnombre
   ,b.datatec
  from VIEW_CLIENTE a,
       VIEW_SINACOFI b
  where b.datatec = @nemo
    and a.clrut = b.clrut
 end else begin
  select 'NO EXISTE'
 end
end

GO
