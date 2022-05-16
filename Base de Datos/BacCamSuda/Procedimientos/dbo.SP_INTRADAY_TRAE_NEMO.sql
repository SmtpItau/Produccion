USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTRADAY_TRAE_NEMO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_INTRADAY_TRAE_NEMO]
 ( @rut numeric(9) )
as
begin
 set nocount on
 select  datatec
 from  VIEW_SINACOFI
 where  clrut =    @rut
 set nocount off
end 



GO
