USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_NEGOCIO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_LLENA_NEGOCIO]
as
begin  
set nocount on
select * from MENEG
set nocount off
end

GO
