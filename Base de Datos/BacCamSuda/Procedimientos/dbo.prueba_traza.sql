USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[prueba_traza]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[prueba_traza]
as
begin
select getdate()
end
GO
