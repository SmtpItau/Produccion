USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NUOPERACION]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_NUOPERACION]
as
begin
set nocount on
 select accorope from MEAC
set nocount off
end

GO
