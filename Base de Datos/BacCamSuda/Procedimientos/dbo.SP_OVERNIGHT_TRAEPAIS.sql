USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OVERNIGHT_TRAEPAIS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_OVERNIGHT_TRAEPAIS]
as
begin
set nocount on
      select nombre,codigo_pais from VIEW_PAIS
set nocount off
end 



GO
